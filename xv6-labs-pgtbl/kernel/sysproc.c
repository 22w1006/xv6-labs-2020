#include "types.h"
#include "riscv.h"
#include "param.h"
#include "defs.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;


  argint(0, &n);
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
  // lab pgtbl: your code here.
  uint64 s_addr;
  int n;
  uint64 out;
  argaddr(0, &s_addr);
  argint(1, &n);
  argaddr(2, &out);
  
  if(n > 64){
    printf("Error: can't detect more than 64 pages at one time, you require to detect [%d] pages!\n", n);
    return -1;
  }
  
  printf("%p %d %p\n", s_addr, n, out);
  pagetable_t pagetable = myproc()->pagetable;
  uint64 res = 0;
  
  for(int i = 0; i < n; ++i){
    pte_t *p = walk(pagetable, s_addr + PGSIZE * i, 0);
    // Accessed
    if(*p & PTE_A){
      *p &= ~PTE_A;
      res |= (1L << i);
    }
  }
  
  if(copyout(myproc()->pagetable, out, (char *) &res, sizeof(uint64)) < 0){
    panic("copyout[sysproc.c:104]");
    return -1;
  }
  
  return 0;
}
#endif

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
