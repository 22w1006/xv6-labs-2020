// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

#define NBUCKET 13

struct {
  struct spinlock lock[NBUCKET];
  struct buf buf[NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
  struct buf buckets[NBUCKET];
} bcache;

int 
hash(int n)
{
  return n % NBUCKET;
}

void
binit(void)
{
  struct buf *b;

  int i;
  for(i=0;i<NBUCKET;++i){
    initlock(&bcache.lock[i], "bcache");
    bcache.buckets[i].prev = &bcache.buckets[i];
    bcache.buckets[i].next = &bcache.buckets[i];
  }

  // Create linked list of buffers
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    int id = hash(b->blockno);
    b->prev = &bcache.buckets[id];
    b->next = bcache.buckets[id].next;
    initsleeplock(&b->lock, "buffer");
    bcache.buckets[id].next->prev = b;
    bcache.buckets[id].next = b;
  }
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;
  
  int id = hash(blockno);

  acquire(&bcache.lock[id]);

  // Is the block already cached?
  int j = 0;
  for(b = bcache.buckets[id].next; b != &bcache.buckets[id]; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&bcache.lock[id]);
      //printf("92 [%d]\n", cpuid());
      acquiresleep(&b->lock);
      //printf("94 [%d]\n", cpuid());
      return b;
    }
    //printf("97 [%d]\n", cpuid());
    j++;
    if(j > 30)
      break;
  }
  
  //printf("to Remove lock: %d\n", id);
  release(&bcache.lock[id]);
  //printf("Remove lock: %d\n", id);

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  int i;
  for(i = 0; i < NBUCKET; ++i){
    if(i == id)
      continue;
    int j = 0;
    for(b = bcache.buckets[i].prev; b != &bcache.buckets[i]; b = b->prev){
      j++;
      if(j>30)
        break;
      //printf("102 to Got lock: %d\n", i);
  	  acquire(&bcache.lock[i]);
  	  //printf("102 Got lock: %d\n", i);
      if(b->refcnt == 0) {
        b->dev = dev;
        b->blockno = blockno;
        b->valid = 0;
        b->refcnt = 1;
        
        // pop
        b->next->prev = b->prev;
        b->prev->next = b->next;

        
        // push
  		//printf("116 to Got lock: %d\n", id);
  		acquire(&bcache.lock[id]);
 		//printf("116 Got lock: %d\n", id);
        b->prev = &bcache.buckets[id];
    	b->next = bcache.buckets[id].next;
  	  	bcache.buckets[id].next->prev = b;
  	 	bcache.buckets[id].next = b;
  	 	//printf("to Remove lock: %d\n", id);
  		release(&bcache.lock[id]);
 		//printf("Remove lock: %d\n", id);
        
        //printf("to Remove lock: %d\n", i);
  		release(&bcache.lock[i]);
  		//printf("Remove lock: %d\n", i);
        
        acquiresleep(&b->lock);
        return b;
      }
      //printf("to Remove lock: %d\n", i);
  	  release(&bcache.lock[i]);
  	  //printf("Remove lock: %d\n", i);
    }
  }
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);

  int id = hash(b->blockno);
  
  //printf("177 to Got lock: %d\n", id);
  acquire(&bcache.lock[id]);
  //printf("177 Got lock: %d\n", id);
  
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    // pop
    b->next->prev = b->prev;
    b->prev->next = b->next;
    
    // push
    b->next = bcache.buckets[id].next;
    b->prev = &bcache.buckets[id];
    bcache.buckets[id].next->prev = b;
    bcache.buckets[id].next = b;
  }
  
  //printf("to Remove lock: %d\n", id);
  release(&bcache.lock[id]);
  //printf("Remove lock: %d\n", id);
}

void
bpin(struct buf *b) {
  int id = hash(b->blockno);
  //printf("to Got lock: %d\n", id);
  acquire(&bcache.lock[id]);
  //printf("Got lock: %d\n", id);
  b->refcnt++;
  //printf("to Remove lock: %d\n", id);
  release(&bcache.lock[id]);
  //printf("Remove lock: %d\n", id);
}

void
bunpin(struct buf *b) {
  int id = hash(b->blockno);
  //printf("to Got lock: %d\n", id);
  acquire(&bcache.lock[id]);
  //printf("Got lock: %d\n", id);
  b->refcnt--;
  //printf("to Remove lock: %d\n", id);
  release(&bcache.lock[id]);
  //printf("Remove lock: %d\n", id);
}


