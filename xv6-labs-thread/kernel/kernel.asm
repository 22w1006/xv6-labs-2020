
kernel/kernel：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	a5013103          	ld	sp,-1456(sp) # 80008a50 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	207050ef          	jal	ra,80005a1c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <inc_cow_cnt>:
int cow_cnt[(PHYSTOP - KERNBASE) / PGSIZE];
#define PA2IDX(pa) (((uint64)pa - KERNBASE) / PGSIZE)

void
inc_cow_cnt(void* pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
    80000028:	84aa                	mv	s1,a0
  acquire(&cow_cnt_lock);
    8000002a:	00009917          	auipc	s2,0x9
    8000002e:	a7690913          	addi	s2,s2,-1418 # 80008aa0 <cow_cnt_lock>
    80000032:	854a                	mv	a0,s2
    80000034:	00006097          	auipc	ra,0x6
    80000038:	3e8080e7          	jalr	1000(ra) # 8000641c <acquire>
  cow_cnt[PA2IDX(pa)]++;
    8000003c:	80000537          	lui	a0,0x80000
    80000040:	94aa                	add	s1,s1,a0
    80000042:	80b1                	srli	s1,s1,0xc
    80000044:	048a                	slli	s1,s1,0x2
    80000046:	00009797          	auipc	a5,0x9
    8000004a:	a9278793          	addi	a5,a5,-1390 # 80008ad8 <cow_cnt>
    8000004e:	94be                	add	s1,s1,a5
    80000050:	409c                	lw	a5,0(s1)
    80000052:	2785                	addiw	a5,a5,1
    80000054:	c09c                	sw	a5,0(s1)
  release(&cow_cnt_lock);
    80000056:	854a                	mv	a0,s2
    80000058:	00006097          	auipc	ra,0x6
    8000005c:	478080e7          	jalr	1144(ra) # 800064d0 <release>
}
    80000060:	60e2                	ld	ra,24(sp)
    80000062:	6442                	ld	s0,16(sp)
    80000064:	64a2                	ld	s1,8(sp)
    80000066:	6902                	ld	s2,0(sp)
    80000068:	6105                	addi	sp,sp,32
    8000006a:	8082                	ret

000000008000006c <dec_cow_cnt>:

void 
dec_cow_cnt(void* pa)
{
    8000006c:	1101                	addi	sp,sp,-32
    8000006e:	ec06                	sd	ra,24(sp)
    80000070:	e822                	sd	s0,16(sp)
    80000072:	e426                	sd	s1,8(sp)
    80000074:	e04a                	sd	s2,0(sp)
    80000076:	1000                	addi	s0,sp,32
    80000078:	84aa                	mv	s1,a0
  acquire(&cow_cnt_lock);
    8000007a:	00009917          	auipc	s2,0x9
    8000007e:	a2690913          	addi	s2,s2,-1498 # 80008aa0 <cow_cnt_lock>
    80000082:	854a                	mv	a0,s2
    80000084:	00006097          	auipc	ra,0x6
    80000088:	398080e7          	jalr	920(ra) # 8000641c <acquire>
  cow_cnt[PA2IDX(pa)]--;
    8000008c:	80000537          	lui	a0,0x80000
    80000090:	94aa                	add	s1,s1,a0
    80000092:	80b1                	srli	s1,s1,0xc
    80000094:	048a                	slli	s1,s1,0x2
    80000096:	00009797          	auipc	a5,0x9
    8000009a:	a4278793          	addi	a5,a5,-1470 # 80008ad8 <cow_cnt>
    8000009e:	94be                	add	s1,s1,a5
    800000a0:	409c                	lw	a5,0(s1)
    800000a2:	37fd                	addiw	a5,a5,-1
    800000a4:	c09c                	sw	a5,0(s1)
  release(&cow_cnt_lock);
    800000a6:	854a                	mv	a0,s2
    800000a8:	00006097          	auipc	ra,0x6
    800000ac:	428080e7          	jalr	1064(ra) # 800064d0 <release>
}
    800000b0:	60e2                	ld	ra,24(sp)
    800000b2:	6442                	ld	s0,16(sp)
    800000b4:	64a2                	ld	s1,8(sp)
    800000b6:	6902                	ld	s2,0(sp)
    800000b8:	6105                	addi	sp,sp,32
    800000ba:	8082                	ret

00000000800000bc <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800000bc:	7179                	addi	sp,sp,-48
    800000be:	f406                	sd	ra,40(sp)
    800000c0:	f022                	sd	s0,32(sp)
    800000c2:	ec26                	sd	s1,24(sp)
    800000c4:	e84a                	sd	s2,16(sp)
    800000c6:	e44e                	sd	s3,8(sp)
    800000c8:	1800                	addi	s0,sp,48
    800000ca:	84aa                	mv	s1,a0
  dec_cow_cnt(pa);
    800000cc:	00000097          	auipc	ra,0x0
    800000d0:	fa0080e7          	jalr	-96(ra) # 8000006c <dec_cow_cnt>
  
  if(cow_cnt[PA2IDX(pa)] <= 0){
    800000d4:	800007b7          	lui	a5,0x80000
    800000d8:	97a6                	add	a5,a5,s1
    800000da:	83b1                	srli	a5,a5,0xc
    800000dc:	078a                	slli	a5,a5,0x2
    800000de:	00009717          	auipc	a4,0x9
    800000e2:	9fa70713          	addi	a4,a4,-1542 # 80008ad8 <cow_cnt>
    800000e6:	97ba                	add	a5,a5,a4
    800000e8:	439c                	lw	a5,0(a5)
    800000ea:	00f05963          	blez	a5,800000fc <kfree+0x40>
    acquire(&kmem.lock);
    r->next = kmem.freelist;
    kmem.freelist = r;
    release(&kmem.lock);
  }
}
    800000ee:	70a2                	ld	ra,40(sp)
    800000f0:	7402                	ld	s0,32(sp)
    800000f2:	64e2                	ld	s1,24(sp)
    800000f4:	6942                	ld	s2,16(sp)
    800000f6:	69a2                	ld	s3,8(sp)
    800000f8:	6145                	addi	sp,sp,48
    800000fa:	8082                	ret
    if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800000fc:	03449793          	slli	a5,s1,0x34
    80000100:	ebb1                	bnez	a5,80000154 <kfree+0x98>
    80000102:	00042797          	auipc	a5,0x42
    80000106:	e2e78793          	addi	a5,a5,-466 # 80041f30 <end>
    8000010a:	04f4e563          	bltu	s1,a5,80000154 <kfree+0x98>
    8000010e:	47c5                	li	a5,17
    80000110:	07ee                	slli	a5,a5,0x1b
    80000112:	04f4f163          	bgeu	s1,a5,80000154 <kfree+0x98>
    memset(pa, 1, PGSIZE);
    80000116:	6605                	lui	a2,0x1
    80000118:	4585                	li	a1,1
    8000011a:	8526                	mv	a0,s1
    8000011c:	00000097          	auipc	ra,0x0
    80000120:	168080e7          	jalr	360(ra) # 80000284 <memset>
    acquire(&kmem.lock);
    80000124:	00009997          	auipc	s3,0x9
    80000128:	97c98993          	addi	s3,s3,-1668 # 80008aa0 <cow_cnt_lock>
    8000012c:	00009917          	auipc	s2,0x9
    80000130:	98c90913          	addi	s2,s2,-1652 # 80008ab8 <kmem>
    80000134:	854a                	mv	a0,s2
    80000136:	00006097          	auipc	ra,0x6
    8000013a:	2e6080e7          	jalr	742(ra) # 8000641c <acquire>
    r->next = kmem.freelist;
    8000013e:	0309b783          	ld	a5,48(s3)
    80000142:	e09c                	sd	a5,0(s1)
    kmem.freelist = r;
    80000144:	0299b823          	sd	s1,48(s3)
    release(&kmem.lock);
    80000148:	854a                	mv	a0,s2
    8000014a:	00006097          	auipc	ra,0x6
    8000014e:	386080e7          	jalr	902(ra) # 800064d0 <release>
}
    80000152:	bf71                	j	800000ee <kfree+0x32>
      panic("kfree");
    80000154:	00008517          	auipc	a0,0x8
    80000158:	ebc50513          	addi	a0,a0,-324 # 80008010 <etext+0x10>
    8000015c:	00006097          	auipc	ra,0x6
    80000160:	d76080e7          	jalr	-650(ra) # 80005ed2 <panic>

0000000080000164 <freerange>:
{
    80000164:	7179                	addi	sp,sp,-48
    80000166:	f406                	sd	ra,40(sp)
    80000168:	f022                	sd	s0,32(sp)
    8000016a:	ec26                	sd	s1,24(sp)
    8000016c:	e84a                	sd	s2,16(sp)
    8000016e:	e44e                	sd	s3,8(sp)
    80000170:	e052                	sd	s4,0(sp)
    80000172:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000174:	6785                	lui	a5,0x1
    80000176:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    8000017a:	94aa                	add	s1,s1,a0
    8000017c:	757d                	lui	a0,0xfffff
    8000017e:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000180:	94be                	add	s1,s1,a5
    80000182:	0095ee63          	bltu	a1,s1,8000019e <freerange+0x3a>
    80000186:	892e                	mv	s2,a1
    kfree(p);
    80000188:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000018a:	6985                	lui	s3,0x1
    kfree(p);
    8000018c:	01448533          	add	a0,s1,s4
    80000190:	00000097          	auipc	ra,0x0
    80000194:	f2c080e7          	jalr	-212(ra) # 800000bc <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000198:	94ce                	add	s1,s1,s3
    8000019a:	fe9979e3          	bgeu	s2,s1,8000018c <freerange+0x28>
}
    8000019e:	70a2                	ld	ra,40(sp)
    800001a0:	7402                	ld	s0,32(sp)
    800001a2:	64e2                	ld	s1,24(sp)
    800001a4:	6942                	ld	s2,16(sp)
    800001a6:	69a2                	ld	s3,8(sp)
    800001a8:	6a02                	ld	s4,0(sp)
    800001aa:	6145                	addi	sp,sp,48
    800001ac:	8082                	ret

00000000800001ae <kinit>:
{
    800001ae:	1141                	addi	sp,sp,-16
    800001b0:	e406                	sd	ra,8(sp)
    800001b2:	e022                	sd	s0,0(sp)
    800001b4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800001b6:	00008597          	auipc	a1,0x8
    800001ba:	e6258593          	addi	a1,a1,-414 # 80008018 <etext+0x18>
    800001be:	00009517          	auipc	a0,0x9
    800001c2:	8fa50513          	addi	a0,a0,-1798 # 80008ab8 <kmem>
    800001c6:	00006097          	auipc	ra,0x6
    800001ca:	1c6080e7          	jalr	454(ra) # 8000638c <initlock>
  initlock(&cow_cnt_lock, "cow_cnt_lock");
    800001ce:	00008597          	auipc	a1,0x8
    800001d2:	e5258593          	addi	a1,a1,-430 # 80008020 <etext+0x20>
    800001d6:	00009517          	auipc	a0,0x9
    800001da:	8ca50513          	addi	a0,a0,-1846 # 80008aa0 <cow_cnt_lock>
    800001de:	00006097          	auipc	ra,0x6
    800001e2:	1ae080e7          	jalr	430(ra) # 8000638c <initlock>
  freerange(end, (void*)PHYSTOP);
    800001e6:	45c5                	li	a1,17
    800001e8:	05ee                	slli	a1,a1,0x1b
    800001ea:	00042517          	auipc	a0,0x42
    800001ee:	d4650513          	addi	a0,a0,-698 # 80041f30 <end>
    800001f2:	00000097          	auipc	ra,0x0
    800001f6:	f72080e7          	jalr	-142(ra) # 80000164 <freerange>
}
    800001fa:	60a2                	ld	ra,8(sp)
    800001fc:	6402                	ld	s0,0(sp)
    800001fe:	0141                	addi	sp,sp,16
    80000200:	8082                	ret

0000000080000202 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000202:	1101                	addi	sp,sp,-32
    80000204:	ec06                	sd	ra,24(sp)
    80000206:	e822                	sd	s0,16(sp)
    80000208:	e426                	sd	s1,8(sp)
    8000020a:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000020c:	00009517          	auipc	a0,0x9
    80000210:	8ac50513          	addi	a0,a0,-1876 # 80008ab8 <kmem>
    80000214:	00006097          	auipc	ra,0x6
    80000218:	208080e7          	jalr	520(ra) # 8000641c <acquire>
  r = kmem.freelist;
    8000021c:	00009497          	auipc	s1,0x9
    80000220:	8b44b483          	ld	s1,-1868(s1) # 80008ad0 <kmem+0x18>
  if(r)
    80000224:	c4b9                	beqz	s1,80000272 <kalloc+0x70>
    kmem.freelist = r->next;
    80000226:	609c                	ld	a5,0(s1)
    80000228:	00009717          	auipc	a4,0x9
    8000022c:	8af73423          	sd	a5,-1880(a4) # 80008ad0 <kmem+0x18>
  release(&kmem.lock);
    80000230:	00009517          	auipc	a0,0x9
    80000234:	88850513          	addi	a0,a0,-1912 # 80008ab8 <kmem>
    80000238:	00006097          	auipc	ra,0x6
    8000023c:	298080e7          	jalr	664(ra) # 800064d0 <release>

  if(r){
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000240:	6605                	lui	a2,0x1
    80000242:	4595                	li	a1,5
    80000244:	8526                	mv	a0,s1
    80000246:	00000097          	auipc	ra,0x0
    8000024a:	03e080e7          	jalr	62(ra) # 80000284 <memset>
    cow_cnt[PA2IDX(r)] = 1;
    8000024e:	800007b7          	lui	a5,0x80000
    80000252:	97a6                	add	a5,a5,s1
    80000254:	83b1                	srli	a5,a5,0xc
    80000256:	078a                	slli	a5,a5,0x2
    80000258:	00009717          	auipc	a4,0x9
    8000025c:	88070713          	addi	a4,a4,-1920 # 80008ad8 <cow_cnt>
    80000260:	97ba                	add	a5,a5,a4
    80000262:	4705                	li	a4,1
    80000264:	c398                	sw	a4,0(a5)
  }
  return (void*)r;
}
    80000266:	8526                	mv	a0,s1
    80000268:	60e2                	ld	ra,24(sp)
    8000026a:	6442                	ld	s0,16(sp)
    8000026c:	64a2                	ld	s1,8(sp)
    8000026e:	6105                	addi	sp,sp,32
    80000270:	8082                	ret
  release(&kmem.lock);
    80000272:	00009517          	auipc	a0,0x9
    80000276:	84650513          	addi	a0,a0,-1978 # 80008ab8 <kmem>
    8000027a:	00006097          	auipc	ra,0x6
    8000027e:	256080e7          	jalr	598(ra) # 800064d0 <release>
  if(r){
    80000282:	b7d5                	j	80000266 <kalloc+0x64>

0000000080000284 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000284:	1141                	addi	sp,sp,-16
    80000286:	e422                	sd	s0,8(sp)
    80000288:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000028a:	ce09                	beqz	a2,800002a4 <memset+0x20>
    8000028c:	87aa                	mv	a5,a0
    8000028e:	fff6071b          	addiw	a4,a2,-1
    80000292:	1702                	slli	a4,a4,0x20
    80000294:	9301                	srli	a4,a4,0x20
    80000296:	0705                	addi	a4,a4,1
    80000298:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000029a:	00b78023          	sb	a1,0(a5) # ffffffff80000000 <end+0xfffffffefffbe0d0>
  for(i = 0; i < n; i++){
    8000029e:	0785                	addi	a5,a5,1
    800002a0:	fee79de3          	bne	a5,a4,8000029a <memset+0x16>
  }
  return dst;
}
    800002a4:	6422                	ld	s0,8(sp)
    800002a6:	0141                	addi	sp,sp,16
    800002a8:	8082                	ret

00000000800002aa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800002aa:	1141                	addi	sp,sp,-16
    800002ac:	e422                	sd	s0,8(sp)
    800002ae:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800002b0:	ca05                	beqz	a2,800002e0 <memcmp+0x36>
    800002b2:	fff6069b          	addiw	a3,a2,-1
    800002b6:	1682                	slli	a3,a3,0x20
    800002b8:	9281                	srli	a3,a3,0x20
    800002ba:	0685                	addi	a3,a3,1
    800002bc:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800002be:	00054783          	lbu	a5,0(a0)
    800002c2:	0005c703          	lbu	a4,0(a1)
    800002c6:	00e79863          	bne	a5,a4,800002d6 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800002ca:	0505                	addi	a0,a0,1
    800002cc:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800002ce:	fed518e3          	bne	a0,a3,800002be <memcmp+0x14>
  }

  return 0;
    800002d2:	4501                	li	a0,0
    800002d4:	a019                	j	800002da <memcmp+0x30>
      return *s1 - *s2;
    800002d6:	40e7853b          	subw	a0,a5,a4
}
    800002da:	6422                	ld	s0,8(sp)
    800002dc:	0141                	addi	sp,sp,16
    800002de:	8082                	ret
  return 0;
    800002e0:	4501                	li	a0,0
    800002e2:	bfe5                	j	800002da <memcmp+0x30>

00000000800002e4 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800002e4:	1141                	addi	sp,sp,-16
    800002e6:	e422                	sd	s0,8(sp)
    800002e8:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800002ea:	ca0d                	beqz	a2,8000031c <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800002ec:	00a5f963          	bgeu	a1,a0,800002fe <memmove+0x1a>
    800002f0:	02061693          	slli	a3,a2,0x20
    800002f4:	9281                	srli	a3,a3,0x20
    800002f6:	00d58733          	add	a4,a1,a3
    800002fa:	02e56463          	bltu	a0,a4,80000322 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800002fe:	fff6079b          	addiw	a5,a2,-1
    80000302:	1782                	slli	a5,a5,0x20
    80000304:	9381                	srli	a5,a5,0x20
    80000306:	0785                	addi	a5,a5,1
    80000308:	97ae                	add	a5,a5,a1
    8000030a:	872a                	mv	a4,a0
      *d++ = *s++;
    8000030c:	0585                	addi	a1,a1,1
    8000030e:	0705                	addi	a4,a4,1
    80000310:	fff5c683          	lbu	a3,-1(a1)
    80000314:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000318:	fef59ae3          	bne	a1,a5,8000030c <memmove+0x28>

  return dst;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
    d += n;
    80000322:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000324:	fff6079b          	addiw	a5,a2,-1
    80000328:	1782                	slli	a5,a5,0x20
    8000032a:	9381                	srli	a5,a5,0x20
    8000032c:	fff7c793          	not	a5,a5
    80000330:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000332:	177d                	addi	a4,a4,-1
    80000334:	16fd                	addi	a3,a3,-1
    80000336:	00074603          	lbu	a2,0(a4)
    8000033a:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000033e:	fef71ae3          	bne	a4,a5,80000332 <memmove+0x4e>
    80000342:	bfe9                	j	8000031c <memmove+0x38>

0000000080000344 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000344:	1141                	addi	sp,sp,-16
    80000346:	e406                	sd	ra,8(sp)
    80000348:	e022                	sd	s0,0(sp)
    8000034a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000034c:	00000097          	auipc	ra,0x0
    80000350:	f98080e7          	jalr	-104(ra) # 800002e4 <memmove>
}
    80000354:	60a2                	ld	ra,8(sp)
    80000356:	6402                	ld	s0,0(sp)
    80000358:	0141                	addi	sp,sp,16
    8000035a:	8082                	ret

000000008000035c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000035c:	1141                	addi	sp,sp,-16
    8000035e:	e422                	sd	s0,8(sp)
    80000360:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000362:	ce11                	beqz	a2,8000037e <strncmp+0x22>
    80000364:	00054783          	lbu	a5,0(a0)
    80000368:	cf89                	beqz	a5,80000382 <strncmp+0x26>
    8000036a:	0005c703          	lbu	a4,0(a1)
    8000036e:	00f71a63          	bne	a4,a5,80000382 <strncmp+0x26>
    n--, p++, q++;
    80000372:	367d                	addiw	a2,a2,-1
    80000374:	0505                	addi	a0,a0,1
    80000376:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000378:	f675                	bnez	a2,80000364 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000037a:	4501                	li	a0,0
    8000037c:	a809                	j	8000038e <strncmp+0x32>
    8000037e:	4501                	li	a0,0
    80000380:	a039                	j	8000038e <strncmp+0x32>
  if(n == 0)
    80000382:	ca09                	beqz	a2,80000394 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000384:	00054503          	lbu	a0,0(a0)
    80000388:	0005c783          	lbu	a5,0(a1)
    8000038c:	9d1d                	subw	a0,a0,a5
}
    8000038e:	6422                	ld	s0,8(sp)
    80000390:	0141                	addi	sp,sp,16
    80000392:	8082                	ret
    return 0;
    80000394:	4501                	li	a0,0
    80000396:	bfe5                	j	8000038e <strncmp+0x32>

0000000080000398 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000398:	1141                	addi	sp,sp,-16
    8000039a:	e422                	sd	s0,8(sp)
    8000039c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000039e:	872a                	mv	a4,a0
    800003a0:	8832                	mv	a6,a2
    800003a2:	367d                	addiw	a2,a2,-1
    800003a4:	01005963          	blez	a6,800003b6 <strncpy+0x1e>
    800003a8:	0705                	addi	a4,a4,1
    800003aa:	0005c783          	lbu	a5,0(a1)
    800003ae:	fef70fa3          	sb	a5,-1(a4)
    800003b2:	0585                	addi	a1,a1,1
    800003b4:	f7f5                	bnez	a5,800003a0 <strncpy+0x8>
    ;
  while(n-- > 0)
    800003b6:	00c05d63          	blez	a2,800003d0 <strncpy+0x38>
    800003ba:	86ba                	mv	a3,a4
    *s++ = 0;
    800003bc:	0685                	addi	a3,a3,1
    800003be:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800003c2:	fff6c793          	not	a5,a3
    800003c6:	9fb9                	addw	a5,a5,a4
    800003c8:	010787bb          	addw	a5,a5,a6
    800003cc:	fef048e3          	bgtz	a5,800003bc <strncpy+0x24>
  return os;
}
    800003d0:	6422                	ld	s0,8(sp)
    800003d2:	0141                	addi	sp,sp,16
    800003d4:	8082                	ret

00000000800003d6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800003d6:	1141                	addi	sp,sp,-16
    800003d8:	e422                	sd	s0,8(sp)
    800003da:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800003dc:	02c05363          	blez	a2,80000402 <safestrcpy+0x2c>
    800003e0:	fff6069b          	addiw	a3,a2,-1
    800003e4:	1682                	slli	a3,a3,0x20
    800003e6:	9281                	srli	a3,a3,0x20
    800003e8:	96ae                	add	a3,a3,a1
    800003ea:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800003ec:	00d58963          	beq	a1,a3,800003fe <safestrcpy+0x28>
    800003f0:	0585                	addi	a1,a1,1
    800003f2:	0785                	addi	a5,a5,1
    800003f4:	fff5c703          	lbu	a4,-1(a1)
    800003f8:	fee78fa3          	sb	a4,-1(a5)
    800003fc:	fb65                	bnez	a4,800003ec <safestrcpy+0x16>
    ;
  *s = 0;
    800003fe:	00078023          	sb	zero,0(a5)
  return os;
}
    80000402:	6422                	ld	s0,8(sp)
    80000404:	0141                	addi	sp,sp,16
    80000406:	8082                	ret

0000000080000408 <strlen>:

int
strlen(const char *s)
{
    80000408:	1141                	addi	sp,sp,-16
    8000040a:	e422                	sd	s0,8(sp)
    8000040c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8000040e:	00054783          	lbu	a5,0(a0)
    80000412:	cf91                	beqz	a5,8000042e <strlen+0x26>
    80000414:	0505                	addi	a0,a0,1
    80000416:	87aa                	mv	a5,a0
    80000418:	4685                	li	a3,1
    8000041a:	9e89                	subw	a3,a3,a0
    8000041c:	00f6853b          	addw	a0,a3,a5
    80000420:	0785                	addi	a5,a5,1
    80000422:	fff7c703          	lbu	a4,-1(a5)
    80000426:	fb7d                	bnez	a4,8000041c <strlen+0x14>
    ;
  return n;
}
    80000428:	6422                	ld	s0,8(sp)
    8000042a:	0141                	addi	sp,sp,16
    8000042c:	8082                	ret
  for(n = 0; s[n]; n++)
    8000042e:	4501                	li	a0,0
    80000430:	bfe5                	j	80000428 <strlen+0x20>

0000000080000432 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000432:	1141                	addi	sp,sp,-16
    80000434:	e406                	sd	ra,8(sp)
    80000436:	e022                	sd	s0,0(sp)
    80000438:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000043a:	00001097          	auipc	ra,0x1
    8000043e:	c9c080e7          	jalr	-868(ra) # 800010d6 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000442:	00008717          	auipc	a4,0x8
    80000446:	62e70713          	addi	a4,a4,1582 # 80008a70 <started>
  if(cpuid() == 0){
    8000044a:	c139                	beqz	a0,80000490 <main+0x5e>
    while(started == 0)
    8000044c:	431c                	lw	a5,0(a4)
    8000044e:	2781                	sext.w	a5,a5
    80000450:	dff5                	beqz	a5,8000044c <main+0x1a>
      ;
    __sync_synchronize();
    80000452:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000456:	00001097          	auipc	ra,0x1
    8000045a:	c80080e7          	jalr	-896(ra) # 800010d6 <cpuid>
    8000045e:	85aa                	mv	a1,a0
    80000460:	00008517          	auipc	a0,0x8
    80000464:	be850513          	addi	a0,a0,-1048 # 80008048 <etext+0x48>
    80000468:	00006097          	auipc	ra,0x6
    8000046c:	ab4080e7          	jalr	-1356(ra) # 80005f1c <printf>
    kvminithart();    // turn on paging
    80000470:	00000097          	auipc	ra,0x0
    80000474:	0d8080e7          	jalr	216(ra) # 80000548 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000478:	00002097          	auipc	ra,0x2
    8000047c:	926080e7          	jalr	-1754(ra) # 80001d9e <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000480:	00005097          	auipc	ra,0x5
    80000484:	ef0080e7          	jalr	-272(ra) # 80005370 <plicinithart>
  }

  scheduler();        
    80000488:	00001097          	auipc	ra,0x1
    8000048c:	170080e7          	jalr	368(ra) # 800015f8 <scheduler>
    consoleinit();
    80000490:	00006097          	auipc	ra,0x6
    80000494:	954080e7          	jalr	-1708(ra) # 80005de4 <consoleinit>
    printfinit();
    80000498:	00006097          	auipc	ra,0x6
    8000049c:	c6a080e7          	jalr	-918(ra) # 80006102 <printfinit>
    printf("\n");
    800004a0:	00008517          	auipc	a0,0x8
    800004a4:	bb850513          	addi	a0,a0,-1096 # 80008058 <etext+0x58>
    800004a8:	00006097          	auipc	ra,0x6
    800004ac:	a74080e7          	jalr	-1420(ra) # 80005f1c <printf>
    printf("xv6 kernel is booting\n");
    800004b0:	00008517          	auipc	a0,0x8
    800004b4:	b8050513          	addi	a0,a0,-1152 # 80008030 <etext+0x30>
    800004b8:	00006097          	auipc	ra,0x6
    800004bc:	a64080e7          	jalr	-1436(ra) # 80005f1c <printf>
    printf("\n");
    800004c0:	00008517          	auipc	a0,0x8
    800004c4:	b9850513          	addi	a0,a0,-1128 # 80008058 <etext+0x58>
    800004c8:	00006097          	auipc	ra,0x6
    800004cc:	a54080e7          	jalr	-1452(ra) # 80005f1c <printf>
    kinit();         // physical page allocator
    800004d0:	00000097          	auipc	ra,0x0
    800004d4:	cde080e7          	jalr	-802(ra) # 800001ae <kinit>
    kvminit();       // create kernel page table
    800004d8:	00000097          	auipc	ra,0x0
    800004dc:	38a080e7          	jalr	906(ra) # 80000862 <kvminit>
    kvminithart();   // turn on paging
    800004e0:	00000097          	auipc	ra,0x0
    800004e4:	068080e7          	jalr	104(ra) # 80000548 <kvminithart>
    procinit();      // process table
    800004e8:	00001097          	auipc	ra,0x1
    800004ec:	b3a080e7          	jalr	-1222(ra) # 80001022 <procinit>
    trapinit();      // trap vectors
    800004f0:	00002097          	auipc	ra,0x2
    800004f4:	886080e7          	jalr	-1914(ra) # 80001d76 <trapinit>
    trapinithart();  // install kernel trap vector
    800004f8:	00002097          	auipc	ra,0x2
    800004fc:	8a6080e7          	jalr	-1882(ra) # 80001d9e <trapinithart>
    plicinit();      // set up interrupt controller
    80000500:	00005097          	auipc	ra,0x5
    80000504:	e5a080e7          	jalr	-422(ra) # 8000535a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000508:	00005097          	auipc	ra,0x5
    8000050c:	e68080e7          	jalr	-408(ra) # 80005370 <plicinithart>
    binit();         // buffer cache
    80000510:	00002097          	auipc	ra,0x2
    80000514:	01a080e7          	jalr	26(ra) # 8000252a <binit>
    iinit();         // inode table
    80000518:	00002097          	auipc	ra,0x2
    8000051c:	6be080e7          	jalr	1726(ra) # 80002bd6 <iinit>
    fileinit();      // file table
    80000520:	00003097          	auipc	ra,0x3
    80000524:	65c080e7          	jalr	1628(ra) # 80003b7c <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000528:	00005097          	auipc	ra,0x5
    8000052c:	f50080e7          	jalr	-176(ra) # 80005478 <virtio_disk_init>
    userinit();      // first user process
    80000530:	00001097          	auipc	ra,0x1
    80000534:	eae080e7          	jalr	-338(ra) # 800013de <userinit>
    __sync_synchronize();
    80000538:	0ff0000f          	fence
    started = 1;
    8000053c:	4785                	li	a5,1
    8000053e:	00008717          	auipc	a4,0x8
    80000542:	52f72923          	sw	a5,1330(a4) # 80008a70 <started>
    80000546:	b789                	j	80000488 <main+0x56>

0000000080000548 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000548:	1141                	addi	sp,sp,-16
    8000054a:	e422                	sd	s0,8(sp)
    8000054c:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    8000054e:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000552:	00008797          	auipc	a5,0x8
    80000556:	5267b783          	ld	a5,1318(a5) # 80008a78 <kernel_pagetable>
    8000055a:	83b1                	srli	a5,a5,0xc
    8000055c:	577d                	li	a4,-1
    8000055e:	177e                	slli	a4,a4,0x3f
    80000560:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000562:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000566:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    8000056a:	6422                	ld	s0,8(sp)
    8000056c:	0141                	addi	sp,sp,16
    8000056e:	8082                	ret

0000000080000570 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000570:	7139                	addi	sp,sp,-64
    80000572:	fc06                	sd	ra,56(sp)
    80000574:	f822                	sd	s0,48(sp)
    80000576:	f426                	sd	s1,40(sp)
    80000578:	f04a                	sd	s2,32(sp)
    8000057a:	ec4e                	sd	s3,24(sp)
    8000057c:	e852                	sd	s4,16(sp)
    8000057e:	e456                	sd	s5,8(sp)
    80000580:	e05a                	sd	s6,0(sp)
    80000582:	0080                	addi	s0,sp,64
    80000584:	84aa                	mv	s1,a0
    80000586:	89ae                	mv	s3,a1
    80000588:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000058a:	57fd                	li	a5,-1
    8000058c:	83e9                	srli	a5,a5,0x1a
    8000058e:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000590:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000592:	04b7f263          	bgeu	a5,a1,800005d6 <walk+0x66>
    panic("walk");
    80000596:	00008517          	auipc	a0,0x8
    8000059a:	aca50513          	addi	a0,a0,-1334 # 80008060 <etext+0x60>
    8000059e:	00006097          	auipc	ra,0x6
    800005a2:	934080e7          	jalr	-1740(ra) # 80005ed2 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800005a6:	060a8663          	beqz	s5,80000612 <walk+0xa2>
    800005aa:	00000097          	auipc	ra,0x0
    800005ae:	c58080e7          	jalr	-936(ra) # 80000202 <kalloc>
    800005b2:	84aa                	mv	s1,a0
    800005b4:	c529                	beqz	a0,800005fe <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800005b6:	6605                	lui	a2,0x1
    800005b8:	4581                	li	a1,0
    800005ba:	00000097          	auipc	ra,0x0
    800005be:	cca080e7          	jalr	-822(ra) # 80000284 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800005c2:	00c4d793          	srli	a5,s1,0xc
    800005c6:	07aa                	slli	a5,a5,0xa
    800005c8:	0017e793          	ori	a5,a5,1
    800005cc:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800005d0:	3a5d                	addiw	s4,s4,-9
    800005d2:	036a0063          	beq	s4,s6,800005f2 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800005d6:	0149d933          	srl	s2,s3,s4
    800005da:	1ff97913          	andi	s2,s2,511
    800005de:	090e                	slli	s2,s2,0x3
    800005e0:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800005e2:	00093483          	ld	s1,0(s2)
    800005e6:	0014f793          	andi	a5,s1,1
    800005ea:	dfd5                	beqz	a5,800005a6 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800005ec:	80a9                	srli	s1,s1,0xa
    800005ee:	04b2                	slli	s1,s1,0xc
    800005f0:	b7c5                	j	800005d0 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800005f2:	00c9d513          	srli	a0,s3,0xc
    800005f6:	1ff57513          	andi	a0,a0,511
    800005fa:	050e                	slli	a0,a0,0x3
    800005fc:	9526                	add	a0,a0,s1
}
    800005fe:	70e2                	ld	ra,56(sp)
    80000600:	7442                	ld	s0,48(sp)
    80000602:	74a2                	ld	s1,40(sp)
    80000604:	7902                	ld	s2,32(sp)
    80000606:	69e2                	ld	s3,24(sp)
    80000608:	6a42                	ld	s4,16(sp)
    8000060a:	6aa2                	ld	s5,8(sp)
    8000060c:	6b02                	ld	s6,0(sp)
    8000060e:	6121                	addi	sp,sp,64
    80000610:	8082                	ret
        return 0;
    80000612:	4501                	li	a0,0
    80000614:	b7ed                	j	800005fe <walk+0x8e>

0000000080000616 <is_COW_fault>:
  if((stval >= MAXVA) || (stval == 0))
    80000616:	fff58713          	addi	a4,a1,-1
    8000061a:	f80007b7          	lui	a5,0xf8000
    8000061e:	83e9                	srli	a5,a5,0x1a
    80000620:	00e7f463          	bgeu	a5,a4,80000628 <is_COW_fault+0x12>
    return 0;
    80000624:	4501                	li	a0,0
}
    80000626:	8082                	ret
int is_COW_fault(pagetable_t pgt, uint64 stval){
    80000628:	1141                	addi	sp,sp,-16
    8000062a:	e406                	sd	ra,8(sp)
    8000062c:	e022                	sd	s0,0(sp)
    8000062e:	0800                	addi	s0,sp,16
    pte_t* pte = walk(pgt, PGROUNDDOWN(stval), 0);
    80000630:	4601                	li	a2,0
    80000632:	77fd                	lui	a5,0xfffff
    80000634:	8dfd                	and	a1,a1,a5
    80000636:	00000097          	auipc	ra,0x0
    8000063a:	f3a080e7          	jalr	-198(ra) # 80000570 <walk>
    8000063e:	87aa                	mv	a5,a0
    return pte && (*pte & (PTE_V | PTE_U | PTE_C));
    80000640:	4501                	li	a0,0
    80000642:	c791                	beqz	a5,8000064e <is_COW_fault+0x38>
    80000644:	6388                	ld	a0,0(a5)
    80000646:	11157513          	andi	a0,a0,273
    return 0;
    8000064a:	00a03533          	snez	a0,a0
}
    8000064e:	60a2                	ld	ra,8(sp)
    80000650:	6402                	ld	s0,0(sp)
    80000652:	0141                	addi	sp,sp,16
    80000654:	8082                	ret

0000000080000656 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000656:	57fd                	li	a5,-1
    80000658:	83e9                	srli	a5,a5,0x1a
    8000065a:	00b7f463          	bgeu	a5,a1,80000662 <walkaddr+0xc>
    return 0;
    8000065e:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000660:	8082                	ret
{
    80000662:	1141                	addi	sp,sp,-16
    80000664:	e406                	sd	ra,8(sp)
    80000666:	e022                	sd	s0,0(sp)
    80000668:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000066a:	4601                	li	a2,0
    8000066c:	00000097          	auipc	ra,0x0
    80000670:	f04080e7          	jalr	-252(ra) # 80000570 <walk>
  if(pte == 0)
    80000674:	c105                	beqz	a0,80000694 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000676:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000678:	0117f693          	andi	a3,a5,17
    8000067c:	4745                	li	a4,17
    return 0;
    8000067e:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000680:	00e68663          	beq	a3,a4,8000068c <walkaddr+0x36>
}
    80000684:	60a2                	ld	ra,8(sp)
    80000686:	6402                	ld	s0,0(sp)
    80000688:	0141                	addi	sp,sp,16
    8000068a:	8082                	ret
  pa = PTE2PA(*pte);
    8000068c:	00a7d513          	srli	a0,a5,0xa
    80000690:	0532                	slli	a0,a0,0xc
  return pa;
    80000692:	bfcd                	j	80000684 <walkaddr+0x2e>
    return 0;
    80000694:	4501                	li	a0,0
    80000696:	b7fd                	j	80000684 <walkaddr+0x2e>

0000000080000698 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000698:	715d                	addi	sp,sp,-80
    8000069a:	e486                	sd	ra,72(sp)
    8000069c:	e0a2                	sd	s0,64(sp)
    8000069e:	fc26                	sd	s1,56(sp)
    800006a0:	f84a                	sd	s2,48(sp)
    800006a2:	f44e                	sd	s3,40(sp)
    800006a4:	f052                	sd	s4,32(sp)
    800006a6:	ec56                	sd	s5,24(sp)
    800006a8:	e85a                	sd	s6,16(sp)
    800006aa:	e45e                	sd	s7,8(sp)
    800006ac:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800006ae:	03459793          	slli	a5,a1,0x34
    800006b2:	e385                	bnez	a5,800006d2 <mappages+0x3a>
    800006b4:	8aaa                	mv	s5,a0
    800006b6:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800006b8:	03461793          	slli	a5,a2,0x34
    800006bc:	e39d                	bnez	a5,800006e2 <mappages+0x4a>
    panic("mappages: size not aligned");

  if(size == 0)
    800006be:	ca15                	beqz	a2,800006f2 <mappages+0x5a>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800006c0:	79fd                	lui	s3,0xfffff
    800006c2:	964e                	add	a2,a2,s3
    800006c4:	00b609b3          	add	s3,a2,a1
  a = va;
    800006c8:	892e                	mv	s2,a1
    800006ca:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800006ce:	6b85                	lui	s7,0x1
    800006d0:	a091                	j	80000714 <mappages+0x7c>
    panic("mappages: va not aligned");
    800006d2:	00008517          	auipc	a0,0x8
    800006d6:	99650513          	addi	a0,a0,-1642 # 80008068 <etext+0x68>
    800006da:	00005097          	auipc	ra,0x5
    800006de:	7f8080e7          	jalr	2040(ra) # 80005ed2 <panic>
    panic("mappages: size not aligned");
    800006e2:	00008517          	auipc	a0,0x8
    800006e6:	9a650513          	addi	a0,a0,-1626 # 80008088 <etext+0x88>
    800006ea:	00005097          	auipc	ra,0x5
    800006ee:	7e8080e7          	jalr	2024(ra) # 80005ed2 <panic>
    panic("mappages: size");
    800006f2:	00008517          	auipc	a0,0x8
    800006f6:	9b650513          	addi	a0,a0,-1610 # 800080a8 <etext+0xa8>
    800006fa:	00005097          	auipc	ra,0x5
    800006fe:	7d8080e7          	jalr	2008(ra) # 80005ed2 <panic>
      panic("mappages: remap");
    80000702:	00008517          	auipc	a0,0x8
    80000706:	9b650513          	addi	a0,a0,-1610 # 800080b8 <etext+0xb8>
    8000070a:	00005097          	auipc	ra,0x5
    8000070e:	7c8080e7          	jalr	1992(ra) # 80005ed2 <panic>
    a += PGSIZE;
    80000712:	995e                	add	s2,s2,s7
  for(;;){
    80000714:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000718:	4605                	li	a2,1
    8000071a:	85ca                	mv	a1,s2
    8000071c:	8556                	mv	a0,s5
    8000071e:	00000097          	auipc	ra,0x0
    80000722:	e52080e7          	jalr	-430(ra) # 80000570 <walk>
    80000726:	cd19                	beqz	a0,80000744 <mappages+0xac>
    if(*pte & PTE_V)
    80000728:	611c                	ld	a5,0(a0)
    8000072a:	8b85                	andi	a5,a5,1
    8000072c:	fbf9                	bnez	a5,80000702 <mappages+0x6a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000072e:	80b1                	srli	s1,s1,0xc
    80000730:	04aa                	slli	s1,s1,0xa
    80000732:	0164e4b3          	or	s1,s1,s6
    80000736:	0014e493          	ori	s1,s1,1
    8000073a:	e104                	sd	s1,0(a0)
    if(a == last)
    8000073c:	fd391be3          	bne	s2,s3,80000712 <mappages+0x7a>
    pa += PGSIZE;
  }
  return 0;
    80000740:	4501                	li	a0,0
    80000742:	a011                	j	80000746 <mappages+0xae>
      return -1;
    80000744:	557d                	li	a0,-1
}
    80000746:	60a6                	ld	ra,72(sp)
    80000748:	6406                	ld	s0,64(sp)
    8000074a:	74e2                	ld	s1,56(sp)
    8000074c:	7942                	ld	s2,48(sp)
    8000074e:	79a2                	ld	s3,40(sp)
    80000750:	7a02                	ld	s4,32(sp)
    80000752:	6ae2                	ld	s5,24(sp)
    80000754:	6b42                	ld	s6,16(sp)
    80000756:	6ba2                	ld	s7,8(sp)
    80000758:	6161                	addi	sp,sp,80
    8000075a:	8082                	ret

000000008000075c <kvmmap>:
{
    8000075c:	1141                	addi	sp,sp,-16
    8000075e:	e406                	sd	ra,8(sp)
    80000760:	e022                	sd	s0,0(sp)
    80000762:	0800                	addi	s0,sp,16
    80000764:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000766:	86b2                	mv	a3,a2
    80000768:	863e                	mv	a2,a5
    8000076a:	00000097          	auipc	ra,0x0
    8000076e:	f2e080e7          	jalr	-210(ra) # 80000698 <mappages>
    80000772:	e509                	bnez	a0,8000077c <kvmmap+0x20>
}
    80000774:	60a2                	ld	ra,8(sp)
    80000776:	6402                	ld	s0,0(sp)
    80000778:	0141                	addi	sp,sp,16
    8000077a:	8082                	ret
    panic("kvmmap");
    8000077c:	00008517          	auipc	a0,0x8
    80000780:	94c50513          	addi	a0,a0,-1716 # 800080c8 <etext+0xc8>
    80000784:	00005097          	auipc	ra,0x5
    80000788:	74e080e7          	jalr	1870(ra) # 80005ed2 <panic>

000000008000078c <kvmmake>:
{
    8000078c:	1101                	addi	sp,sp,-32
    8000078e:	ec06                	sd	ra,24(sp)
    80000790:	e822                	sd	s0,16(sp)
    80000792:	e426                	sd	s1,8(sp)
    80000794:	e04a                	sd	s2,0(sp)
    80000796:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000798:	00000097          	auipc	ra,0x0
    8000079c:	a6a080e7          	jalr	-1430(ra) # 80000202 <kalloc>
    800007a0:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800007a2:	6605                	lui	a2,0x1
    800007a4:	4581                	li	a1,0
    800007a6:	00000097          	auipc	ra,0x0
    800007aa:	ade080e7          	jalr	-1314(ra) # 80000284 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800007ae:	4719                	li	a4,6
    800007b0:	6685                	lui	a3,0x1
    800007b2:	10000637          	lui	a2,0x10000
    800007b6:	100005b7          	lui	a1,0x10000
    800007ba:	8526                	mv	a0,s1
    800007bc:	00000097          	auipc	ra,0x0
    800007c0:	fa0080e7          	jalr	-96(ra) # 8000075c <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800007c4:	4719                	li	a4,6
    800007c6:	6685                	lui	a3,0x1
    800007c8:	10001637          	lui	a2,0x10001
    800007cc:	100015b7          	lui	a1,0x10001
    800007d0:	8526                	mv	a0,s1
    800007d2:	00000097          	auipc	ra,0x0
    800007d6:	f8a080e7          	jalr	-118(ra) # 8000075c <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800007da:	4719                	li	a4,6
    800007dc:	004006b7          	lui	a3,0x400
    800007e0:	0c000637          	lui	a2,0xc000
    800007e4:	0c0005b7          	lui	a1,0xc000
    800007e8:	8526                	mv	a0,s1
    800007ea:	00000097          	auipc	ra,0x0
    800007ee:	f72080e7          	jalr	-142(ra) # 8000075c <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800007f2:	00008917          	auipc	s2,0x8
    800007f6:	80e90913          	addi	s2,s2,-2034 # 80008000 <etext>
    800007fa:	4729                	li	a4,10
    800007fc:	80008697          	auipc	a3,0x80008
    80000800:	80468693          	addi	a3,a3,-2044 # 8000 <_entry-0x7fff8000>
    80000804:	4605                	li	a2,1
    80000806:	067e                	slli	a2,a2,0x1f
    80000808:	85b2                	mv	a1,a2
    8000080a:	8526                	mv	a0,s1
    8000080c:	00000097          	auipc	ra,0x0
    80000810:	f50080e7          	jalr	-176(ra) # 8000075c <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000814:	4719                	li	a4,6
    80000816:	46c5                	li	a3,17
    80000818:	06ee                	slli	a3,a3,0x1b
    8000081a:	412686b3          	sub	a3,a3,s2
    8000081e:	864a                	mv	a2,s2
    80000820:	85ca                	mv	a1,s2
    80000822:	8526                	mv	a0,s1
    80000824:	00000097          	auipc	ra,0x0
    80000828:	f38080e7          	jalr	-200(ra) # 8000075c <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000082c:	4729                	li	a4,10
    8000082e:	6685                	lui	a3,0x1
    80000830:	00006617          	auipc	a2,0x6
    80000834:	7d060613          	addi	a2,a2,2000 # 80007000 <_trampoline>
    80000838:	040005b7          	lui	a1,0x4000
    8000083c:	15fd                	addi	a1,a1,-1
    8000083e:	05b2                	slli	a1,a1,0xc
    80000840:	8526                	mv	a0,s1
    80000842:	00000097          	auipc	ra,0x0
    80000846:	f1a080e7          	jalr	-230(ra) # 8000075c <kvmmap>
  proc_mapstacks(kpgtbl);
    8000084a:	8526                	mv	a0,s1
    8000084c:	00000097          	auipc	ra,0x0
    80000850:	740080e7          	jalr	1856(ra) # 80000f8c <proc_mapstacks>
}
    80000854:	8526                	mv	a0,s1
    80000856:	60e2                	ld	ra,24(sp)
    80000858:	6442                	ld	s0,16(sp)
    8000085a:	64a2                	ld	s1,8(sp)
    8000085c:	6902                	ld	s2,0(sp)
    8000085e:	6105                	addi	sp,sp,32
    80000860:	8082                	ret

0000000080000862 <kvminit>:
{
    80000862:	1141                	addi	sp,sp,-16
    80000864:	e406                	sd	ra,8(sp)
    80000866:	e022                	sd	s0,0(sp)
    80000868:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000086a:	00000097          	auipc	ra,0x0
    8000086e:	f22080e7          	jalr	-222(ra) # 8000078c <kvmmake>
    80000872:	00008797          	auipc	a5,0x8
    80000876:	20a7b323          	sd	a0,518(a5) # 80008a78 <kernel_pagetable>
}
    8000087a:	60a2                	ld	ra,8(sp)
    8000087c:	6402                	ld	s0,0(sp)
    8000087e:	0141                	addi	sp,sp,16
    80000880:	8082                	ret

0000000080000882 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000882:	715d                	addi	sp,sp,-80
    80000884:	e486                	sd	ra,72(sp)
    80000886:	e0a2                	sd	s0,64(sp)
    80000888:	fc26                	sd	s1,56(sp)
    8000088a:	f84a                	sd	s2,48(sp)
    8000088c:	f44e                	sd	s3,40(sp)
    8000088e:	f052                	sd	s4,32(sp)
    80000890:	ec56                	sd	s5,24(sp)
    80000892:	e85a                	sd	s6,16(sp)
    80000894:	e45e                	sd	s7,8(sp)
    80000896:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000898:	03459793          	slli	a5,a1,0x34
    8000089c:	e795                	bnez	a5,800008c8 <uvmunmap+0x46>
    8000089e:	8a2a                	mv	s4,a0
    800008a0:	892e                	mv	s2,a1
    800008a2:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008a4:	0632                	slli	a2,a2,0xc
    800008a6:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800008aa:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008ac:	6b05                	lui	s6,0x1
    800008ae:	0735e863          	bltu	a1,s3,8000091e <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800008b2:	60a6                	ld	ra,72(sp)
    800008b4:	6406                	ld	s0,64(sp)
    800008b6:	74e2                	ld	s1,56(sp)
    800008b8:	7942                	ld	s2,48(sp)
    800008ba:	79a2                	ld	s3,40(sp)
    800008bc:	7a02                	ld	s4,32(sp)
    800008be:	6ae2                	ld	s5,24(sp)
    800008c0:	6b42                	ld	s6,16(sp)
    800008c2:	6ba2                	ld	s7,8(sp)
    800008c4:	6161                	addi	sp,sp,80
    800008c6:	8082                	ret
    panic("uvmunmap: not aligned");
    800008c8:	00008517          	auipc	a0,0x8
    800008cc:	80850513          	addi	a0,a0,-2040 # 800080d0 <etext+0xd0>
    800008d0:	00005097          	auipc	ra,0x5
    800008d4:	602080e7          	jalr	1538(ra) # 80005ed2 <panic>
      panic("uvmunmap: walk");
    800008d8:	00008517          	auipc	a0,0x8
    800008dc:	81050513          	addi	a0,a0,-2032 # 800080e8 <etext+0xe8>
    800008e0:	00005097          	auipc	ra,0x5
    800008e4:	5f2080e7          	jalr	1522(ra) # 80005ed2 <panic>
      panic("uvmunmap: not mapped");
    800008e8:	00008517          	auipc	a0,0x8
    800008ec:	81050513          	addi	a0,a0,-2032 # 800080f8 <etext+0xf8>
    800008f0:	00005097          	auipc	ra,0x5
    800008f4:	5e2080e7          	jalr	1506(ra) # 80005ed2 <panic>
      panic("uvmunmap: not a leaf");
    800008f8:	00008517          	auipc	a0,0x8
    800008fc:	81850513          	addi	a0,a0,-2024 # 80008110 <etext+0x110>
    80000900:	00005097          	auipc	ra,0x5
    80000904:	5d2080e7          	jalr	1490(ra) # 80005ed2 <panic>
      uint64 pa = PTE2PA(*pte);
    80000908:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000090a:	0532                	slli	a0,a0,0xc
    8000090c:	fffff097          	auipc	ra,0xfffff
    80000910:	7b0080e7          	jalr	1968(ra) # 800000bc <kfree>
    *pte = 0;
    80000914:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000918:	995a                	add	s2,s2,s6
    8000091a:	f9397ce3          	bgeu	s2,s3,800008b2 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000091e:	4601                	li	a2,0
    80000920:	85ca                	mv	a1,s2
    80000922:	8552                	mv	a0,s4
    80000924:	00000097          	auipc	ra,0x0
    80000928:	c4c080e7          	jalr	-948(ra) # 80000570 <walk>
    8000092c:	84aa                	mv	s1,a0
    8000092e:	d54d                	beqz	a0,800008d8 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    80000930:	6108                	ld	a0,0(a0)
    80000932:	00157793          	andi	a5,a0,1
    80000936:	dbcd                	beqz	a5,800008e8 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80000938:	3ff57793          	andi	a5,a0,1023
    8000093c:	fb778ee3          	beq	a5,s7,800008f8 <uvmunmap+0x76>
    if(do_free){
    80000940:	fc0a8ae3          	beqz	s5,80000914 <uvmunmap+0x92>
    80000944:	b7d1                	j	80000908 <uvmunmap+0x86>

0000000080000946 <handle_COW>:
  if(!stval)
    80000946:	cdf9                	beqz	a1,80000a24 <handle_COW+0xde>
int handle_COW(pagetable_t pgt, uint64 stval){
    80000948:	7139                	addi	sp,sp,-64
    8000094a:	fc06                	sd	ra,56(sp)
    8000094c:	f822                	sd	s0,48(sp)
    8000094e:	f426                	sd	s1,40(sp)
    80000950:	f04a                	sd	s2,32(sp)
    80000952:	ec4e                	sd	s3,24(sp)
    80000954:	e852                	sd	s4,16(sp)
    80000956:	e456                	sd	s5,8(sp)
    80000958:	0080                	addi	s0,sp,64
    8000095a:	89aa                	mv	s3,a0
  uint64 va = PGROUNDDOWN(stval);
    8000095c:	74fd                	lui	s1,0xfffff
    8000095e:	8ced                	and	s1,s1,a1
  pte_t* pte = walk(pgt, va, 0);
    80000960:	4601                	li	a2,0
    80000962:	85a6                	mv	a1,s1
    80000964:	00000097          	auipc	ra,0x0
    80000968:	c0c080e7          	jalr	-1012(ra) # 80000570 <walk>
  if (pte == 0){
    8000096c:	c135                	beqz	a0,800009d0 <handle_COW+0x8a>
  uint64 flags = (PTE_FLAGS(*pte) & (~PTE_C)) | (PTE_W);
    8000096e:	610c                	ld	a1,0(a0)
    80000970:	2fb5f713          	andi	a4,a1,763
    80000974:	00476a93          	ori	s5,a4,4
  uint64 pa = PTE2PA(*pte);
    80000978:	81a9                	srli	a1,a1,0xa
    8000097a:	00c59913          	slli	s2,a1,0xc
  if((mem = kalloc()) == 0) // 没有空闲内存
    8000097e:	00000097          	auipc	ra,0x0
    80000982:	884080e7          	jalr	-1916(ra) # 80000202 <kalloc>
    80000986:	8a2a                	mv	s4,a0
    80000988:	cd31                	beqz	a0,800009e4 <handle_COW+0x9e>
  if(pa){
    8000098a:	06090763          	beqz	s2,800009f8 <handle_COW+0xb2>
    memmove(mem, (char*)pa, PGSIZE);  // 拷贝内存
    8000098e:	6605                	lui	a2,0x1
    80000990:	85ca                	mv	a1,s2
    80000992:	00000097          	auipc	ra,0x0
    80000996:	952080e7          	jalr	-1710(ra) # 800002e4 <memmove>
    uvmunmap(pgt, va, 1, 1);
    8000099a:	4685                	li	a3,1
    8000099c:	4605                	li	a2,1
    8000099e:	85a6                	mv	a1,s1
    800009a0:	854e                	mv	a0,s3
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	ee0080e7          	jalr	-288(ra) # 80000882 <uvmunmap>
  if(mappages(pgt, va, PGSIZE, (uint64)mem, flags) != 0){
    800009aa:	8756                	mv	a4,s5
    800009ac:	86d2                	mv	a3,s4
    800009ae:	6605                	lui	a2,0x1
    800009b0:	85a6                	mv	a1,s1
    800009b2:	854e                	mv	a0,s3
    800009b4:	00000097          	auipc	ra,0x0
    800009b8:	ce4080e7          	jalr	-796(ra) # 80000698 <mappages>
    800009bc:	e529                	bnez	a0,80000a06 <handle_COW+0xc0>
}
    800009be:	70e2                	ld	ra,56(sp)
    800009c0:	7442                	ld	s0,48(sp)
    800009c2:	74a2                	ld	s1,40(sp)
    800009c4:	7902                	ld	s2,32(sp)
    800009c6:	69e2                	ld	s3,24(sp)
    800009c8:	6a42                	ld	s4,16(sp)
    800009ca:	6aa2                	ld	s5,8(sp)
    800009cc:	6121                	addi	sp,sp,64
    800009ce:	8082                	ret
    printf("Error: can't find pte, walk error in handle_COW()[vm.c:22].\n");
    800009d0:	00007517          	auipc	a0,0x7
    800009d4:	75850513          	addi	a0,a0,1880 # 80008128 <etext+0x128>
    800009d8:	00005097          	auipc	ra,0x5
    800009dc:	544080e7          	jalr	1348(ra) # 80005f1c <printf>
    return -1;
    800009e0:	557d                	li	a0,-1
    800009e2:	bff1                	j	800009be <handle_COW+0x78>
    printf("Not enough memory for copy(COW) in [vm.c:33]\n");
    800009e4:	00007517          	auipc	a0,0x7
    800009e8:	78450513          	addi	a0,a0,1924 # 80008168 <etext+0x168>
    800009ec:	00005097          	auipc	ra,0x5
    800009f0:	530080e7          	jalr	1328(ra) # 80005f1c <printf>
    return -1;
    800009f4:	557d                	li	a0,-1
    800009f6:	b7e1                	j	800009be <handle_COW+0x78>
    kfree((void*) pa);
    800009f8:	4501                	li	a0,0
    800009fa:	fffff097          	auipc	ra,0xfffff
    800009fe:	6c2080e7          	jalr	1730(ra) # 800000bc <kfree>
    return -1;
    80000a02:	557d                	li	a0,-1
    80000a04:	bf6d                	j	800009be <handle_COW+0x78>
    kfree(mem);
    80000a06:	8552                	mv	a0,s4
    80000a08:	fffff097          	auipc	ra,0xfffff
    80000a0c:	6b4080e7          	jalr	1716(ra) # 800000bc <kfree>
    printf("Can't map new page(COW) in [vm.c:41]\n");
    80000a10:	00007517          	auipc	a0,0x7
    80000a14:	78850513          	addi	a0,a0,1928 # 80008198 <etext+0x198>
    80000a18:	00005097          	auipc	ra,0x5
    80000a1c:	504080e7          	jalr	1284(ra) # 80005f1c <printf>
    return -1;
    80000a20:	557d                	li	a0,-1
    80000a22:	bf71                	j	800009be <handle_COW+0x78>
    return -1;
    80000a24:	557d                	li	a0,-1
}
    80000a26:	8082                	ret

0000000080000a28 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000a28:	1101                	addi	sp,sp,-32
    80000a2a:	ec06                	sd	ra,24(sp)
    80000a2c:	e822                	sd	s0,16(sp)
    80000a2e:	e426                	sd	s1,8(sp)
    80000a30:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000a32:	fffff097          	auipc	ra,0xfffff
    80000a36:	7d0080e7          	jalr	2000(ra) # 80000202 <kalloc>
    80000a3a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000a3c:	c519                	beqz	a0,80000a4a <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000a3e:	6605                	lui	a2,0x1
    80000a40:	4581                	li	a1,0
    80000a42:	00000097          	auipc	ra,0x0
    80000a46:	842080e7          	jalr	-1982(ra) # 80000284 <memset>
  return pagetable;
}
    80000a4a:	8526                	mv	a0,s1
    80000a4c:	60e2                	ld	ra,24(sp)
    80000a4e:	6442                	ld	s0,16(sp)
    80000a50:	64a2                	ld	s1,8(sp)
    80000a52:	6105                	addi	sp,sp,32
    80000a54:	8082                	ret

0000000080000a56 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000a56:	7179                	addi	sp,sp,-48
    80000a58:	f406                	sd	ra,40(sp)
    80000a5a:	f022                	sd	s0,32(sp)
    80000a5c:	ec26                	sd	s1,24(sp)
    80000a5e:	e84a                	sd	s2,16(sp)
    80000a60:	e44e                	sd	s3,8(sp)
    80000a62:	e052                	sd	s4,0(sp)
    80000a64:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000a66:	6785                	lui	a5,0x1
    80000a68:	04f67863          	bgeu	a2,a5,80000ab8 <uvmfirst+0x62>
    80000a6c:	8a2a                	mv	s4,a0
    80000a6e:	89ae                	mv	s3,a1
    80000a70:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000a72:	fffff097          	auipc	ra,0xfffff
    80000a76:	790080e7          	jalr	1936(ra) # 80000202 <kalloc>
    80000a7a:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000a7c:	6605                	lui	a2,0x1
    80000a7e:	4581                	li	a1,0
    80000a80:	00000097          	auipc	ra,0x0
    80000a84:	804080e7          	jalr	-2044(ra) # 80000284 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000a88:	4779                	li	a4,30
    80000a8a:	86ca                	mv	a3,s2
    80000a8c:	6605                	lui	a2,0x1
    80000a8e:	4581                	li	a1,0
    80000a90:	8552                	mv	a0,s4
    80000a92:	00000097          	auipc	ra,0x0
    80000a96:	c06080e7          	jalr	-1018(ra) # 80000698 <mappages>
  memmove(mem, src, sz);
    80000a9a:	8626                	mv	a2,s1
    80000a9c:	85ce                	mv	a1,s3
    80000a9e:	854a                	mv	a0,s2
    80000aa0:	00000097          	auipc	ra,0x0
    80000aa4:	844080e7          	jalr	-1980(ra) # 800002e4 <memmove>
}
    80000aa8:	70a2                	ld	ra,40(sp)
    80000aaa:	7402                	ld	s0,32(sp)
    80000aac:	64e2                	ld	s1,24(sp)
    80000aae:	6942                	ld	s2,16(sp)
    80000ab0:	69a2                	ld	s3,8(sp)
    80000ab2:	6a02                	ld	s4,0(sp)
    80000ab4:	6145                	addi	sp,sp,48
    80000ab6:	8082                	ret
    panic("uvmfirst: more than a page");
    80000ab8:	00007517          	auipc	a0,0x7
    80000abc:	70850513          	addi	a0,a0,1800 # 800081c0 <etext+0x1c0>
    80000ac0:	00005097          	auipc	ra,0x5
    80000ac4:	412080e7          	jalr	1042(ra) # 80005ed2 <panic>

0000000080000ac8 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000ac8:	1101                	addi	sp,sp,-32
    80000aca:	ec06                	sd	ra,24(sp)
    80000acc:	e822                	sd	s0,16(sp)
    80000ace:	e426                	sd	s1,8(sp)
    80000ad0:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000ad2:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000ad4:	00b67d63          	bgeu	a2,a1,80000aee <uvmdealloc+0x26>
    80000ad8:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000ada:	6785                	lui	a5,0x1
    80000adc:	17fd                	addi	a5,a5,-1
    80000ade:	00f60733          	add	a4,a2,a5
    80000ae2:	767d                	lui	a2,0xfffff
    80000ae4:	8f71                	and	a4,a4,a2
    80000ae6:	97ae                	add	a5,a5,a1
    80000ae8:	8ff1                	and	a5,a5,a2
    80000aea:	00f76863          	bltu	a4,a5,80000afa <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000aee:	8526                	mv	a0,s1
    80000af0:	60e2                	ld	ra,24(sp)
    80000af2:	6442                	ld	s0,16(sp)
    80000af4:	64a2                	ld	s1,8(sp)
    80000af6:	6105                	addi	sp,sp,32
    80000af8:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000afa:	8f99                	sub	a5,a5,a4
    80000afc:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000afe:	4685                	li	a3,1
    80000b00:	0007861b          	sext.w	a2,a5
    80000b04:	85ba                	mv	a1,a4
    80000b06:	00000097          	auipc	ra,0x0
    80000b0a:	d7c080e7          	jalr	-644(ra) # 80000882 <uvmunmap>
    80000b0e:	b7c5                	j	80000aee <uvmdealloc+0x26>

0000000080000b10 <uvmalloc>:
  if(newsz < oldsz)
    80000b10:	0ab66563          	bltu	a2,a1,80000bba <uvmalloc+0xaa>
{
    80000b14:	7139                	addi	sp,sp,-64
    80000b16:	fc06                	sd	ra,56(sp)
    80000b18:	f822                	sd	s0,48(sp)
    80000b1a:	f426                	sd	s1,40(sp)
    80000b1c:	f04a                	sd	s2,32(sp)
    80000b1e:	ec4e                	sd	s3,24(sp)
    80000b20:	e852                	sd	s4,16(sp)
    80000b22:	e456                	sd	s5,8(sp)
    80000b24:	e05a                	sd	s6,0(sp)
    80000b26:	0080                	addi	s0,sp,64
    80000b28:	8aaa                	mv	s5,a0
    80000b2a:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000b2c:	6985                	lui	s3,0x1
    80000b2e:	19fd                	addi	s3,s3,-1
    80000b30:	95ce                	add	a1,a1,s3
    80000b32:	79fd                	lui	s3,0xfffff
    80000b34:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000b38:	08c9f363          	bgeu	s3,a2,80000bbe <uvmalloc+0xae>
    80000b3c:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000b3e:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000b42:	fffff097          	auipc	ra,0xfffff
    80000b46:	6c0080e7          	jalr	1728(ra) # 80000202 <kalloc>
    80000b4a:	84aa                	mv	s1,a0
    if(mem == 0){
    80000b4c:	c51d                	beqz	a0,80000b7a <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80000b4e:	6605                	lui	a2,0x1
    80000b50:	4581                	li	a1,0
    80000b52:	fffff097          	auipc	ra,0xfffff
    80000b56:	732080e7          	jalr	1842(ra) # 80000284 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000b5a:	875a                	mv	a4,s6
    80000b5c:	86a6                	mv	a3,s1
    80000b5e:	6605                	lui	a2,0x1
    80000b60:	85ca                	mv	a1,s2
    80000b62:	8556                	mv	a0,s5
    80000b64:	00000097          	auipc	ra,0x0
    80000b68:	b34080e7          	jalr	-1228(ra) # 80000698 <mappages>
    80000b6c:	e90d                	bnez	a0,80000b9e <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000b6e:	6785                	lui	a5,0x1
    80000b70:	993e                	add	s2,s2,a5
    80000b72:	fd4968e3          	bltu	s2,s4,80000b42 <uvmalloc+0x32>
  return newsz;
    80000b76:	8552                	mv	a0,s4
    80000b78:	a809                	j	80000b8a <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000b7a:	864e                	mv	a2,s3
    80000b7c:	85ca                	mv	a1,s2
    80000b7e:	8556                	mv	a0,s5
    80000b80:	00000097          	auipc	ra,0x0
    80000b84:	f48080e7          	jalr	-184(ra) # 80000ac8 <uvmdealloc>
      return 0;
    80000b88:	4501                	li	a0,0
}
    80000b8a:	70e2                	ld	ra,56(sp)
    80000b8c:	7442                	ld	s0,48(sp)
    80000b8e:	74a2                	ld	s1,40(sp)
    80000b90:	7902                	ld	s2,32(sp)
    80000b92:	69e2                	ld	s3,24(sp)
    80000b94:	6a42                	ld	s4,16(sp)
    80000b96:	6aa2                	ld	s5,8(sp)
    80000b98:	6b02                	ld	s6,0(sp)
    80000b9a:	6121                	addi	sp,sp,64
    80000b9c:	8082                	ret
      kfree(mem);
    80000b9e:	8526                	mv	a0,s1
    80000ba0:	fffff097          	auipc	ra,0xfffff
    80000ba4:	51c080e7          	jalr	1308(ra) # 800000bc <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000ba8:	864e                	mv	a2,s3
    80000baa:	85ca                	mv	a1,s2
    80000bac:	8556                	mv	a0,s5
    80000bae:	00000097          	auipc	ra,0x0
    80000bb2:	f1a080e7          	jalr	-230(ra) # 80000ac8 <uvmdealloc>
      return 0;
    80000bb6:	4501                	li	a0,0
    80000bb8:	bfc9                	j	80000b8a <uvmalloc+0x7a>
    return oldsz;
    80000bba:	852e                	mv	a0,a1
}
    80000bbc:	8082                	ret
  return newsz;
    80000bbe:	8532                	mv	a0,a2
    80000bc0:	b7e9                	j	80000b8a <uvmalloc+0x7a>

0000000080000bc2 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000bc2:	7179                	addi	sp,sp,-48
    80000bc4:	f406                	sd	ra,40(sp)
    80000bc6:	f022                	sd	s0,32(sp)
    80000bc8:	ec26                	sd	s1,24(sp)
    80000bca:	e84a                	sd	s2,16(sp)
    80000bcc:	e44e                	sd	s3,8(sp)
    80000bce:	e052                	sd	s4,0(sp)
    80000bd0:	1800                	addi	s0,sp,48
    80000bd2:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000bd4:	84aa                	mv	s1,a0
    80000bd6:	6905                	lui	s2,0x1
    80000bd8:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000bda:	4985                	li	s3,1
    80000bdc:	a821                	j	80000bf4 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000bde:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80000be0:	0532                	slli	a0,a0,0xc
    80000be2:	00000097          	auipc	ra,0x0
    80000be6:	fe0080e7          	jalr	-32(ra) # 80000bc2 <freewalk>
      pagetable[i] = 0;
    80000bea:	0004b023          	sd	zero,0(s1) # fffffffffffff000 <end+0xffffffff7ffbd0d0>
  for(int i = 0; i < 512; i++){
    80000bee:	04a1                	addi	s1,s1,8
    80000bf0:	03248163          	beq	s1,s2,80000c12 <freewalk+0x50>
    pte_t pte = pagetable[i];
    80000bf4:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000bf6:	00f57793          	andi	a5,a0,15
    80000bfa:	ff3782e3          	beq	a5,s3,80000bde <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000bfe:	8905                	andi	a0,a0,1
    80000c00:	d57d                	beqz	a0,80000bee <freewalk+0x2c>
      panic("freewalk: leaf");
    80000c02:	00007517          	auipc	a0,0x7
    80000c06:	5de50513          	addi	a0,a0,1502 # 800081e0 <etext+0x1e0>
    80000c0a:	00005097          	auipc	ra,0x5
    80000c0e:	2c8080e7          	jalr	712(ra) # 80005ed2 <panic>
    }
  }
  kfree((void*)pagetable);
    80000c12:	8552                	mv	a0,s4
    80000c14:	fffff097          	auipc	ra,0xfffff
    80000c18:	4a8080e7          	jalr	1192(ra) # 800000bc <kfree>
}
    80000c1c:	70a2                	ld	ra,40(sp)
    80000c1e:	7402                	ld	s0,32(sp)
    80000c20:	64e2                	ld	s1,24(sp)
    80000c22:	6942                	ld	s2,16(sp)
    80000c24:	69a2                	ld	s3,8(sp)
    80000c26:	6a02                	ld	s4,0(sp)
    80000c28:	6145                	addi	sp,sp,48
    80000c2a:	8082                	ret

0000000080000c2c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000c2c:	1101                	addi	sp,sp,-32
    80000c2e:	ec06                	sd	ra,24(sp)
    80000c30:	e822                	sd	s0,16(sp)
    80000c32:	e426                	sd	s1,8(sp)
    80000c34:	1000                	addi	s0,sp,32
    80000c36:	84aa                	mv	s1,a0
  if(sz > 0)
    80000c38:	e999                	bnez	a1,80000c4e <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000c3a:	8526                	mv	a0,s1
    80000c3c:	00000097          	auipc	ra,0x0
    80000c40:	f86080e7          	jalr	-122(ra) # 80000bc2 <freewalk>
}
    80000c44:	60e2                	ld	ra,24(sp)
    80000c46:	6442                	ld	s0,16(sp)
    80000c48:	64a2                	ld	s1,8(sp)
    80000c4a:	6105                	addi	sp,sp,32
    80000c4c:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000c4e:	6605                	lui	a2,0x1
    80000c50:	167d                	addi	a2,a2,-1
    80000c52:	962e                	add	a2,a2,a1
    80000c54:	4685                	li	a3,1
    80000c56:	8231                	srli	a2,a2,0xc
    80000c58:	4581                	li	a1,0
    80000c5a:	00000097          	auipc	ra,0x0
    80000c5e:	c28080e7          	jalr	-984(ra) # 80000882 <uvmunmap>
    80000c62:	bfe1                	j	80000c3a <uvmfree+0xe>

0000000080000c64 <uvmcopy>:
{
  pte_t *pte;
  uint64 pa, i;
  uint flags;

  for(i = 0; i < sz; i += PGSIZE){
    80000c64:	c65d                	beqz	a2,80000d12 <uvmcopy+0xae>
{
    80000c66:	7139                	addi	sp,sp,-64
    80000c68:	fc06                	sd	ra,56(sp)
    80000c6a:	f822                	sd	s0,48(sp)
    80000c6c:	f426                	sd	s1,40(sp)
    80000c6e:	f04a                	sd	s2,32(sp)
    80000c70:	ec4e                	sd	s3,24(sp)
    80000c72:	e852                	sd	s4,16(sp)
    80000c74:	e456                	sd	s5,8(sp)
    80000c76:	0080                	addi	s0,sp,64
    80000c78:	8a2a                	mv	s4,a0
    80000c7a:	8aae                	mv	s5,a1
    80000c7c:	89b2                	mv	s3,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000c7e:	4481                	li	s1,0
    if((pte = walk(old, i, 0)) == 0)
    80000c80:	4601                	li	a2,0
    80000c82:	85a6                	mv	a1,s1
    80000c84:	8552                	mv	a0,s4
    80000c86:	00000097          	auipc	ra,0x0
    80000c8a:	8ea080e7          	jalr	-1814(ra) # 80000570 <walk>
    80000c8e:	c931                	beqz	a0,80000ce2 <uvmcopy+0x7e>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000c90:	6118                	ld	a4,0(a0)
    80000c92:	00177793          	andi	a5,a4,1
    80000c96:	cfb1                	beqz	a5,80000cf2 <uvmcopy+0x8e>
      panic("uvmcopy: page not present");
      
    pa = PTE2PA(*pte);
    80000c98:	00a75913          	srli	s2,a4,0xa
    80000c9c:	0932                	slli	s2,s2,0xc
    *pte &= ~PTE_W;
    80000c9e:	9b6d                	andi	a4,a4,-5
    *pte |= PTE_C;
    80000ca0:	10076713          	ori	a4,a4,256
    80000ca4:	e118                	sd	a4,0(a0)
    flags = PTE_FLAGS(*pte);
    
    
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
    80000ca6:	3fb77713          	andi	a4,a4,1019
    80000caa:	86ca                	mv	a3,s2
    80000cac:	6605                	lui	a2,0x1
    80000cae:	85a6                	mv	a1,s1
    80000cb0:	8556                	mv	a0,s5
    80000cb2:	00000097          	auipc	ra,0x0
    80000cb6:	9e6080e7          	jalr	-1562(ra) # 80000698 <mappages>
    80000cba:	e521                	bnez	a0,80000d02 <uvmcopy+0x9e>
      panic("uvmcopy: can't map father page to child");
      goto err;
    }
    
    inc_cow_cnt((void*) pa);
    80000cbc:	854a                	mv	a0,s2
    80000cbe:	fffff097          	auipc	ra,0xfffff
    80000cc2:	35e080e7          	jalr	862(ra) # 8000001c <inc_cow_cnt>
  for(i = 0; i < sz; i += PGSIZE){
    80000cc6:	6785                	lui	a5,0x1
    80000cc8:	94be                	add	s1,s1,a5
    80000cca:	fb34ebe3          	bltu	s1,s3,80000c80 <uvmcopy+0x1c>
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
  return -1;
}
    80000cce:	4501                	li	a0,0
    80000cd0:	70e2                	ld	ra,56(sp)
    80000cd2:	7442                	ld	s0,48(sp)
    80000cd4:	74a2                	ld	s1,40(sp)
    80000cd6:	7902                	ld	s2,32(sp)
    80000cd8:	69e2                	ld	s3,24(sp)
    80000cda:	6a42                	ld	s4,16(sp)
    80000cdc:	6aa2                	ld	s5,8(sp)
    80000cde:	6121                	addi	sp,sp,64
    80000ce0:	8082                	ret
      panic("uvmcopy: pte should exist");
    80000ce2:	00007517          	auipc	a0,0x7
    80000ce6:	50e50513          	addi	a0,a0,1294 # 800081f0 <etext+0x1f0>
    80000cea:	00005097          	auipc	ra,0x5
    80000cee:	1e8080e7          	jalr	488(ra) # 80005ed2 <panic>
      panic("uvmcopy: page not present");
    80000cf2:	00007517          	auipc	a0,0x7
    80000cf6:	51e50513          	addi	a0,a0,1310 # 80008210 <etext+0x210>
    80000cfa:	00005097          	auipc	ra,0x5
    80000cfe:	1d8080e7          	jalr	472(ra) # 80005ed2 <panic>
      panic("uvmcopy: can't map father page to child");
    80000d02:	00007517          	auipc	a0,0x7
    80000d06:	52e50513          	addi	a0,a0,1326 # 80008230 <etext+0x230>
    80000d0a:	00005097          	auipc	ra,0x5
    80000d0e:	1c8080e7          	jalr	456(ra) # 80005ed2 <panic>
}
    80000d12:	4501                	li	a0,0
    80000d14:	8082                	ret

0000000080000d16 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000d16:	1141                	addi	sp,sp,-16
    80000d18:	e406                	sd	ra,8(sp)
    80000d1a:	e022                	sd	s0,0(sp)
    80000d1c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000d1e:	4601                	li	a2,0
    80000d20:	00000097          	auipc	ra,0x0
    80000d24:	850080e7          	jalr	-1968(ra) # 80000570 <walk>
  if(pte == 0)
    80000d28:	c901                	beqz	a0,80000d38 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000d2a:	611c                	ld	a5,0(a0)
    80000d2c:	9bbd                	andi	a5,a5,-17
    80000d2e:	e11c                	sd	a5,0(a0)
}
    80000d30:	60a2                	ld	ra,8(sp)
    80000d32:	6402                	ld	s0,0(sp)
    80000d34:	0141                	addi	sp,sp,16
    80000d36:	8082                	ret
    panic("uvmclear");
    80000d38:	00007517          	auipc	a0,0x7
    80000d3c:	52050513          	addi	a0,a0,1312 # 80008258 <etext+0x258>
    80000d40:	00005097          	auipc	ra,0x5
    80000d44:	192080e7          	jalr	402(ra) # 80005ed2 <panic>

0000000080000d48 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    80000d48:	caf5                	beqz	a3,80000e3c <copyout+0xf4>
{
    80000d4a:	711d                	addi	sp,sp,-96
    80000d4c:	ec86                	sd	ra,88(sp)
    80000d4e:	e8a2                	sd	s0,80(sp)
    80000d50:	e4a6                	sd	s1,72(sp)
    80000d52:	e0ca                	sd	s2,64(sp)
    80000d54:	fc4e                	sd	s3,56(sp)
    80000d56:	f852                	sd	s4,48(sp)
    80000d58:	f456                	sd	s5,40(sp)
    80000d5a:	f05a                	sd	s6,32(sp)
    80000d5c:	ec5e                	sd	s7,24(sp)
    80000d5e:	e862                	sd	s8,16(sp)
    80000d60:	e466                	sd	s9,8(sp)
    80000d62:	e06a                	sd	s10,0(sp)
    80000d64:	1080                	addi	s0,sp,96
    80000d66:	8b2a                	mv	s6,a0
    80000d68:	8a2e                	mv	s4,a1
    80000d6a:	8ab2                	mv	s5,a2
    80000d6c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000d6e:	74fd                	lui	s1,0xfffff
    80000d70:	8ced                	and	s1,s1,a1
    if(va0 >= MAXVA)
    80000d72:	57fd                	li	a5,-1
    80000d74:	83e9                	srli	a5,a5,0x1a
    80000d76:	0c97e563          	bltu	a5,s1,80000e40 <copyout+0xf8>
      return -1;
    
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0){
    80000d7a:	4c45                	li	s8,17
    80000d7c:	6c85                	lui	s9,0x1
    if(va0 >= MAXVA)
    80000d7e:	8bbe                	mv	s7,a5
    80000d80:	a0ad                	j	80000dea <copyout+0xa2>
      printf("copycout() in [vm.c:414]: Page fault, copy terminates.\n");
    80000d82:	00007517          	auipc	a0,0x7
    80000d86:	4e650513          	addi	a0,a0,1254 # 80008268 <etext+0x268>
    80000d8a:	00005097          	auipc	ra,0x5
    80000d8e:	192080e7          	jalr	402(ra) # 80005f1c <printf>
      return -1;
    80000d92:	557d                	li	a0,-1
    len -= n;
    src += n;
    dstva = va0 + PGSIZE;
  }
  return 0;
}
    80000d94:	60e6                	ld	ra,88(sp)
    80000d96:	6446                	ld	s0,80(sp)
    80000d98:	64a6                	ld	s1,72(sp)
    80000d9a:	6906                	ld	s2,64(sp)
    80000d9c:	79e2                	ld	s3,56(sp)
    80000d9e:	7a42                	ld	s4,48(sp)
    80000da0:	7aa2                	ld	s5,40(sp)
    80000da2:	7b02                	ld	s6,32(sp)
    80000da4:	6be2                	ld	s7,24(sp)
    80000da6:	6c42                	ld	s8,16(sp)
    80000da8:	6ca2                	ld	s9,8(sp)
    80000daa:	6d02                	ld	s10,0(sp)
    80000dac:	6125                	addi	sp,sp,96
    80000dae:	8082                	ret
        printf("copycout() in [vm.c:420]: COW failed, copy terminates.\n");
    80000db0:	00007517          	auipc	a0,0x7
    80000db4:	4f050513          	addi	a0,a0,1264 # 800082a0 <etext+0x2a0>
    80000db8:	00005097          	auipc	ra,0x5
    80000dbc:	164080e7          	jalr	356(ra) # 80005f1c <printf>
        return -1;
    80000dc0:	557d                	li	a0,-1
    80000dc2:	bfc9                	j	80000d94 <copyout+0x4c>
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000dc4:	409a04b3          	sub	s1,s4,s1
    80000dc8:	0009061b          	sext.w	a2,s2
    80000dcc:	85d6                	mv	a1,s5
    80000dce:	9526                	add	a0,a0,s1
    80000dd0:	fffff097          	auipc	ra,0xfffff
    80000dd4:	514080e7          	jalr	1300(ra) # 800002e4 <memmove>
    len -= n;
    80000dd8:	412989b3          	sub	s3,s3,s2
    src += n;
    80000ddc:	9aca                	add	s5,s5,s2
  while(len > 0){
    80000dde:	04098d63          	beqz	s3,80000e38 <copyout+0xf0>
    if(va0 >= MAXVA)
    80000de2:	07abe163          	bltu	s7,s10,80000e44 <copyout+0xfc>
    va0 = PGROUNDDOWN(dstva);
    80000de6:	84ea                	mv	s1,s10
    dstva = va0 + PGSIZE;
    80000de8:	8a6a                	mv	s4,s10
    pte = walk(pagetable, va0, 0);
    80000dea:	4601                	li	a2,0
    80000dec:	85a6                	mv	a1,s1
    80000dee:	855a                	mv	a0,s6
    80000df0:	fffff097          	auipc	ra,0xfffff
    80000df4:	780080e7          	jalr	1920(ra) # 80000570 <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0){
    80000df8:	d549                	beqz	a0,80000d82 <copyout+0x3a>
    80000dfa:	611c                	ld	a5,0(a0)
    80000dfc:	0117f713          	andi	a4,a5,17
    80000e00:	f98711e3          	bne	a4,s8,80000d82 <copyout+0x3a>
    if (*pte & PTE_C){
    80000e04:	1007f793          	andi	a5,a5,256
    80000e08:	cb89                	beqz	a5,80000e1a <copyout+0xd2>
      if (handle_COW(pagetable, va0) < 0){
    80000e0a:	85a6                	mv	a1,s1
    80000e0c:	855a                	mv	a0,s6
    80000e0e:	00000097          	auipc	ra,0x0
    80000e12:	b38080e7          	jalr	-1224(ra) # 80000946 <handle_COW>
    80000e16:	f8054de3          	bltz	a0,80000db0 <copyout+0x68>
    pa0 = walkaddr(pagetable, va0);
    80000e1a:	85a6                	mv	a1,s1
    80000e1c:	855a                	mv	a0,s6
    80000e1e:	00000097          	auipc	ra,0x0
    80000e22:	838080e7          	jalr	-1992(ra) # 80000656 <walkaddr>
    if (!pa0)
    80000e26:	c10d                	beqz	a0,80000e48 <copyout+0x100>
    n = PGSIZE - (dstva - va0);
    80000e28:	01948d33          	add	s10,s1,s9
    80000e2c:	414d0933          	sub	s2,s10,s4
    if(n > len)
    80000e30:	f929fae3          	bgeu	s3,s2,80000dc4 <copyout+0x7c>
    80000e34:	894e                	mv	s2,s3
    80000e36:	b779                	j	80000dc4 <copyout+0x7c>
  return 0;
    80000e38:	4501                	li	a0,0
    80000e3a:	bfa9                	j	80000d94 <copyout+0x4c>
    80000e3c:	4501                	li	a0,0
}
    80000e3e:	8082                	ret
      return -1;
    80000e40:	557d                	li	a0,-1
    80000e42:	bf89                	j	80000d94 <copyout+0x4c>
    80000e44:	557d                	li	a0,-1
    80000e46:	b7b9                	j	80000d94 <copyout+0x4c>
      return -1;
    80000e48:	557d                	li	a0,-1
    80000e4a:	b7a9                	j	80000d94 <copyout+0x4c>

0000000080000e4c <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000e4c:	c6bd                	beqz	a3,80000eba <copyin+0x6e>
{
    80000e4e:	715d                	addi	sp,sp,-80
    80000e50:	e486                	sd	ra,72(sp)
    80000e52:	e0a2                	sd	s0,64(sp)
    80000e54:	fc26                	sd	s1,56(sp)
    80000e56:	f84a                	sd	s2,48(sp)
    80000e58:	f44e                	sd	s3,40(sp)
    80000e5a:	f052                	sd	s4,32(sp)
    80000e5c:	ec56                	sd	s5,24(sp)
    80000e5e:	e85a                	sd	s6,16(sp)
    80000e60:	e45e                	sd	s7,8(sp)
    80000e62:	e062                	sd	s8,0(sp)
    80000e64:	0880                	addi	s0,sp,80
    80000e66:	8b2a                	mv	s6,a0
    80000e68:	8a2e                	mv	s4,a1
    80000e6a:	8c32                	mv	s8,a2
    80000e6c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000e6e:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000e70:	6a85                	lui	s5,0x1
    80000e72:	a015                	j	80000e96 <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000e74:	9562                	add	a0,a0,s8
    80000e76:	0004861b          	sext.w	a2,s1
    80000e7a:	412505b3          	sub	a1,a0,s2
    80000e7e:	8552                	mv	a0,s4
    80000e80:	fffff097          	auipc	ra,0xfffff
    80000e84:	464080e7          	jalr	1124(ra) # 800002e4 <memmove>

    len -= n;
    80000e88:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000e8c:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000e8e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000e92:	02098263          	beqz	s3,80000eb6 <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000e96:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000e9a:	85ca                	mv	a1,s2
    80000e9c:	855a                	mv	a0,s6
    80000e9e:	fffff097          	auipc	ra,0xfffff
    80000ea2:	7b8080e7          	jalr	1976(ra) # 80000656 <walkaddr>
    if(pa0 == 0)
    80000ea6:	cd01                	beqz	a0,80000ebe <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000ea8:	418904b3          	sub	s1,s2,s8
    80000eac:	94d6                	add	s1,s1,s5
    if(n > len)
    80000eae:	fc99f3e3          	bgeu	s3,s1,80000e74 <copyin+0x28>
    80000eb2:	84ce                	mv	s1,s3
    80000eb4:	b7c1                	j	80000e74 <copyin+0x28>
  }
  return 0;
    80000eb6:	4501                	li	a0,0
    80000eb8:	a021                	j	80000ec0 <copyin+0x74>
    80000eba:	4501                	li	a0,0
}
    80000ebc:	8082                	ret
      return -1;
    80000ebe:	557d                	li	a0,-1
}
    80000ec0:	60a6                	ld	ra,72(sp)
    80000ec2:	6406                	ld	s0,64(sp)
    80000ec4:	74e2                	ld	s1,56(sp)
    80000ec6:	7942                	ld	s2,48(sp)
    80000ec8:	79a2                	ld	s3,40(sp)
    80000eca:	7a02                	ld	s4,32(sp)
    80000ecc:	6ae2                	ld	s5,24(sp)
    80000ece:	6b42                	ld	s6,16(sp)
    80000ed0:	6ba2                	ld	s7,8(sp)
    80000ed2:	6c02                	ld	s8,0(sp)
    80000ed4:	6161                	addi	sp,sp,80
    80000ed6:	8082                	ret

0000000080000ed8 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000ed8:	c6c5                	beqz	a3,80000f80 <copyinstr+0xa8>
{
    80000eda:	715d                	addi	sp,sp,-80
    80000edc:	e486                	sd	ra,72(sp)
    80000ede:	e0a2                	sd	s0,64(sp)
    80000ee0:	fc26                	sd	s1,56(sp)
    80000ee2:	f84a                	sd	s2,48(sp)
    80000ee4:	f44e                	sd	s3,40(sp)
    80000ee6:	f052                	sd	s4,32(sp)
    80000ee8:	ec56                	sd	s5,24(sp)
    80000eea:	e85a                	sd	s6,16(sp)
    80000eec:	e45e                	sd	s7,8(sp)
    80000eee:	0880                	addi	s0,sp,80
    80000ef0:	8a2a                	mv	s4,a0
    80000ef2:	8b2e                	mv	s6,a1
    80000ef4:	8bb2                	mv	s7,a2
    80000ef6:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000ef8:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000efa:	6985                	lui	s3,0x1
    80000efc:	a035                	j	80000f28 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000efe:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000f02:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000f04:	0017b793          	seqz	a5,a5
    80000f08:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000f0c:	60a6                	ld	ra,72(sp)
    80000f0e:	6406                	ld	s0,64(sp)
    80000f10:	74e2                	ld	s1,56(sp)
    80000f12:	7942                	ld	s2,48(sp)
    80000f14:	79a2                	ld	s3,40(sp)
    80000f16:	7a02                	ld	s4,32(sp)
    80000f18:	6ae2                	ld	s5,24(sp)
    80000f1a:	6b42                	ld	s6,16(sp)
    80000f1c:	6ba2                	ld	s7,8(sp)
    80000f1e:	6161                	addi	sp,sp,80
    80000f20:	8082                	ret
    srcva = va0 + PGSIZE;
    80000f22:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000f26:	c8a9                	beqz	s1,80000f78 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000f28:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000f2c:	85ca                	mv	a1,s2
    80000f2e:	8552                	mv	a0,s4
    80000f30:	fffff097          	auipc	ra,0xfffff
    80000f34:	726080e7          	jalr	1830(ra) # 80000656 <walkaddr>
    if(pa0 == 0)
    80000f38:	c131                	beqz	a0,80000f7c <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000f3a:	41790833          	sub	a6,s2,s7
    80000f3e:	984e                	add	a6,a6,s3
    if(n > max)
    80000f40:	0104f363          	bgeu	s1,a6,80000f46 <copyinstr+0x6e>
    80000f44:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000f46:	955e                	add	a0,a0,s7
    80000f48:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000f4c:	fc080be3          	beqz	a6,80000f22 <copyinstr+0x4a>
    80000f50:	985a                	add	a6,a6,s6
    80000f52:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000f54:	41650633          	sub	a2,a0,s6
    80000f58:	14fd                	addi	s1,s1,-1
    80000f5a:	9b26                	add	s6,s6,s1
    80000f5c:	00f60733          	add	a4,a2,a5
    80000f60:	00074703          	lbu	a4,0(a4)
    80000f64:	df49                	beqz	a4,80000efe <copyinstr+0x26>
        *dst = *p;
    80000f66:	00e78023          	sb	a4,0(a5)
      --max;
    80000f6a:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000f6e:	0785                	addi	a5,a5,1
    while(n > 0){
    80000f70:	ff0796e3          	bne	a5,a6,80000f5c <copyinstr+0x84>
      dst++;
    80000f74:	8b42                	mv	s6,a6
    80000f76:	b775                	j	80000f22 <copyinstr+0x4a>
    80000f78:	4781                	li	a5,0
    80000f7a:	b769                	j	80000f04 <copyinstr+0x2c>
      return -1;
    80000f7c:	557d                	li	a0,-1
    80000f7e:	b779                	j	80000f0c <copyinstr+0x34>
  int got_null = 0;
    80000f80:	4781                	li	a5,0
  if(got_null){
    80000f82:	0017b793          	seqz	a5,a5
    80000f86:	40f00533          	neg	a0,a5
}
    80000f8a:	8082                	ret

0000000080000f8c <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000f8c:	7139                	addi	sp,sp,-64
    80000f8e:	fc06                	sd	ra,56(sp)
    80000f90:	f822                	sd	s0,48(sp)
    80000f92:	f426                	sd	s1,40(sp)
    80000f94:	f04a                	sd	s2,32(sp)
    80000f96:	ec4e                	sd	s3,24(sp)
    80000f98:	e852                	sd	s4,16(sp)
    80000f9a:	e456                	sd	s5,8(sp)
    80000f9c:	e05a                	sd	s6,0(sp)
    80000f9e:	0080                	addi	s0,sp,64
    80000fa0:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fa2:	00028497          	auipc	s1,0x28
    80000fa6:	f6648493          	addi	s1,s1,-154 # 80028f08 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000faa:	8b26                	mv	s6,s1
    80000fac:	00007a97          	auipc	s5,0x7
    80000fb0:	054a8a93          	addi	s5,s5,84 # 80008000 <etext>
    80000fb4:	04000937          	lui	s2,0x4000
    80000fb8:	197d                	addi	s2,s2,-1
    80000fba:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fbc:	0002ea17          	auipc	s4,0x2e
    80000fc0:	94ca0a13          	addi	s4,s4,-1716 # 8002e908 <tickslock>
    char *pa = kalloc();
    80000fc4:	fffff097          	auipc	ra,0xfffff
    80000fc8:	23e080e7          	jalr	574(ra) # 80000202 <kalloc>
    80000fcc:	862a                	mv	a2,a0
    if(pa == 0)
    80000fce:	c131                	beqz	a0,80001012 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000fd0:	416485b3          	sub	a1,s1,s6
    80000fd4:	858d                	srai	a1,a1,0x3
    80000fd6:	000ab783          	ld	a5,0(s5)
    80000fda:	02f585b3          	mul	a1,a1,a5
    80000fde:	2585                	addiw	a1,a1,1
    80000fe0:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000fe4:	4719                	li	a4,6
    80000fe6:	6685                	lui	a3,0x1
    80000fe8:	40b905b3          	sub	a1,s2,a1
    80000fec:	854e                	mv	a0,s3
    80000fee:	fffff097          	auipc	ra,0xfffff
    80000ff2:	76e080e7          	jalr	1902(ra) # 8000075c <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ff6:	16848493          	addi	s1,s1,360
    80000ffa:	fd4495e3          	bne	s1,s4,80000fc4 <proc_mapstacks+0x38>
  }
}
    80000ffe:	70e2                	ld	ra,56(sp)
    80001000:	7442                	ld	s0,48(sp)
    80001002:	74a2                	ld	s1,40(sp)
    80001004:	7902                	ld	s2,32(sp)
    80001006:	69e2                	ld	s3,24(sp)
    80001008:	6a42                	ld	s4,16(sp)
    8000100a:	6aa2                	ld	s5,8(sp)
    8000100c:	6b02                	ld	s6,0(sp)
    8000100e:	6121                	addi	sp,sp,64
    80001010:	8082                	ret
      panic("kalloc");
    80001012:	00007517          	auipc	a0,0x7
    80001016:	2c650513          	addi	a0,a0,710 # 800082d8 <etext+0x2d8>
    8000101a:	00005097          	auipc	ra,0x5
    8000101e:	eb8080e7          	jalr	-328(ra) # 80005ed2 <panic>

0000000080001022 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80001022:	7139                	addi	sp,sp,-64
    80001024:	fc06                	sd	ra,56(sp)
    80001026:	f822                	sd	s0,48(sp)
    80001028:	f426                	sd	s1,40(sp)
    8000102a:	f04a                	sd	s2,32(sp)
    8000102c:	ec4e                	sd	s3,24(sp)
    8000102e:	e852                	sd	s4,16(sp)
    80001030:	e456                	sd	s5,8(sp)
    80001032:	e05a                	sd	s6,0(sp)
    80001034:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80001036:	00007597          	auipc	a1,0x7
    8000103a:	2aa58593          	addi	a1,a1,682 # 800082e0 <etext+0x2e0>
    8000103e:	00028517          	auipc	a0,0x28
    80001042:	a9a50513          	addi	a0,a0,-1382 # 80028ad8 <pid_lock>
    80001046:	00005097          	auipc	ra,0x5
    8000104a:	346080e7          	jalr	838(ra) # 8000638c <initlock>
  initlock(&wait_lock, "wait_lock");
    8000104e:	00007597          	auipc	a1,0x7
    80001052:	29a58593          	addi	a1,a1,666 # 800082e8 <etext+0x2e8>
    80001056:	00028517          	auipc	a0,0x28
    8000105a:	a9a50513          	addi	a0,a0,-1382 # 80028af0 <wait_lock>
    8000105e:	00005097          	auipc	ra,0x5
    80001062:	32e080e7          	jalr	814(ra) # 8000638c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001066:	00028497          	auipc	s1,0x28
    8000106a:	ea248493          	addi	s1,s1,-350 # 80028f08 <proc>
      initlock(&p->lock, "proc");
    8000106e:	00007b17          	auipc	s6,0x7
    80001072:	28ab0b13          	addi	s6,s6,650 # 800082f8 <etext+0x2f8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80001076:	8aa6                	mv	s5,s1
    80001078:	00007a17          	auipc	s4,0x7
    8000107c:	f88a0a13          	addi	s4,s4,-120 # 80008000 <etext>
    80001080:	04000937          	lui	s2,0x4000
    80001084:	197d                	addi	s2,s2,-1
    80001086:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001088:	0002e997          	auipc	s3,0x2e
    8000108c:	88098993          	addi	s3,s3,-1920 # 8002e908 <tickslock>
      initlock(&p->lock, "proc");
    80001090:	85da                	mv	a1,s6
    80001092:	8526                	mv	a0,s1
    80001094:	00005097          	auipc	ra,0x5
    80001098:	2f8080e7          	jalr	760(ra) # 8000638c <initlock>
      p->state = UNUSED;
    8000109c:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    800010a0:	415487b3          	sub	a5,s1,s5
    800010a4:	878d                	srai	a5,a5,0x3
    800010a6:	000a3703          	ld	a4,0(s4)
    800010aa:	02e787b3          	mul	a5,a5,a4
    800010ae:	2785                	addiw	a5,a5,1
    800010b0:	00d7979b          	slliw	a5,a5,0xd
    800010b4:	40f907b3          	sub	a5,s2,a5
    800010b8:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    800010ba:	16848493          	addi	s1,s1,360
    800010be:	fd3499e3          	bne	s1,s3,80001090 <procinit+0x6e>
  }
}
    800010c2:	70e2                	ld	ra,56(sp)
    800010c4:	7442                	ld	s0,48(sp)
    800010c6:	74a2                	ld	s1,40(sp)
    800010c8:	7902                	ld	s2,32(sp)
    800010ca:	69e2                	ld	s3,24(sp)
    800010cc:	6a42                	ld	s4,16(sp)
    800010ce:	6aa2                	ld	s5,8(sp)
    800010d0:	6b02                	ld	s6,0(sp)
    800010d2:	6121                	addi	sp,sp,64
    800010d4:	8082                	ret

00000000800010d6 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800010d6:	1141                	addi	sp,sp,-16
    800010d8:	e422                	sd	s0,8(sp)
    800010da:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    800010dc:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    800010de:	2501                	sext.w	a0,a0
    800010e0:	6422                	ld	s0,8(sp)
    800010e2:	0141                	addi	sp,sp,16
    800010e4:	8082                	ret

00000000800010e6 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    800010e6:	1141                	addi	sp,sp,-16
    800010e8:	e422                	sd	s0,8(sp)
    800010ea:	0800                	addi	s0,sp,16
    800010ec:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    800010ee:	2781                	sext.w	a5,a5
    800010f0:	079e                	slli	a5,a5,0x7
  return c;
}
    800010f2:	00028517          	auipc	a0,0x28
    800010f6:	a1650513          	addi	a0,a0,-1514 # 80028b08 <cpus>
    800010fa:	953e                	add	a0,a0,a5
    800010fc:	6422                	ld	s0,8(sp)
    800010fe:	0141                	addi	sp,sp,16
    80001100:	8082                	ret

0000000080001102 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80001102:	1101                	addi	sp,sp,-32
    80001104:	ec06                	sd	ra,24(sp)
    80001106:	e822                	sd	s0,16(sp)
    80001108:	e426                	sd	s1,8(sp)
    8000110a:	1000                	addi	s0,sp,32
  push_off();
    8000110c:	00005097          	auipc	ra,0x5
    80001110:	2c4080e7          	jalr	708(ra) # 800063d0 <push_off>
    80001114:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001116:	2781                	sext.w	a5,a5
    80001118:	079e                	slli	a5,a5,0x7
    8000111a:	00028717          	auipc	a4,0x28
    8000111e:	9be70713          	addi	a4,a4,-1602 # 80028ad8 <pid_lock>
    80001122:	97ba                	add	a5,a5,a4
    80001124:	7b84                	ld	s1,48(a5)
  pop_off();
    80001126:	00005097          	auipc	ra,0x5
    8000112a:	34a080e7          	jalr	842(ra) # 80006470 <pop_off>
  return p;
}
    8000112e:	8526                	mv	a0,s1
    80001130:	60e2                	ld	ra,24(sp)
    80001132:	6442                	ld	s0,16(sp)
    80001134:	64a2                	ld	s1,8(sp)
    80001136:	6105                	addi	sp,sp,32
    80001138:	8082                	ret

000000008000113a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    8000113a:	1141                	addi	sp,sp,-16
    8000113c:	e406                	sd	ra,8(sp)
    8000113e:	e022                	sd	s0,0(sp)
    80001140:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001142:	00000097          	auipc	ra,0x0
    80001146:	fc0080e7          	jalr	-64(ra) # 80001102 <myproc>
    8000114a:	00005097          	auipc	ra,0x5
    8000114e:	386080e7          	jalr	902(ra) # 800064d0 <release>

  if (first) {
    80001152:	00008797          	auipc	a5,0x8
    80001156:	8ae7a783          	lw	a5,-1874(a5) # 80008a00 <first.1688>
    8000115a:	eb89                	bnez	a5,8000116c <forkret+0x32>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    8000115c:	00001097          	auipc	ra,0x1
    80001160:	c5a080e7          	jalr	-934(ra) # 80001db6 <usertrapret>
}
    80001164:	60a2                	ld	ra,8(sp)
    80001166:	6402                	ld	s0,0(sp)
    80001168:	0141                	addi	sp,sp,16
    8000116a:	8082                	ret
    fsinit(ROOTDEV);
    8000116c:	4505                	li	a0,1
    8000116e:	00002097          	auipc	ra,0x2
    80001172:	9e8080e7          	jalr	-1560(ra) # 80002b56 <fsinit>
    first = 0;
    80001176:	00008797          	auipc	a5,0x8
    8000117a:	8807a523          	sw	zero,-1910(a5) # 80008a00 <first.1688>
    __sync_synchronize();
    8000117e:	0ff0000f          	fence
    80001182:	bfe9                	j	8000115c <forkret+0x22>

0000000080001184 <allocpid>:
{
    80001184:	1101                	addi	sp,sp,-32
    80001186:	ec06                	sd	ra,24(sp)
    80001188:	e822                	sd	s0,16(sp)
    8000118a:	e426                	sd	s1,8(sp)
    8000118c:	e04a                	sd	s2,0(sp)
    8000118e:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001190:	00028917          	auipc	s2,0x28
    80001194:	94890913          	addi	s2,s2,-1720 # 80028ad8 <pid_lock>
    80001198:	854a                	mv	a0,s2
    8000119a:	00005097          	auipc	ra,0x5
    8000119e:	282080e7          	jalr	642(ra) # 8000641c <acquire>
  pid = nextpid;
    800011a2:	00008797          	auipc	a5,0x8
    800011a6:	86278793          	addi	a5,a5,-1950 # 80008a04 <nextpid>
    800011aa:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800011ac:	0014871b          	addiw	a4,s1,1
    800011b0:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800011b2:	854a                	mv	a0,s2
    800011b4:	00005097          	auipc	ra,0x5
    800011b8:	31c080e7          	jalr	796(ra) # 800064d0 <release>
}
    800011bc:	8526                	mv	a0,s1
    800011be:	60e2                	ld	ra,24(sp)
    800011c0:	6442                	ld	s0,16(sp)
    800011c2:	64a2                	ld	s1,8(sp)
    800011c4:	6902                	ld	s2,0(sp)
    800011c6:	6105                	addi	sp,sp,32
    800011c8:	8082                	ret

00000000800011ca <proc_pagetable>:
{
    800011ca:	1101                	addi	sp,sp,-32
    800011cc:	ec06                	sd	ra,24(sp)
    800011ce:	e822                	sd	s0,16(sp)
    800011d0:	e426                	sd	s1,8(sp)
    800011d2:	e04a                	sd	s2,0(sp)
    800011d4:	1000                	addi	s0,sp,32
    800011d6:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    800011d8:	00000097          	auipc	ra,0x0
    800011dc:	850080e7          	jalr	-1968(ra) # 80000a28 <uvmcreate>
    800011e0:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800011e2:	c121                	beqz	a0,80001222 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    800011e4:	4729                	li	a4,10
    800011e6:	00006697          	auipc	a3,0x6
    800011ea:	e1a68693          	addi	a3,a3,-486 # 80007000 <_trampoline>
    800011ee:	6605                	lui	a2,0x1
    800011f0:	040005b7          	lui	a1,0x4000
    800011f4:	15fd                	addi	a1,a1,-1
    800011f6:	05b2                	slli	a1,a1,0xc
    800011f8:	fffff097          	auipc	ra,0xfffff
    800011fc:	4a0080e7          	jalr	1184(ra) # 80000698 <mappages>
    80001200:	02054863          	bltz	a0,80001230 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001204:	4719                	li	a4,6
    80001206:	05893683          	ld	a3,88(s2)
    8000120a:	6605                	lui	a2,0x1
    8000120c:	020005b7          	lui	a1,0x2000
    80001210:	15fd                	addi	a1,a1,-1
    80001212:	05b6                	slli	a1,a1,0xd
    80001214:	8526                	mv	a0,s1
    80001216:	fffff097          	auipc	ra,0xfffff
    8000121a:	482080e7          	jalr	1154(ra) # 80000698 <mappages>
    8000121e:	02054163          	bltz	a0,80001240 <proc_pagetable+0x76>
}
    80001222:	8526                	mv	a0,s1
    80001224:	60e2                	ld	ra,24(sp)
    80001226:	6442                	ld	s0,16(sp)
    80001228:	64a2                	ld	s1,8(sp)
    8000122a:	6902                	ld	s2,0(sp)
    8000122c:	6105                	addi	sp,sp,32
    8000122e:	8082                	ret
    uvmfree(pagetable, 0);
    80001230:	4581                	li	a1,0
    80001232:	8526                	mv	a0,s1
    80001234:	00000097          	auipc	ra,0x0
    80001238:	9f8080e7          	jalr	-1544(ra) # 80000c2c <uvmfree>
    return 0;
    8000123c:	4481                	li	s1,0
    8000123e:	b7d5                	j	80001222 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001240:	4681                	li	a3,0
    80001242:	4605                	li	a2,1
    80001244:	040005b7          	lui	a1,0x4000
    80001248:	15fd                	addi	a1,a1,-1
    8000124a:	05b2                	slli	a1,a1,0xc
    8000124c:	8526                	mv	a0,s1
    8000124e:	fffff097          	auipc	ra,0xfffff
    80001252:	634080e7          	jalr	1588(ra) # 80000882 <uvmunmap>
    uvmfree(pagetable, 0);
    80001256:	4581                	li	a1,0
    80001258:	8526                	mv	a0,s1
    8000125a:	00000097          	auipc	ra,0x0
    8000125e:	9d2080e7          	jalr	-1582(ra) # 80000c2c <uvmfree>
    return 0;
    80001262:	4481                	li	s1,0
    80001264:	bf7d                	j	80001222 <proc_pagetable+0x58>

0000000080001266 <proc_freepagetable>:
{
    80001266:	1101                	addi	sp,sp,-32
    80001268:	ec06                	sd	ra,24(sp)
    8000126a:	e822                	sd	s0,16(sp)
    8000126c:	e426                	sd	s1,8(sp)
    8000126e:	e04a                	sd	s2,0(sp)
    80001270:	1000                	addi	s0,sp,32
    80001272:	84aa                	mv	s1,a0
    80001274:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001276:	4681                	li	a3,0
    80001278:	4605                	li	a2,1
    8000127a:	040005b7          	lui	a1,0x4000
    8000127e:	15fd                	addi	a1,a1,-1
    80001280:	05b2                	slli	a1,a1,0xc
    80001282:	fffff097          	auipc	ra,0xfffff
    80001286:	600080e7          	jalr	1536(ra) # 80000882 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000128a:	4681                	li	a3,0
    8000128c:	4605                	li	a2,1
    8000128e:	020005b7          	lui	a1,0x2000
    80001292:	15fd                	addi	a1,a1,-1
    80001294:	05b6                	slli	a1,a1,0xd
    80001296:	8526                	mv	a0,s1
    80001298:	fffff097          	auipc	ra,0xfffff
    8000129c:	5ea080e7          	jalr	1514(ra) # 80000882 <uvmunmap>
  uvmfree(pagetable, sz);
    800012a0:	85ca                	mv	a1,s2
    800012a2:	8526                	mv	a0,s1
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	988080e7          	jalr	-1656(ra) # 80000c2c <uvmfree>
}
    800012ac:	60e2                	ld	ra,24(sp)
    800012ae:	6442                	ld	s0,16(sp)
    800012b0:	64a2                	ld	s1,8(sp)
    800012b2:	6902                	ld	s2,0(sp)
    800012b4:	6105                	addi	sp,sp,32
    800012b6:	8082                	ret

00000000800012b8 <freeproc>:
{
    800012b8:	1101                	addi	sp,sp,-32
    800012ba:	ec06                	sd	ra,24(sp)
    800012bc:	e822                	sd	s0,16(sp)
    800012be:	e426                	sd	s1,8(sp)
    800012c0:	1000                	addi	s0,sp,32
    800012c2:	84aa                	mv	s1,a0
  if(p->trapframe)
    800012c4:	6d28                	ld	a0,88(a0)
    800012c6:	c509                	beqz	a0,800012d0 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800012c8:	fffff097          	auipc	ra,0xfffff
    800012cc:	df4080e7          	jalr	-524(ra) # 800000bc <kfree>
  p->trapframe = 0;
    800012d0:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    800012d4:	68a8                	ld	a0,80(s1)
    800012d6:	c511                	beqz	a0,800012e2 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    800012d8:	64ac                	ld	a1,72(s1)
    800012da:	00000097          	auipc	ra,0x0
    800012de:	f8c080e7          	jalr	-116(ra) # 80001266 <proc_freepagetable>
  p->pagetable = 0;
    800012e2:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800012e6:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800012ea:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    800012ee:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    800012f2:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800012f6:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800012fa:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    800012fe:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001302:	0004ac23          	sw	zero,24(s1)
}
    80001306:	60e2                	ld	ra,24(sp)
    80001308:	6442                	ld	s0,16(sp)
    8000130a:	64a2                	ld	s1,8(sp)
    8000130c:	6105                	addi	sp,sp,32
    8000130e:	8082                	ret

0000000080001310 <allocproc>:
{
    80001310:	1101                	addi	sp,sp,-32
    80001312:	ec06                	sd	ra,24(sp)
    80001314:	e822                	sd	s0,16(sp)
    80001316:	e426                	sd	s1,8(sp)
    80001318:	e04a                	sd	s2,0(sp)
    8000131a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000131c:	00028497          	auipc	s1,0x28
    80001320:	bec48493          	addi	s1,s1,-1044 # 80028f08 <proc>
    80001324:	0002d917          	auipc	s2,0x2d
    80001328:	5e490913          	addi	s2,s2,1508 # 8002e908 <tickslock>
    acquire(&p->lock);
    8000132c:	8526                	mv	a0,s1
    8000132e:	00005097          	auipc	ra,0x5
    80001332:	0ee080e7          	jalr	238(ra) # 8000641c <acquire>
    if(p->state == UNUSED) {
    80001336:	4c9c                	lw	a5,24(s1)
    80001338:	cf81                	beqz	a5,80001350 <allocproc+0x40>
      release(&p->lock);
    8000133a:	8526                	mv	a0,s1
    8000133c:	00005097          	auipc	ra,0x5
    80001340:	194080e7          	jalr	404(ra) # 800064d0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001344:	16848493          	addi	s1,s1,360
    80001348:	ff2492e3          	bne	s1,s2,8000132c <allocproc+0x1c>
  return 0;
    8000134c:	4481                	li	s1,0
    8000134e:	a889                	j	800013a0 <allocproc+0x90>
  p->pid = allocpid();
    80001350:	00000097          	auipc	ra,0x0
    80001354:	e34080e7          	jalr	-460(ra) # 80001184 <allocpid>
    80001358:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000135a:	4785                	li	a5,1
    8000135c:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000135e:	fffff097          	auipc	ra,0xfffff
    80001362:	ea4080e7          	jalr	-348(ra) # 80000202 <kalloc>
    80001366:	892a                	mv	s2,a0
    80001368:	eca8                	sd	a0,88(s1)
    8000136a:	c131                	beqz	a0,800013ae <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    8000136c:	8526                	mv	a0,s1
    8000136e:	00000097          	auipc	ra,0x0
    80001372:	e5c080e7          	jalr	-420(ra) # 800011ca <proc_pagetable>
    80001376:	892a                	mv	s2,a0
    80001378:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000137a:	c531                	beqz	a0,800013c6 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    8000137c:	07000613          	li	a2,112
    80001380:	4581                	li	a1,0
    80001382:	06048513          	addi	a0,s1,96
    80001386:	fffff097          	auipc	ra,0xfffff
    8000138a:	efe080e7          	jalr	-258(ra) # 80000284 <memset>
  p->context.ra = (uint64)forkret;
    8000138e:	00000797          	auipc	a5,0x0
    80001392:	dac78793          	addi	a5,a5,-596 # 8000113a <forkret>
    80001396:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001398:	60bc                	ld	a5,64(s1)
    8000139a:	6705                	lui	a4,0x1
    8000139c:	97ba                	add	a5,a5,a4
    8000139e:	f4bc                	sd	a5,104(s1)
}
    800013a0:	8526                	mv	a0,s1
    800013a2:	60e2                	ld	ra,24(sp)
    800013a4:	6442                	ld	s0,16(sp)
    800013a6:	64a2                	ld	s1,8(sp)
    800013a8:	6902                	ld	s2,0(sp)
    800013aa:	6105                	addi	sp,sp,32
    800013ac:	8082                	ret
    freeproc(p);
    800013ae:	8526                	mv	a0,s1
    800013b0:	00000097          	auipc	ra,0x0
    800013b4:	f08080e7          	jalr	-248(ra) # 800012b8 <freeproc>
    release(&p->lock);
    800013b8:	8526                	mv	a0,s1
    800013ba:	00005097          	auipc	ra,0x5
    800013be:	116080e7          	jalr	278(ra) # 800064d0 <release>
    return 0;
    800013c2:	84ca                	mv	s1,s2
    800013c4:	bff1                	j	800013a0 <allocproc+0x90>
    freeproc(p);
    800013c6:	8526                	mv	a0,s1
    800013c8:	00000097          	auipc	ra,0x0
    800013cc:	ef0080e7          	jalr	-272(ra) # 800012b8 <freeproc>
    release(&p->lock);
    800013d0:	8526                	mv	a0,s1
    800013d2:	00005097          	auipc	ra,0x5
    800013d6:	0fe080e7          	jalr	254(ra) # 800064d0 <release>
    return 0;
    800013da:	84ca                	mv	s1,s2
    800013dc:	b7d1                	j	800013a0 <allocproc+0x90>

00000000800013de <userinit>:
{
    800013de:	1101                	addi	sp,sp,-32
    800013e0:	ec06                	sd	ra,24(sp)
    800013e2:	e822                	sd	s0,16(sp)
    800013e4:	e426                	sd	s1,8(sp)
    800013e6:	1000                	addi	s0,sp,32
  p = allocproc();
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	f28080e7          	jalr	-216(ra) # 80001310 <allocproc>
    800013f0:	84aa                	mv	s1,a0
  initproc = p;
    800013f2:	00007797          	auipc	a5,0x7
    800013f6:	68a7b723          	sd	a0,1678(a5) # 80008a80 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800013fa:	03400613          	li	a2,52
    800013fe:	00007597          	auipc	a1,0x7
    80001402:	61258593          	addi	a1,a1,1554 # 80008a10 <initcode>
    80001406:	6928                	ld	a0,80(a0)
    80001408:	fffff097          	auipc	ra,0xfffff
    8000140c:	64e080e7          	jalr	1614(ra) # 80000a56 <uvmfirst>
  p->sz = PGSIZE;
    80001410:	6785                	lui	a5,0x1
    80001412:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001414:	6cb8                	ld	a4,88(s1)
    80001416:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000141a:	6cb8                	ld	a4,88(s1)
    8000141c:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    8000141e:	4641                	li	a2,16
    80001420:	00007597          	auipc	a1,0x7
    80001424:	ee058593          	addi	a1,a1,-288 # 80008300 <etext+0x300>
    80001428:	15848513          	addi	a0,s1,344
    8000142c:	fffff097          	auipc	ra,0xfffff
    80001430:	faa080e7          	jalr	-86(ra) # 800003d6 <safestrcpy>
  p->cwd = namei("/");
    80001434:	00007517          	auipc	a0,0x7
    80001438:	edc50513          	addi	a0,a0,-292 # 80008310 <etext+0x310>
    8000143c:	00002097          	auipc	ra,0x2
    80001440:	13c080e7          	jalr	316(ra) # 80003578 <namei>
    80001444:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001448:	478d                	li	a5,3
    8000144a:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000144c:	8526                	mv	a0,s1
    8000144e:	00005097          	auipc	ra,0x5
    80001452:	082080e7          	jalr	130(ra) # 800064d0 <release>
}
    80001456:	60e2                	ld	ra,24(sp)
    80001458:	6442                	ld	s0,16(sp)
    8000145a:	64a2                	ld	s1,8(sp)
    8000145c:	6105                	addi	sp,sp,32
    8000145e:	8082                	ret

0000000080001460 <growproc>:
{
    80001460:	1101                	addi	sp,sp,-32
    80001462:	ec06                	sd	ra,24(sp)
    80001464:	e822                	sd	s0,16(sp)
    80001466:	e426                	sd	s1,8(sp)
    80001468:	e04a                	sd	s2,0(sp)
    8000146a:	1000                	addi	s0,sp,32
    8000146c:	892a                	mv	s2,a0
  struct proc *p = myproc();
    8000146e:	00000097          	auipc	ra,0x0
    80001472:	c94080e7          	jalr	-876(ra) # 80001102 <myproc>
    80001476:	84aa                	mv	s1,a0
  sz = p->sz;
    80001478:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000147a:	01204c63          	bgtz	s2,80001492 <growproc+0x32>
  } else if(n < 0){
    8000147e:	02094663          	bltz	s2,800014aa <growproc+0x4a>
  p->sz = sz;
    80001482:	e4ac                	sd	a1,72(s1)
  return 0;
    80001484:	4501                	li	a0,0
}
    80001486:	60e2                	ld	ra,24(sp)
    80001488:	6442                	ld	s0,16(sp)
    8000148a:	64a2                	ld	s1,8(sp)
    8000148c:	6902                	ld	s2,0(sp)
    8000148e:	6105                	addi	sp,sp,32
    80001490:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001492:	4691                	li	a3,4
    80001494:	00b90633          	add	a2,s2,a1
    80001498:	6928                	ld	a0,80(a0)
    8000149a:	fffff097          	auipc	ra,0xfffff
    8000149e:	676080e7          	jalr	1654(ra) # 80000b10 <uvmalloc>
    800014a2:	85aa                	mv	a1,a0
    800014a4:	fd79                	bnez	a0,80001482 <growproc+0x22>
      return -1;
    800014a6:	557d                	li	a0,-1
    800014a8:	bff9                	j	80001486 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800014aa:	00b90633          	add	a2,s2,a1
    800014ae:	6928                	ld	a0,80(a0)
    800014b0:	fffff097          	auipc	ra,0xfffff
    800014b4:	618080e7          	jalr	1560(ra) # 80000ac8 <uvmdealloc>
    800014b8:	85aa                	mv	a1,a0
    800014ba:	b7e1                	j	80001482 <growproc+0x22>

00000000800014bc <fork>:
{
    800014bc:	7179                	addi	sp,sp,-48
    800014be:	f406                	sd	ra,40(sp)
    800014c0:	f022                	sd	s0,32(sp)
    800014c2:	ec26                	sd	s1,24(sp)
    800014c4:	e84a                	sd	s2,16(sp)
    800014c6:	e44e                	sd	s3,8(sp)
    800014c8:	e052                	sd	s4,0(sp)
    800014ca:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	c36080e7          	jalr	-970(ra) # 80001102 <myproc>
    800014d4:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    800014d6:	00000097          	auipc	ra,0x0
    800014da:	e3a080e7          	jalr	-454(ra) # 80001310 <allocproc>
    800014de:	10050b63          	beqz	a0,800015f4 <fork+0x138>
    800014e2:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800014e4:	04893603          	ld	a2,72(s2)
    800014e8:	692c                	ld	a1,80(a0)
    800014ea:	05093503          	ld	a0,80(s2)
    800014ee:	fffff097          	auipc	ra,0xfffff
    800014f2:	776080e7          	jalr	1910(ra) # 80000c64 <uvmcopy>
    800014f6:	04054663          	bltz	a0,80001542 <fork+0x86>
  np->sz = p->sz;
    800014fa:	04893783          	ld	a5,72(s2)
    800014fe:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001502:	05893683          	ld	a3,88(s2)
    80001506:	87b6                	mv	a5,a3
    80001508:	0589b703          	ld	a4,88(s3)
    8000150c:	12068693          	addi	a3,a3,288
    80001510:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001514:	6788                	ld	a0,8(a5)
    80001516:	6b8c                	ld	a1,16(a5)
    80001518:	6f90                	ld	a2,24(a5)
    8000151a:	01073023          	sd	a6,0(a4)
    8000151e:	e708                	sd	a0,8(a4)
    80001520:	eb0c                	sd	a1,16(a4)
    80001522:	ef10                	sd	a2,24(a4)
    80001524:	02078793          	addi	a5,a5,32
    80001528:	02070713          	addi	a4,a4,32
    8000152c:	fed792e3          	bne	a5,a3,80001510 <fork+0x54>
  np->trapframe->a0 = 0;
    80001530:	0589b783          	ld	a5,88(s3)
    80001534:	0607b823          	sd	zero,112(a5)
    80001538:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    8000153c:	15000a13          	li	s4,336
    80001540:	a03d                	j	8000156e <fork+0xb2>
    freeproc(np);
    80001542:	854e                	mv	a0,s3
    80001544:	00000097          	auipc	ra,0x0
    80001548:	d74080e7          	jalr	-652(ra) # 800012b8 <freeproc>
    release(&np->lock);
    8000154c:	854e                	mv	a0,s3
    8000154e:	00005097          	auipc	ra,0x5
    80001552:	f82080e7          	jalr	-126(ra) # 800064d0 <release>
    return -1;
    80001556:	5a7d                	li	s4,-1
    80001558:	a069                	j	800015e2 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    8000155a:	00002097          	auipc	ra,0x2
    8000155e:	6b4080e7          	jalr	1716(ra) # 80003c0e <filedup>
    80001562:	009987b3          	add	a5,s3,s1
    80001566:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    80001568:	04a1                	addi	s1,s1,8
    8000156a:	01448763          	beq	s1,s4,80001578 <fork+0xbc>
    if(p->ofile[i])
    8000156e:	009907b3          	add	a5,s2,s1
    80001572:	6388                	ld	a0,0(a5)
    80001574:	f17d                	bnez	a0,8000155a <fork+0x9e>
    80001576:	bfcd                	j	80001568 <fork+0xac>
  np->cwd = idup(p->cwd);
    80001578:	15093503          	ld	a0,336(s2)
    8000157c:	00002097          	auipc	ra,0x2
    80001580:	818080e7          	jalr	-2024(ra) # 80002d94 <idup>
    80001584:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001588:	4641                	li	a2,16
    8000158a:	15890593          	addi	a1,s2,344
    8000158e:	15898513          	addi	a0,s3,344
    80001592:	fffff097          	auipc	ra,0xfffff
    80001596:	e44080e7          	jalr	-444(ra) # 800003d6 <safestrcpy>
  pid = np->pid;
    8000159a:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    8000159e:	854e                	mv	a0,s3
    800015a0:	00005097          	auipc	ra,0x5
    800015a4:	f30080e7          	jalr	-208(ra) # 800064d0 <release>
  acquire(&wait_lock);
    800015a8:	00027497          	auipc	s1,0x27
    800015ac:	54848493          	addi	s1,s1,1352 # 80028af0 <wait_lock>
    800015b0:	8526                	mv	a0,s1
    800015b2:	00005097          	auipc	ra,0x5
    800015b6:	e6a080e7          	jalr	-406(ra) # 8000641c <acquire>
  np->parent = p;
    800015ba:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    800015be:	8526                	mv	a0,s1
    800015c0:	00005097          	auipc	ra,0x5
    800015c4:	f10080e7          	jalr	-240(ra) # 800064d0 <release>
  acquire(&np->lock);
    800015c8:	854e                	mv	a0,s3
    800015ca:	00005097          	auipc	ra,0x5
    800015ce:	e52080e7          	jalr	-430(ra) # 8000641c <acquire>
  np->state = RUNNABLE;
    800015d2:	478d                	li	a5,3
    800015d4:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    800015d8:	854e                	mv	a0,s3
    800015da:	00005097          	auipc	ra,0x5
    800015de:	ef6080e7          	jalr	-266(ra) # 800064d0 <release>
}
    800015e2:	8552                	mv	a0,s4
    800015e4:	70a2                	ld	ra,40(sp)
    800015e6:	7402                	ld	s0,32(sp)
    800015e8:	64e2                	ld	s1,24(sp)
    800015ea:	6942                	ld	s2,16(sp)
    800015ec:	69a2                	ld	s3,8(sp)
    800015ee:	6a02                	ld	s4,0(sp)
    800015f0:	6145                	addi	sp,sp,48
    800015f2:	8082                	ret
    return -1;
    800015f4:	5a7d                	li	s4,-1
    800015f6:	b7f5                	j	800015e2 <fork+0x126>

00000000800015f8 <scheduler>:
{
    800015f8:	7139                	addi	sp,sp,-64
    800015fa:	fc06                	sd	ra,56(sp)
    800015fc:	f822                	sd	s0,48(sp)
    800015fe:	f426                	sd	s1,40(sp)
    80001600:	f04a                	sd	s2,32(sp)
    80001602:	ec4e                	sd	s3,24(sp)
    80001604:	e852                	sd	s4,16(sp)
    80001606:	e456                	sd	s5,8(sp)
    80001608:	e05a                	sd	s6,0(sp)
    8000160a:	0080                	addi	s0,sp,64
    8000160c:	8792                	mv	a5,tp
  int id = r_tp();
    8000160e:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001610:	00779a93          	slli	s5,a5,0x7
    80001614:	00027717          	auipc	a4,0x27
    80001618:	4c470713          	addi	a4,a4,1220 # 80028ad8 <pid_lock>
    8000161c:	9756                	add	a4,a4,s5
    8000161e:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001622:	00027717          	auipc	a4,0x27
    80001626:	4ee70713          	addi	a4,a4,1262 # 80028b10 <cpus+0x8>
    8000162a:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000162c:	498d                	li	s3,3
        p->state = RUNNING;
    8000162e:	4b11                	li	s6,4
        c->proc = p;
    80001630:	079e                	slli	a5,a5,0x7
    80001632:	00027a17          	auipc	s4,0x27
    80001636:	4a6a0a13          	addi	s4,s4,1190 # 80028ad8 <pid_lock>
    8000163a:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000163c:	0002d917          	auipc	s2,0x2d
    80001640:	2cc90913          	addi	s2,s2,716 # 8002e908 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001644:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001648:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000164c:	10079073          	csrw	sstatus,a5
    80001650:	00028497          	auipc	s1,0x28
    80001654:	8b848493          	addi	s1,s1,-1864 # 80028f08 <proc>
    80001658:	a03d                	j	80001686 <scheduler+0x8e>
        p->state = RUNNING;
    8000165a:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    8000165e:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001662:	06048593          	addi	a1,s1,96
    80001666:	8556                	mv	a0,s5
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	6a4080e7          	jalr	1700(ra) # 80001d0c <swtch>
        c->proc = 0;
    80001670:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    80001674:	8526                	mv	a0,s1
    80001676:	00005097          	auipc	ra,0x5
    8000167a:	e5a080e7          	jalr	-422(ra) # 800064d0 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8000167e:	16848493          	addi	s1,s1,360
    80001682:	fd2481e3          	beq	s1,s2,80001644 <scheduler+0x4c>
      acquire(&p->lock);
    80001686:	8526                	mv	a0,s1
    80001688:	00005097          	auipc	ra,0x5
    8000168c:	d94080e7          	jalr	-620(ra) # 8000641c <acquire>
      if(p->state == RUNNABLE) {
    80001690:	4c9c                	lw	a5,24(s1)
    80001692:	ff3791e3          	bne	a5,s3,80001674 <scheduler+0x7c>
    80001696:	b7d1                	j	8000165a <scheduler+0x62>

0000000080001698 <sched>:
{
    80001698:	7179                	addi	sp,sp,-48
    8000169a:	f406                	sd	ra,40(sp)
    8000169c:	f022                	sd	s0,32(sp)
    8000169e:	ec26                	sd	s1,24(sp)
    800016a0:	e84a                	sd	s2,16(sp)
    800016a2:	e44e                	sd	s3,8(sp)
    800016a4:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800016a6:	00000097          	auipc	ra,0x0
    800016aa:	a5c080e7          	jalr	-1444(ra) # 80001102 <myproc>
    800016ae:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800016b0:	00005097          	auipc	ra,0x5
    800016b4:	cf2080e7          	jalr	-782(ra) # 800063a2 <holding>
    800016b8:	c93d                	beqz	a0,8000172e <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016ba:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800016bc:	2781                	sext.w	a5,a5
    800016be:	079e                	slli	a5,a5,0x7
    800016c0:	00027717          	auipc	a4,0x27
    800016c4:	41870713          	addi	a4,a4,1048 # 80028ad8 <pid_lock>
    800016c8:	97ba                	add	a5,a5,a4
    800016ca:	0a87a703          	lw	a4,168(a5)
    800016ce:	4785                	li	a5,1
    800016d0:	06f71763          	bne	a4,a5,8000173e <sched+0xa6>
  if(p->state == RUNNING)
    800016d4:	4c98                	lw	a4,24(s1)
    800016d6:	4791                	li	a5,4
    800016d8:	06f70b63          	beq	a4,a5,8000174e <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800016dc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800016e0:	8b89                	andi	a5,a5,2
  if(intr_get())
    800016e2:	efb5                	bnez	a5,8000175e <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800016e4:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800016e6:	00027917          	auipc	s2,0x27
    800016ea:	3f290913          	addi	s2,s2,1010 # 80028ad8 <pid_lock>
    800016ee:	2781                	sext.w	a5,a5
    800016f0:	079e                	slli	a5,a5,0x7
    800016f2:	97ca                	add	a5,a5,s2
    800016f4:	0ac7a983          	lw	s3,172(a5)
    800016f8:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800016fa:	2781                	sext.w	a5,a5
    800016fc:	079e                	slli	a5,a5,0x7
    800016fe:	00027597          	auipc	a1,0x27
    80001702:	41258593          	addi	a1,a1,1042 # 80028b10 <cpus+0x8>
    80001706:	95be                	add	a1,a1,a5
    80001708:	06048513          	addi	a0,s1,96
    8000170c:	00000097          	auipc	ra,0x0
    80001710:	600080e7          	jalr	1536(ra) # 80001d0c <swtch>
    80001714:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001716:	2781                	sext.w	a5,a5
    80001718:	079e                	slli	a5,a5,0x7
    8000171a:	97ca                	add	a5,a5,s2
    8000171c:	0b37a623          	sw	s3,172(a5)
}
    80001720:	70a2                	ld	ra,40(sp)
    80001722:	7402                	ld	s0,32(sp)
    80001724:	64e2                	ld	s1,24(sp)
    80001726:	6942                	ld	s2,16(sp)
    80001728:	69a2                	ld	s3,8(sp)
    8000172a:	6145                	addi	sp,sp,48
    8000172c:	8082                	ret
    panic("sched p->lock");
    8000172e:	00007517          	auipc	a0,0x7
    80001732:	bea50513          	addi	a0,a0,-1046 # 80008318 <etext+0x318>
    80001736:	00004097          	auipc	ra,0x4
    8000173a:	79c080e7          	jalr	1948(ra) # 80005ed2 <panic>
    panic("sched locks");
    8000173e:	00007517          	auipc	a0,0x7
    80001742:	bea50513          	addi	a0,a0,-1046 # 80008328 <etext+0x328>
    80001746:	00004097          	auipc	ra,0x4
    8000174a:	78c080e7          	jalr	1932(ra) # 80005ed2 <panic>
    panic("sched running");
    8000174e:	00007517          	auipc	a0,0x7
    80001752:	bea50513          	addi	a0,a0,-1046 # 80008338 <etext+0x338>
    80001756:	00004097          	auipc	ra,0x4
    8000175a:	77c080e7          	jalr	1916(ra) # 80005ed2 <panic>
    panic("sched interruptible");
    8000175e:	00007517          	auipc	a0,0x7
    80001762:	bea50513          	addi	a0,a0,-1046 # 80008348 <etext+0x348>
    80001766:	00004097          	auipc	ra,0x4
    8000176a:	76c080e7          	jalr	1900(ra) # 80005ed2 <panic>

000000008000176e <yield>:
{
    8000176e:	1101                	addi	sp,sp,-32
    80001770:	ec06                	sd	ra,24(sp)
    80001772:	e822                	sd	s0,16(sp)
    80001774:	e426                	sd	s1,8(sp)
    80001776:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001778:	00000097          	auipc	ra,0x0
    8000177c:	98a080e7          	jalr	-1654(ra) # 80001102 <myproc>
    80001780:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001782:	00005097          	auipc	ra,0x5
    80001786:	c9a080e7          	jalr	-870(ra) # 8000641c <acquire>
  p->state = RUNNABLE;
    8000178a:	478d                	li	a5,3
    8000178c:	cc9c                	sw	a5,24(s1)
  sched();
    8000178e:	00000097          	auipc	ra,0x0
    80001792:	f0a080e7          	jalr	-246(ra) # 80001698 <sched>
  release(&p->lock);
    80001796:	8526                	mv	a0,s1
    80001798:	00005097          	auipc	ra,0x5
    8000179c:	d38080e7          	jalr	-712(ra) # 800064d0 <release>
}
    800017a0:	60e2                	ld	ra,24(sp)
    800017a2:	6442                	ld	s0,16(sp)
    800017a4:	64a2                	ld	s1,8(sp)
    800017a6:	6105                	addi	sp,sp,32
    800017a8:	8082                	ret

00000000800017aa <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800017aa:	7179                	addi	sp,sp,-48
    800017ac:	f406                	sd	ra,40(sp)
    800017ae:	f022                	sd	s0,32(sp)
    800017b0:	ec26                	sd	s1,24(sp)
    800017b2:	e84a                	sd	s2,16(sp)
    800017b4:	e44e                	sd	s3,8(sp)
    800017b6:	1800                	addi	s0,sp,48
    800017b8:	89aa                	mv	s3,a0
    800017ba:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800017bc:	00000097          	auipc	ra,0x0
    800017c0:	946080e7          	jalr	-1722(ra) # 80001102 <myproc>
    800017c4:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800017c6:	00005097          	auipc	ra,0x5
    800017ca:	c56080e7          	jalr	-938(ra) # 8000641c <acquire>
  release(lk);
    800017ce:	854a                	mv	a0,s2
    800017d0:	00005097          	auipc	ra,0x5
    800017d4:	d00080e7          	jalr	-768(ra) # 800064d0 <release>

  // Go to sleep.
  p->chan = chan;
    800017d8:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800017dc:	4789                	li	a5,2
    800017de:	cc9c                	sw	a5,24(s1)

  sched();
    800017e0:	00000097          	auipc	ra,0x0
    800017e4:	eb8080e7          	jalr	-328(ra) # 80001698 <sched>

  // Tidy up.
  p->chan = 0;
    800017e8:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800017ec:	8526                	mv	a0,s1
    800017ee:	00005097          	auipc	ra,0x5
    800017f2:	ce2080e7          	jalr	-798(ra) # 800064d0 <release>
  acquire(lk);
    800017f6:	854a                	mv	a0,s2
    800017f8:	00005097          	auipc	ra,0x5
    800017fc:	c24080e7          	jalr	-988(ra) # 8000641c <acquire>
}
    80001800:	70a2                	ld	ra,40(sp)
    80001802:	7402                	ld	s0,32(sp)
    80001804:	64e2                	ld	s1,24(sp)
    80001806:	6942                	ld	s2,16(sp)
    80001808:	69a2                	ld	s3,8(sp)
    8000180a:	6145                	addi	sp,sp,48
    8000180c:	8082                	ret

000000008000180e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000180e:	7139                	addi	sp,sp,-64
    80001810:	fc06                	sd	ra,56(sp)
    80001812:	f822                	sd	s0,48(sp)
    80001814:	f426                	sd	s1,40(sp)
    80001816:	f04a                	sd	s2,32(sp)
    80001818:	ec4e                	sd	s3,24(sp)
    8000181a:	e852                	sd	s4,16(sp)
    8000181c:	e456                	sd	s5,8(sp)
    8000181e:	0080                	addi	s0,sp,64
    80001820:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001822:	00027497          	auipc	s1,0x27
    80001826:	6e648493          	addi	s1,s1,1766 # 80028f08 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000182a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000182c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000182e:	0002d917          	auipc	s2,0x2d
    80001832:	0da90913          	addi	s2,s2,218 # 8002e908 <tickslock>
    80001836:	a821                	j	8000184e <wakeup+0x40>
        p->state = RUNNABLE;
    80001838:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    8000183c:	8526                	mv	a0,s1
    8000183e:	00005097          	auipc	ra,0x5
    80001842:	c92080e7          	jalr	-878(ra) # 800064d0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001846:	16848493          	addi	s1,s1,360
    8000184a:	03248463          	beq	s1,s2,80001872 <wakeup+0x64>
    if(p != myproc()){
    8000184e:	00000097          	auipc	ra,0x0
    80001852:	8b4080e7          	jalr	-1868(ra) # 80001102 <myproc>
    80001856:	fea488e3          	beq	s1,a0,80001846 <wakeup+0x38>
      acquire(&p->lock);
    8000185a:	8526                	mv	a0,s1
    8000185c:	00005097          	auipc	ra,0x5
    80001860:	bc0080e7          	jalr	-1088(ra) # 8000641c <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001864:	4c9c                	lw	a5,24(s1)
    80001866:	fd379be3          	bne	a5,s3,8000183c <wakeup+0x2e>
    8000186a:	709c                	ld	a5,32(s1)
    8000186c:	fd4798e3          	bne	a5,s4,8000183c <wakeup+0x2e>
    80001870:	b7e1                	j	80001838 <wakeup+0x2a>
    }
  }
}
    80001872:	70e2                	ld	ra,56(sp)
    80001874:	7442                	ld	s0,48(sp)
    80001876:	74a2                	ld	s1,40(sp)
    80001878:	7902                	ld	s2,32(sp)
    8000187a:	69e2                	ld	s3,24(sp)
    8000187c:	6a42                	ld	s4,16(sp)
    8000187e:	6aa2                	ld	s5,8(sp)
    80001880:	6121                	addi	sp,sp,64
    80001882:	8082                	ret

0000000080001884 <reparent>:
{
    80001884:	7179                	addi	sp,sp,-48
    80001886:	f406                	sd	ra,40(sp)
    80001888:	f022                	sd	s0,32(sp)
    8000188a:	ec26                	sd	s1,24(sp)
    8000188c:	e84a                	sd	s2,16(sp)
    8000188e:	e44e                	sd	s3,8(sp)
    80001890:	e052                	sd	s4,0(sp)
    80001892:	1800                	addi	s0,sp,48
    80001894:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001896:	00027497          	auipc	s1,0x27
    8000189a:	67248493          	addi	s1,s1,1650 # 80028f08 <proc>
      pp->parent = initproc;
    8000189e:	00007a17          	auipc	s4,0x7
    800018a2:	1e2a0a13          	addi	s4,s4,482 # 80008a80 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800018a6:	0002d997          	auipc	s3,0x2d
    800018aa:	06298993          	addi	s3,s3,98 # 8002e908 <tickslock>
    800018ae:	a029                	j	800018b8 <reparent+0x34>
    800018b0:	16848493          	addi	s1,s1,360
    800018b4:	01348d63          	beq	s1,s3,800018ce <reparent+0x4a>
    if(pp->parent == p){
    800018b8:	7c9c                	ld	a5,56(s1)
    800018ba:	ff279be3          	bne	a5,s2,800018b0 <reparent+0x2c>
      pp->parent = initproc;
    800018be:	000a3503          	ld	a0,0(s4)
    800018c2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800018c4:	00000097          	auipc	ra,0x0
    800018c8:	f4a080e7          	jalr	-182(ra) # 8000180e <wakeup>
    800018cc:	b7d5                	j	800018b0 <reparent+0x2c>
}
    800018ce:	70a2                	ld	ra,40(sp)
    800018d0:	7402                	ld	s0,32(sp)
    800018d2:	64e2                	ld	s1,24(sp)
    800018d4:	6942                	ld	s2,16(sp)
    800018d6:	69a2                	ld	s3,8(sp)
    800018d8:	6a02                	ld	s4,0(sp)
    800018da:	6145                	addi	sp,sp,48
    800018dc:	8082                	ret

00000000800018de <exit>:
{
    800018de:	7179                	addi	sp,sp,-48
    800018e0:	f406                	sd	ra,40(sp)
    800018e2:	f022                	sd	s0,32(sp)
    800018e4:	ec26                	sd	s1,24(sp)
    800018e6:	e84a                	sd	s2,16(sp)
    800018e8:	e44e                	sd	s3,8(sp)
    800018ea:	e052                	sd	s4,0(sp)
    800018ec:	1800                	addi	s0,sp,48
    800018ee:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800018f0:	00000097          	auipc	ra,0x0
    800018f4:	812080e7          	jalr	-2030(ra) # 80001102 <myproc>
    800018f8:	89aa                	mv	s3,a0
  if(p == initproc)
    800018fa:	00007797          	auipc	a5,0x7
    800018fe:	1867b783          	ld	a5,390(a5) # 80008a80 <initproc>
    80001902:	0d050493          	addi	s1,a0,208
    80001906:	15050913          	addi	s2,a0,336
    8000190a:	02a79363          	bne	a5,a0,80001930 <exit+0x52>
    panic("init exiting");
    8000190e:	00007517          	auipc	a0,0x7
    80001912:	a5250513          	addi	a0,a0,-1454 # 80008360 <etext+0x360>
    80001916:	00004097          	auipc	ra,0x4
    8000191a:	5bc080e7          	jalr	1468(ra) # 80005ed2 <panic>
      fileclose(f);
    8000191e:	00002097          	auipc	ra,0x2
    80001922:	342080e7          	jalr	834(ra) # 80003c60 <fileclose>
      p->ofile[fd] = 0;
    80001926:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000192a:	04a1                	addi	s1,s1,8
    8000192c:	01248563          	beq	s1,s2,80001936 <exit+0x58>
    if(p->ofile[fd]){
    80001930:	6088                	ld	a0,0(s1)
    80001932:	f575                	bnez	a0,8000191e <exit+0x40>
    80001934:	bfdd                	j	8000192a <exit+0x4c>
  begin_op();
    80001936:	00002097          	auipc	ra,0x2
    8000193a:	e5e080e7          	jalr	-418(ra) # 80003794 <begin_op>
  iput(p->cwd);
    8000193e:	1509b503          	ld	a0,336(s3)
    80001942:	00001097          	auipc	ra,0x1
    80001946:	64a080e7          	jalr	1610(ra) # 80002f8c <iput>
  end_op();
    8000194a:	00002097          	auipc	ra,0x2
    8000194e:	eca080e7          	jalr	-310(ra) # 80003814 <end_op>
  p->cwd = 0;
    80001952:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001956:	00027497          	auipc	s1,0x27
    8000195a:	19a48493          	addi	s1,s1,410 # 80028af0 <wait_lock>
    8000195e:	8526                	mv	a0,s1
    80001960:	00005097          	auipc	ra,0x5
    80001964:	abc080e7          	jalr	-1348(ra) # 8000641c <acquire>
  reparent(p);
    80001968:	854e                	mv	a0,s3
    8000196a:	00000097          	auipc	ra,0x0
    8000196e:	f1a080e7          	jalr	-230(ra) # 80001884 <reparent>
  wakeup(p->parent);
    80001972:	0389b503          	ld	a0,56(s3)
    80001976:	00000097          	auipc	ra,0x0
    8000197a:	e98080e7          	jalr	-360(ra) # 8000180e <wakeup>
  acquire(&p->lock);
    8000197e:	854e                	mv	a0,s3
    80001980:	00005097          	auipc	ra,0x5
    80001984:	a9c080e7          	jalr	-1380(ra) # 8000641c <acquire>
  p->xstate = status;
    80001988:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000198c:	4795                	li	a5,5
    8000198e:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001992:	8526                	mv	a0,s1
    80001994:	00005097          	auipc	ra,0x5
    80001998:	b3c080e7          	jalr	-1220(ra) # 800064d0 <release>
  sched();
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	cfc080e7          	jalr	-772(ra) # 80001698 <sched>
  panic("zombie exit");
    800019a4:	00007517          	auipc	a0,0x7
    800019a8:	9cc50513          	addi	a0,a0,-1588 # 80008370 <etext+0x370>
    800019ac:	00004097          	auipc	ra,0x4
    800019b0:	526080e7          	jalr	1318(ra) # 80005ed2 <panic>

00000000800019b4 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800019b4:	7179                	addi	sp,sp,-48
    800019b6:	f406                	sd	ra,40(sp)
    800019b8:	f022                	sd	s0,32(sp)
    800019ba:	ec26                	sd	s1,24(sp)
    800019bc:	e84a                	sd	s2,16(sp)
    800019be:	e44e                	sd	s3,8(sp)
    800019c0:	1800                	addi	s0,sp,48
    800019c2:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800019c4:	00027497          	auipc	s1,0x27
    800019c8:	54448493          	addi	s1,s1,1348 # 80028f08 <proc>
    800019cc:	0002d997          	auipc	s3,0x2d
    800019d0:	f3c98993          	addi	s3,s3,-196 # 8002e908 <tickslock>
    acquire(&p->lock);
    800019d4:	8526                	mv	a0,s1
    800019d6:	00005097          	auipc	ra,0x5
    800019da:	a46080e7          	jalr	-1466(ra) # 8000641c <acquire>
    if(p->pid == pid){
    800019de:	589c                	lw	a5,48(s1)
    800019e0:	01278d63          	beq	a5,s2,800019fa <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800019e4:	8526                	mv	a0,s1
    800019e6:	00005097          	auipc	ra,0x5
    800019ea:	aea080e7          	jalr	-1302(ra) # 800064d0 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800019ee:	16848493          	addi	s1,s1,360
    800019f2:	ff3491e3          	bne	s1,s3,800019d4 <kill+0x20>
  }
  return -1;
    800019f6:	557d                	li	a0,-1
    800019f8:	a829                	j	80001a12 <kill+0x5e>
      p->killed = 1;
    800019fa:	4785                	li	a5,1
    800019fc:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800019fe:	4c98                	lw	a4,24(s1)
    80001a00:	4789                	li	a5,2
    80001a02:	00f70f63          	beq	a4,a5,80001a20 <kill+0x6c>
      release(&p->lock);
    80001a06:	8526                	mv	a0,s1
    80001a08:	00005097          	auipc	ra,0x5
    80001a0c:	ac8080e7          	jalr	-1336(ra) # 800064d0 <release>
      return 0;
    80001a10:	4501                	li	a0,0
}
    80001a12:	70a2                	ld	ra,40(sp)
    80001a14:	7402                	ld	s0,32(sp)
    80001a16:	64e2                	ld	s1,24(sp)
    80001a18:	6942                	ld	s2,16(sp)
    80001a1a:	69a2                	ld	s3,8(sp)
    80001a1c:	6145                	addi	sp,sp,48
    80001a1e:	8082                	ret
        p->state = RUNNABLE;
    80001a20:	478d                	li	a5,3
    80001a22:	cc9c                	sw	a5,24(s1)
    80001a24:	b7cd                	j	80001a06 <kill+0x52>

0000000080001a26 <setkilled>:

void
setkilled(struct proc *p)
{
    80001a26:	1101                	addi	sp,sp,-32
    80001a28:	ec06                	sd	ra,24(sp)
    80001a2a:	e822                	sd	s0,16(sp)
    80001a2c:	e426                	sd	s1,8(sp)
    80001a2e:	1000                	addi	s0,sp,32
    80001a30:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001a32:	00005097          	auipc	ra,0x5
    80001a36:	9ea080e7          	jalr	-1558(ra) # 8000641c <acquire>
  p->killed = 1;
    80001a3a:	4785                	li	a5,1
    80001a3c:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001a3e:	8526                	mv	a0,s1
    80001a40:	00005097          	auipc	ra,0x5
    80001a44:	a90080e7          	jalr	-1392(ra) # 800064d0 <release>
}
    80001a48:	60e2                	ld	ra,24(sp)
    80001a4a:	6442                	ld	s0,16(sp)
    80001a4c:	64a2                	ld	s1,8(sp)
    80001a4e:	6105                	addi	sp,sp,32
    80001a50:	8082                	ret

0000000080001a52 <killed>:

int
killed(struct proc *p)
{
    80001a52:	1101                	addi	sp,sp,-32
    80001a54:	ec06                	sd	ra,24(sp)
    80001a56:	e822                	sd	s0,16(sp)
    80001a58:	e426                	sd	s1,8(sp)
    80001a5a:	e04a                	sd	s2,0(sp)
    80001a5c:	1000                	addi	s0,sp,32
    80001a5e:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001a60:	00005097          	auipc	ra,0x5
    80001a64:	9bc080e7          	jalr	-1604(ra) # 8000641c <acquire>
  k = p->killed;
    80001a68:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001a6c:	8526                	mv	a0,s1
    80001a6e:	00005097          	auipc	ra,0x5
    80001a72:	a62080e7          	jalr	-1438(ra) # 800064d0 <release>
  return k;
}
    80001a76:	854a                	mv	a0,s2
    80001a78:	60e2                	ld	ra,24(sp)
    80001a7a:	6442                	ld	s0,16(sp)
    80001a7c:	64a2                	ld	s1,8(sp)
    80001a7e:	6902                	ld	s2,0(sp)
    80001a80:	6105                	addi	sp,sp,32
    80001a82:	8082                	ret

0000000080001a84 <wait>:
{
    80001a84:	715d                	addi	sp,sp,-80
    80001a86:	e486                	sd	ra,72(sp)
    80001a88:	e0a2                	sd	s0,64(sp)
    80001a8a:	fc26                	sd	s1,56(sp)
    80001a8c:	f84a                	sd	s2,48(sp)
    80001a8e:	f44e                	sd	s3,40(sp)
    80001a90:	f052                	sd	s4,32(sp)
    80001a92:	ec56                	sd	s5,24(sp)
    80001a94:	e85a                	sd	s6,16(sp)
    80001a96:	e45e                	sd	s7,8(sp)
    80001a98:	e062                	sd	s8,0(sp)
    80001a9a:	0880                	addi	s0,sp,80
    80001a9c:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001a9e:	fffff097          	auipc	ra,0xfffff
    80001aa2:	664080e7          	jalr	1636(ra) # 80001102 <myproc>
    80001aa6:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001aa8:	00027517          	auipc	a0,0x27
    80001aac:	04850513          	addi	a0,a0,72 # 80028af0 <wait_lock>
    80001ab0:	00005097          	auipc	ra,0x5
    80001ab4:	96c080e7          	jalr	-1684(ra) # 8000641c <acquire>
    havekids = 0;
    80001ab8:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001aba:	4a15                	li	s4,5
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001abc:	0002d997          	auipc	s3,0x2d
    80001ac0:	e4c98993          	addi	s3,s3,-436 # 8002e908 <tickslock>
        havekids = 1;
    80001ac4:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001ac6:	00027c17          	auipc	s8,0x27
    80001aca:	02ac0c13          	addi	s8,s8,42 # 80028af0 <wait_lock>
    havekids = 0;
    80001ace:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001ad0:	00027497          	auipc	s1,0x27
    80001ad4:	43848493          	addi	s1,s1,1080 # 80028f08 <proc>
    80001ad8:	a0bd                	j	80001b46 <wait+0xc2>
          pid = pp->pid;
    80001ada:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001ade:	000b0e63          	beqz	s6,80001afa <wait+0x76>
    80001ae2:	4691                	li	a3,4
    80001ae4:	02c48613          	addi	a2,s1,44
    80001ae8:	85da                	mv	a1,s6
    80001aea:	05093503          	ld	a0,80(s2)
    80001aee:	fffff097          	auipc	ra,0xfffff
    80001af2:	25a080e7          	jalr	602(ra) # 80000d48 <copyout>
    80001af6:	02054563          	bltz	a0,80001b20 <wait+0x9c>
          freeproc(pp);
    80001afa:	8526                	mv	a0,s1
    80001afc:	fffff097          	auipc	ra,0xfffff
    80001b00:	7bc080e7          	jalr	1980(ra) # 800012b8 <freeproc>
          release(&pp->lock);
    80001b04:	8526                	mv	a0,s1
    80001b06:	00005097          	auipc	ra,0x5
    80001b0a:	9ca080e7          	jalr	-1590(ra) # 800064d0 <release>
          release(&wait_lock);
    80001b0e:	00027517          	auipc	a0,0x27
    80001b12:	fe250513          	addi	a0,a0,-30 # 80028af0 <wait_lock>
    80001b16:	00005097          	auipc	ra,0x5
    80001b1a:	9ba080e7          	jalr	-1606(ra) # 800064d0 <release>
          return pid;
    80001b1e:	a0b5                	j	80001b8a <wait+0x106>
            release(&pp->lock);
    80001b20:	8526                	mv	a0,s1
    80001b22:	00005097          	auipc	ra,0x5
    80001b26:	9ae080e7          	jalr	-1618(ra) # 800064d0 <release>
            release(&wait_lock);
    80001b2a:	00027517          	auipc	a0,0x27
    80001b2e:	fc650513          	addi	a0,a0,-58 # 80028af0 <wait_lock>
    80001b32:	00005097          	auipc	ra,0x5
    80001b36:	99e080e7          	jalr	-1634(ra) # 800064d0 <release>
            return -1;
    80001b3a:	59fd                	li	s3,-1
    80001b3c:	a0b9                	j	80001b8a <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001b3e:	16848493          	addi	s1,s1,360
    80001b42:	03348463          	beq	s1,s3,80001b6a <wait+0xe6>
      if(pp->parent == p){
    80001b46:	7c9c                	ld	a5,56(s1)
    80001b48:	ff279be3          	bne	a5,s2,80001b3e <wait+0xba>
        acquire(&pp->lock);
    80001b4c:	8526                	mv	a0,s1
    80001b4e:	00005097          	auipc	ra,0x5
    80001b52:	8ce080e7          	jalr	-1842(ra) # 8000641c <acquire>
        if(pp->state == ZOMBIE){
    80001b56:	4c9c                	lw	a5,24(s1)
    80001b58:	f94781e3          	beq	a5,s4,80001ada <wait+0x56>
        release(&pp->lock);
    80001b5c:	8526                	mv	a0,s1
    80001b5e:	00005097          	auipc	ra,0x5
    80001b62:	972080e7          	jalr	-1678(ra) # 800064d0 <release>
        havekids = 1;
    80001b66:	8756                	mv	a4,s5
    80001b68:	bfd9                	j	80001b3e <wait+0xba>
    if(!havekids || killed(p)){
    80001b6a:	c719                	beqz	a4,80001b78 <wait+0xf4>
    80001b6c:	854a                	mv	a0,s2
    80001b6e:	00000097          	auipc	ra,0x0
    80001b72:	ee4080e7          	jalr	-284(ra) # 80001a52 <killed>
    80001b76:	c51d                	beqz	a0,80001ba4 <wait+0x120>
      release(&wait_lock);
    80001b78:	00027517          	auipc	a0,0x27
    80001b7c:	f7850513          	addi	a0,a0,-136 # 80028af0 <wait_lock>
    80001b80:	00005097          	auipc	ra,0x5
    80001b84:	950080e7          	jalr	-1712(ra) # 800064d0 <release>
      return -1;
    80001b88:	59fd                	li	s3,-1
}
    80001b8a:	854e                	mv	a0,s3
    80001b8c:	60a6                	ld	ra,72(sp)
    80001b8e:	6406                	ld	s0,64(sp)
    80001b90:	74e2                	ld	s1,56(sp)
    80001b92:	7942                	ld	s2,48(sp)
    80001b94:	79a2                	ld	s3,40(sp)
    80001b96:	7a02                	ld	s4,32(sp)
    80001b98:	6ae2                	ld	s5,24(sp)
    80001b9a:	6b42                	ld	s6,16(sp)
    80001b9c:	6ba2                	ld	s7,8(sp)
    80001b9e:	6c02                	ld	s8,0(sp)
    80001ba0:	6161                	addi	sp,sp,80
    80001ba2:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001ba4:	85e2                	mv	a1,s8
    80001ba6:	854a                	mv	a0,s2
    80001ba8:	00000097          	auipc	ra,0x0
    80001bac:	c02080e7          	jalr	-1022(ra) # 800017aa <sleep>
    havekids = 0;
    80001bb0:	bf39                	j	80001ace <wait+0x4a>

0000000080001bb2 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001bb2:	7179                	addi	sp,sp,-48
    80001bb4:	f406                	sd	ra,40(sp)
    80001bb6:	f022                	sd	s0,32(sp)
    80001bb8:	ec26                	sd	s1,24(sp)
    80001bba:	e84a                	sd	s2,16(sp)
    80001bbc:	e44e                	sd	s3,8(sp)
    80001bbe:	e052                	sd	s4,0(sp)
    80001bc0:	1800                	addi	s0,sp,48
    80001bc2:	84aa                	mv	s1,a0
    80001bc4:	892e                	mv	s2,a1
    80001bc6:	89b2                	mv	s3,a2
    80001bc8:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001bca:	fffff097          	auipc	ra,0xfffff
    80001bce:	538080e7          	jalr	1336(ra) # 80001102 <myproc>
  if(user_dst){
    80001bd2:	c08d                	beqz	s1,80001bf4 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001bd4:	86d2                	mv	a3,s4
    80001bd6:	864e                	mv	a2,s3
    80001bd8:	85ca                	mv	a1,s2
    80001bda:	6928                	ld	a0,80(a0)
    80001bdc:	fffff097          	auipc	ra,0xfffff
    80001be0:	16c080e7          	jalr	364(ra) # 80000d48 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001be4:	70a2                	ld	ra,40(sp)
    80001be6:	7402                	ld	s0,32(sp)
    80001be8:	64e2                	ld	s1,24(sp)
    80001bea:	6942                	ld	s2,16(sp)
    80001bec:	69a2                	ld	s3,8(sp)
    80001bee:	6a02                	ld	s4,0(sp)
    80001bf0:	6145                	addi	sp,sp,48
    80001bf2:	8082                	ret
    memmove((char *)dst, src, len);
    80001bf4:	000a061b          	sext.w	a2,s4
    80001bf8:	85ce                	mv	a1,s3
    80001bfa:	854a                	mv	a0,s2
    80001bfc:	ffffe097          	auipc	ra,0xffffe
    80001c00:	6e8080e7          	jalr	1768(ra) # 800002e4 <memmove>
    return 0;
    80001c04:	8526                	mv	a0,s1
    80001c06:	bff9                	j	80001be4 <either_copyout+0x32>

0000000080001c08 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001c08:	7179                	addi	sp,sp,-48
    80001c0a:	f406                	sd	ra,40(sp)
    80001c0c:	f022                	sd	s0,32(sp)
    80001c0e:	ec26                	sd	s1,24(sp)
    80001c10:	e84a                	sd	s2,16(sp)
    80001c12:	e44e                	sd	s3,8(sp)
    80001c14:	e052                	sd	s4,0(sp)
    80001c16:	1800                	addi	s0,sp,48
    80001c18:	892a                	mv	s2,a0
    80001c1a:	84ae                	mv	s1,a1
    80001c1c:	89b2                	mv	s3,a2
    80001c1e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	4e2080e7          	jalr	1250(ra) # 80001102 <myproc>
  if(user_src){
    80001c28:	c08d                	beqz	s1,80001c4a <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001c2a:	86d2                	mv	a3,s4
    80001c2c:	864e                	mv	a2,s3
    80001c2e:	85ca                	mv	a1,s2
    80001c30:	6928                	ld	a0,80(a0)
    80001c32:	fffff097          	auipc	ra,0xfffff
    80001c36:	21a080e7          	jalr	538(ra) # 80000e4c <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001c3a:	70a2                	ld	ra,40(sp)
    80001c3c:	7402                	ld	s0,32(sp)
    80001c3e:	64e2                	ld	s1,24(sp)
    80001c40:	6942                	ld	s2,16(sp)
    80001c42:	69a2                	ld	s3,8(sp)
    80001c44:	6a02                	ld	s4,0(sp)
    80001c46:	6145                	addi	sp,sp,48
    80001c48:	8082                	ret
    memmove(dst, (char*)src, len);
    80001c4a:	000a061b          	sext.w	a2,s4
    80001c4e:	85ce                	mv	a1,s3
    80001c50:	854a                	mv	a0,s2
    80001c52:	ffffe097          	auipc	ra,0xffffe
    80001c56:	692080e7          	jalr	1682(ra) # 800002e4 <memmove>
    return 0;
    80001c5a:	8526                	mv	a0,s1
    80001c5c:	bff9                	j	80001c3a <either_copyin+0x32>

0000000080001c5e <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001c5e:	715d                	addi	sp,sp,-80
    80001c60:	e486                	sd	ra,72(sp)
    80001c62:	e0a2                	sd	s0,64(sp)
    80001c64:	fc26                	sd	s1,56(sp)
    80001c66:	f84a                	sd	s2,48(sp)
    80001c68:	f44e                	sd	s3,40(sp)
    80001c6a:	f052                	sd	s4,32(sp)
    80001c6c:	ec56                	sd	s5,24(sp)
    80001c6e:	e85a                	sd	s6,16(sp)
    80001c70:	e45e                	sd	s7,8(sp)
    80001c72:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001c74:	00006517          	auipc	a0,0x6
    80001c78:	3e450513          	addi	a0,a0,996 # 80008058 <etext+0x58>
    80001c7c:	00004097          	auipc	ra,0x4
    80001c80:	2a0080e7          	jalr	672(ra) # 80005f1c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001c84:	00027497          	auipc	s1,0x27
    80001c88:	3dc48493          	addi	s1,s1,988 # 80029060 <proc+0x158>
    80001c8c:	0002d917          	auipc	s2,0x2d
    80001c90:	dd490913          	addi	s2,s2,-556 # 8002ea60 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001c94:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001c96:	00006997          	auipc	s3,0x6
    80001c9a:	6ea98993          	addi	s3,s3,1770 # 80008380 <etext+0x380>
    printf("%d %s %s", p->pid, state, p->name);
    80001c9e:	00006a97          	auipc	s5,0x6
    80001ca2:	6eaa8a93          	addi	s5,s5,1770 # 80008388 <etext+0x388>
    printf("\n");
    80001ca6:	00006a17          	auipc	s4,0x6
    80001caa:	3b2a0a13          	addi	s4,s4,946 # 80008058 <etext+0x58>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001cae:	00006b97          	auipc	s7,0x6
    80001cb2:	71ab8b93          	addi	s7,s7,1818 # 800083c8 <states.1732>
    80001cb6:	a00d                	j	80001cd8 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001cb8:	ed86a583          	lw	a1,-296(a3)
    80001cbc:	8556                	mv	a0,s5
    80001cbe:	00004097          	auipc	ra,0x4
    80001cc2:	25e080e7          	jalr	606(ra) # 80005f1c <printf>
    printf("\n");
    80001cc6:	8552                	mv	a0,s4
    80001cc8:	00004097          	auipc	ra,0x4
    80001ccc:	254080e7          	jalr	596(ra) # 80005f1c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001cd0:	16848493          	addi	s1,s1,360
    80001cd4:	03248163          	beq	s1,s2,80001cf6 <procdump+0x98>
    if(p->state == UNUSED)
    80001cd8:	86a6                	mv	a3,s1
    80001cda:	ec04a783          	lw	a5,-320(s1)
    80001cde:	dbed                	beqz	a5,80001cd0 <procdump+0x72>
      state = "???";
    80001ce0:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ce2:	fcfb6be3          	bltu	s6,a5,80001cb8 <procdump+0x5a>
    80001ce6:	1782                	slli	a5,a5,0x20
    80001ce8:	9381                	srli	a5,a5,0x20
    80001cea:	078e                	slli	a5,a5,0x3
    80001cec:	97de                	add	a5,a5,s7
    80001cee:	6390                	ld	a2,0(a5)
    80001cf0:	f661                	bnez	a2,80001cb8 <procdump+0x5a>
      state = "???";
    80001cf2:	864e                	mv	a2,s3
    80001cf4:	b7d1                	j	80001cb8 <procdump+0x5a>
  }
}
    80001cf6:	60a6                	ld	ra,72(sp)
    80001cf8:	6406                	ld	s0,64(sp)
    80001cfa:	74e2                	ld	s1,56(sp)
    80001cfc:	7942                	ld	s2,48(sp)
    80001cfe:	79a2                	ld	s3,40(sp)
    80001d00:	7a02                	ld	s4,32(sp)
    80001d02:	6ae2                	ld	s5,24(sp)
    80001d04:	6b42                	ld	s6,16(sp)
    80001d06:	6ba2                	ld	s7,8(sp)
    80001d08:	6161                	addi	sp,sp,80
    80001d0a:	8082                	ret

0000000080001d0c <swtch>:
    80001d0c:	00153023          	sd	ra,0(a0)
    80001d10:	00253423          	sd	sp,8(a0)
    80001d14:	e900                	sd	s0,16(a0)
    80001d16:	ed04                	sd	s1,24(a0)
    80001d18:	03253023          	sd	s2,32(a0)
    80001d1c:	03353423          	sd	s3,40(a0)
    80001d20:	03453823          	sd	s4,48(a0)
    80001d24:	03553c23          	sd	s5,56(a0)
    80001d28:	05653023          	sd	s6,64(a0)
    80001d2c:	05753423          	sd	s7,72(a0)
    80001d30:	05853823          	sd	s8,80(a0)
    80001d34:	05953c23          	sd	s9,88(a0)
    80001d38:	07a53023          	sd	s10,96(a0)
    80001d3c:	07b53423          	sd	s11,104(a0)
    80001d40:	0005b083          	ld	ra,0(a1)
    80001d44:	0085b103          	ld	sp,8(a1)
    80001d48:	6980                	ld	s0,16(a1)
    80001d4a:	6d84                	ld	s1,24(a1)
    80001d4c:	0205b903          	ld	s2,32(a1)
    80001d50:	0285b983          	ld	s3,40(a1)
    80001d54:	0305ba03          	ld	s4,48(a1)
    80001d58:	0385ba83          	ld	s5,56(a1)
    80001d5c:	0405bb03          	ld	s6,64(a1)
    80001d60:	0485bb83          	ld	s7,72(a1)
    80001d64:	0505bc03          	ld	s8,80(a1)
    80001d68:	0585bc83          	ld	s9,88(a1)
    80001d6c:	0605bd03          	ld	s10,96(a1)
    80001d70:	0685bd83          	ld	s11,104(a1)
    80001d74:	8082                	ret

0000000080001d76 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001d76:	1141                	addi	sp,sp,-16
    80001d78:	e406                	sd	ra,8(sp)
    80001d7a:	e022                	sd	s0,0(sp)
    80001d7c:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001d7e:	00006597          	auipc	a1,0x6
    80001d82:	67a58593          	addi	a1,a1,1658 # 800083f8 <states.1732+0x30>
    80001d86:	0002d517          	auipc	a0,0x2d
    80001d8a:	b8250513          	addi	a0,a0,-1150 # 8002e908 <tickslock>
    80001d8e:	00004097          	auipc	ra,0x4
    80001d92:	5fe080e7          	jalr	1534(ra) # 8000638c <initlock>
}
    80001d96:	60a2                	ld	ra,8(sp)
    80001d98:	6402                	ld	s0,0(sp)
    80001d9a:	0141                	addi	sp,sp,16
    80001d9c:	8082                	ret

0000000080001d9e <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001d9e:	1141                	addi	sp,sp,-16
    80001da0:	e422                	sd	s0,8(sp)
    80001da2:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001da4:	00003797          	auipc	a5,0x3
    80001da8:	4fc78793          	addi	a5,a5,1276 # 800052a0 <kernelvec>
    80001dac:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001db0:	6422                	ld	s0,8(sp)
    80001db2:	0141                	addi	sp,sp,16
    80001db4:	8082                	ret

0000000080001db6 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001db6:	1141                	addi	sp,sp,-16
    80001db8:	e406                	sd	ra,8(sp)
    80001dba:	e022                	sd	s0,0(sp)
    80001dbc:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001dbe:	fffff097          	auipc	ra,0xfffff
    80001dc2:	344080e7          	jalr	836(ra) # 80001102 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dc6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001dca:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dcc:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001dd0:	00005617          	auipc	a2,0x5
    80001dd4:	23060613          	addi	a2,a2,560 # 80007000 <_trampoline>
    80001dd8:	00005697          	auipc	a3,0x5
    80001ddc:	22868693          	addi	a3,a3,552 # 80007000 <_trampoline>
    80001de0:	8e91                	sub	a3,a3,a2
    80001de2:	040007b7          	lui	a5,0x4000
    80001de6:	17fd                	addi	a5,a5,-1
    80001de8:	07b2                	slli	a5,a5,0xc
    80001dea:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001dec:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001df0:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001df2:	180026f3          	csrr	a3,satp
    80001df6:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001df8:	6d38                	ld	a4,88(a0)
    80001dfa:	6134                	ld	a3,64(a0)
    80001dfc:	6585                	lui	a1,0x1
    80001dfe:	96ae                	add	a3,a3,a1
    80001e00:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001e02:	6d38                	ld	a4,88(a0)
    80001e04:	00000697          	auipc	a3,0x0
    80001e08:	13068693          	addi	a3,a3,304 # 80001f34 <usertrap>
    80001e0c:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001e0e:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001e10:	8692                	mv	a3,tp
    80001e12:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e14:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001e18:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001e1c:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e20:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001e24:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e26:	6f18                	ld	a4,24(a4)
    80001e28:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001e2c:	6928                	ld	a0,80(a0)
    80001e2e:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001e30:	00005717          	auipc	a4,0x5
    80001e34:	26c70713          	addi	a4,a4,620 # 8000709c <userret>
    80001e38:	8f11                	sub	a4,a4,a2
    80001e3a:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001e3c:	577d                	li	a4,-1
    80001e3e:	177e                	slli	a4,a4,0x3f
    80001e40:	8d59                	or	a0,a0,a4
    80001e42:	9782                	jalr	a5
}
    80001e44:	60a2                	ld	ra,8(sp)
    80001e46:	6402                	ld	s0,0(sp)
    80001e48:	0141                	addi	sp,sp,16
    80001e4a:	8082                	ret

0000000080001e4c <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001e4c:	1101                	addi	sp,sp,-32
    80001e4e:	ec06                	sd	ra,24(sp)
    80001e50:	e822                	sd	s0,16(sp)
    80001e52:	e426                	sd	s1,8(sp)
    80001e54:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001e56:	0002d497          	auipc	s1,0x2d
    80001e5a:	ab248493          	addi	s1,s1,-1358 # 8002e908 <tickslock>
    80001e5e:	8526                	mv	a0,s1
    80001e60:	00004097          	auipc	ra,0x4
    80001e64:	5bc080e7          	jalr	1468(ra) # 8000641c <acquire>
  ticks++;
    80001e68:	00007517          	auipc	a0,0x7
    80001e6c:	c2050513          	addi	a0,a0,-992 # 80008a88 <ticks>
    80001e70:	411c                	lw	a5,0(a0)
    80001e72:	2785                	addiw	a5,a5,1
    80001e74:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001e76:	00000097          	auipc	ra,0x0
    80001e7a:	998080e7          	jalr	-1640(ra) # 8000180e <wakeup>
  release(&tickslock);
    80001e7e:	8526                	mv	a0,s1
    80001e80:	00004097          	auipc	ra,0x4
    80001e84:	650080e7          	jalr	1616(ra) # 800064d0 <release>
}
    80001e88:	60e2                	ld	ra,24(sp)
    80001e8a:	6442                	ld	s0,16(sp)
    80001e8c:	64a2                	ld	s1,8(sp)
    80001e8e:	6105                	addi	sp,sp,32
    80001e90:	8082                	ret

0000000080001e92 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001e92:	1101                	addi	sp,sp,-32
    80001e94:	ec06                	sd	ra,24(sp)
    80001e96:	e822                	sd	s0,16(sp)
    80001e98:	e426                	sd	s1,8(sp)
    80001e9a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e9c:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001ea0:	00074d63          	bltz	a4,80001eba <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001ea4:	57fd                	li	a5,-1
    80001ea6:	17fe                	slli	a5,a5,0x3f
    80001ea8:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001eaa:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001eac:	06f70363          	beq	a4,a5,80001f12 <devintr+0x80>
  }
}
    80001eb0:	60e2                	ld	ra,24(sp)
    80001eb2:	6442                	ld	s0,16(sp)
    80001eb4:	64a2                	ld	s1,8(sp)
    80001eb6:	6105                	addi	sp,sp,32
    80001eb8:	8082                	ret
     (scause & 0xff) == 9){
    80001eba:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001ebe:	46a5                	li	a3,9
    80001ec0:	fed792e3          	bne	a5,a3,80001ea4 <devintr+0x12>
    int irq = plic_claim();
    80001ec4:	00003097          	auipc	ra,0x3
    80001ec8:	4e4080e7          	jalr	1252(ra) # 800053a8 <plic_claim>
    80001ecc:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001ece:	47a9                	li	a5,10
    80001ed0:	02f50763          	beq	a0,a5,80001efe <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001ed4:	4785                	li	a5,1
    80001ed6:	02f50963          	beq	a0,a5,80001f08 <devintr+0x76>
    return 1;
    80001eda:	4505                	li	a0,1
    } else if(irq){
    80001edc:	d8f1                	beqz	s1,80001eb0 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001ede:	85a6                	mv	a1,s1
    80001ee0:	00006517          	auipc	a0,0x6
    80001ee4:	52050513          	addi	a0,a0,1312 # 80008400 <states.1732+0x38>
    80001ee8:	00004097          	auipc	ra,0x4
    80001eec:	034080e7          	jalr	52(ra) # 80005f1c <printf>
      plic_complete(irq);
    80001ef0:	8526                	mv	a0,s1
    80001ef2:	00003097          	auipc	ra,0x3
    80001ef6:	4da080e7          	jalr	1242(ra) # 800053cc <plic_complete>
    return 1;
    80001efa:	4505                	li	a0,1
    80001efc:	bf55                	j	80001eb0 <devintr+0x1e>
      uartintr();
    80001efe:	00004097          	auipc	ra,0x4
    80001f02:	43e080e7          	jalr	1086(ra) # 8000633c <uartintr>
    80001f06:	b7ed                	j	80001ef0 <devintr+0x5e>
      virtio_disk_intr();
    80001f08:	00004097          	auipc	ra,0x4
    80001f0c:	9ee080e7          	jalr	-1554(ra) # 800058f6 <virtio_disk_intr>
    80001f10:	b7c5                	j	80001ef0 <devintr+0x5e>
    if(cpuid() == 0){
    80001f12:	fffff097          	auipc	ra,0xfffff
    80001f16:	1c4080e7          	jalr	452(ra) # 800010d6 <cpuid>
    80001f1a:	c901                	beqz	a0,80001f2a <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001f1c:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001f20:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001f22:	14479073          	csrw	sip,a5
    return 2;
    80001f26:	4509                	li	a0,2
    80001f28:	b761                	j	80001eb0 <devintr+0x1e>
      clockintr();
    80001f2a:	00000097          	auipc	ra,0x0
    80001f2e:	f22080e7          	jalr	-222(ra) # 80001e4c <clockintr>
    80001f32:	b7ed                	j	80001f1c <devintr+0x8a>

0000000080001f34 <usertrap>:
{
    80001f34:	1101                	addi	sp,sp,-32
    80001f36:	ec06                	sd	ra,24(sp)
    80001f38:	e822                	sd	s0,16(sp)
    80001f3a:	e426                	sd	s1,8(sp)
    80001f3c:	e04a                	sd	s2,0(sp)
    80001f3e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f40:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001f44:	1007f793          	andi	a5,a5,256
    80001f48:	efc1                	bnez	a5,80001fe0 <usertrap+0xac>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001f4a:	00003797          	auipc	a5,0x3
    80001f4e:	35678793          	addi	a5,a5,854 # 800052a0 <kernelvec>
    80001f52:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001f56:	fffff097          	auipc	ra,0xfffff
    80001f5a:	1ac080e7          	jalr	428(ra) # 80001102 <myproc>
    80001f5e:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001f60:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f62:	14102773          	csrr	a4,sepc
    80001f66:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f68:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001f6c:	47a1                	li	a5,8
    80001f6e:	08f70163          	beq	a4,a5,80001ff0 <usertrap+0xbc>
    80001f72:	14202773          	csrr	a4,scause
  } else if (r_scause() == 15){
    80001f76:	47bd                	li	a5,15
    80001f78:	0af70663          	beq	a4,a5,80002024 <usertrap+0xf0>
  else if((which_dev = devintr()) != 0){
    80001f7c:	00000097          	auipc	ra,0x0
    80001f80:	f16080e7          	jalr	-234(ra) # 80001e92 <devintr>
    80001f84:	892a                	mv	s2,a0
    80001f86:	e979                	bnez	a0,8000205c <usertrap+0x128>
    80001f88:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001f8c:	5890                	lw	a2,48(s1)
    80001f8e:	00006517          	auipc	a0,0x6
    80001f92:	4ea50513          	addi	a0,a0,1258 # 80008478 <states.1732+0xb0>
    80001f96:	00004097          	auipc	ra,0x4
    80001f9a:	f86080e7          	jalr	-122(ra) # 80005f1c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f9e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001fa2:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001fa6:	00006517          	auipc	a0,0x6
    80001faa:	50250513          	addi	a0,a0,1282 # 800084a8 <states.1732+0xe0>
    80001fae:	00004097          	auipc	ra,0x4
    80001fb2:	f6e080e7          	jalr	-146(ra) # 80005f1c <printf>
    setkilled(p);
    80001fb6:	8526                	mv	a0,s1
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	a6e080e7          	jalr	-1426(ra) # 80001a26 <setkilled>
  if(killed(p))
    80001fc0:	8526                	mv	a0,s1
    80001fc2:	00000097          	auipc	ra,0x0
    80001fc6:	a90080e7          	jalr	-1392(ra) # 80001a52 <killed>
    80001fca:	e145                	bnez	a0,8000206a <usertrap+0x136>
  usertrapret();
    80001fcc:	00000097          	auipc	ra,0x0
    80001fd0:	dea080e7          	jalr	-534(ra) # 80001db6 <usertrapret>
}
    80001fd4:	60e2                	ld	ra,24(sp)
    80001fd6:	6442                	ld	s0,16(sp)
    80001fd8:	64a2                	ld	s1,8(sp)
    80001fda:	6902                	ld	s2,0(sp)
    80001fdc:	6105                	addi	sp,sp,32
    80001fde:	8082                	ret
    panic("usertrap: not from user mode");
    80001fe0:	00006517          	auipc	a0,0x6
    80001fe4:	44050513          	addi	a0,a0,1088 # 80008420 <states.1732+0x58>
    80001fe8:	00004097          	auipc	ra,0x4
    80001fec:	eea080e7          	jalr	-278(ra) # 80005ed2 <panic>
    if(killed(p))
    80001ff0:	00000097          	auipc	ra,0x0
    80001ff4:	a62080e7          	jalr	-1438(ra) # 80001a52 <killed>
    80001ff8:	e105                	bnez	a0,80002018 <usertrap+0xe4>
    p->trapframe->epc += 4;
    80001ffa:	6cb8                	ld	a4,88(s1)
    80001ffc:	6f1c                	ld	a5,24(a4)
    80001ffe:	0791                	addi	a5,a5,4
    80002000:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002002:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80002006:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000200a:	10079073          	csrw	sstatus,a5
    syscall();
    8000200e:	00000097          	auipc	ra,0x0
    80002012:	2c2080e7          	jalr	706(ra) # 800022d0 <syscall>
    80002016:	b76d                	j	80001fc0 <usertrap+0x8c>
      exit(-1);
    80002018:	557d                	li	a0,-1
    8000201a:	00000097          	auipc	ra,0x0
    8000201e:	8c4080e7          	jalr	-1852(ra) # 800018de <exit>
    80002022:	bfe1                	j	80001ffa <usertrap+0xc6>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002024:	14302973          	csrr	s2,stval
      if (is_COW_fault(p->pagetable, stval)){
    80002028:	85ca                	mv	a1,s2
    8000202a:	6928                	ld	a0,80(a0)
    8000202c:	ffffe097          	auipc	ra,0xffffe
    80002030:	5ea080e7          	jalr	1514(ra) # 80000616 <is_COW_fault>
    80002034:	d931                	beqz	a0,80001f88 <usertrap+0x54>
        if (handle_COW(p->pagetable, stval) < 0){
    80002036:	85ca                	mv	a1,s2
    80002038:	68a8                	ld	a0,80(s1)
    8000203a:	fffff097          	auipc	ra,0xfffff
    8000203e:	90c080e7          	jalr	-1780(ra) # 80000946 <handle_COW>
    80002042:	f6055fe3          	bgez	a0,80001fc0 <usertrap+0x8c>
          printf("usertrap() in [trap.c:72]: COW failed, program killed.\n");
    80002046:	00006517          	auipc	a0,0x6
    8000204a:	3fa50513          	addi	a0,a0,1018 # 80008440 <states.1732+0x78>
    8000204e:	00004097          	auipc	ra,0x4
    80002052:	ece080e7          	jalr	-306(ra) # 80005f1c <printf>
          p->killed = 1;
    80002056:	4785                	li	a5,1
    80002058:	d49c                	sw	a5,40(s1)
    8000205a:	b79d                	j	80001fc0 <usertrap+0x8c>
  if(killed(p))
    8000205c:	8526                	mv	a0,s1
    8000205e:	00000097          	auipc	ra,0x0
    80002062:	9f4080e7          	jalr	-1548(ra) # 80001a52 <killed>
    80002066:	c901                	beqz	a0,80002076 <usertrap+0x142>
    80002068:	a011                	j	8000206c <usertrap+0x138>
    8000206a:	4901                	li	s2,0
    exit(-1);
    8000206c:	557d                	li	a0,-1
    8000206e:	00000097          	auipc	ra,0x0
    80002072:	870080e7          	jalr	-1936(ra) # 800018de <exit>
  if(which_dev == 2)
    80002076:	4789                	li	a5,2
    80002078:	f4f91ae3          	bne	s2,a5,80001fcc <usertrap+0x98>
    yield();
    8000207c:	fffff097          	auipc	ra,0xfffff
    80002080:	6f2080e7          	jalr	1778(ra) # 8000176e <yield>
    80002084:	b7a1                	j	80001fcc <usertrap+0x98>

0000000080002086 <kerneltrap>:
{
    80002086:	7179                	addi	sp,sp,-48
    80002088:	f406                	sd	ra,40(sp)
    8000208a:	f022                	sd	s0,32(sp)
    8000208c:	ec26                	sd	s1,24(sp)
    8000208e:	e84a                	sd	s2,16(sp)
    80002090:	e44e                	sd	s3,8(sp)
    80002092:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002094:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002098:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000209c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    800020a0:	1004f793          	andi	a5,s1,256
    800020a4:	cb85                	beqz	a5,800020d4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800020a6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800020aa:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    800020ac:	ef85                	bnez	a5,800020e4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    800020ae:	00000097          	auipc	ra,0x0
    800020b2:	de4080e7          	jalr	-540(ra) # 80001e92 <devintr>
    800020b6:	cd1d                	beqz	a0,800020f4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800020b8:	4789                	li	a5,2
    800020ba:	06f50a63          	beq	a0,a5,8000212e <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    800020be:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800020c2:	10049073          	csrw	sstatus,s1
}
    800020c6:	70a2                	ld	ra,40(sp)
    800020c8:	7402                	ld	s0,32(sp)
    800020ca:	64e2                	ld	s1,24(sp)
    800020cc:	6942                	ld	s2,16(sp)
    800020ce:	69a2                	ld	s3,8(sp)
    800020d0:	6145                	addi	sp,sp,48
    800020d2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800020d4:	00006517          	auipc	a0,0x6
    800020d8:	3f450513          	addi	a0,a0,1012 # 800084c8 <states.1732+0x100>
    800020dc:	00004097          	auipc	ra,0x4
    800020e0:	df6080e7          	jalr	-522(ra) # 80005ed2 <panic>
    panic("kerneltrap: interrupts enabled");
    800020e4:	00006517          	auipc	a0,0x6
    800020e8:	40c50513          	addi	a0,a0,1036 # 800084f0 <states.1732+0x128>
    800020ec:	00004097          	auipc	ra,0x4
    800020f0:	de6080e7          	jalr	-538(ra) # 80005ed2 <panic>
    printf("scause %p\n", scause);
    800020f4:	85ce                	mv	a1,s3
    800020f6:	00006517          	auipc	a0,0x6
    800020fa:	41a50513          	addi	a0,a0,1050 # 80008510 <states.1732+0x148>
    800020fe:	00004097          	auipc	ra,0x4
    80002102:	e1e080e7          	jalr	-482(ra) # 80005f1c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002106:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000210a:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000210e:	00006517          	auipc	a0,0x6
    80002112:	41250513          	addi	a0,a0,1042 # 80008520 <states.1732+0x158>
    80002116:	00004097          	auipc	ra,0x4
    8000211a:	e06080e7          	jalr	-506(ra) # 80005f1c <printf>
    panic("kerneltrap");
    8000211e:	00006517          	auipc	a0,0x6
    80002122:	41a50513          	addi	a0,a0,1050 # 80008538 <states.1732+0x170>
    80002126:	00004097          	auipc	ra,0x4
    8000212a:	dac080e7          	jalr	-596(ra) # 80005ed2 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000212e:	fffff097          	auipc	ra,0xfffff
    80002132:	fd4080e7          	jalr	-44(ra) # 80001102 <myproc>
    80002136:	d541                	beqz	a0,800020be <kerneltrap+0x38>
    80002138:	fffff097          	auipc	ra,0xfffff
    8000213c:	fca080e7          	jalr	-54(ra) # 80001102 <myproc>
    80002140:	4d18                	lw	a4,24(a0)
    80002142:	4791                	li	a5,4
    80002144:	f6f71de3          	bne	a4,a5,800020be <kerneltrap+0x38>
    yield();
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	626080e7          	jalr	1574(ra) # 8000176e <yield>
    80002150:	b7bd                	j	800020be <kerneltrap+0x38>

0000000080002152 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002152:	1101                	addi	sp,sp,-32
    80002154:	ec06                	sd	ra,24(sp)
    80002156:	e822                	sd	s0,16(sp)
    80002158:	e426                	sd	s1,8(sp)
    8000215a:	1000                	addi	s0,sp,32
    8000215c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000215e:	fffff097          	auipc	ra,0xfffff
    80002162:	fa4080e7          	jalr	-92(ra) # 80001102 <myproc>
  switch (n) {
    80002166:	4795                	li	a5,5
    80002168:	0497e163          	bltu	a5,s1,800021aa <argraw+0x58>
    8000216c:	048a                	slli	s1,s1,0x2
    8000216e:	00006717          	auipc	a4,0x6
    80002172:	40270713          	addi	a4,a4,1026 # 80008570 <states.1732+0x1a8>
    80002176:	94ba                	add	s1,s1,a4
    80002178:	409c                	lw	a5,0(s1)
    8000217a:	97ba                	add	a5,a5,a4
    8000217c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    8000217e:	6d3c                	ld	a5,88(a0)
    80002180:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002182:	60e2                	ld	ra,24(sp)
    80002184:	6442                	ld	s0,16(sp)
    80002186:	64a2                	ld	s1,8(sp)
    80002188:	6105                	addi	sp,sp,32
    8000218a:	8082                	ret
    return p->trapframe->a1;
    8000218c:	6d3c                	ld	a5,88(a0)
    8000218e:	7fa8                	ld	a0,120(a5)
    80002190:	bfcd                	j	80002182 <argraw+0x30>
    return p->trapframe->a2;
    80002192:	6d3c                	ld	a5,88(a0)
    80002194:	63c8                	ld	a0,128(a5)
    80002196:	b7f5                	j	80002182 <argraw+0x30>
    return p->trapframe->a3;
    80002198:	6d3c                	ld	a5,88(a0)
    8000219a:	67c8                	ld	a0,136(a5)
    8000219c:	b7dd                	j	80002182 <argraw+0x30>
    return p->trapframe->a4;
    8000219e:	6d3c                	ld	a5,88(a0)
    800021a0:	6bc8                	ld	a0,144(a5)
    800021a2:	b7c5                	j	80002182 <argraw+0x30>
    return p->trapframe->a5;
    800021a4:	6d3c                	ld	a5,88(a0)
    800021a6:	6fc8                	ld	a0,152(a5)
    800021a8:	bfe9                	j	80002182 <argraw+0x30>
  panic("argraw");
    800021aa:	00006517          	auipc	a0,0x6
    800021ae:	39e50513          	addi	a0,a0,926 # 80008548 <states.1732+0x180>
    800021b2:	00004097          	auipc	ra,0x4
    800021b6:	d20080e7          	jalr	-736(ra) # 80005ed2 <panic>

00000000800021ba <fetchaddr>:
{
    800021ba:	1101                	addi	sp,sp,-32
    800021bc:	ec06                	sd	ra,24(sp)
    800021be:	e822                	sd	s0,16(sp)
    800021c0:	e426                	sd	s1,8(sp)
    800021c2:	e04a                	sd	s2,0(sp)
    800021c4:	1000                	addi	s0,sp,32
    800021c6:	84aa                	mv	s1,a0
    800021c8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800021ca:	fffff097          	auipc	ra,0xfffff
    800021ce:	f38080e7          	jalr	-200(ra) # 80001102 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    800021d2:	653c                	ld	a5,72(a0)
    800021d4:	02f4f863          	bgeu	s1,a5,80002204 <fetchaddr+0x4a>
    800021d8:	00848713          	addi	a4,s1,8
    800021dc:	02e7e663          	bltu	a5,a4,80002208 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    800021e0:	46a1                	li	a3,8
    800021e2:	8626                	mv	a2,s1
    800021e4:	85ca                	mv	a1,s2
    800021e6:	6928                	ld	a0,80(a0)
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	c64080e7          	jalr	-924(ra) # 80000e4c <copyin>
    800021f0:	00a03533          	snez	a0,a0
    800021f4:	40a00533          	neg	a0,a0
}
    800021f8:	60e2                	ld	ra,24(sp)
    800021fa:	6442                	ld	s0,16(sp)
    800021fc:	64a2                	ld	s1,8(sp)
    800021fe:	6902                	ld	s2,0(sp)
    80002200:	6105                	addi	sp,sp,32
    80002202:	8082                	ret
    return -1;
    80002204:	557d                	li	a0,-1
    80002206:	bfcd                	j	800021f8 <fetchaddr+0x3e>
    80002208:	557d                	li	a0,-1
    8000220a:	b7fd                	j	800021f8 <fetchaddr+0x3e>

000000008000220c <fetchstr>:
{
    8000220c:	7179                	addi	sp,sp,-48
    8000220e:	f406                	sd	ra,40(sp)
    80002210:	f022                	sd	s0,32(sp)
    80002212:	ec26                	sd	s1,24(sp)
    80002214:	e84a                	sd	s2,16(sp)
    80002216:	e44e                	sd	s3,8(sp)
    80002218:	1800                	addi	s0,sp,48
    8000221a:	892a                	mv	s2,a0
    8000221c:	84ae                	mv	s1,a1
    8000221e:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002220:	fffff097          	auipc	ra,0xfffff
    80002224:	ee2080e7          	jalr	-286(ra) # 80001102 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80002228:	86ce                	mv	a3,s3
    8000222a:	864a                	mv	a2,s2
    8000222c:	85a6                	mv	a1,s1
    8000222e:	6928                	ld	a0,80(a0)
    80002230:	fffff097          	auipc	ra,0xfffff
    80002234:	ca8080e7          	jalr	-856(ra) # 80000ed8 <copyinstr>
    80002238:	00054e63          	bltz	a0,80002254 <fetchstr+0x48>
  return strlen(buf);
    8000223c:	8526                	mv	a0,s1
    8000223e:	ffffe097          	auipc	ra,0xffffe
    80002242:	1ca080e7          	jalr	458(ra) # 80000408 <strlen>
}
    80002246:	70a2                	ld	ra,40(sp)
    80002248:	7402                	ld	s0,32(sp)
    8000224a:	64e2                	ld	s1,24(sp)
    8000224c:	6942                	ld	s2,16(sp)
    8000224e:	69a2                	ld	s3,8(sp)
    80002250:	6145                	addi	sp,sp,48
    80002252:	8082                	ret
    return -1;
    80002254:	557d                	li	a0,-1
    80002256:	bfc5                	j	80002246 <fetchstr+0x3a>

0000000080002258 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002258:	1101                	addi	sp,sp,-32
    8000225a:	ec06                	sd	ra,24(sp)
    8000225c:	e822                	sd	s0,16(sp)
    8000225e:	e426                	sd	s1,8(sp)
    80002260:	1000                	addi	s0,sp,32
    80002262:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002264:	00000097          	auipc	ra,0x0
    80002268:	eee080e7          	jalr	-274(ra) # 80002152 <argraw>
    8000226c:	c088                	sw	a0,0(s1)
}
    8000226e:	60e2                	ld	ra,24(sp)
    80002270:	6442                	ld	s0,16(sp)
    80002272:	64a2                	ld	s1,8(sp)
    80002274:	6105                	addi	sp,sp,32
    80002276:	8082                	ret

0000000080002278 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80002278:	1101                	addi	sp,sp,-32
    8000227a:	ec06                	sd	ra,24(sp)
    8000227c:	e822                	sd	s0,16(sp)
    8000227e:	e426                	sd	s1,8(sp)
    80002280:	1000                	addi	s0,sp,32
    80002282:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002284:	00000097          	auipc	ra,0x0
    80002288:	ece080e7          	jalr	-306(ra) # 80002152 <argraw>
    8000228c:	e088                	sd	a0,0(s1)
}
    8000228e:	60e2                	ld	ra,24(sp)
    80002290:	6442                	ld	s0,16(sp)
    80002292:	64a2                	ld	s1,8(sp)
    80002294:	6105                	addi	sp,sp,32
    80002296:	8082                	ret

0000000080002298 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002298:	7179                	addi	sp,sp,-48
    8000229a:	f406                	sd	ra,40(sp)
    8000229c:	f022                	sd	s0,32(sp)
    8000229e:	ec26                	sd	s1,24(sp)
    800022a0:	e84a                	sd	s2,16(sp)
    800022a2:	1800                	addi	s0,sp,48
    800022a4:	84ae                	mv	s1,a1
    800022a6:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    800022a8:	fd840593          	addi	a1,s0,-40
    800022ac:	00000097          	auipc	ra,0x0
    800022b0:	fcc080e7          	jalr	-52(ra) # 80002278 <argaddr>
  return fetchstr(addr, buf, max);
    800022b4:	864a                	mv	a2,s2
    800022b6:	85a6                	mv	a1,s1
    800022b8:	fd843503          	ld	a0,-40(s0)
    800022bc:	00000097          	auipc	ra,0x0
    800022c0:	f50080e7          	jalr	-176(ra) # 8000220c <fetchstr>
}
    800022c4:	70a2                	ld	ra,40(sp)
    800022c6:	7402                	ld	s0,32(sp)
    800022c8:	64e2                	ld	s1,24(sp)
    800022ca:	6942                	ld	s2,16(sp)
    800022cc:	6145                	addi	sp,sp,48
    800022ce:	8082                	ret

00000000800022d0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    800022d0:	1101                	addi	sp,sp,-32
    800022d2:	ec06                	sd	ra,24(sp)
    800022d4:	e822                	sd	s0,16(sp)
    800022d6:	e426                	sd	s1,8(sp)
    800022d8:	e04a                	sd	s2,0(sp)
    800022da:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    800022dc:	fffff097          	auipc	ra,0xfffff
    800022e0:	e26080e7          	jalr	-474(ra) # 80001102 <myproc>
    800022e4:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800022e6:	05853903          	ld	s2,88(a0)
    800022ea:	0a893783          	ld	a5,168(s2)
    800022ee:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800022f2:	37fd                	addiw	a5,a5,-1
    800022f4:	4751                	li	a4,20
    800022f6:	00f76f63          	bltu	a4,a5,80002314 <syscall+0x44>
    800022fa:	00369713          	slli	a4,a3,0x3
    800022fe:	00006797          	auipc	a5,0x6
    80002302:	28a78793          	addi	a5,a5,650 # 80008588 <syscalls>
    80002306:	97ba                	add	a5,a5,a4
    80002308:	639c                	ld	a5,0(a5)
    8000230a:	c789                	beqz	a5,80002314 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    8000230c:	9782                	jalr	a5
    8000230e:	06a93823          	sd	a0,112(s2)
    80002312:	a839                	j	80002330 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002314:	15848613          	addi	a2,s1,344
    80002318:	588c                	lw	a1,48(s1)
    8000231a:	00006517          	auipc	a0,0x6
    8000231e:	23650513          	addi	a0,a0,566 # 80008550 <states.1732+0x188>
    80002322:	00004097          	auipc	ra,0x4
    80002326:	bfa080e7          	jalr	-1030(ra) # 80005f1c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000232a:	6cbc                	ld	a5,88(s1)
    8000232c:	577d                	li	a4,-1
    8000232e:	fbb8                	sd	a4,112(a5)
  }
}
    80002330:	60e2                	ld	ra,24(sp)
    80002332:	6442                	ld	s0,16(sp)
    80002334:	64a2                	ld	s1,8(sp)
    80002336:	6902                	ld	s2,0(sp)
    80002338:	6105                	addi	sp,sp,32
    8000233a:	8082                	ret

000000008000233c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000233c:	1101                	addi	sp,sp,-32
    8000233e:	ec06                	sd	ra,24(sp)
    80002340:	e822                	sd	s0,16(sp)
    80002342:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002344:	fec40593          	addi	a1,s0,-20
    80002348:	4501                	li	a0,0
    8000234a:	00000097          	auipc	ra,0x0
    8000234e:	f0e080e7          	jalr	-242(ra) # 80002258 <argint>
  exit(n);
    80002352:	fec42503          	lw	a0,-20(s0)
    80002356:	fffff097          	auipc	ra,0xfffff
    8000235a:	588080e7          	jalr	1416(ra) # 800018de <exit>
  return 0;  // not reached
}
    8000235e:	4501                	li	a0,0
    80002360:	60e2                	ld	ra,24(sp)
    80002362:	6442                	ld	s0,16(sp)
    80002364:	6105                	addi	sp,sp,32
    80002366:	8082                	ret

0000000080002368 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002368:	1141                	addi	sp,sp,-16
    8000236a:	e406                	sd	ra,8(sp)
    8000236c:	e022                	sd	s0,0(sp)
    8000236e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002370:	fffff097          	auipc	ra,0xfffff
    80002374:	d92080e7          	jalr	-622(ra) # 80001102 <myproc>
}
    80002378:	5908                	lw	a0,48(a0)
    8000237a:	60a2                	ld	ra,8(sp)
    8000237c:	6402                	ld	s0,0(sp)
    8000237e:	0141                	addi	sp,sp,16
    80002380:	8082                	ret

0000000080002382 <sys_fork>:

uint64
sys_fork(void)
{
    80002382:	1141                	addi	sp,sp,-16
    80002384:	e406                	sd	ra,8(sp)
    80002386:	e022                	sd	s0,0(sp)
    80002388:	0800                	addi	s0,sp,16
  return fork();
    8000238a:	fffff097          	auipc	ra,0xfffff
    8000238e:	132080e7          	jalr	306(ra) # 800014bc <fork>
}
    80002392:	60a2                	ld	ra,8(sp)
    80002394:	6402                	ld	s0,0(sp)
    80002396:	0141                	addi	sp,sp,16
    80002398:	8082                	ret

000000008000239a <sys_wait>:

uint64
sys_wait(void)
{
    8000239a:	1101                	addi	sp,sp,-32
    8000239c:	ec06                	sd	ra,24(sp)
    8000239e:	e822                	sd	s0,16(sp)
    800023a0:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800023a2:	fe840593          	addi	a1,s0,-24
    800023a6:	4501                	li	a0,0
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	ed0080e7          	jalr	-304(ra) # 80002278 <argaddr>
  return wait(p);
    800023b0:	fe843503          	ld	a0,-24(s0)
    800023b4:	fffff097          	auipc	ra,0xfffff
    800023b8:	6d0080e7          	jalr	1744(ra) # 80001a84 <wait>
}
    800023bc:	60e2                	ld	ra,24(sp)
    800023be:	6442                	ld	s0,16(sp)
    800023c0:	6105                	addi	sp,sp,32
    800023c2:	8082                	ret

00000000800023c4 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800023c4:	7179                	addi	sp,sp,-48
    800023c6:	f406                	sd	ra,40(sp)
    800023c8:	f022                	sd	s0,32(sp)
    800023ca:	ec26                	sd	s1,24(sp)
    800023cc:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    800023ce:	fdc40593          	addi	a1,s0,-36
    800023d2:	4501                	li	a0,0
    800023d4:	00000097          	auipc	ra,0x0
    800023d8:	e84080e7          	jalr	-380(ra) # 80002258 <argint>
  addr = myproc()->sz;
    800023dc:	fffff097          	auipc	ra,0xfffff
    800023e0:	d26080e7          	jalr	-730(ra) # 80001102 <myproc>
    800023e4:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    800023e6:	fdc42503          	lw	a0,-36(s0)
    800023ea:	fffff097          	auipc	ra,0xfffff
    800023ee:	076080e7          	jalr	118(ra) # 80001460 <growproc>
    800023f2:	00054863          	bltz	a0,80002402 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    800023f6:	8526                	mv	a0,s1
    800023f8:	70a2                	ld	ra,40(sp)
    800023fa:	7402                	ld	s0,32(sp)
    800023fc:	64e2                	ld	s1,24(sp)
    800023fe:	6145                	addi	sp,sp,48
    80002400:	8082                	ret
    return -1;
    80002402:	54fd                	li	s1,-1
    80002404:	bfcd                	j	800023f6 <sys_sbrk+0x32>

0000000080002406 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002406:	7139                	addi	sp,sp,-64
    80002408:	fc06                	sd	ra,56(sp)
    8000240a:	f822                	sd	s0,48(sp)
    8000240c:	f426                	sd	s1,40(sp)
    8000240e:	f04a                	sd	s2,32(sp)
    80002410:	ec4e                	sd	s3,24(sp)
    80002412:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002414:	fcc40593          	addi	a1,s0,-52
    80002418:	4501                	li	a0,0
    8000241a:	00000097          	auipc	ra,0x0
    8000241e:	e3e080e7          	jalr	-450(ra) # 80002258 <argint>
  if(n < 0)
    80002422:	fcc42783          	lw	a5,-52(s0)
    80002426:	0607cf63          	bltz	a5,800024a4 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    8000242a:	0002c517          	auipc	a0,0x2c
    8000242e:	4de50513          	addi	a0,a0,1246 # 8002e908 <tickslock>
    80002432:	00004097          	auipc	ra,0x4
    80002436:	fea080e7          	jalr	-22(ra) # 8000641c <acquire>
  ticks0 = ticks;
    8000243a:	00006917          	auipc	s2,0x6
    8000243e:	64e92903          	lw	s2,1614(s2) # 80008a88 <ticks>
  while(ticks - ticks0 < n){
    80002442:	fcc42783          	lw	a5,-52(s0)
    80002446:	cf9d                	beqz	a5,80002484 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002448:	0002c997          	auipc	s3,0x2c
    8000244c:	4c098993          	addi	s3,s3,1216 # 8002e908 <tickslock>
    80002450:	00006497          	auipc	s1,0x6
    80002454:	63848493          	addi	s1,s1,1592 # 80008a88 <ticks>
    if(killed(myproc())){
    80002458:	fffff097          	auipc	ra,0xfffff
    8000245c:	caa080e7          	jalr	-854(ra) # 80001102 <myproc>
    80002460:	fffff097          	auipc	ra,0xfffff
    80002464:	5f2080e7          	jalr	1522(ra) # 80001a52 <killed>
    80002468:	e129                	bnez	a0,800024aa <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    8000246a:	85ce                	mv	a1,s3
    8000246c:	8526                	mv	a0,s1
    8000246e:	fffff097          	auipc	ra,0xfffff
    80002472:	33c080e7          	jalr	828(ra) # 800017aa <sleep>
  while(ticks - ticks0 < n){
    80002476:	409c                	lw	a5,0(s1)
    80002478:	412787bb          	subw	a5,a5,s2
    8000247c:	fcc42703          	lw	a4,-52(s0)
    80002480:	fce7ece3          	bltu	a5,a4,80002458 <sys_sleep+0x52>
  }
  release(&tickslock);
    80002484:	0002c517          	auipc	a0,0x2c
    80002488:	48450513          	addi	a0,a0,1156 # 8002e908 <tickslock>
    8000248c:	00004097          	auipc	ra,0x4
    80002490:	044080e7          	jalr	68(ra) # 800064d0 <release>
  return 0;
    80002494:	4501                	li	a0,0
}
    80002496:	70e2                	ld	ra,56(sp)
    80002498:	7442                	ld	s0,48(sp)
    8000249a:	74a2                	ld	s1,40(sp)
    8000249c:	7902                	ld	s2,32(sp)
    8000249e:	69e2                	ld	s3,24(sp)
    800024a0:	6121                	addi	sp,sp,64
    800024a2:	8082                	ret
    n = 0;
    800024a4:	fc042623          	sw	zero,-52(s0)
    800024a8:	b749                	j	8000242a <sys_sleep+0x24>
      release(&tickslock);
    800024aa:	0002c517          	auipc	a0,0x2c
    800024ae:	45e50513          	addi	a0,a0,1118 # 8002e908 <tickslock>
    800024b2:	00004097          	auipc	ra,0x4
    800024b6:	01e080e7          	jalr	30(ra) # 800064d0 <release>
      return -1;
    800024ba:	557d                	li	a0,-1
    800024bc:	bfe9                	j	80002496 <sys_sleep+0x90>

00000000800024be <sys_kill>:

uint64
sys_kill(void)
{
    800024be:	1101                	addi	sp,sp,-32
    800024c0:	ec06                	sd	ra,24(sp)
    800024c2:	e822                	sd	s0,16(sp)
    800024c4:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800024c6:	fec40593          	addi	a1,s0,-20
    800024ca:	4501                	li	a0,0
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	d8c080e7          	jalr	-628(ra) # 80002258 <argint>
  return kill(pid);
    800024d4:	fec42503          	lw	a0,-20(s0)
    800024d8:	fffff097          	auipc	ra,0xfffff
    800024dc:	4dc080e7          	jalr	1244(ra) # 800019b4 <kill>
}
    800024e0:	60e2                	ld	ra,24(sp)
    800024e2:	6442                	ld	s0,16(sp)
    800024e4:	6105                	addi	sp,sp,32
    800024e6:	8082                	ret

00000000800024e8 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800024e8:	1101                	addi	sp,sp,-32
    800024ea:	ec06                	sd	ra,24(sp)
    800024ec:	e822                	sd	s0,16(sp)
    800024ee:	e426                	sd	s1,8(sp)
    800024f0:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800024f2:	0002c517          	auipc	a0,0x2c
    800024f6:	41650513          	addi	a0,a0,1046 # 8002e908 <tickslock>
    800024fa:	00004097          	auipc	ra,0x4
    800024fe:	f22080e7          	jalr	-222(ra) # 8000641c <acquire>
  xticks = ticks;
    80002502:	00006497          	auipc	s1,0x6
    80002506:	5864a483          	lw	s1,1414(s1) # 80008a88 <ticks>
  release(&tickslock);
    8000250a:	0002c517          	auipc	a0,0x2c
    8000250e:	3fe50513          	addi	a0,a0,1022 # 8002e908 <tickslock>
    80002512:	00004097          	auipc	ra,0x4
    80002516:	fbe080e7          	jalr	-66(ra) # 800064d0 <release>
  return xticks;
}
    8000251a:	02049513          	slli	a0,s1,0x20
    8000251e:	9101                	srli	a0,a0,0x20
    80002520:	60e2                	ld	ra,24(sp)
    80002522:	6442                	ld	s0,16(sp)
    80002524:	64a2                	ld	s1,8(sp)
    80002526:	6105                	addi	sp,sp,32
    80002528:	8082                	ret

000000008000252a <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000252a:	7179                	addi	sp,sp,-48
    8000252c:	f406                	sd	ra,40(sp)
    8000252e:	f022                	sd	s0,32(sp)
    80002530:	ec26                	sd	s1,24(sp)
    80002532:	e84a                	sd	s2,16(sp)
    80002534:	e44e                	sd	s3,8(sp)
    80002536:	e052                	sd	s4,0(sp)
    80002538:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000253a:	00006597          	auipc	a1,0x6
    8000253e:	0fe58593          	addi	a1,a1,254 # 80008638 <syscalls+0xb0>
    80002542:	0002c517          	auipc	a0,0x2c
    80002546:	3de50513          	addi	a0,a0,990 # 8002e920 <bcache>
    8000254a:	00004097          	auipc	ra,0x4
    8000254e:	e42080e7          	jalr	-446(ra) # 8000638c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002552:	00034797          	auipc	a5,0x34
    80002556:	3ce78793          	addi	a5,a5,974 # 80036920 <bcache+0x8000>
    8000255a:	00034717          	auipc	a4,0x34
    8000255e:	62e70713          	addi	a4,a4,1582 # 80036b88 <bcache+0x8268>
    80002562:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002566:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000256a:	0002c497          	auipc	s1,0x2c
    8000256e:	3ce48493          	addi	s1,s1,974 # 8002e938 <bcache+0x18>
    b->next = bcache.head.next;
    80002572:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002574:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002576:	00006a17          	auipc	s4,0x6
    8000257a:	0caa0a13          	addi	s4,s4,202 # 80008640 <syscalls+0xb8>
    b->next = bcache.head.next;
    8000257e:	2b893783          	ld	a5,696(s2)
    80002582:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002584:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002588:	85d2                	mv	a1,s4
    8000258a:	01048513          	addi	a0,s1,16
    8000258e:	00001097          	auipc	ra,0x1
    80002592:	4c4080e7          	jalr	1220(ra) # 80003a52 <initsleeplock>
    bcache.head.next->prev = b;
    80002596:	2b893783          	ld	a5,696(s2)
    8000259a:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000259c:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800025a0:	45848493          	addi	s1,s1,1112
    800025a4:	fd349de3          	bne	s1,s3,8000257e <binit+0x54>
  }
}
    800025a8:	70a2                	ld	ra,40(sp)
    800025aa:	7402                	ld	s0,32(sp)
    800025ac:	64e2                	ld	s1,24(sp)
    800025ae:	6942                	ld	s2,16(sp)
    800025b0:	69a2                	ld	s3,8(sp)
    800025b2:	6a02                	ld	s4,0(sp)
    800025b4:	6145                	addi	sp,sp,48
    800025b6:	8082                	ret

00000000800025b8 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800025b8:	7179                	addi	sp,sp,-48
    800025ba:	f406                	sd	ra,40(sp)
    800025bc:	f022                	sd	s0,32(sp)
    800025be:	ec26                	sd	s1,24(sp)
    800025c0:	e84a                	sd	s2,16(sp)
    800025c2:	e44e                	sd	s3,8(sp)
    800025c4:	1800                	addi	s0,sp,48
    800025c6:	89aa                	mv	s3,a0
    800025c8:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800025ca:	0002c517          	auipc	a0,0x2c
    800025ce:	35650513          	addi	a0,a0,854 # 8002e920 <bcache>
    800025d2:	00004097          	auipc	ra,0x4
    800025d6:	e4a080e7          	jalr	-438(ra) # 8000641c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800025da:	00034497          	auipc	s1,0x34
    800025de:	5fe4b483          	ld	s1,1534(s1) # 80036bd8 <bcache+0x82b8>
    800025e2:	00034797          	auipc	a5,0x34
    800025e6:	5a678793          	addi	a5,a5,1446 # 80036b88 <bcache+0x8268>
    800025ea:	02f48f63          	beq	s1,a5,80002628 <bread+0x70>
    800025ee:	873e                	mv	a4,a5
    800025f0:	a021                	j	800025f8 <bread+0x40>
    800025f2:	68a4                	ld	s1,80(s1)
    800025f4:	02e48a63          	beq	s1,a4,80002628 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800025f8:	449c                	lw	a5,8(s1)
    800025fa:	ff379ce3          	bne	a5,s3,800025f2 <bread+0x3a>
    800025fe:	44dc                	lw	a5,12(s1)
    80002600:	ff2799e3          	bne	a5,s2,800025f2 <bread+0x3a>
      b->refcnt++;
    80002604:	40bc                	lw	a5,64(s1)
    80002606:	2785                	addiw	a5,a5,1
    80002608:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000260a:	0002c517          	auipc	a0,0x2c
    8000260e:	31650513          	addi	a0,a0,790 # 8002e920 <bcache>
    80002612:	00004097          	auipc	ra,0x4
    80002616:	ebe080e7          	jalr	-322(ra) # 800064d0 <release>
      acquiresleep(&b->lock);
    8000261a:	01048513          	addi	a0,s1,16
    8000261e:	00001097          	auipc	ra,0x1
    80002622:	46e080e7          	jalr	1134(ra) # 80003a8c <acquiresleep>
      return b;
    80002626:	a8b9                	j	80002684 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002628:	00034497          	auipc	s1,0x34
    8000262c:	5a84b483          	ld	s1,1448(s1) # 80036bd0 <bcache+0x82b0>
    80002630:	00034797          	auipc	a5,0x34
    80002634:	55878793          	addi	a5,a5,1368 # 80036b88 <bcache+0x8268>
    80002638:	00f48863          	beq	s1,a5,80002648 <bread+0x90>
    8000263c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000263e:	40bc                	lw	a5,64(s1)
    80002640:	cf81                	beqz	a5,80002658 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002642:	64a4                	ld	s1,72(s1)
    80002644:	fee49de3          	bne	s1,a4,8000263e <bread+0x86>
  panic("bget: no buffers");
    80002648:	00006517          	auipc	a0,0x6
    8000264c:	00050513          	mv	a0,a0
    80002650:	00004097          	auipc	ra,0x4
    80002654:	882080e7          	jalr	-1918(ra) # 80005ed2 <panic>
      b->dev = dev;
    80002658:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    8000265c:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80002660:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002664:	4785                	li	a5,1
    80002666:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002668:	0002c517          	auipc	a0,0x2c
    8000266c:	2b850513          	addi	a0,a0,696 # 8002e920 <bcache>
    80002670:	00004097          	auipc	ra,0x4
    80002674:	e60080e7          	jalr	-416(ra) # 800064d0 <release>
      acquiresleep(&b->lock);
    80002678:	01048513          	addi	a0,s1,16
    8000267c:	00001097          	auipc	ra,0x1
    80002680:	410080e7          	jalr	1040(ra) # 80003a8c <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002684:	409c                	lw	a5,0(s1)
    80002686:	cb89                	beqz	a5,80002698 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002688:	8526                	mv	a0,s1
    8000268a:	70a2                	ld	ra,40(sp)
    8000268c:	7402                	ld	s0,32(sp)
    8000268e:	64e2                	ld	s1,24(sp)
    80002690:	6942                	ld	s2,16(sp)
    80002692:	69a2                	ld	s3,8(sp)
    80002694:	6145                	addi	sp,sp,48
    80002696:	8082                	ret
    virtio_disk_rw(b, 0);
    80002698:	4581                	li	a1,0
    8000269a:	8526                	mv	a0,s1
    8000269c:	00003097          	auipc	ra,0x3
    800026a0:	fcc080e7          	jalr	-52(ra) # 80005668 <virtio_disk_rw>
    b->valid = 1;
    800026a4:	4785                	li	a5,1
    800026a6:	c09c                	sw	a5,0(s1)
  return b;
    800026a8:	b7c5                	j	80002688 <bread+0xd0>

00000000800026aa <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800026aa:	1101                	addi	sp,sp,-32
    800026ac:	ec06                	sd	ra,24(sp)
    800026ae:	e822                	sd	s0,16(sp)
    800026b0:	e426                	sd	s1,8(sp)
    800026b2:	1000                	addi	s0,sp,32
    800026b4:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800026b6:	0541                	addi	a0,a0,16
    800026b8:	00001097          	auipc	ra,0x1
    800026bc:	46e080e7          	jalr	1134(ra) # 80003b26 <holdingsleep>
    800026c0:	cd01                	beqz	a0,800026d8 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800026c2:	4585                	li	a1,1
    800026c4:	8526                	mv	a0,s1
    800026c6:	00003097          	auipc	ra,0x3
    800026ca:	fa2080e7          	jalr	-94(ra) # 80005668 <virtio_disk_rw>
}
    800026ce:	60e2                	ld	ra,24(sp)
    800026d0:	6442                	ld	s0,16(sp)
    800026d2:	64a2                	ld	s1,8(sp)
    800026d4:	6105                	addi	sp,sp,32
    800026d6:	8082                	ret
    panic("bwrite");
    800026d8:	00006517          	auipc	a0,0x6
    800026dc:	f8850513          	addi	a0,a0,-120 # 80008660 <syscalls+0xd8>
    800026e0:	00003097          	auipc	ra,0x3
    800026e4:	7f2080e7          	jalr	2034(ra) # 80005ed2 <panic>

00000000800026e8 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800026e8:	1101                	addi	sp,sp,-32
    800026ea:	ec06                	sd	ra,24(sp)
    800026ec:	e822                	sd	s0,16(sp)
    800026ee:	e426                	sd	s1,8(sp)
    800026f0:	e04a                	sd	s2,0(sp)
    800026f2:	1000                	addi	s0,sp,32
    800026f4:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800026f6:	01050913          	addi	s2,a0,16
    800026fa:	854a                	mv	a0,s2
    800026fc:	00001097          	auipc	ra,0x1
    80002700:	42a080e7          	jalr	1066(ra) # 80003b26 <holdingsleep>
    80002704:	c92d                	beqz	a0,80002776 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002706:	854a                	mv	a0,s2
    80002708:	00001097          	auipc	ra,0x1
    8000270c:	3da080e7          	jalr	986(ra) # 80003ae2 <releasesleep>

  acquire(&bcache.lock);
    80002710:	0002c517          	auipc	a0,0x2c
    80002714:	21050513          	addi	a0,a0,528 # 8002e920 <bcache>
    80002718:	00004097          	auipc	ra,0x4
    8000271c:	d04080e7          	jalr	-764(ra) # 8000641c <acquire>
  b->refcnt--;
    80002720:	40bc                	lw	a5,64(s1)
    80002722:	37fd                	addiw	a5,a5,-1
    80002724:	0007871b          	sext.w	a4,a5
    80002728:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000272a:	eb05                	bnez	a4,8000275a <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000272c:	68bc                	ld	a5,80(s1)
    8000272e:	64b8                	ld	a4,72(s1)
    80002730:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002732:	64bc                	ld	a5,72(s1)
    80002734:	68b8                	ld	a4,80(s1)
    80002736:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002738:	00034797          	auipc	a5,0x34
    8000273c:	1e878793          	addi	a5,a5,488 # 80036920 <bcache+0x8000>
    80002740:	2b87b703          	ld	a4,696(a5)
    80002744:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002746:	00034717          	auipc	a4,0x34
    8000274a:	44270713          	addi	a4,a4,1090 # 80036b88 <bcache+0x8268>
    8000274e:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002750:	2b87b703          	ld	a4,696(a5)
    80002754:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002756:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000275a:	0002c517          	auipc	a0,0x2c
    8000275e:	1c650513          	addi	a0,a0,454 # 8002e920 <bcache>
    80002762:	00004097          	auipc	ra,0x4
    80002766:	d6e080e7          	jalr	-658(ra) # 800064d0 <release>
}
    8000276a:	60e2                	ld	ra,24(sp)
    8000276c:	6442                	ld	s0,16(sp)
    8000276e:	64a2                	ld	s1,8(sp)
    80002770:	6902                	ld	s2,0(sp)
    80002772:	6105                	addi	sp,sp,32
    80002774:	8082                	ret
    panic("brelse");
    80002776:	00006517          	auipc	a0,0x6
    8000277a:	ef250513          	addi	a0,a0,-270 # 80008668 <syscalls+0xe0>
    8000277e:	00003097          	auipc	ra,0x3
    80002782:	754080e7          	jalr	1876(ra) # 80005ed2 <panic>

0000000080002786 <bpin>:

void
bpin(struct buf *b) {
    80002786:	1101                	addi	sp,sp,-32
    80002788:	ec06                	sd	ra,24(sp)
    8000278a:	e822                	sd	s0,16(sp)
    8000278c:	e426                	sd	s1,8(sp)
    8000278e:	1000                	addi	s0,sp,32
    80002790:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002792:	0002c517          	auipc	a0,0x2c
    80002796:	18e50513          	addi	a0,a0,398 # 8002e920 <bcache>
    8000279a:	00004097          	auipc	ra,0x4
    8000279e:	c82080e7          	jalr	-894(ra) # 8000641c <acquire>
  b->refcnt++;
    800027a2:	40bc                	lw	a5,64(s1)
    800027a4:	2785                	addiw	a5,a5,1
    800027a6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800027a8:	0002c517          	auipc	a0,0x2c
    800027ac:	17850513          	addi	a0,a0,376 # 8002e920 <bcache>
    800027b0:	00004097          	auipc	ra,0x4
    800027b4:	d20080e7          	jalr	-736(ra) # 800064d0 <release>
}
    800027b8:	60e2                	ld	ra,24(sp)
    800027ba:	6442                	ld	s0,16(sp)
    800027bc:	64a2                	ld	s1,8(sp)
    800027be:	6105                	addi	sp,sp,32
    800027c0:	8082                	ret

00000000800027c2 <bunpin>:

void
bunpin(struct buf *b) {
    800027c2:	1101                	addi	sp,sp,-32
    800027c4:	ec06                	sd	ra,24(sp)
    800027c6:	e822                	sd	s0,16(sp)
    800027c8:	e426                	sd	s1,8(sp)
    800027ca:	1000                	addi	s0,sp,32
    800027cc:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800027ce:	0002c517          	auipc	a0,0x2c
    800027d2:	15250513          	addi	a0,a0,338 # 8002e920 <bcache>
    800027d6:	00004097          	auipc	ra,0x4
    800027da:	c46080e7          	jalr	-954(ra) # 8000641c <acquire>
  b->refcnt--;
    800027de:	40bc                	lw	a5,64(s1)
    800027e0:	37fd                	addiw	a5,a5,-1
    800027e2:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800027e4:	0002c517          	auipc	a0,0x2c
    800027e8:	13c50513          	addi	a0,a0,316 # 8002e920 <bcache>
    800027ec:	00004097          	auipc	ra,0x4
    800027f0:	ce4080e7          	jalr	-796(ra) # 800064d0 <release>
}
    800027f4:	60e2                	ld	ra,24(sp)
    800027f6:	6442                	ld	s0,16(sp)
    800027f8:	64a2                	ld	s1,8(sp)
    800027fa:	6105                	addi	sp,sp,32
    800027fc:	8082                	ret

00000000800027fe <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800027fe:	1101                	addi	sp,sp,-32
    80002800:	ec06                	sd	ra,24(sp)
    80002802:	e822                	sd	s0,16(sp)
    80002804:	e426                	sd	s1,8(sp)
    80002806:	e04a                	sd	s2,0(sp)
    80002808:	1000                	addi	s0,sp,32
    8000280a:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000280c:	00d5d59b          	srliw	a1,a1,0xd
    80002810:	00034797          	auipc	a5,0x34
    80002814:	7ec7a783          	lw	a5,2028(a5) # 80036ffc <sb+0x1c>
    80002818:	9dbd                	addw	a1,a1,a5
    8000281a:	00000097          	auipc	ra,0x0
    8000281e:	d9e080e7          	jalr	-610(ra) # 800025b8 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002822:	0074f713          	andi	a4,s1,7
    80002826:	4785                	li	a5,1
    80002828:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000282c:	14ce                	slli	s1,s1,0x33
    8000282e:	90d9                	srli	s1,s1,0x36
    80002830:	00950733          	add	a4,a0,s1
    80002834:	05874703          	lbu	a4,88(a4)
    80002838:	00e7f6b3          	and	a3,a5,a4
    8000283c:	c69d                	beqz	a3,8000286a <bfree+0x6c>
    8000283e:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002840:	94aa                	add	s1,s1,a0
    80002842:	fff7c793          	not	a5,a5
    80002846:	8ff9                	and	a5,a5,a4
    80002848:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000284c:	00001097          	auipc	ra,0x1
    80002850:	120080e7          	jalr	288(ra) # 8000396c <log_write>
  brelse(bp);
    80002854:	854a                	mv	a0,s2
    80002856:	00000097          	auipc	ra,0x0
    8000285a:	e92080e7          	jalr	-366(ra) # 800026e8 <brelse>
}
    8000285e:	60e2                	ld	ra,24(sp)
    80002860:	6442                	ld	s0,16(sp)
    80002862:	64a2                	ld	s1,8(sp)
    80002864:	6902                	ld	s2,0(sp)
    80002866:	6105                	addi	sp,sp,32
    80002868:	8082                	ret
    panic("freeing free block");
    8000286a:	00006517          	auipc	a0,0x6
    8000286e:	e0650513          	addi	a0,a0,-506 # 80008670 <syscalls+0xe8>
    80002872:	00003097          	auipc	ra,0x3
    80002876:	660080e7          	jalr	1632(ra) # 80005ed2 <panic>

000000008000287a <balloc>:
{
    8000287a:	711d                	addi	sp,sp,-96
    8000287c:	ec86                	sd	ra,88(sp)
    8000287e:	e8a2                	sd	s0,80(sp)
    80002880:	e4a6                	sd	s1,72(sp)
    80002882:	e0ca                	sd	s2,64(sp)
    80002884:	fc4e                	sd	s3,56(sp)
    80002886:	f852                	sd	s4,48(sp)
    80002888:	f456                	sd	s5,40(sp)
    8000288a:	f05a                	sd	s6,32(sp)
    8000288c:	ec5e                	sd	s7,24(sp)
    8000288e:	e862                	sd	s8,16(sp)
    80002890:	e466                	sd	s9,8(sp)
    80002892:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002894:	00034797          	auipc	a5,0x34
    80002898:	7507a783          	lw	a5,1872(a5) # 80036fe4 <sb+0x4>
    8000289c:	10078163          	beqz	a5,8000299e <balloc+0x124>
    800028a0:	8baa                	mv	s7,a0
    800028a2:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800028a4:	00034b17          	auipc	s6,0x34
    800028a8:	73cb0b13          	addi	s6,s6,1852 # 80036fe0 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800028ac:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800028ae:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800028b0:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800028b2:	6c89                	lui	s9,0x2
    800028b4:	a061                	j	8000293c <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    800028b6:	974a                	add	a4,a4,s2
    800028b8:	8fd5                	or	a5,a5,a3
    800028ba:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800028be:	854a                	mv	a0,s2
    800028c0:	00001097          	auipc	ra,0x1
    800028c4:	0ac080e7          	jalr	172(ra) # 8000396c <log_write>
        brelse(bp);
    800028c8:	854a                	mv	a0,s2
    800028ca:	00000097          	auipc	ra,0x0
    800028ce:	e1e080e7          	jalr	-482(ra) # 800026e8 <brelse>
  bp = bread(dev, bno);
    800028d2:	85a6                	mv	a1,s1
    800028d4:	855e                	mv	a0,s7
    800028d6:	00000097          	auipc	ra,0x0
    800028da:	ce2080e7          	jalr	-798(ra) # 800025b8 <bread>
    800028de:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800028e0:	40000613          	li	a2,1024
    800028e4:	4581                	li	a1,0
    800028e6:	05850513          	addi	a0,a0,88
    800028ea:	ffffe097          	auipc	ra,0xffffe
    800028ee:	99a080e7          	jalr	-1638(ra) # 80000284 <memset>
  log_write(bp);
    800028f2:	854a                	mv	a0,s2
    800028f4:	00001097          	auipc	ra,0x1
    800028f8:	078080e7          	jalr	120(ra) # 8000396c <log_write>
  brelse(bp);
    800028fc:	854a                	mv	a0,s2
    800028fe:	00000097          	auipc	ra,0x0
    80002902:	dea080e7          	jalr	-534(ra) # 800026e8 <brelse>
}
    80002906:	8526                	mv	a0,s1
    80002908:	60e6                	ld	ra,88(sp)
    8000290a:	6446                	ld	s0,80(sp)
    8000290c:	64a6                	ld	s1,72(sp)
    8000290e:	6906                	ld	s2,64(sp)
    80002910:	79e2                	ld	s3,56(sp)
    80002912:	7a42                	ld	s4,48(sp)
    80002914:	7aa2                	ld	s5,40(sp)
    80002916:	7b02                	ld	s6,32(sp)
    80002918:	6be2                	ld	s7,24(sp)
    8000291a:	6c42                	ld	s8,16(sp)
    8000291c:	6ca2                	ld	s9,8(sp)
    8000291e:	6125                	addi	sp,sp,96
    80002920:	8082                	ret
    brelse(bp);
    80002922:	854a                	mv	a0,s2
    80002924:	00000097          	auipc	ra,0x0
    80002928:	dc4080e7          	jalr	-572(ra) # 800026e8 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000292c:	015c87bb          	addw	a5,s9,s5
    80002930:	00078a9b          	sext.w	s5,a5
    80002934:	004b2703          	lw	a4,4(s6)
    80002938:	06eaf363          	bgeu	s5,a4,8000299e <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    8000293c:	41fad79b          	sraiw	a5,s5,0x1f
    80002940:	0137d79b          	srliw	a5,a5,0x13
    80002944:	015787bb          	addw	a5,a5,s5
    80002948:	40d7d79b          	sraiw	a5,a5,0xd
    8000294c:	01cb2583          	lw	a1,28(s6)
    80002950:	9dbd                	addw	a1,a1,a5
    80002952:	855e                	mv	a0,s7
    80002954:	00000097          	auipc	ra,0x0
    80002958:	c64080e7          	jalr	-924(ra) # 800025b8 <bread>
    8000295c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000295e:	004b2503          	lw	a0,4(s6)
    80002962:	000a849b          	sext.w	s1,s5
    80002966:	8662                	mv	a2,s8
    80002968:	faa4fde3          	bgeu	s1,a0,80002922 <balloc+0xa8>
      m = 1 << (bi % 8);
    8000296c:	41f6579b          	sraiw	a5,a2,0x1f
    80002970:	01d7d69b          	srliw	a3,a5,0x1d
    80002974:	00c6873b          	addw	a4,a3,a2
    80002978:	00777793          	andi	a5,a4,7
    8000297c:	9f95                	subw	a5,a5,a3
    8000297e:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002982:	4037571b          	sraiw	a4,a4,0x3
    80002986:	00e906b3          	add	a3,s2,a4
    8000298a:	0586c683          	lbu	a3,88(a3)
    8000298e:	00d7f5b3          	and	a1,a5,a3
    80002992:	d195                	beqz	a1,800028b6 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002994:	2605                	addiw	a2,a2,1
    80002996:	2485                	addiw	s1,s1,1
    80002998:	fd4618e3          	bne	a2,s4,80002968 <balloc+0xee>
    8000299c:	b759                	j	80002922 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    8000299e:	00006517          	auipc	a0,0x6
    800029a2:	cea50513          	addi	a0,a0,-790 # 80008688 <syscalls+0x100>
    800029a6:	00003097          	auipc	ra,0x3
    800029aa:	576080e7          	jalr	1398(ra) # 80005f1c <printf>
  return 0;
    800029ae:	4481                	li	s1,0
    800029b0:	bf99                	j	80002906 <balloc+0x8c>

00000000800029b2 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800029b2:	7179                	addi	sp,sp,-48
    800029b4:	f406                	sd	ra,40(sp)
    800029b6:	f022                	sd	s0,32(sp)
    800029b8:	ec26                	sd	s1,24(sp)
    800029ba:	e84a                	sd	s2,16(sp)
    800029bc:	e44e                	sd	s3,8(sp)
    800029be:	e052                	sd	s4,0(sp)
    800029c0:	1800                	addi	s0,sp,48
    800029c2:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800029c4:	47ad                	li	a5,11
    800029c6:	02b7e763          	bltu	a5,a1,800029f4 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    800029ca:	02059493          	slli	s1,a1,0x20
    800029ce:	9081                	srli	s1,s1,0x20
    800029d0:	048a                	slli	s1,s1,0x2
    800029d2:	94aa                	add	s1,s1,a0
    800029d4:	0504a903          	lw	s2,80(s1)
    800029d8:	06091e63          	bnez	s2,80002a54 <bmap+0xa2>
      addr = balloc(ip->dev);
    800029dc:	4108                	lw	a0,0(a0)
    800029de:	00000097          	auipc	ra,0x0
    800029e2:	e9c080e7          	jalr	-356(ra) # 8000287a <balloc>
    800029e6:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800029ea:	06090563          	beqz	s2,80002a54 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    800029ee:	0524a823          	sw	s2,80(s1)
    800029f2:	a08d                	j	80002a54 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    800029f4:	ff45849b          	addiw	s1,a1,-12
    800029f8:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800029fc:	0ff00793          	li	a5,255
    80002a00:	08e7e563          	bltu	a5,a4,80002a8a <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002a04:	08052903          	lw	s2,128(a0)
    80002a08:	00091d63          	bnez	s2,80002a22 <bmap+0x70>
      addr = balloc(ip->dev);
    80002a0c:	4108                	lw	a0,0(a0)
    80002a0e:	00000097          	auipc	ra,0x0
    80002a12:	e6c080e7          	jalr	-404(ra) # 8000287a <balloc>
    80002a16:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002a1a:	02090d63          	beqz	s2,80002a54 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002a1e:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80002a22:	85ca                	mv	a1,s2
    80002a24:	0009a503          	lw	a0,0(s3)
    80002a28:	00000097          	auipc	ra,0x0
    80002a2c:	b90080e7          	jalr	-1136(ra) # 800025b8 <bread>
    80002a30:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002a32:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002a36:	02049593          	slli	a1,s1,0x20
    80002a3a:	9181                	srli	a1,a1,0x20
    80002a3c:	058a                	slli	a1,a1,0x2
    80002a3e:	00b784b3          	add	s1,a5,a1
    80002a42:	0004a903          	lw	s2,0(s1)
    80002a46:	02090063          	beqz	s2,80002a66 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002a4a:	8552                	mv	a0,s4
    80002a4c:	00000097          	auipc	ra,0x0
    80002a50:	c9c080e7          	jalr	-868(ra) # 800026e8 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002a54:	854a                	mv	a0,s2
    80002a56:	70a2                	ld	ra,40(sp)
    80002a58:	7402                	ld	s0,32(sp)
    80002a5a:	64e2                	ld	s1,24(sp)
    80002a5c:	6942                	ld	s2,16(sp)
    80002a5e:	69a2                	ld	s3,8(sp)
    80002a60:	6a02                	ld	s4,0(sp)
    80002a62:	6145                	addi	sp,sp,48
    80002a64:	8082                	ret
      addr = balloc(ip->dev);
    80002a66:	0009a503          	lw	a0,0(s3)
    80002a6a:	00000097          	auipc	ra,0x0
    80002a6e:	e10080e7          	jalr	-496(ra) # 8000287a <balloc>
    80002a72:	0005091b          	sext.w	s2,a0
      if(addr){
    80002a76:	fc090ae3          	beqz	s2,80002a4a <bmap+0x98>
        a[bn] = addr;
    80002a7a:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002a7e:	8552                	mv	a0,s4
    80002a80:	00001097          	auipc	ra,0x1
    80002a84:	eec080e7          	jalr	-276(ra) # 8000396c <log_write>
    80002a88:	b7c9                	j	80002a4a <bmap+0x98>
  panic("bmap: out of range");
    80002a8a:	00006517          	auipc	a0,0x6
    80002a8e:	c1650513          	addi	a0,a0,-1002 # 800086a0 <syscalls+0x118>
    80002a92:	00003097          	auipc	ra,0x3
    80002a96:	440080e7          	jalr	1088(ra) # 80005ed2 <panic>

0000000080002a9a <iget>:
{
    80002a9a:	7179                	addi	sp,sp,-48
    80002a9c:	f406                	sd	ra,40(sp)
    80002a9e:	f022                	sd	s0,32(sp)
    80002aa0:	ec26                	sd	s1,24(sp)
    80002aa2:	e84a                	sd	s2,16(sp)
    80002aa4:	e44e                	sd	s3,8(sp)
    80002aa6:	e052                	sd	s4,0(sp)
    80002aa8:	1800                	addi	s0,sp,48
    80002aaa:	89aa                	mv	s3,a0
    80002aac:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002aae:	00034517          	auipc	a0,0x34
    80002ab2:	55250513          	addi	a0,a0,1362 # 80037000 <itable>
    80002ab6:	00004097          	auipc	ra,0x4
    80002aba:	966080e7          	jalr	-1690(ra) # 8000641c <acquire>
  empty = 0;
    80002abe:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002ac0:	00034497          	auipc	s1,0x34
    80002ac4:	55848493          	addi	s1,s1,1368 # 80037018 <itable+0x18>
    80002ac8:	00036697          	auipc	a3,0x36
    80002acc:	fe068693          	addi	a3,a3,-32 # 80038aa8 <log>
    80002ad0:	a039                	j	80002ade <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002ad2:	02090b63          	beqz	s2,80002b08 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002ad6:	08848493          	addi	s1,s1,136
    80002ada:	02d48a63          	beq	s1,a3,80002b0e <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002ade:	449c                	lw	a5,8(s1)
    80002ae0:	fef059e3          	blez	a5,80002ad2 <iget+0x38>
    80002ae4:	4098                	lw	a4,0(s1)
    80002ae6:	ff3716e3          	bne	a4,s3,80002ad2 <iget+0x38>
    80002aea:	40d8                	lw	a4,4(s1)
    80002aec:	ff4713e3          	bne	a4,s4,80002ad2 <iget+0x38>
      ip->ref++;
    80002af0:	2785                	addiw	a5,a5,1
    80002af2:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002af4:	00034517          	auipc	a0,0x34
    80002af8:	50c50513          	addi	a0,a0,1292 # 80037000 <itable>
    80002afc:	00004097          	auipc	ra,0x4
    80002b00:	9d4080e7          	jalr	-1580(ra) # 800064d0 <release>
      return ip;
    80002b04:	8926                	mv	s2,s1
    80002b06:	a03d                	j	80002b34 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002b08:	f7f9                	bnez	a5,80002ad6 <iget+0x3c>
    80002b0a:	8926                	mv	s2,s1
    80002b0c:	b7e9                	j	80002ad6 <iget+0x3c>
  if(empty == 0)
    80002b0e:	02090c63          	beqz	s2,80002b46 <iget+0xac>
  ip->dev = dev;
    80002b12:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002b16:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002b1a:	4785                	li	a5,1
    80002b1c:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002b20:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002b24:	00034517          	auipc	a0,0x34
    80002b28:	4dc50513          	addi	a0,a0,1244 # 80037000 <itable>
    80002b2c:	00004097          	auipc	ra,0x4
    80002b30:	9a4080e7          	jalr	-1628(ra) # 800064d0 <release>
}
    80002b34:	854a                	mv	a0,s2
    80002b36:	70a2                	ld	ra,40(sp)
    80002b38:	7402                	ld	s0,32(sp)
    80002b3a:	64e2                	ld	s1,24(sp)
    80002b3c:	6942                	ld	s2,16(sp)
    80002b3e:	69a2                	ld	s3,8(sp)
    80002b40:	6a02                	ld	s4,0(sp)
    80002b42:	6145                	addi	sp,sp,48
    80002b44:	8082                	ret
    panic("iget: no inodes");
    80002b46:	00006517          	auipc	a0,0x6
    80002b4a:	b7250513          	addi	a0,a0,-1166 # 800086b8 <syscalls+0x130>
    80002b4e:	00003097          	auipc	ra,0x3
    80002b52:	384080e7          	jalr	900(ra) # 80005ed2 <panic>

0000000080002b56 <fsinit>:
fsinit(int dev) {
    80002b56:	7179                	addi	sp,sp,-48
    80002b58:	f406                	sd	ra,40(sp)
    80002b5a:	f022                	sd	s0,32(sp)
    80002b5c:	ec26                	sd	s1,24(sp)
    80002b5e:	e84a                	sd	s2,16(sp)
    80002b60:	e44e                	sd	s3,8(sp)
    80002b62:	1800                	addi	s0,sp,48
    80002b64:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002b66:	4585                	li	a1,1
    80002b68:	00000097          	auipc	ra,0x0
    80002b6c:	a50080e7          	jalr	-1456(ra) # 800025b8 <bread>
    80002b70:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002b72:	00034997          	auipc	s3,0x34
    80002b76:	46e98993          	addi	s3,s3,1134 # 80036fe0 <sb>
    80002b7a:	02000613          	li	a2,32
    80002b7e:	05850593          	addi	a1,a0,88
    80002b82:	854e                	mv	a0,s3
    80002b84:	ffffd097          	auipc	ra,0xffffd
    80002b88:	760080e7          	jalr	1888(ra) # 800002e4 <memmove>
  brelse(bp);
    80002b8c:	8526                	mv	a0,s1
    80002b8e:	00000097          	auipc	ra,0x0
    80002b92:	b5a080e7          	jalr	-1190(ra) # 800026e8 <brelse>
  if(sb.magic != FSMAGIC)
    80002b96:	0009a703          	lw	a4,0(s3)
    80002b9a:	102037b7          	lui	a5,0x10203
    80002b9e:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002ba2:	02f71263          	bne	a4,a5,80002bc6 <fsinit+0x70>
  initlog(dev, &sb);
    80002ba6:	00034597          	auipc	a1,0x34
    80002baa:	43a58593          	addi	a1,a1,1082 # 80036fe0 <sb>
    80002bae:	854a                	mv	a0,s2
    80002bb0:	00001097          	auipc	ra,0x1
    80002bb4:	b40080e7          	jalr	-1216(ra) # 800036f0 <initlog>
}
    80002bb8:	70a2                	ld	ra,40(sp)
    80002bba:	7402                	ld	s0,32(sp)
    80002bbc:	64e2                	ld	s1,24(sp)
    80002bbe:	6942                	ld	s2,16(sp)
    80002bc0:	69a2                	ld	s3,8(sp)
    80002bc2:	6145                	addi	sp,sp,48
    80002bc4:	8082                	ret
    panic("invalid file system");
    80002bc6:	00006517          	auipc	a0,0x6
    80002bca:	b0250513          	addi	a0,a0,-1278 # 800086c8 <syscalls+0x140>
    80002bce:	00003097          	auipc	ra,0x3
    80002bd2:	304080e7          	jalr	772(ra) # 80005ed2 <panic>

0000000080002bd6 <iinit>:
{
    80002bd6:	7179                	addi	sp,sp,-48
    80002bd8:	f406                	sd	ra,40(sp)
    80002bda:	f022                	sd	s0,32(sp)
    80002bdc:	ec26                	sd	s1,24(sp)
    80002bde:	e84a                	sd	s2,16(sp)
    80002be0:	e44e                	sd	s3,8(sp)
    80002be2:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002be4:	00006597          	auipc	a1,0x6
    80002be8:	afc58593          	addi	a1,a1,-1284 # 800086e0 <syscalls+0x158>
    80002bec:	00034517          	auipc	a0,0x34
    80002bf0:	41450513          	addi	a0,a0,1044 # 80037000 <itable>
    80002bf4:	00003097          	auipc	ra,0x3
    80002bf8:	798080e7          	jalr	1944(ra) # 8000638c <initlock>
  for(i = 0; i < NINODE; i++) {
    80002bfc:	00034497          	auipc	s1,0x34
    80002c00:	42c48493          	addi	s1,s1,1068 # 80037028 <itable+0x28>
    80002c04:	00036997          	auipc	s3,0x36
    80002c08:	eb498993          	addi	s3,s3,-332 # 80038ab8 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002c0c:	00006917          	auipc	s2,0x6
    80002c10:	adc90913          	addi	s2,s2,-1316 # 800086e8 <syscalls+0x160>
    80002c14:	85ca                	mv	a1,s2
    80002c16:	8526                	mv	a0,s1
    80002c18:	00001097          	auipc	ra,0x1
    80002c1c:	e3a080e7          	jalr	-454(ra) # 80003a52 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002c20:	08848493          	addi	s1,s1,136
    80002c24:	ff3498e3          	bne	s1,s3,80002c14 <iinit+0x3e>
}
    80002c28:	70a2                	ld	ra,40(sp)
    80002c2a:	7402                	ld	s0,32(sp)
    80002c2c:	64e2                	ld	s1,24(sp)
    80002c2e:	6942                	ld	s2,16(sp)
    80002c30:	69a2                	ld	s3,8(sp)
    80002c32:	6145                	addi	sp,sp,48
    80002c34:	8082                	ret

0000000080002c36 <ialloc>:
{
    80002c36:	715d                	addi	sp,sp,-80
    80002c38:	e486                	sd	ra,72(sp)
    80002c3a:	e0a2                	sd	s0,64(sp)
    80002c3c:	fc26                	sd	s1,56(sp)
    80002c3e:	f84a                	sd	s2,48(sp)
    80002c40:	f44e                	sd	s3,40(sp)
    80002c42:	f052                	sd	s4,32(sp)
    80002c44:	ec56                	sd	s5,24(sp)
    80002c46:	e85a                	sd	s6,16(sp)
    80002c48:	e45e                	sd	s7,8(sp)
    80002c4a:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c4c:	00034717          	auipc	a4,0x34
    80002c50:	3a072703          	lw	a4,928(a4) # 80036fec <sb+0xc>
    80002c54:	4785                	li	a5,1
    80002c56:	04e7fa63          	bgeu	a5,a4,80002caa <ialloc+0x74>
    80002c5a:	8aaa                	mv	s5,a0
    80002c5c:	8bae                	mv	s7,a1
    80002c5e:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002c60:	00034a17          	auipc	s4,0x34
    80002c64:	380a0a13          	addi	s4,s4,896 # 80036fe0 <sb>
    80002c68:	00048b1b          	sext.w	s6,s1
    80002c6c:	0044d593          	srli	a1,s1,0x4
    80002c70:	018a2783          	lw	a5,24(s4)
    80002c74:	9dbd                	addw	a1,a1,a5
    80002c76:	8556                	mv	a0,s5
    80002c78:	00000097          	auipc	ra,0x0
    80002c7c:	940080e7          	jalr	-1728(ra) # 800025b8 <bread>
    80002c80:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002c82:	05850993          	addi	s3,a0,88
    80002c86:	00f4f793          	andi	a5,s1,15
    80002c8a:	079a                	slli	a5,a5,0x6
    80002c8c:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002c8e:	00099783          	lh	a5,0(s3)
    80002c92:	c3a1                	beqz	a5,80002cd2 <ialloc+0x9c>
    brelse(bp);
    80002c94:	00000097          	auipc	ra,0x0
    80002c98:	a54080e7          	jalr	-1452(ra) # 800026e8 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c9c:	0485                	addi	s1,s1,1
    80002c9e:	00ca2703          	lw	a4,12(s4)
    80002ca2:	0004879b          	sext.w	a5,s1
    80002ca6:	fce7e1e3          	bltu	a5,a4,80002c68 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80002caa:	00006517          	auipc	a0,0x6
    80002cae:	a4650513          	addi	a0,a0,-1466 # 800086f0 <syscalls+0x168>
    80002cb2:	00003097          	auipc	ra,0x3
    80002cb6:	26a080e7          	jalr	618(ra) # 80005f1c <printf>
  return 0;
    80002cba:	4501                	li	a0,0
}
    80002cbc:	60a6                	ld	ra,72(sp)
    80002cbe:	6406                	ld	s0,64(sp)
    80002cc0:	74e2                	ld	s1,56(sp)
    80002cc2:	7942                	ld	s2,48(sp)
    80002cc4:	79a2                	ld	s3,40(sp)
    80002cc6:	7a02                	ld	s4,32(sp)
    80002cc8:	6ae2                	ld	s5,24(sp)
    80002cca:	6b42                	ld	s6,16(sp)
    80002ccc:	6ba2                	ld	s7,8(sp)
    80002cce:	6161                	addi	sp,sp,80
    80002cd0:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002cd2:	04000613          	li	a2,64
    80002cd6:	4581                	li	a1,0
    80002cd8:	854e                	mv	a0,s3
    80002cda:	ffffd097          	auipc	ra,0xffffd
    80002cde:	5aa080e7          	jalr	1450(ra) # 80000284 <memset>
      dip->type = type;
    80002ce2:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002ce6:	854a                	mv	a0,s2
    80002ce8:	00001097          	auipc	ra,0x1
    80002cec:	c84080e7          	jalr	-892(ra) # 8000396c <log_write>
      brelse(bp);
    80002cf0:	854a                	mv	a0,s2
    80002cf2:	00000097          	auipc	ra,0x0
    80002cf6:	9f6080e7          	jalr	-1546(ra) # 800026e8 <brelse>
      return iget(dev, inum);
    80002cfa:	85da                	mv	a1,s6
    80002cfc:	8556                	mv	a0,s5
    80002cfe:	00000097          	auipc	ra,0x0
    80002d02:	d9c080e7          	jalr	-612(ra) # 80002a9a <iget>
    80002d06:	bf5d                	j	80002cbc <ialloc+0x86>

0000000080002d08 <iupdate>:
{
    80002d08:	1101                	addi	sp,sp,-32
    80002d0a:	ec06                	sd	ra,24(sp)
    80002d0c:	e822                	sd	s0,16(sp)
    80002d0e:	e426                	sd	s1,8(sp)
    80002d10:	e04a                	sd	s2,0(sp)
    80002d12:	1000                	addi	s0,sp,32
    80002d14:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002d16:	415c                	lw	a5,4(a0)
    80002d18:	0047d79b          	srliw	a5,a5,0x4
    80002d1c:	00034597          	auipc	a1,0x34
    80002d20:	2dc5a583          	lw	a1,732(a1) # 80036ff8 <sb+0x18>
    80002d24:	9dbd                	addw	a1,a1,a5
    80002d26:	4108                	lw	a0,0(a0)
    80002d28:	00000097          	auipc	ra,0x0
    80002d2c:	890080e7          	jalr	-1904(ra) # 800025b8 <bread>
    80002d30:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002d32:	05850793          	addi	a5,a0,88
    80002d36:	40c8                	lw	a0,4(s1)
    80002d38:	893d                	andi	a0,a0,15
    80002d3a:	051a                	slli	a0,a0,0x6
    80002d3c:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002d3e:	04449703          	lh	a4,68(s1)
    80002d42:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80002d46:	04649703          	lh	a4,70(s1)
    80002d4a:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80002d4e:	04849703          	lh	a4,72(s1)
    80002d52:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80002d56:	04a49703          	lh	a4,74(s1)
    80002d5a:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80002d5e:	44f8                	lw	a4,76(s1)
    80002d60:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002d62:	03400613          	li	a2,52
    80002d66:	05048593          	addi	a1,s1,80
    80002d6a:	0531                	addi	a0,a0,12
    80002d6c:	ffffd097          	auipc	ra,0xffffd
    80002d70:	578080e7          	jalr	1400(ra) # 800002e4 <memmove>
  log_write(bp);
    80002d74:	854a                	mv	a0,s2
    80002d76:	00001097          	auipc	ra,0x1
    80002d7a:	bf6080e7          	jalr	-1034(ra) # 8000396c <log_write>
  brelse(bp);
    80002d7e:	854a                	mv	a0,s2
    80002d80:	00000097          	auipc	ra,0x0
    80002d84:	968080e7          	jalr	-1688(ra) # 800026e8 <brelse>
}
    80002d88:	60e2                	ld	ra,24(sp)
    80002d8a:	6442                	ld	s0,16(sp)
    80002d8c:	64a2                	ld	s1,8(sp)
    80002d8e:	6902                	ld	s2,0(sp)
    80002d90:	6105                	addi	sp,sp,32
    80002d92:	8082                	ret

0000000080002d94 <idup>:
{
    80002d94:	1101                	addi	sp,sp,-32
    80002d96:	ec06                	sd	ra,24(sp)
    80002d98:	e822                	sd	s0,16(sp)
    80002d9a:	e426                	sd	s1,8(sp)
    80002d9c:	1000                	addi	s0,sp,32
    80002d9e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002da0:	00034517          	auipc	a0,0x34
    80002da4:	26050513          	addi	a0,a0,608 # 80037000 <itable>
    80002da8:	00003097          	auipc	ra,0x3
    80002dac:	674080e7          	jalr	1652(ra) # 8000641c <acquire>
  ip->ref++;
    80002db0:	449c                	lw	a5,8(s1)
    80002db2:	2785                	addiw	a5,a5,1
    80002db4:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002db6:	00034517          	auipc	a0,0x34
    80002dba:	24a50513          	addi	a0,a0,586 # 80037000 <itable>
    80002dbe:	00003097          	auipc	ra,0x3
    80002dc2:	712080e7          	jalr	1810(ra) # 800064d0 <release>
}
    80002dc6:	8526                	mv	a0,s1
    80002dc8:	60e2                	ld	ra,24(sp)
    80002dca:	6442                	ld	s0,16(sp)
    80002dcc:	64a2                	ld	s1,8(sp)
    80002dce:	6105                	addi	sp,sp,32
    80002dd0:	8082                	ret

0000000080002dd2 <ilock>:
{
    80002dd2:	1101                	addi	sp,sp,-32
    80002dd4:	ec06                	sd	ra,24(sp)
    80002dd6:	e822                	sd	s0,16(sp)
    80002dd8:	e426                	sd	s1,8(sp)
    80002dda:	e04a                	sd	s2,0(sp)
    80002ddc:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002dde:	c115                	beqz	a0,80002e02 <ilock+0x30>
    80002de0:	84aa                	mv	s1,a0
    80002de2:	451c                	lw	a5,8(a0)
    80002de4:	00f05f63          	blez	a5,80002e02 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002de8:	0541                	addi	a0,a0,16
    80002dea:	00001097          	auipc	ra,0x1
    80002dee:	ca2080e7          	jalr	-862(ra) # 80003a8c <acquiresleep>
  if(ip->valid == 0){
    80002df2:	40bc                	lw	a5,64(s1)
    80002df4:	cf99                	beqz	a5,80002e12 <ilock+0x40>
}
    80002df6:	60e2                	ld	ra,24(sp)
    80002df8:	6442                	ld	s0,16(sp)
    80002dfa:	64a2                	ld	s1,8(sp)
    80002dfc:	6902                	ld	s2,0(sp)
    80002dfe:	6105                	addi	sp,sp,32
    80002e00:	8082                	ret
    panic("ilock");
    80002e02:	00006517          	auipc	a0,0x6
    80002e06:	90650513          	addi	a0,a0,-1786 # 80008708 <syscalls+0x180>
    80002e0a:	00003097          	auipc	ra,0x3
    80002e0e:	0c8080e7          	jalr	200(ra) # 80005ed2 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002e12:	40dc                	lw	a5,4(s1)
    80002e14:	0047d79b          	srliw	a5,a5,0x4
    80002e18:	00034597          	auipc	a1,0x34
    80002e1c:	1e05a583          	lw	a1,480(a1) # 80036ff8 <sb+0x18>
    80002e20:	9dbd                	addw	a1,a1,a5
    80002e22:	4088                	lw	a0,0(s1)
    80002e24:	fffff097          	auipc	ra,0xfffff
    80002e28:	794080e7          	jalr	1940(ra) # 800025b8 <bread>
    80002e2c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002e2e:	05850593          	addi	a1,a0,88
    80002e32:	40dc                	lw	a5,4(s1)
    80002e34:	8bbd                	andi	a5,a5,15
    80002e36:	079a                	slli	a5,a5,0x6
    80002e38:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002e3a:	00059783          	lh	a5,0(a1)
    80002e3e:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002e42:	00259783          	lh	a5,2(a1)
    80002e46:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002e4a:	00459783          	lh	a5,4(a1)
    80002e4e:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002e52:	00659783          	lh	a5,6(a1)
    80002e56:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002e5a:	459c                	lw	a5,8(a1)
    80002e5c:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002e5e:	03400613          	li	a2,52
    80002e62:	05b1                	addi	a1,a1,12
    80002e64:	05048513          	addi	a0,s1,80
    80002e68:	ffffd097          	auipc	ra,0xffffd
    80002e6c:	47c080e7          	jalr	1148(ra) # 800002e4 <memmove>
    brelse(bp);
    80002e70:	854a                	mv	a0,s2
    80002e72:	00000097          	auipc	ra,0x0
    80002e76:	876080e7          	jalr	-1930(ra) # 800026e8 <brelse>
    ip->valid = 1;
    80002e7a:	4785                	li	a5,1
    80002e7c:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002e7e:	04449783          	lh	a5,68(s1)
    80002e82:	fbb5                	bnez	a5,80002df6 <ilock+0x24>
      panic("ilock: no type");
    80002e84:	00006517          	auipc	a0,0x6
    80002e88:	88c50513          	addi	a0,a0,-1908 # 80008710 <syscalls+0x188>
    80002e8c:	00003097          	auipc	ra,0x3
    80002e90:	046080e7          	jalr	70(ra) # 80005ed2 <panic>

0000000080002e94 <iunlock>:
{
    80002e94:	1101                	addi	sp,sp,-32
    80002e96:	ec06                	sd	ra,24(sp)
    80002e98:	e822                	sd	s0,16(sp)
    80002e9a:	e426                	sd	s1,8(sp)
    80002e9c:	e04a                	sd	s2,0(sp)
    80002e9e:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002ea0:	c905                	beqz	a0,80002ed0 <iunlock+0x3c>
    80002ea2:	84aa                	mv	s1,a0
    80002ea4:	01050913          	addi	s2,a0,16
    80002ea8:	854a                	mv	a0,s2
    80002eaa:	00001097          	auipc	ra,0x1
    80002eae:	c7c080e7          	jalr	-900(ra) # 80003b26 <holdingsleep>
    80002eb2:	cd19                	beqz	a0,80002ed0 <iunlock+0x3c>
    80002eb4:	449c                	lw	a5,8(s1)
    80002eb6:	00f05d63          	blez	a5,80002ed0 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002eba:	854a                	mv	a0,s2
    80002ebc:	00001097          	auipc	ra,0x1
    80002ec0:	c26080e7          	jalr	-986(ra) # 80003ae2 <releasesleep>
}
    80002ec4:	60e2                	ld	ra,24(sp)
    80002ec6:	6442                	ld	s0,16(sp)
    80002ec8:	64a2                	ld	s1,8(sp)
    80002eca:	6902                	ld	s2,0(sp)
    80002ecc:	6105                	addi	sp,sp,32
    80002ece:	8082                	ret
    panic("iunlock");
    80002ed0:	00006517          	auipc	a0,0x6
    80002ed4:	85050513          	addi	a0,a0,-1968 # 80008720 <syscalls+0x198>
    80002ed8:	00003097          	auipc	ra,0x3
    80002edc:	ffa080e7          	jalr	-6(ra) # 80005ed2 <panic>

0000000080002ee0 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002ee0:	7179                	addi	sp,sp,-48
    80002ee2:	f406                	sd	ra,40(sp)
    80002ee4:	f022                	sd	s0,32(sp)
    80002ee6:	ec26                	sd	s1,24(sp)
    80002ee8:	e84a                	sd	s2,16(sp)
    80002eea:	e44e                	sd	s3,8(sp)
    80002eec:	e052                	sd	s4,0(sp)
    80002eee:	1800                	addi	s0,sp,48
    80002ef0:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002ef2:	05050493          	addi	s1,a0,80
    80002ef6:	08050913          	addi	s2,a0,128
    80002efa:	a021                	j	80002f02 <itrunc+0x22>
    80002efc:	0491                	addi	s1,s1,4
    80002efe:	01248d63          	beq	s1,s2,80002f18 <itrunc+0x38>
    if(ip->addrs[i]){
    80002f02:	408c                	lw	a1,0(s1)
    80002f04:	dde5                	beqz	a1,80002efc <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002f06:	0009a503          	lw	a0,0(s3)
    80002f0a:	00000097          	auipc	ra,0x0
    80002f0e:	8f4080e7          	jalr	-1804(ra) # 800027fe <bfree>
      ip->addrs[i] = 0;
    80002f12:	0004a023          	sw	zero,0(s1)
    80002f16:	b7dd                	j	80002efc <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002f18:	0809a583          	lw	a1,128(s3)
    80002f1c:	e185                	bnez	a1,80002f3c <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002f1e:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002f22:	854e                	mv	a0,s3
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	de4080e7          	jalr	-540(ra) # 80002d08 <iupdate>
}
    80002f2c:	70a2                	ld	ra,40(sp)
    80002f2e:	7402                	ld	s0,32(sp)
    80002f30:	64e2                	ld	s1,24(sp)
    80002f32:	6942                	ld	s2,16(sp)
    80002f34:	69a2                	ld	s3,8(sp)
    80002f36:	6a02                	ld	s4,0(sp)
    80002f38:	6145                	addi	sp,sp,48
    80002f3a:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002f3c:	0009a503          	lw	a0,0(s3)
    80002f40:	fffff097          	auipc	ra,0xfffff
    80002f44:	678080e7          	jalr	1656(ra) # 800025b8 <bread>
    80002f48:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002f4a:	05850493          	addi	s1,a0,88
    80002f4e:	45850913          	addi	s2,a0,1112
    80002f52:	a811                	j	80002f66 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002f54:	0009a503          	lw	a0,0(s3)
    80002f58:	00000097          	auipc	ra,0x0
    80002f5c:	8a6080e7          	jalr	-1882(ra) # 800027fe <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002f60:	0491                	addi	s1,s1,4
    80002f62:	01248563          	beq	s1,s2,80002f6c <itrunc+0x8c>
      if(a[j])
    80002f66:	408c                	lw	a1,0(s1)
    80002f68:	dde5                	beqz	a1,80002f60 <itrunc+0x80>
    80002f6a:	b7ed                	j	80002f54 <itrunc+0x74>
    brelse(bp);
    80002f6c:	8552                	mv	a0,s4
    80002f6e:	fffff097          	auipc	ra,0xfffff
    80002f72:	77a080e7          	jalr	1914(ra) # 800026e8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002f76:	0809a583          	lw	a1,128(s3)
    80002f7a:	0009a503          	lw	a0,0(s3)
    80002f7e:	00000097          	auipc	ra,0x0
    80002f82:	880080e7          	jalr	-1920(ra) # 800027fe <bfree>
    ip->addrs[NDIRECT] = 0;
    80002f86:	0809a023          	sw	zero,128(s3)
    80002f8a:	bf51                	j	80002f1e <itrunc+0x3e>

0000000080002f8c <iput>:
{
    80002f8c:	1101                	addi	sp,sp,-32
    80002f8e:	ec06                	sd	ra,24(sp)
    80002f90:	e822                	sd	s0,16(sp)
    80002f92:	e426                	sd	s1,8(sp)
    80002f94:	e04a                	sd	s2,0(sp)
    80002f96:	1000                	addi	s0,sp,32
    80002f98:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f9a:	00034517          	auipc	a0,0x34
    80002f9e:	06650513          	addi	a0,a0,102 # 80037000 <itable>
    80002fa2:	00003097          	auipc	ra,0x3
    80002fa6:	47a080e7          	jalr	1146(ra) # 8000641c <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002faa:	4498                	lw	a4,8(s1)
    80002fac:	4785                	li	a5,1
    80002fae:	02f70363          	beq	a4,a5,80002fd4 <iput+0x48>
  ip->ref--;
    80002fb2:	449c                	lw	a5,8(s1)
    80002fb4:	37fd                	addiw	a5,a5,-1
    80002fb6:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002fb8:	00034517          	auipc	a0,0x34
    80002fbc:	04850513          	addi	a0,a0,72 # 80037000 <itable>
    80002fc0:	00003097          	auipc	ra,0x3
    80002fc4:	510080e7          	jalr	1296(ra) # 800064d0 <release>
}
    80002fc8:	60e2                	ld	ra,24(sp)
    80002fca:	6442                	ld	s0,16(sp)
    80002fcc:	64a2                	ld	s1,8(sp)
    80002fce:	6902                	ld	s2,0(sp)
    80002fd0:	6105                	addi	sp,sp,32
    80002fd2:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002fd4:	40bc                	lw	a5,64(s1)
    80002fd6:	dff1                	beqz	a5,80002fb2 <iput+0x26>
    80002fd8:	04a49783          	lh	a5,74(s1)
    80002fdc:	fbf9                	bnez	a5,80002fb2 <iput+0x26>
    acquiresleep(&ip->lock);
    80002fde:	01048913          	addi	s2,s1,16
    80002fe2:	854a                	mv	a0,s2
    80002fe4:	00001097          	auipc	ra,0x1
    80002fe8:	aa8080e7          	jalr	-1368(ra) # 80003a8c <acquiresleep>
    release(&itable.lock);
    80002fec:	00034517          	auipc	a0,0x34
    80002ff0:	01450513          	addi	a0,a0,20 # 80037000 <itable>
    80002ff4:	00003097          	auipc	ra,0x3
    80002ff8:	4dc080e7          	jalr	1244(ra) # 800064d0 <release>
    itrunc(ip);
    80002ffc:	8526                	mv	a0,s1
    80002ffe:	00000097          	auipc	ra,0x0
    80003002:	ee2080e7          	jalr	-286(ra) # 80002ee0 <itrunc>
    ip->type = 0;
    80003006:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000300a:	8526                	mv	a0,s1
    8000300c:	00000097          	auipc	ra,0x0
    80003010:	cfc080e7          	jalr	-772(ra) # 80002d08 <iupdate>
    ip->valid = 0;
    80003014:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80003018:	854a                	mv	a0,s2
    8000301a:	00001097          	auipc	ra,0x1
    8000301e:	ac8080e7          	jalr	-1336(ra) # 80003ae2 <releasesleep>
    acquire(&itable.lock);
    80003022:	00034517          	auipc	a0,0x34
    80003026:	fde50513          	addi	a0,a0,-34 # 80037000 <itable>
    8000302a:	00003097          	auipc	ra,0x3
    8000302e:	3f2080e7          	jalr	1010(ra) # 8000641c <acquire>
    80003032:	b741                	j	80002fb2 <iput+0x26>

0000000080003034 <iunlockput>:
{
    80003034:	1101                	addi	sp,sp,-32
    80003036:	ec06                	sd	ra,24(sp)
    80003038:	e822                	sd	s0,16(sp)
    8000303a:	e426                	sd	s1,8(sp)
    8000303c:	1000                	addi	s0,sp,32
    8000303e:	84aa                	mv	s1,a0
  iunlock(ip);
    80003040:	00000097          	auipc	ra,0x0
    80003044:	e54080e7          	jalr	-428(ra) # 80002e94 <iunlock>
  iput(ip);
    80003048:	8526                	mv	a0,s1
    8000304a:	00000097          	auipc	ra,0x0
    8000304e:	f42080e7          	jalr	-190(ra) # 80002f8c <iput>
}
    80003052:	60e2                	ld	ra,24(sp)
    80003054:	6442                	ld	s0,16(sp)
    80003056:	64a2                	ld	s1,8(sp)
    80003058:	6105                	addi	sp,sp,32
    8000305a:	8082                	ret

000000008000305c <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    8000305c:	1141                	addi	sp,sp,-16
    8000305e:	e422                	sd	s0,8(sp)
    80003060:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80003062:	411c                	lw	a5,0(a0)
    80003064:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003066:	415c                	lw	a5,4(a0)
    80003068:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    8000306a:	04451783          	lh	a5,68(a0)
    8000306e:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80003072:	04a51783          	lh	a5,74(a0)
    80003076:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    8000307a:	04c56783          	lwu	a5,76(a0)
    8000307e:	e99c                	sd	a5,16(a1)
}
    80003080:	6422                	ld	s0,8(sp)
    80003082:	0141                	addi	sp,sp,16
    80003084:	8082                	ret

0000000080003086 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003086:	457c                	lw	a5,76(a0)
    80003088:	0ed7e963          	bltu	a5,a3,8000317a <readi+0xf4>
{
    8000308c:	7159                	addi	sp,sp,-112
    8000308e:	f486                	sd	ra,104(sp)
    80003090:	f0a2                	sd	s0,96(sp)
    80003092:	eca6                	sd	s1,88(sp)
    80003094:	e8ca                	sd	s2,80(sp)
    80003096:	e4ce                	sd	s3,72(sp)
    80003098:	e0d2                	sd	s4,64(sp)
    8000309a:	fc56                	sd	s5,56(sp)
    8000309c:	f85a                	sd	s6,48(sp)
    8000309e:	f45e                	sd	s7,40(sp)
    800030a0:	f062                	sd	s8,32(sp)
    800030a2:	ec66                	sd	s9,24(sp)
    800030a4:	e86a                	sd	s10,16(sp)
    800030a6:	e46e                	sd	s11,8(sp)
    800030a8:	1880                	addi	s0,sp,112
    800030aa:	8b2a                	mv	s6,a0
    800030ac:	8bae                	mv	s7,a1
    800030ae:	8a32                	mv	s4,a2
    800030b0:	84b6                	mv	s1,a3
    800030b2:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800030b4:	9f35                	addw	a4,a4,a3
    return 0;
    800030b6:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800030b8:	0ad76063          	bltu	a4,a3,80003158 <readi+0xd2>
  if(off + n > ip->size)
    800030bc:	00e7f463          	bgeu	a5,a4,800030c4 <readi+0x3e>
    n = ip->size - off;
    800030c0:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030c4:	0a0a8963          	beqz	s5,80003176 <readi+0xf0>
    800030c8:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800030ca:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800030ce:	5c7d                	li	s8,-1
    800030d0:	a82d                	j	8000310a <readi+0x84>
    800030d2:	020d1d93          	slli	s11,s10,0x20
    800030d6:	020ddd93          	srli	s11,s11,0x20
    800030da:	05890613          	addi	a2,s2,88
    800030de:	86ee                	mv	a3,s11
    800030e0:	963a                	add	a2,a2,a4
    800030e2:	85d2                	mv	a1,s4
    800030e4:	855e                	mv	a0,s7
    800030e6:	fffff097          	auipc	ra,0xfffff
    800030ea:	acc080e7          	jalr	-1332(ra) # 80001bb2 <either_copyout>
    800030ee:	05850d63          	beq	a0,s8,80003148 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800030f2:	854a                	mv	a0,s2
    800030f4:	fffff097          	auipc	ra,0xfffff
    800030f8:	5f4080e7          	jalr	1524(ra) # 800026e8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030fc:	013d09bb          	addw	s3,s10,s3
    80003100:	009d04bb          	addw	s1,s10,s1
    80003104:	9a6e                	add	s4,s4,s11
    80003106:	0559f763          	bgeu	s3,s5,80003154 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    8000310a:	00a4d59b          	srliw	a1,s1,0xa
    8000310e:	855a                	mv	a0,s6
    80003110:	00000097          	auipc	ra,0x0
    80003114:	8a2080e7          	jalr	-1886(ra) # 800029b2 <bmap>
    80003118:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000311c:	cd85                	beqz	a1,80003154 <readi+0xce>
    bp = bread(ip->dev, addr);
    8000311e:	000b2503          	lw	a0,0(s6)
    80003122:	fffff097          	auipc	ra,0xfffff
    80003126:	496080e7          	jalr	1174(ra) # 800025b8 <bread>
    8000312a:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000312c:	3ff4f713          	andi	a4,s1,1023
    80003130:	40ec87bb          	subw	a5,s9,a4
    80003134:	413a86bb          	subw	a3,s5,s3
    80003138:	8d3e                	mv	s10,a5
    8000313a:	2781                	sext.w	a5,a5
    8000313c:	0006861b          	sext.w	a2,a3
    80003140:	f8f679e3          	bgeu	a2,a5,800030d2 <readi+0x4c>
    80003144:	8d36                	mv	s10,a3
    80003146:	b771                	j	800030d2 <readi+0x4c>
      brelse(bp);
    80003148:	854a                	mv	a0,s2
    8000314a:	fffff097          	auipc	ra,0xfffff
    8000314e:	59e080e7          	jalr	1438(ra) # 800026e8 <brelse>
      tot = -1;
    80003152:	59fd                	li	s3,-1
  }
  return tot;
    80003154:	0009851b          	sext.w	a0,s3
}
    80003158:	70a6                	ld	ra,104(sp)
    8000315a:	7406                	ld	s0,96(sp)
    8000315c:	64e6                	ld	s1,88(sp)
    8000315e:	6946                	ld	s2,80(sp)
    80003160:	69a6                	ld	s3,72(sp)
    80003162:	6a06                	ld	s4,64(sp)
    80003164:	7ae2                	ld	s5,56(sp)
    80003166:	7b42                	ld	s6,48(sp)
    80003168:	7ba2                	ld	s7,40(sp)
    8000316a:	7c02                	ld	s8,32(sp)
    8000316c:	6ce2                	ld	s9,24(sp)
    8000316e:	6d42                	ld	s10,16(sp)
    80003170:	6da2                	ld	s11,8(sp)
    80003172:	6165                	addi	sp,sp,112
    80003174:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003176:	89d6                	mv	s3,s5
    80003178:	bff1                	j	80003154 <readi+0xce>
    return 0;
    8000317a:	4501                	li	a0,0
}
    8000317c:	8082                	ret

000000008000317e <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000317e:	457c                	lw	a5,76(a0)
    80003180:	10d7e863          	bltu	a5,a3,80003290 <writei+0x112>
{
    80003184:	7159                	addi	sp,sp,-112
    80003186:	f486                	sd	ra,104(sp)
    80003188:	f0a2                	sd	s0,96(sp)
    8000318a:	eca6                	sd	s1,88(sp)
    8000318c:	e8ca                	sd	s2,80(sp)
    8000318e:	e4ce                	sd	s3,72(sp)
    80003190:	e0d2                	sd	s4,64(sp)
    80003192:	fc56                	sd	s5,56(sp)
    80003194:	f85a                	sd	s6,48(sp)
    80003196:	f45e                	sd	s7,40(sp)
    80003198:	f062                	sd	s8,32(sp)
    8000319a:	ec66                	sd	s9,24(sp)
    8000319c:	e86a                	sd	s10,16(sp)
    8000319e:	e46e                	sd	s11,8(sp)
    800031a0:	1880                	addi	s0,sp,112
    800031a2:	8aaa                	mv	s5,a0
    800031a4:	8bae                	mv	s7,a1
    800031a6:	8a32                	mv	s4,a2
    800031a8:	8936                	mv	s2,a3
    800031aa:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800031ac:	00e687bb          	addw	a5,a3,a4
    800031b0:	0ed7e263          	bltu	a5,a3,80003294 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800031b4:	00043737          	lui	a4,0x43
    800031b8:	0ef76063          	bltu	a4,a5,80003298 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031bc:	0c0b0863          	beqz	s6,8000328c <writei+0x10e>
    800031c0:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800031c2:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800031c6:	5c7d                	li	s8,-1
    800031c8:	a091                	j	8000320c <writei+0x8e>
    800031ca:	020d1d93          	slli	s11,s10,0x20
    800031ce:	020ddd93          	srli	s11,s11,0x20
    800031d2:	05848513          	addi	a0,s1,88
    800031d6:	86ee                	mv	a3,s11
    800031d8:	8652                	mv	a2,s4
    800031da:	85de                	mv	a1,s7
    800031dc:	953a                	add	a0,a0,a4
    800031de:	fffff097          	auipc	ra,0xfffff
    800031e2:	a2a080e7          	jalr	-1494(ra) # 80001c08 <either_copyin>
    800031e6:	07850263          	beq	a0,s8,8000324a <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    800031ea:	8526                	mv	a0,s1
    800031ec:	00000097          	auipc	ra,0x0
    800031f0:	780080e7          	jalr	1920(ra) # 8000396c <log_write>
    brelse(bp);
    800031f4:	8526                	mv	a0,s1
    800031f6:	fffff097          	auipc	ra,0xfffff
    800031fa:	4f2080e7          	jalr	1266(ra) # 800026e8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031fe:	013d09bb          	addw	s3,s10,s3
    80003202:	012d093b          	addw	s2,s10,s2
    80003206:	9a6e                	add	s4,s4,s11
    80003208:	0569f663          	bgeu	s3,s6,80003254 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    8000320c:	00a9559b          	srliw	a1,s2,0xa
    80003210:	8556                	mv	a0,s5
    80003212:	fffff097          	auipc	ra,0xfffff
    80003216:	7a0080e7          	jalr	1952(ra) # 800029b2 <bmap>
    8000321a:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000321e:	c99d                	beqz	a1,80003254 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003220:	000aa503          	lw	a0,0(s5)
    80003224:	fffff097          	auipc	ra,0xfffff
    80003228:	394080e7          	jalr	916(ra) # 800025b8 <bread>
    8000322c:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000322e:	3ff97713          	andi	a4,s2,1023
    80003232:	40ec87bb          	subw	a5,s9,a4
    80003236:	413b06bb          	subw	a3,s6,s3
    8000323a:	8d3e                	mv	s10,a5
    8000323c:	2781                	sext.w	a5,a5
    8000323e:	0006861b          	sext.w	a2,a3
    80003242:	f8f674e3          	bgeu	a2,a5,800031ca <writei+0x4c>
    80003246:	8d36                	mv	s10,a3
    80003248:	b749                	j	800031ca <writei+0x4c>
      brelse(bp);
    8000324a:	8526                	mv	a0,s1
    8000324c:	fffff097          	auipc	ra,0xfffff
    80003250:	49c080e7          	jalr	1180(ra) # 800026e8 <brelse>
  }

  if(off > ip->size)
    80003254:	04caa783          	lw	a5,76(s5)
    80003258:	0127f463          	bgeu	a5,s2,80003260 <writei+0xe2>
    ip->size = off;
    8000325c:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003260:	8556                	mv	a0,s5
    80003262:	00000097          	auipc	ra,0x0
    80003266:	aa6080e7          	jalr	-1370(ra) # 80002d08 <iupdate>

  return tot;
    8000326a:	0009851b          	sext.w	a0,s3
}
    8000326e:	70a6                	ld	ra,104(sp)
    80003270:	7406                	ld	s0,96(sp)
    80003272:	64e6                	ld	s1,88(sp)
    80003274:	6946                	ld	s2,80(sp)
    80003276:	69a6                	ld	s3,72(sp)
    80003278:	6a06                	ld	s4,64(sp)
    8000327a:	7ae2                	ld	s5,56(sp)
    8000327c:	7b42                	ld	s6,48(sp)
    8000327e:	7ba2                	ld	s7,40(sp)
    80003280:	7c02                	ld	s8,32(sp)
    80003282:	6ce2                	ld	s9,24(sp)
    80003284:	6d42                	ld	s10,16(sp)
    80003286:	6da2                	ld	s11,8(sp)
    80003288:	6165                	addi	sp,sp,112
    8000328a:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000328c:	89da                	mv	s3,s6
    8000328e:	bfc9                	j	80003260 <writei+0xe2>
    return -1;
    80003290:	557d                	li	a0,-1
}
    80003292:	8082                	ret
    return -1;
    80003294:	557d                	li	a0,-1
    80003296:	bfe1                	j	8000326e <writei+0xf0>
    return -1;
    80003298:	557d                	li	a0,-1
    8000329a:	bfd1                	j	8000326e <writei+0xf0>

000000008000329c <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    8000329c:	1141                	addi	sp,sp,-16
    8000329e:	e406                	sd	ra,8(sp)
    800032a0:	e022                	sd	s0,0(sp)
    800032a2:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800032a4:	4639                	li	a2,14
    800032a6:	ffffd097          	auipc	ra,0xffffd
    800032aa:	0b6080e7          	jalr	182(ra) # 8000035c <strncmp>
}
    800032ae:	60a2                	ld	ra,8(sp)
    800032b0:	6402                	ld	s0,0(sp)
    800032b2:	0141                	addi	sp,sp,16
    800032b4:	8082                	ret

00000000800032b6 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800032b6:	7139                	addi	sp,sp,-64
    800032b8:	fc06                	sd	ra,56(sp)
    800032ba:	f822                	sd	s0,48(sp)
    800032bc:	f426                	sd	s1,40(sp)
    800032be:	f04a                	sd	s2,32(sp)
    800032c0:	ec4e                	sd	s3,24(sp)
    800032c2:	e852                	sd	s4,16(sp)
    800032c4:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800032c6:	04451703          	lh	a4,68(a0)
    800032ca:	4785                	li	a5,1
    800032cc:	00f71a63          	bne	a4,a5,800032e0 <dirlookup+0x2a>
    800032d0:	892a                	mv	s2,a0
    800032d2:	89ae                	mv	s3,a1
    800032d4:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800032d6:	457c                	lw	a5,76(a0)
    800032d8:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800032da:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032dc:	e79d                	bnez	a5,8000330a <dirlookup+0x54>
    800032de:	a8a5                	j	80003356 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800032e0:	00005517          	auipc	a0,0x5
    800032e4:	44850513          	addi	a0,a0,1096 # 80008728 <syscalls+0x1a0>
    800032e8:	00003097          	auipc	ra,0x3
    800032ec:	bea080e7          	jalr	-1046(ra) # 80005ed2 <panic>
      panic("dirlookup read");
    800032f0:	00005517          	auipc	a0,0x5
    800032f4:	45050513          	addi	a0,a0,1104 # 80008740 <syscalls+0x1b8>
    800032f8:	00003097          	auipc	ra,0x3
    800032fc:	bda080e7          	jalr	-1062(ra) # 80005ed2 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003300:	24c1                	addiw	s1,s1,16
    80003302:	04c92783          	lw	a5,76(s2)
    80003306:	04f4f763          	bgeu	s1,a5,80003354 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000330a:	4741                	li	a4,16
    8000330c:	86a6                	mv	a3,s1
    8000330e:	fc040613          	addi	a2,s0,-64
    80003312:	4581                	li	a1,0
    80003314:	854a                	mv	a0,s2
    80003316:	00000097          	auipc	ra,0x0
    8000331a:	d70080e7          	jalr	-656(ra) # 80003086 <readi>
    8000331e:	47c1                	li	a5,16
    80003320:	fcf518e3          	bne	a0,a5,800032f0 <dirlookup+0x3a>
    if(de.inum == 0)
    80003324:	fc045783          	lhu	a5,-64(s0)
    80003328:	dfe1                	beqz	a5,80003300 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000332a:	fc240593          	addi	a1,s0,-62
    8000332e:	854e                	mv	a0,s3
    80003330:	00000097          	auipc	ra,0x0
    80003334:	f6c080e7          	jalr	-148(ra) # 8000329c <namecmp>
    80003338:	f561                	bnez	a0,80003300 <dirlookup+0x4a>
      if(poff)
    8000333a:	000a0463          	beqz	s4,80003342 <dirlookup+0x8c>
        *poff = off;
    8000333e:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003342:	fc045583          	lhu	a1,-64(s0)
    80003346:	00092503          	lw	a0,0(s2)
    8000334a:	fffff097          	auipc	ra,0xfffff
    8000334e:	750080e7          	jalr	1872(ra) # 80002a9a <iget>
    80003352:	a011                	j	80003356 <dirlookup+0xa0>
  return 0;
    80003354:	4501                	li	a0,0
}
    80003356:	70e2                	ld	ra,56(sp)
    80003358:	7442                	ld	s0,48(sp)
    8000335a:	74a2                	ld	s1,40(sp)
    8000335c:	7902                	ld	s2,32(sp)
    8000335e:	69e2                	ld	s3,24(sp)
    80003360:	6a42                	ld	s4,16(sp)
    80003362:	6121                	addi	sp,sp,64
    80003364:	8082                	ret

0000000080003366 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003366:	711d                	addi	sp,sp,-96
    80003368:	ec86                	sd	ra,88(sp)
    8000336a:	e8a2                	sd	s0,80(sp)
    8000336c:	e4a6                	sd	s1,72(sp)
    8000336e:	e0ca                	sd	s2,64(sp)
    80003370:	fc4e                	sd	s3,56(sp)
    80003372:	f852                	sd	s4,48(sp)
    80003374:	f456                	sd	s5,40(sp)
    80003376:	f05a                	sd	s6,32(sp)
    80003378:	ec5e                	sd	s7,24(sp)
    8000337a:	e862                	sd	s8,16(sp)
    8000337c:	e466                	sd	s9,8(sp)
    8000337e:	1080                	addi	s0,sp,96
    80003380:	84aa                	mv	s1,a0
    80003382:	8b2e                	mv	s6,a1
    80003384:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003386:	00054703          	lbu	a4,0(a0)
    8000338a:	02f00793          	li	a5,47
    8000338e:	02f70363          	beq	a4,a5,800033b4 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003392:	ffffe097          	auipc	ra,0xffffe
    80003396:	d70080e7          	jalr	-656(ra) # 80001102 <myproc>
    8000339a:	15053503          	ld	a0,336(a0)
    8000339e:	00000097          	auipc	ra,0x0
    800033a2:	9f6080e7          	jalr	-1546(ra) # 80002d94 <idup>
    800033a6:	89aa                	mv	s3,a0
  while(*path == '/')
    800033a8:	02f00913          	li	s2,47
  len = path - s;
    800033ac:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    800033ae:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800033b0:	4c05                	li	s8,1
    800033b2:	a865                	j	8000346a <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    800033b4:	4585                	li	a1,1
    800033b6:	4505                	li	a0,1
    800033b8:	fffff097          	auipc	ra,0xfffff
    800033bc:	6e2080e7          	jalr	1762(ra) # 80002a9a <iget>
    800033c0:	89aa                	mv	s3,a0
    800033c2:	b7dd                	j	800033a8 <namex+0x42>
      iunlockput(ip);
    800033c4:	854e                	mv	a0,s3
    800033c6:	00000097          	auipc	ra,0x0
    800033ca:	c6e080e7          	jalr	-914(ra) # 80003034 <iunlockput>
      return 0;
    800033ce:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800033d0:	854e                	mv	a0,s3
    800033d2:	60e6                	ld	ra,88(sp)
    800033d4:	6446                	ld	s0,80(sp)
    800033d6:	64a6                	ld	s1,72(sp)
    800033d8:	6906                	ld	s2,64(sp)
    800033da:	79e2                	ld	s3,56(sp)
    800033dc:	7a42                	ld	s4,48(sp)
    800033de:	7aa2                	ld	s5,40(sp)
    800033e0:	7b02                	ld	s6,32(sp)
    800033e2:	6be2                	ld	s7,24(sp)
    800033e4:	6c42                	ld	s8,16(sp)
    800033e6:	6ca2                	ld	s9,8(sp)
    800033e8:	6125                	addi	sp,sp,96
    800033ea:	8082                	ret
      iunlock(ip);
    800033ec:	854e                	mv	a0,s3
    800033ee:	00000097          	auipc	ra,0x0
    800033f2:	aa6080e7          	jalr	-1370(ra) # 80002e94 <iunlock>
      return ip;
    800033f6:	bfe9                	j	800033d0 <namex+0x6a>
      iunlockput(ip);
    800033f8:	854e                	mv	a0,s3
    800033fa:	00000097          	auipc	ra,0x0
    800033fe:	c3a080e7          	jalr	-966(ra) # 80003034 <iunlockput>
      return 0;
    80003402:	89d2                	mv	s3,s4
    80003404:	b7f1                	j	800033d0 <namex+0x6a>
  len = path - s;
    80003406:	40b48633          	sub	a2,s1,a1
    8000340a:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    8000340e:	094cd463          	bge	s9,s4,80003496 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003412:	4639                	li	a2,14
    80003414:	8556                	mv	a0,s5
    80003416:	ffffd097          	auipc	ra,0xffffd
    8000341a:	ece080e7          	jalr	-306(ra) # 800002e4 <memmove>
  while(*path == '/')
    8000341e:	0004c783          	lbu	a5,0(s1)
    80003422:	01279763          	bne	a5,s2,80003430 <namex+0xca>
    path++;
    80003426:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003428:	0004c783          	lbu	a5,0(s1)
    8000342c:	ff278de3          	beq	a5,s2,80003426 <namex+0xc0>
    ilock(ip);
    80003430:	854e                	mv	a0,s3
    80003432:	00000097          	auipc	ra,0x0
    80003436:	9a0080e7          	jalr	-1632(ra) # 80002dd2 <ilock>
    if(ip->type != T_DIR){
    8000343a:	04499783          	lh	a5,68(s3)
    8000343e:	f98793e3          	bne	a5,s8,800033c4 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003442:	000b0563          	beqz	s6,8000344c <namex+0xe6>
    80003446:	0004c783          	lbu	a5,0(s1)
    8000344a:	d3cd                	beqz	a5,800033ec <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    8000344c:	865e                	mv	a2,s7
    8000344e:	85d6                	mv	a1,s5
    80003450:	854e                	mv	a0,s3
    80003452:	00000097          	auipc	ra,0x0
    80003456:	e64080e7          	jalr	-412(ra) # 800032b6 <dirlookup>
    8000345a:	8a2a                	mv	s4,a0
    8000345c:	dd51                	beqz	a0,800033f8 <namex+0x92>
    iunlockput(ip);
    8000345e:	854e                	mv	a0,s3
    80003460:	00000097          	auipc	ra,0x0
    80003464:	bd4080e7          	jalr	-1068(ra) # 80003034 <iunlockput>
    ip = next;
    80003468:	89d2                	mv	s3,s4
  while(*path == '/')
    8000346a:	0004c783          	lbu	a5,0(s1)
    8000346e:	05279763          	bne	a5,s2,800034bc <namex+0x156>
    path++;
    80003472:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003474:	0004c783          	lbu	a5,0(s1)
    80003478:	ff278de3          	beq	a5,s2,80003472 <namex+0x10c>
  if(*path == 0)
    8000347c:	c79d                	beqz	a5,800034aa <namex+0x144>
    path++;
    8000347e:	85a6                	mv	a1,s1
  len = path - s;
    80003480:	8a5e                	mv	s4,s7
    80003482:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003484:	01278963          	beq	a5,s2,80003496 <namex+0x130>
    80003488:	dfbd                	beqz	a5,80003406 <namex+0xa0>
    path++;
    8000348a:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    8000348c:	0004c783          	lbu	a5,0(s1)
    80003490:	ff279ce3          	bne	a5,s2,80003488 <namex+0x122>
    80003494:	bf8d                	j	80003406 <namex+0xa0>
    memmove(name, s, len);
    80003496:	2601                	sext.w	a2,a2
    80003498:	8556                	mv	a0,s5
    8000349a:	ffffd097          	auipc	ra,0xffffd
    8000349e:	e4a080e7          	jalr	-438(ra) # 800002e4 <memmove>
    name[len] = 0;
    800034a2:	9a56                	add	s4,s4,s5
    800034a4:	000a0023          	sb	zero,0(s4)
    800034a8:	bf9d                	j	8000341e <namex+0xb8>
  if(nameiparent){
    800034aa:	f20b03e3          	beqz	s6,800033d0 <namex+0x6a>
    iput(ip);
    800034ae:	854e                	mv	a0,s3
    800034b0:	00000097          	auipc	ra,0x0
    800034b4:	adc080e7          	jalr	-1316(ra) # 80002f8c <iput>
    return 0;
    800034b8:	4981                	li	s3,0
    800034ba:	bf19                	j	800033d0 <namex+0x6a>
  if(*path == 0)
    800034bc:	d7fd                	beqz	a5,800034aa <namex+0x144>
  while(*path != '/' && *path != 0)
    800034be:	0004c783          	lbu	a5,0(s1)
    800034c2:	85a6                	mv	a1,s1
    800034c4:	b7d1                	j	80003488 <namex+0x122>

00000000800034c6 <dirlink>:
{
    800034c6:	7139                	addi	sp,sp,-64
    800034c8:	fc06                	sd	ra,56(sp)
    800034ca:	f822                	sd	s0,48(sp)
    800034cc:	f426                	sd	s1,40(sp)
    800034ce:	f04a                	sd	s2,32(sp)
    800034d0:	ec4e                	sd	s3,24(sp)
    800034d2:	e852                	sd	s4,16(sp)
    800034d4:	0080                	addi	s0,sp,64
    800034d6:	892a                	mv	s2,a0
    800034d8:	8a2e                	mv	s4,a1
    800034da:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800034dc:	4601                	li	a2,0
    800034de:	00000097          	auipc	ra,0x0
    800034e2:	dd8080e7          	jalr	-552(ra) # 800032b6 <dirlookup>
    800034e6:	e93d                	bnez	a0,8000355c <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034e8:	04c92483          	lw	s1,76(s2)
    800034ec:	c49d                	beqz	s1,8000351a <dirlink+0x54>
    800034ee:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034f0:	4741                	li	a4,16
    800034f2:	86a6                	mv	a3,s1
    800034f4:	fc040613          	addi	a2,s0,-64
    800034f8:	4581                	li	a1,0
    800034fa:	854a                	mv	a0,s2
    800034fc:	00000097          	auipc	ra,0x0
    80003500:	b8a080e7          	jalr	-1142(ra) # 80003086 <readi>
    80003504:	47c1                	li	a5,16
    80003506:	06f51163          	bne	a0,a5,80003568 <dirlink+0xa2>
    if(de.inum == 0)
    8000350a:	fc045783          	lhu	a5,-64(s0)
    8000350e:	c791                	beqz	a5,8000351a <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003510:	24c1                	addiw	s1,s1,16
    80003512:	04c92783          	lw	a5,76(s2)
    80003516:	fcf4ede3          	bltu	s1,a5,800034f0 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000351a:	4639                	li	a2,14
    8000351c:	85d2                	mv	a1,s4
    8000351e:	fc240513          	addi	a0,s0,-62
    80003522:	ffffd097          	auipc	ra,0xffffd
    80003526:	e76080e7          	jalr	-394(ra) # 80000398 <strncpy>
  de.inum = inum;
    8000352a:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000352e:	4741                	li	a4,16
    80003530:	86a6                	mv	a3,s1
    80003532:	fc040613          	addi	a2,s0,-64
    80003536:	4581                	li	a1,0
    80003538:	854a                	mv	a0,s2
    8000353a:	00000097          	auipc	ra,0x0
    8000353e:	c44080e7          	jalr	-956(ra) # 8000317e <writei>
    80003542:	1541                	addi	a0,a0,-16
    80003544:	00a03533          	snez	a0,a0
    80003548:	40a00533          	neg	a0,a0
}
    8000354c:	70e2                	ld	ra,56(sp)
    8000354e:	7442                	ld	s0,48(sp)
    80003550:	74a2                	ld	s1,40(sp)
    80003552:	7902                	ld	s2,32(sp)
    80003554:	69e2                	ld	s3,24(sp)
    80003556:	6a42                	ld	s4,16(sp)
    80003558:	6121                	addi	sp,sp,64
    8000355a:	8082                	ret
    iput(ip);
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	a30080e7          	jalr	-1488(ra) # 80002f8c <iput>
    return -1;
    80003564:	557d                	li	a0,-1
    80003566:	b7dd                	j	8000354c <dirlink+0x86>
      panic("dirlink read");
    80003568:	00005517          	auipc	a0,0x5
    8000356c:	1e850513          	addi	a0,a0,488 # 80008750 <syscalls+0x1c8>
    80003570:	00003097          	auipc	ra,0x3
    80003574:	962080e7          	jalr	-1694(ra) # 80005ed2 <panic>

0000000080003578 <namei>:

struct inode*
namei(char *path)
{
    80003578:	1101                	addi	sp,sp,-32
    8000357a:	ec06                	sd	ra,24(sp)
    8000357c:	e822                	sd	s0,16(sp)
    8000357e:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003580:	fe040613          	addi	a2,s0,-32
    80003584:	4581                	li	a1,0
    80003586:	00000097          	auipc	ra,0x0
    8000358a:	de0080e7          	jalr	-544(ra) # 80003366 <namex>
}
    8000358e:	60e2                	ld	ra,24(sp)
    80003590:	6442                	ld	s0,16(sp)
    80003592:	6105                	addi	sp,sp,32
    80003594:	8082                	ret

0000000080003596 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003596:	1141                	addi	sp,sp,-16
    80003598:	e406                	sd	ra,8(sp)
    8000359a:	e022                	sd	s0,0(sp)
    8000359c:	0800                	addi	s0,sp,16
    8000359e:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800035a0:	4585                	li	a1,1
    800035a2:	00000097          	auipc	ra,0x0
    800035a6:	dc4080e7          	jalr	-572(ra) # 80003366 <namex>
}
    800035aa:	60a2                	ld	ra,8(sp)
    800035ac:	6402                	ld	s0,0(sp)
    800035ae:	0141                	addi	sp,sp,16
    800035b0:	8082                	ret

00000000800035b2 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800035b2:	1101                	addi	sp,sp,-32
    800035b4:	ec06                	sd	ra,24(sp)
    800035b6:	e822                	sd	s0,16(sp)
    800035b8:	e426                	sd	s1,8(sp)
    800035ba:	e04a                	sd	s2,0(sp)
    800035bc:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800035be:	00035917          	auipc	s2,0x35
    800035c2:	4ea90913          	addi	s2,s2,1258 # 80038aa8 <log>
    800035c6:	01892583          	lw	a1,24(s2)
    800035ca:	02892503          	lw	a0,40(s2)
    800035ce:	fffff097          	auipc	ra,0xfffff
    800035d2:	fea080e7          	jalr	-22(ra) # 800025b8 <bread>
    800035d6:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800035d8:	02c92683          	lw	a3,44(s2)
    800035dc:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800035de:	02d05763          	blez	a3,8000360c <write_head+0x5a>
    800035e2:	00035797          	auipc	a5,0x35
    800035e6:	4f678793          	addi	a5,a5,1270 # 80038ad8 <log+0x30>
    800035ea:	05c50713          	addi	a4,a0,92
    800035ee:	36fd                	addiw	a3,a3,-1
    800035f0:	1682                	slli	a3,a3,0x20
    800035f2:	9281                	srli	a3,a3,0x20
    800035f4:	068a                	slli	a3,a3,0x2
    800035f6:	00035617          	auipc	a2,0x35
    800035fa:	4e660613          	addi	a2,a2,1254 # 80038adc <log+0x34>
    800035fe:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003600:	4390                	lw	a2,0(a5)
    80003602:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003604:	0791                	addi	a5,a5,4
    80003606:	0711                	addi	a4,a4,4
    80003608:	fed79ce3          	bne	a5,a3,80003600 <write_head+0x4e>
  }
  bwrite(buf);
    8000360c:	8526                	mv	a0,s1
    8000360e:	fffff097          	auipc	ra,0xfffff
    80003612:	09c080e7          	jalr	156(ra) # 800026aa <bwrite>
  brelse(buf);
    80003616:	8526                	mv	a0,s1
    80003618:	fffff097          	auipc	ra,0xfffff
    8000361c:	0d0080e7          	jalr	208(ra) # 800026e8 <brelse>
}
    80003620:	60e2                	ld	ra,24(sp)
    80003622:	6442                	ld	s0,16(sp)
    80003624:	64a2                	ld	s1,8(sp)
    80003626:	6902                	ld	s2,0(sp)
    80003628:	6105                	addi	sp,sp,32
    8000362a:	8082                	ret

000000008000362c <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000362c:	00035797          	auipc	a5,0x35
    80003630:	4a87a783          	lw	a5,1192(a5) # 80038ad4 <log+0x2c>
    80003634:	0af05d63          	blez	a5,800036ee <install_trans+0xc2>
{
    80003638:	7139                	addi	sp,sp,-64
    8000363a:	fc06                	sd	ra,56(sp)
    8000363c:	f822                	sd	s0,48(sp)
    8000363e:	f426                	sd	s1,40(sp)
    80003640:	f04a                	sd	s2,32(sp)
    80003642:	ec4e                	sd	s3,24(sp)
    80003644:	e852                	sd	s4,16(sp)
    80003646:	e456                	sd	s5,8(sp)
    80003648:	e05a                	sd	s6,0(sp)
    8000364a:	0080                	addi	s0,sp,64
    8000364c:	8b2a                	mv	s6,a0
    8000364e:	00035a97          	auipc	s5,0x35
    80003652:	48aa8a93          	addi	s5,s5,1162 # 80038ad8 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003656:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003658:	00035997          	auipc	s3,0x35
    8000365c:	45098993          	addi	s3,s3,1104 # 80038aa8 <log>
    80003660:	a035                	j	8000368c <install_trans+0x60>
      bunpin(dbuf);
    80003662:	8526                	mv	a0,s1
    80003664:	fffff097          	auipc	ra,0xfffff
    80003668:	15e080e7          	jalr	350(ra) # 800027c2 <bunpin>
    brelse(lbuf);
    8000366c:	854a                	mv	a0,s2
    8000366e:	fffff097          	auipc	ra,0xfffff
    80003672:	07a080e7          	jalr	122(ra) # 800026e8 <brelse>
    brelse(dbuf);
    80003676:	8526                	mv	a0,s1
    80003678:	fffff097          	auipc	ra,0xfffff
    8000367c:	070080e7          	jalr	112(ra) # 800026e8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003680:	2a05                	addiw	s4,s4,1
    80003682:	0a91                	addi	s5,s5,4
    80003684:	02c9a783          	lw	a5,44(s3)
    80003688:	04fa5963          	bge	s4,a5,800036da <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000368c:	0189a583          	lw	a1,24(s3)
    80003690:	014585bb          	addw	a1,a1,s4
    80003694:	2585                	addiw	a1,a1,1
    80003696:	0289a503          	lw	a0,40(s3)
    8000369a:	fffff097          	auipc	ra,0xfffff
    8000369e:	f1e080e7          	jalr	-226(ra) # 800025b8 <bread>
    800036a2:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800036a4:	000aa583          	lw	a1,0(s5)
    800036a8:	0289a503          	lw	a0,40(s3)
    800036ac:	fffff097          	auipc	ra,0xfffff
    800036b0:	f0c080e7          	jalr	-244(ra) # 800025b8 <bread>
    800036b4:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800036b6:	40000613          	li	a2,1024
    800036ba:	05890593          	addi	a1,s2,88
    800036be:	05850513          	addi	a0,a0,88
    800036c2:	ffffd097          	auipc	ra,0xffffd
    800036c6:	c22080e7          	jalr	-990(ra) # 800002e4 <memmove>
    bwrite(dbuf);  // write dst to disk
    800036ca:	8526                	mv	a0,s1
    800036cc:	fffff097          	auipc	ra,0xfffff
    800036d0:	fde080e7          	jalr	-34(ra) # 800026aa <bwrite>
    if(recovering == 0)
    800036d4:	f80b1ce3          	bnez	s6,8000366c <install_trans+0x40>
    800036d8:	b769                	j	80003662 <install_trans+0x36>
}
    800036da:	70e2                	ld	ra,56(sp)
    800036dc:	7442                	ld	s0,48(sp)
    800036de:	74a2                	ld	s1,40(sp)
    800036e0:	7902                	ld	s2,32(sp)
    800036e2:	69e2                	ld	s3,24(sp)
    800036e4:	6a42                	ld	s4,16(sp)
    800036e6:	6aa2                	ld	s5,8(sp)
    800036e8:	6b02                	ld	s6,0(sp)
    800036ea:	6121                	addi	sp,sp,64
    800036ec:	8082                	ret
    800036ee:	8082                	ret

00000000800036f0 <initlog>:
{
    800036f0:	7179                	addi	sp,sp,-48
    800036f2:	f406                	sd	ra,40(sp)
    800036f4:	f022                	sd	s0,32(sp)
    800036f6:	ec26                	sd	s1,24(sp)
    800036f8:	e84a                	sd	s2,16(sp)
    800036fa:	e44e                	sd	s3,8(sp)
    800036fc:	1800                	addi	s0,sp,48
    800036fe:	892a                	mv	s2,a0
    80003700:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003702:	00035497          	auipc	s1,0x35
    80003706:	3a648493          	addi	s1,s1,934 # 80038aa8 <log>
    8000370a:	00005597          	auipc	a1,0x5
    8000370e:	05658593          	addi	a1,a1,86 # 80008760 <syscalls+0x1d8>
    80003712:	8526                	mv	a0,s1
    80003714:	00003097          	auipc	ra,0x3
    80003718:	c78080e7          	jalr	-904(ra) # 8000638c <initlock>
  log.start = sb->logstart;
    8000371c:	0149a583          	lw	a1,20(s3)
    80003720:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003722:	0109a783          	lw	a5,16(s3)
    80003726:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003728:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000372c:	854a                	mv	a0,s2
    8000372e:	fffff097          	auipc	ra,0xfffff
    80003732:	e8a080e7          	jalr	-374(ra) # 800025b8 <bread>
  log.lh.n = lh->n;
    80003736:	4d3c                	lw	a5,88(a0)
    80003738:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000373a:	02f05563          	blez	a5,80003764 <initlog+0x74>
    8000373e:	05c50713          	addi	a4,a0,92
    80003742:	00035697          	auipc	a3,0x35
    80003746:	39668693          	addi	a3,a3,918 # 80038ad8 <log+0x30>
    8000374a:	37fd                	addiw	a5,a5,-1
    8000374c:	1782                	slli	a5,a5,0x20
    8000374e:	9381                	srli	a5,a5,0x20
    80003750:	078a                	slli	a5,a5,0x2
    80003752:	06050613          	addi	a2,a0,96
    80003756:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003758:	4310                	lw	a2,0(a4)
    8000375a:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    8000375c:	0711                	addi	a4,a4,4
    8000375e:	0691                	addi	a3,a3,4
    80003760:	fef71ce3          	bne	a4,a5,80003758 <initlog+0x68>
  brelse(buf);
    80003764:	fffff097          	auipc	ra,0xfffff
    80003768:	f84080e7          	jalr	-124(ra) # 800026e8 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000376c:	4505                	li	a0,1
    8000376e:	00000097          	auipc	ra,0x0
    80003772:	ebe080e7          	jalr	-322(ra) # 8000362c <install_trans>
  log.lh.n = 0;
    80003776:	00035797          	auipc	a5,0x35
    8000377a:	3407af23          	sw	zero,862(a5) # 80038ad4 <log+0x2c>
  write_head(); // clear the log
    8000377e:	00000097          	auipc	ra,0x0
    80003782:	e34080e7          	jalr	-460(ra) # 800035b2 <write_head>
}
    80003786:	70a2                	ld	ra,40(sp)
    80003788:	7402                	ld	s0,32(sp)
    8000378a:	64e2                	ld	s1,24(sp)
    8000378c:	6942                	ld	s2,16(sp)
    8000378e:	69a2                	ld	s3,8(sp)
    80003790:	6145                	addi	sp,sp,48
    80003792:	8082                	ret

0000000080003794 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003794:	1101                	addi	sp,sp,-32
    80003796:	ec06                	sd	ra,24(sp)
    80003798:	e822                	sd	s0,16(sp)
    8000379a:	e426                	sd	s1,8(sp)
    8000379c:	e04a                	sd	s2,0(sp)
    8000379e:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800037a0:	00035517          	auipc	a0,0x35
    800037a4:	30850513          	addi	a0,a0,776 # 80038aa8 <log>
    800037a8:	00003097          	auipc	ra,0x3
    800037ac:	c74080e7          	jalr	-908(ra) # 8000641c <acquire>
  while(1){
    if(log.committing){
    800037b0:	00035497          	auipc	s1,0x35
    800037b4:	2f848493          	addi	s1,s1,760 # 80038aa8 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800037b8:	4979                	li	s2,30
    800037ba:	a039                	j	800037c8 <begin_op+0x34>
      sleep(&log, &log.lock);
    800037bc:	85a6                	mv	a1,s1
    800037be:	8526                	mv	a0,s1
    800037c0:	ffffe097          	auipc	ra,0xffffe
    800037c4:	fea080e7          	jalr	-22(ra) # 800017aa <sleep>
    if(log.committing){
    800037c8:	50dc                	lw	a5,36(s1)
    800037ca:	fbed                	bnez	a5,800037bc <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800037cc:	509c                	lw	a5,32(s1)
    800037ce:	0017871b          	addiw	a4,a5,1
    800037d2:	0007069b          	sext.w	a3,a4
    800037d6:	0027179b          	slliw	a5,a4,0x2
    800037da:	9fb9                	addw	a5,a5,a4
    800037dc:	0017979b          	slliw	a5,a5,0x1
    800037e0:	54d8                	lw	a4,44(s1)
    800037e2:	9fb9                	addw	a5,a5,a4
    800037e4:	00f95963          	bge	s2,a5,800037f6 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800037e8:	85a6                	mv	a1,s1
    800037ea:	8526                	mv	a0,s1
    800037ec:	ffffe097          	auipc	ra,0xffffe
    800037f0:	fbe080e7          	jalr	-66(ra) # 800017aa <sleep>
    800037f4:	bfd1                	j	800037c8 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800037f6:	00035517          	auipc	a0,0x35
    800037fa:	2b250513          	addi	a0,a0,690 # 80038aa8 <log>
    800037fe:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003800:	00003097          	auipc	ra,0x3
    80003804:	cd0080e7          	jalr	-816(ra) # 800064d0 <release>
      break;
    }
  }
}
    80003808:	60e2                	ld	ra,24(sp)
    8000380a:	6442                	ld	s0,16(sp)
    8000380c:	64a2                	ld	s1,8(sp)
    8000380e:	6902                	ld	s2,0(sp)
    80003810:	6105                	addi	sp,sp,32
    80003812:	8082                	ret

0000000080003814 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003814:	7139                	addi	sp,sp,-64
    80003816:	fc06                	sd	ra,56(sp)
    80003818:	f822                	sd	s0,48(sp)
    8000381a:	f426                	sd	s1,40(sp)
    8000381c:	f04a                	sd	s2,32(sp)
    8000381e:	ec4e                	sd	s3,24(sp)
    80003820:	e852                	sd	s4,16(sp)
    80003822:	e456                	sd	s5,8(sp)
    80003824:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003826:	00035497          	auipc	s1,0x35
    8000382a:	28248493          	addi	s1,s1,642 # 80038aa8 <log>
    8000382e:	8526                	mv	a0,s1
    80003830:	00003097          	auipc	ra,0x3
    80003834:	bec080e7          	jalr	-1044(ra) # 8000641c <acquire>
  log.outstanding -= 1;
    80003838:	509c                	lw	a5,32(s1)
    8000383a:	37fd                	addiw	a5,a5,-1
    8000383c:	0007891b          	sext.w	s2,a5
    80003840:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003842:	50dc                	lw	a5,36(s1)
    80003844:	efb9                	bnez	a5,800038a2 <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003846:	06091663          	bnez	s2,800038b2 <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    8000384a:	00035497          	auipc	s1,0x35
    8000384e:	25e48493          	addi	s1,s1,606 # 80038aa8 <log>
    80003852:	4785                	li	a5,1
    80003854:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003856:	8526                	mv	a0,s1
    80003858:	00003097          	auipc	ra,0x3
    8000385c:	c78080e7          	jalr	-904(ra) # 800064d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003860:	54dc                	lw	a5,44(s1)
    80003862:	06f04763          	bgtz	a5,800038d0 <end_op+0xbc>
    acquire(&log.lock);
    80003866:	00035497          	auipc	s1,0x35
    8000386a:	24248493          	addi	s1,s1,578 # 80038aa8 <log>
    8000386e:	8526                	mv	a0,s1
    80003870:	00003097          	auipc	ra,0x3
    80003874:	bac080e7          	jalr	-1108(ra) # 8000641c <acquire>
    log.committing = 0;
    80003878:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    8000387c:	8526                	mv	a0,s1
    8000387e:	ffffe097          	auipc	ra,0xffffe
    80003882:	f90080e7          	jalr	-112(ra) # 8000180e <wakeup>
    release(&log.lock);
    80003886:	8526                	mv	a0,s1
    80003888:	00003097          	auipc	ra,0x3
    8000388c:	c48080e7          	jalr	-952(ra) # 800064d0 <release>
}
    80003890:	70e2                	ld	ra,56(sp)
    80003892:	7442                	ld	s0,48(sp)
    80003894:	74a2                	ld	s1,40(sp)
    80003896:	7902                	ld	s2,32(sp)
    80003898:	69e2                	ld	s3,24(sp)
    8000389a:	6a42                	ld	s4,16(sp)
    8000389c:	6aa2                	ld	s5,8(sp)
    8000389e:	6121                	addi	sp,sp,64
    800038a0:	8082                	ret
    panic("log.committing");
    800038a2:	00005517          	auipc	a0,0x5
    800038a6:	ec650513          	addi	a0,a0,-314 # 80008768 <syscalls+0x1e0>
    800038aa:	00002097          	auipc	ra,0x2
    800038ae:	628080e7          	jalr	1576(ra) # 80005ed2 <panic>
    wakeup(&log);
    800038b2:	00035497          	auipc	s1,0x35
    800038b6:	1f648493          	addi	s1,s1,502 # 80038aa8 <log>
    800038ba:	8526                	mv	a0,s1
    800038bc:	ffffe097          	auipc	ra,0xffffe
    800038c0:	f52080e7          	jalr	-174(ra) # 8000180e <wakeup>
  release(&log.lock);
    800038c4:	8526                	mv	a0,s1
    800038c6:	00003097          	auipc	ra,0x3
    800038ca:	c0a080e7          	jalr	-1014(ra) # 800064d0 <release>
  if(do_commit){
    800038ce:	b7c9                	j	80003890 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038d0:	00035a97          	auipc	s5,0x35
    800038d4:	208a8a93          	addi	s5,s5,520 # 80038ad8 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800038d8:	00035a17          	auipc	s4,0x35
    800038dc:	1d0a0a13          	addi	s4,s4,464 # 80038aa8 <log>
    800038e0:	018a2583          	lw	a1,24(s4)
    800038e4:	012585bb          	addw	a1,a1,s2
    800038e8:	2585                	addiw	a1,a1,1
    800038ea:	028a2503          	lw	a0,40(s4)
    800038ee:	fffff097          	auipc	ra,0xfffff
    800038f2:	cca080e7          	jalr	-822(ra) # 800025b8 <bread>
    800038f6:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800038f8:	000aa583          	lw	a1,0(s5)
    800038fc:	028a2503          	lw	a0,40(s4)
    80003900:	fffff097          	auipc	ra,0xfffff
    80003904:	cb8080e7          	jalr	-840(ra) # 800025b8 <bread>
    80003908:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000390a:	40000613          	li	a2,1024
    8000390e:	05850593          	addi	a1,a0,88
    80003912:	05848513          	addi	a0,s1,88
    80003916:	ffffd097          	auipc	ra,0xffffd
    8000391a:	9ce080e7          	jalr	-1586(ra) # 800002e4 <memmove>
    bwrite(to);  // write the log
    8000391e:	8526                	mv	a0,s1
    80003920:	fffff097          	auipc	ra,0xfffff
    80003924:	d8a080e7          	jalr	-630(ra) # 800026aa <bwrite>
    brelse(from);
    80003928:	854e                	mv	a0,s3
    8000392a:	fffff097          	auipc	ra,0xfffff
    8000392e:	dbe080e7          	jalr	-578(ra) # 800026e8 <brelse>
    brelse(to);
    80003932:	8526                	mv	a0,s1
    80003934:	fffff097          	auipc	ra,0xfffff
    80003938:	db4080e7          	jalr	-588(ra) # 800026e8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000393c:	2905                	addiw	s2,s2,1
    8000393e:	0a91                	addi	s5,s5,4
    80003940:	02ca2783          	lw	a5,44(s4)
    80003944:	f8f94ee3          	blt	s2,a5,800038e0 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003948:	00000097          	auipc	ra,0x0
    8000394c:	c6a080e7          	jalr	-918(ra) # 800035b2 <write_head>
    install_trans(0); // Now install writes to home locations
    80003950:	4501                	li	a0,0
    80003952:	00000097          	auipc	ra,0x0
    80003956:	cda080e7          	jalr	-806(ra) # 8000362c <install_trans>
    log.lh.n = 0;
    8000395a:	00035797          	auipc	a5,0x35
    8000395e:	1607ad23          	sw	zero,378(a5) # 80038ad4 <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003962:	00000097          	auipc	ra,0x0
    80003966:	c50080e7          	jalr	-944(ra) # 800035b2 <write_head>
    8000396a:	bdf5                	j	80003866 <end_op+0x52>

000000008000396c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000396c:	1101                	addi	sp,sp,-32
    8000396e:	ec06                	sd	ra,24(sp)
    80003970:	e822                	sd	s0,16(sp)
    80003972:	e426                	sd	s1,8(sp)
    80003974:	e04a                	sd	s2,0(sp)
    80003976:	1000                	addi	s0,sp,32
    80003978:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000397a:	00035917          	auipc	s2,0x35
    8000397e:	12e90913          	addi	s2,s2,302 # 80038aa8 <log>
    80003982:	854a                	mv	a0,s2
    80003984:	00003097          	auipc	ra,0x3
    80003988:	a98080e7          	jalr	-1384(ra) # 8000641c <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000398c:	02c92603          	lw	a2,44(s2)
    80003990:	47f5                	li	a5,29
    80003992:	06c7c563          	blt	a5,a2,800039fc <log_write+0x90>
    80003996:	00035797          	auipc	a5,0x35
    8000399a:	12e7a783          	lw	a5,302(a5) # 80038ac4 <log+0x1c>
    8000399e:	37fd                	addiw	a5,a5,-1
    800039a0:	04f65e63          	bge	a2,a5,800039fc <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800039a4:	00035797          	auipc	a5,0x35
    800039a8:	1247a783          	lw	a5,292(a5) # 80038ac8 <log+0x20>
    800039ac:	06f05063          	blez	a5,80003a0c <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800039b0:	4781                	li	a5,0
    800039b2:	06c05563          	blez	a2,80003a1c <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800039b6:	44cc                	lw	a1,12(s1)
    800039b8:	00035717          	auipc	a4,0x35
    800039bc:	12070713          	addi	a4,a4,288 # 80038ad8 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800039c0:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800039c2:	4314                	lw	a3,0(a4)
    800039c4:	04b68c63          	beq	a3,a1,80003a1c <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800039c8:	2785                	addiw	a5,a5,1
    800039ca:	0711                	addi	a4,a4,4
    800039cc:	fef61be3          	bne	a2,a5,800039c2 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800039d0:	0621                	addi	a2,a2,8
    800039d2:	060a                	slli	a2,a2,0x2
    800039d4:	00035797          	auipc	a5,0x35
    800039d8:	0d478793          	addi	a5,a5,212 # 80038aa8 <log>
    800039dc:	963e                	add	a2,a2,a5
    800039de:	44dc                	lw	a5,12(s1)
    800039e0:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800039e2:	8526                	mv	a0,s1
    800039e4:	fffff097          	auipc	ra,0xfffff
    800039e8:	da2080e7          	jalr	-606(ra) # 80002786 <bpin>
    log.lh.n++;
    800039ec:	00035717          	auipc	a4,0x35
    800039f0:	0bc70713          	addi	a4,a4,188 # 80038aa8 <log>
    800039f4:	575c                	lw	a5,44(a4)
    800039f6:	2785                	addiw	a5,a5,1
    800039f8:	d75c                	sw	a5,44(a4)
    800039fa:	a835                	j	80003a36 <log_write+0xca>
    panic("too big a transaction");
    800039fc:	00005517          	auipc	a0,0x5
    80003a00:	d7c50513          	addi	a0,a0,-644 # 80008778 <syscalls+0x1f0>
    80003a04:	00002097          	auipc	ra,0x2
    80003a08:	4ce080e7          	jalr	1230(ra) # 80005ed2 <panic>
    panic("log_write outside of trans");
    80003a0c:	00005517          	auipc	a0,0x5
    80003a10:	d8450513          	addi	a0,a0,-636 # 80008790 <syscalls+0x208>
    80003a14:	00002097          	auipc	ra,0x2
    80003a18:	4be080e7          	jalr	1214(ra) # 80005ed2 <panic>
  log.lh.block[i] = b->blockno;
    80003a1c:	00878713          	addi	a4,a5,8
    80003a20:	00271693          	slli	a3,a4,0x2
    80003a24:	00035717          	auipc	a4,0x35
    80003a28:	08470713          	addi	a4,a4,132 # 80038aa8 <log>
    80003a2c:	9736                	add	a4,a4,a3
    80003a2e:	44d4                	lw	a3,12(s1)
    80003a30:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003a32:	faf608e3          	beq	a2,a5,800039e2 <log_write+0x76>
  }
  release(&log.lock);
    80003a36:	00035517          	auipc	a0,0x35
    80003a3a:	07250513          	addi	a0,a0,114 # 80038aa8 <log>
    80003a3e:	00003097          	auipc	ra,0x3
    80003a42:	a92080e7          	jalr	-1390(ra) # 800064d0 <release>
}
    80003a46:	60e2                	ld	ra,24(sp)
    80003a48:	6442                	ld	s0,16(sp)
    80003a4a:	64a2                	ld	s1,8(sp)
    80003a4c:	6902                	ld	s2,0(sp)
    80003a4e:	6105                	addi	sp,sp,32
    80003a50:	8082                	ret

0000000080003a52 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003a52:	1101                	addi	sp,sp,-32
    80003a54:	ec06                	sd	ra,24(sp)
    80003a56:	e822                	sd	s0,16(sp)
    80003a58:	e426                	sd	s1,8(sp)
    80003a5a:	e04a                	sd	s2,0(sp)
    80003a5c:	1000                	addi	s0,sp,32
    80003a5e:	84aa                	mv	s1,a0
    80003a60:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003a62:	00005597          	auipc	a1,0x5
    80003a66:	d4e58593          	addi	a1,a1,-690 # 800087b0 <syscalls+0x228>
    80003a6a:	0521                	addi	a0,a0,8
    80003a6c:	00003097          	auipc	ra,0x3
    80003a70:	920080e7          	jalr	-1760(ra) # 8000638c <initlock>
  lk->name = name;
    80003a74:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003a78:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a7c:	0204a423          	sw	zero,40(s1)
}
    80003a80:	60e2                	ld	ra,24(sp)
    80003a82:	6442                	ld	s0,16(sp)
    80003a84:	64a2                	ld	s1,8(sp)
    80003a86:	6902                	ld	s2,0(sp)
    80003a88:	6105                	addi	sp,sp,32
    80003a8a:	8082                	ret

0000000080003a8c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a8c:	1101                	addi	sp,sp,-32
    80003a8e:	ec06                	sd	ra,24(sp)
    80003a90:	e822                	sd	s0,16(sp)
    80003a92:	e426                	sd	s1,8(sp)
    80003a94:	e04a                	sd	s2,0(sp)
    80003a96:	1000                	addi	s0,sp,32
    80003a98:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a9a:	00850913          	addi	s2,a0,8
    80003a9e:	854a                	mv	a0,s2
    80003aa0:	00003097          	auipc	ra,0x3
    80003aa4:	97c080e7          	jalr	-1668(ra) # 8000641c <acquire>
  while (lk->locked) {
    80003aa8:	409c                	lw	a5,0(s1)
    80003aaa:	cb89                	beqz	a5,80003abc <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003aac:	85ca                	mv	a1,s2
    80003aae:	8526                	mv	a0,s1
    80003ab0:	ffffe097          	auipc	ra,0xffffe
    80003ab4:	cfa080e7          	jalr	-774(ra) # 800017aa <sleep>
  while (lk->locked) {
    80003ab8:	409c                	lw	a5,0(s1)
    80003aba:	fbed                	bnez	a5,80003aac <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003abc:	4785                	li	a5,1
    80003abe:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003ac0:	ffffd097          	auipc	ra,0xffffd
    80003ac4:	642080e7          	jalr	1602(ra) # 80001102 <myproc>
    80003ac8:	591c                	lw	a5,48(a0)
    80003aca:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003acc:	854a                	mv	a0,s2
    80003ace:	00003097          	auipc	ra,0x3
    80003ad2:	a02080e7          	jalr	-1534(ra) # 800064d0 <release>
}
    80003ad6:	60e2                	ld	ra,24(sp)
    80003ad8:	6442                	ld	s0,16(sp)
    80003ada:	64a2                	ld	s1,8(sp)
    80003adc:	6902                	ld	s2,0(sp)
    80003ade:	6105                	addi	sp,sp,32
    80003ae0:	8082                	ret

0000000080003ae2 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003ae2:	1101                	addi	sp,sp,-32
    80003ae4:	ec06                	sd	ra,24(sp)
    80003ae6:	e822                	sd	s0,16(sp)
    80003ae8:	e426                	sd	s1,8(sp)
    80003aea:	e04a                	sd	s2,0(sp)
    80003aec:	1000                	addi	s0,sp,32
    80003aee:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003af0:	00850913          	addi	s2,a0,8
    80003af4:	854a                	mv	a0,s2
    80003af6:	00003097          	auipc	ra,0x3
    80003afa:	926080e7          	jalr	-1754(ra) # 8000641c <acquire>
  lk->locked = 0;
    80003afe:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003b02:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003b06:	8526                	mv	a0,s1
    80003b08:	ffffe097          	auipc	ra,0xffffe
    80003b0c:	d06080e7          	jalr	-762(ra) # 8000180e <wakeup>
  release(&lk->lk);
    80003b10:	854a                	mv	a0,s2
    80003b12:	00003097          	auipc	ra,0x3
    80003b16:	9be080e7          	jalr	-1602(ra) # 800064d0 <release>
}
    80003b1a:	60e2                	ld	ra,24(sp)
    80003b1c:	6442                	ld	s0,16(sp)
    80003b1e:	64a2                	ld	s1,8(sp)
    80003b20:	6902                	ld	s2,0(sp)
    80003b22:	6105                	addi	sp,sp,32
    80003b24:	8082                	ret

0000000080003b26 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003b26:	7179                	addi	sp,sp,-48
    80003b28:	f406                	sd	ra,40(sp)
    80003b2a:	f022                	sd	s0,32(sp)
    80003b2c:	ec26                	sd	s1,24(sp)
    80003b2e:	e84a                	sd	s2,16(sp)
    80003b30:	e44e                	sd	s3,8(sp)
    80003b32:	1800                	addi	s0,sp,48
    80003b34:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003b36:	00850913          	addi	s2,a0,8
    80003b3a:	854a                	mv	a0,s2
    80003b3c:	00003097          	auipc	ra,0x3
    80003b40:	8e0080e7          	jalr	-1824(ra) # 8000641c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b44:	409c                	lw	a5,0(s1)
    80003b46:	ef99                	bnez	a5,80003b64 <holdingsleep+0x3e>
    80003b48:	4481                	li	s1,0
  release(&lk->lk);
    80003b4a:	854a                	mv	a0,s2
    80003b4c:	00003097          	auipc	ra,0x3
    80003b50:	984080e7          	jalr	-1660(ra) # 800064d0 <release>
  return r;
}
    80003b54:	8526                	mv	a0,s1
    80003b56:	70a2                	ld	ra,40(sp)
    80003b58:	7402                	ld	s0,32(sp)
    80003b5a:	64e2                	ld	s1,24(sp)
    80003b5c:	6942                	ld	s2,16(sp)
    80003b5e:	69a2                	ld	s3,8(sp)
    80003b60:	6145                	addi	sp,sp,48
    80003b62:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b64:	0284a983          	lw	s3,40(s1)
    80003b68:	ffffd097          	auipc	ra,0xffffd
    80003b6c:	59a080e7          	jalr	1434(ra) # 80001102 <myproc>
    80003b70:	5904                	lw	s1,48(a0)
    80003b72:	413484b3          	sub	s1,s1,s3
    80003b76:	0014b493          	seqz	s1,s1
    80003b7a:	bfc1                	j	80003b4a <holdingsleep+0x24>

0000000080003b7c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003b7c:	1141                	addi	sp,sp,-16
    80003b7e:	e406                	sd	ra,8(sp)
    80003b80:	e022                	sd	s0,0(sp)
    80003b82:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003b84:	00005597          	auipc	a1,0x5
    80003b88:	c3c58593          	addi	a1,a1,-964 # 800087c0 <syscalls+0x238>
    80003b8c:	00035517          	auipc	a0,0x35
    80003b90:	06450513          	addi	a0,a0,100 # 80038bf0 <ftable>
    80003b94:	00002097          	auipc	ra,0x2
    80003b98:	7f8080e7          	jalr	2040(ra) # 8000638c <initlock>
}
    80003b9c:	60a2                	ld	ra,8(sp)
    80003b9e:	6402                	ld	s0,0(sp)
    80003ba0:	0141                	addi	sp,sp,16
    80003ba2:	8082                	ret

0000000080003ba4 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003ba4:	1101                	addi	sp,sp,-32
    80003ba6:	ec06                	sd	ra,24(sp)
    80003ba8:	e822                	sd	s0,16(sp)
    80003baa:	e426                	sd	s1,8(sp)
    80003bac:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003bae:	00035517          	auipc	a0,0x35
    80003bb2:	04250513          	addi	a0,a0,66 # 80038bf0 <ftable>
    80003bb6:	00003097          	auipc	ra,0x3
    80003bba:	866080e7          	jalr	-1946(ra) # 8000641c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003bbe:	00035497          	auipc	s1,0x35
    80003bc2:	04a48493          	addi	s1,s1,74 # 80038c08 <ftable+0x18>
    80003bc6:	00036717          	auipc	a4,0x36
    80003bca:	fe270713          	addi	a4,a4,-30 # 80039ba8 <disk>
    if(f->ref == 0){
    80003bce:	40dc                	lw	a5,4(s1)
    80003bd0:	cf99                	beqz	a5,80003bee <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003bd2:	02848493          	addi	s1,s1,40
    80003bd6:	fee49ce3          	bne	s1,a4,80003bce <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003bda:	00035517          	auipc	a0,0x35
    80003bde:	01650513          	addi	a0,a0,22 # 80038bf0 <ftable>
    80003be2:	00003097          	auipc	ra,0x3
    80003be6:	8ee080e7          	jalr	-1810(ra) # 800064d0 <release>
  return 0;
    80003bea:	4481                	li	s1,0
    80003bec:	a819                	j	80003c02 <filealloc+0x5e>
      f->ref = 1;
    80003bee:	4785                	li	a5,1
    80003bf0:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003bf2:	00035517          	auipc	a0,0x35
    80003bf6:	ffe50513          	addi	a0,a0,-2 # 80038bf0 <ftable>
    80003bfa:	00003097          	auipc	ra,0x3
    80003bfe:	8d6080e7          	jalr	-1834(ra) # 800064d0 <release>
}
    80003c02:	8526                	mv	a0,s1
    80003c04:	60e2                	ld	ra,24(sp)
    80003c06:	6442                	ld	s0,16(sp)
    80003c08:	64a2                	ld	s1,8(sp)
    80003c0a:	6105                	addi	sp,sp,32
    80003c0c:	8082                	ret

0000000080003c0e <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003c0e:	1101                	addi	sp,sp,-32
    80003c10:	ec06                	sd	ra,24(sp)
    80003c12:	e822                	sd	s0,16(sp)
    80003c14:	e426                	sd	s1,8(sp)
    80003c16:	1000                	addi	s0,sp,32
    80003c18:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003c1a:	00035517          	auipc	a0,0x35
    80003c1e:	fd650513          	addi	a0,a0,-42 # 80038bf0 <ftable>
    80003c22:	00002097          	auipc	ra,0x2
    80003c26:	7fa080e7          	jalr	2042(ra) # 8000641c <acquire>
  if(f->ref < 1)
    80003c2a:	40dc                	lw	a5,4(s1)
    80003c2c:	02f05263          	blez	a5,80003c50 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003c30:	2785                	addiw	a5,a5,1
    80003c32:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003c34:	00035517          	auipc	a0,0x35
    80003c38:	fbc50513          	addi	a0,a0,-68 # 80038bf0 <ftable>
    80003c3c:	00003097          	auipc	ra,0x3
    80003c40:	894080e7          	jalr	-1900(ra) # 800064d0 <release>
  return f;
}
    80003c44:	8526                	mv	a0,s1
    80003c46:	60e2                	ld	ra,24(sp)
    80003c48:	6442                	ld	s0,16(sp)
    80003c4a:	64a2                	ld	s1,8(sp)
    80003c4c:	6105                	addi	sp,sp,32
    80003c4e:	8082                	ret
    panic("filedup");
    80003c50:	00005517          	auipc	a0,0x5
    80003c54:	b7850513          	addi	a0,a0,-1160 # 800087c8 <syscalls+0x240>
    80003c58:	00002097          	auipc	ra,0x2
    80003c5c:	27a080e7          	jalr	634(ra) # 80005ed2 <panic>

0000000080003c60 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003c60:	7139                	addi	sp,sp,-64
    80003c62:	fc06                	sd	ra,56(sp)
    80003c64:	f822                	sd	s0,48(sp)
    80003c66:	f426                	sd	s1,40(sp)
    80003c68:	f04a                	sd	s2,32(sp)
    80003c6a:	ec4e                	sd	s3,24(sp)
    80003c6c:	e852                	sd	s4,16(sp)
    80003c6e:	e456                	sd	s5,8(sp)
    80003c70:	0080                	addi	s0,sp,64
    80003c72:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003c74:	00035517          	auipc	a0,0x35
    80003c78:	f7c50513          	addi	a0,a0,-132 # 80038bf0 <ftable>
    80003c7c:	00002097          	auipc	ra,0x2
    80003c80:	7a0080e7          	jalr	1952(ra) # 8000641c <acquire>
  if(f->ref < 1)
    80003c84:	40dc                	lw	a5,4(s1)
    80003c86:	06f05163          	blez	a5,80003ce8 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003c8a:	37fd                	addiw	a5,a5,-1
    80003c8c:	0007871b          	sext.w	a4,a5
    80003c90:	c0dc                	sw	a5,4(s1)
    80003c92:	06e04363          	bgtz	a4,80003cf8 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c96:	0004a903          	lw	s2,0(s1)
    80003c9a:	0094ca83          	lbu	s5,9(s1)
    80003c9e:	0104ba03          	ld	s4,16(s1)
    80003ca2:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003ca6:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003caa:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003cae:	00035517          	auipc	a0,0x35
    80003cb2:	f4250513          	addi	a0,a0,-190 # 80038bf0 <ftable>
    80003cb6:	00003097          	auipc	ra,0x3
    80003cba:	81a080e7          	jalr	-2022(ra) # 800064d0 <release>

  if(ff.type == FD_PIPE){
    80003cbe:	4785                	li	a5,1
    80003cc0:	04f90d63          	beq	s2,a5,80003d1a <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003cc4:	3979                	addiw	s2,s2,-2
    80003cc6:	4785                	li	a5,1
    80003cc8:	0527e063          	bltu	a5,s2,80003d08 <fileclose+0xa8>
    begin_op();
    80003ccc:	00000097          	auipc	ra,0x0
    80003cd0:	ac8080e7          	jalr	-1336(ra) # 80003794 <begin_op>
    iput(ff.ip);
    80003cd4:	854e                	mv	a0,s3
    80003cd6:	fffff097          	auipc	ra,0xfffff
    80003cda:	2b6080e7          	jalr	694(ra) # 80002f8c <iput>
    end_op();
    80003cde:	00000097          	auipc	ra,0x0
    80003ce2:	b36080e7          	jalr	-1226(ra) # 80003814 <end_op>
    80003ce6:	a00d                	j	80003d08 <fileclose+0xa8>
    panic("fileclose");
    80003ce8:	00005517          	auipc	a0,0x5
    80003cec:	ae850513          	addi	a0,a0,-1304 # 800087d0 <syscalls+0x248>
    80003cf0:	00002097          	auipc	ra,0x2
    80003cf4:	1e2080e7          	jalr	482(ra) # 80005ed2 <panic>
    release(&ftable.lock);
    80003cf8:	00035517          	auipc	a0,0x35
    80003cfc:	ef850513          	addi	a0,a0,-264 # 80038bf0 <ftable>
    80003d00:	00002097          	auipc	ra,0x2
    80003d04:	7d0080e7          	jalr	2000(ra) # 800064d0 <release>
  }
}
    80003d08:	70e2                	ld	ra,56(sp)
    80003d0a:	7442                	ld	s0,48(sp)
    80003d0c:	74a2                	ld	s1,40(sp)
    80003d0e:	7902                	ld	s2,32(sp)
    80003d10:	69e2                	ld	s3,24(sp)
    80003d12:	6a42                	ld	s4,16(sp)
    80003d14:	6aa2                	ld	s5,8(sp)
    80003d16:	6121                	addi	sp,sp,64
    80003d18:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003d1a:	85d6                	mv	a1,s5
    80003d1c:	8552                	mv	a0,s4
    80003d1e:	00000097          	auipc	ra,0x0
    80003d22:	34c080e7          	jalr	844(ra) # 8000406a <pipeclose>
    80003d26:	b7cd                	j	80003d08 <fileclose+0xa8>

0000000080003d28 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003d28:	715d                	addi	sp,sp,-80
    80003d2a:	e486                	sd	ra,72(sp)
    80003d2c:	e0a2                	sd	s0,64(sp)
    80003d2e:	fc26                	sd	s1,56(sp)
    80003d30:	f84a                	sd	s2,48(sp)
    80003d32:	f44e                	sd	s3,40(sp)
    80003d34:	0880                	addi	s0,sp,80
    80003d36:	84aa                	mv	s1,a0
    80003d38:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003d3a:	ffffd097          	auipc	ra,0xffffd
    80003d3e:	3c8080e7          	jalr	968(ra) # 80001102 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003d42:	409c                	lw	a5,0(s1)
    80003d44:	37f9                	addiw	a5,a5,-2
    80003d46:	4705                	li	a4,1
    80003d48:	04f76763          	bltu	a4,a5,80003d96 <filestat+0x6e>
    80003d4c:	892a                	mv	s2,a0
    ilock(f->ip);
    80003d4e:	6c88                	ld	a0,24(s1)
    80003d50:	fffff097          	auipc	ra,0xfffff
    80003d54:	082080e7          	jalr	130(ra) # 80002dd2 <ilock>
    stati(f->ip, &st);
    80003d58:	fb840593          	addi	a1,s0,-72
    80003d5c:	6c88                	ld	a0,24(s1)
    80003d5e:	fffff097          	auipc	ra,0xfffff
    80003d62:	2fe080e7          	jalr	766(ra) # 8000305c <stati>
    iunlock(f->ip);
    80003d66:	6c88                	ld	a0,24(s1)
    80003d68:	fffff097          	auipc	ra,0xfffff
    80003d6c:	12c080e7          	jalr	300(ra) # 80002e94 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d70:	46e1                	li	a3,24
    80003d72:	fb840613          	addi	a2,s0,-72
    80003d76:	85ce                	mv	a1,s3
    80003d78:	05093503          	ld	a0,80(s2)
    80003d7c:	ffffd097          	auipc	ra,0xffffd
    80003d80:	fcc080e7          	jalr	-52(ra) # 80000d48 <copyout>
    80003d84:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003d88:	60a6                	ld	ra,72(sp)
    80003d8a:	6406                	ld	s0,64(sp)
    80003d8c:	74e2                	ld	s1,56(sp)
    80003d8e:	7942                	ld	s2,48(sp)
    80003d90:	79a2                	ld	s3,40(sp)
    80003d92:	6161                	addi	sp,sp,80
    80003d94:	8082                	ret
  return -1;
    80003d96:	557d                	li	a0,-1
    80003d98:	bfc5                	j	80003d88 <filestat+0x60>

0000000080003d9a <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d9a:	7179                	addi	sp,sp,-48
    80003d9c:	f406                	sd	ra,40(sp)
    80003d9e:	f022                	sd	s0,32(sp)
    80003da0:	ec26                	sd	s1,24(sp)
    80003da2:	e84a                	sd	s2,16(sp)
    80003da4:	e44e                	sd	s3,8(sp)
    80003da6:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003da8:	00854783          	lbu	a5,8(a0)
    80003dac:	c3d5                	beqz	a5,80003e50 <fileread+0xb6>
    80003dae:	84aa                	mv	s1,a0
    80003db0:	89ae                	mv	s3,a1
    80003db2:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003db4:	411c                	lw	a5,0(a0)
    80003db6:	4705                	li	a4,1
    80003db8:	04e78963          	beq	a5,a4,80003e0a <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003dbc:	470d                	li	a4,3
    80003dbe:	04e78d63          	beq	a5,a4,80003e18 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003dc2:	4709                	li	a4,2
    80003dc4:	06e79e63          	bne	a5,a4,80003e40 <fileread+0xa6>
    ilock(f->ip);
    80003dc8:	6d08                	ld	a0,24(a0)
    80003dca:	fffff097          	auipc	ra,0xfffff
    80003dce:	008080e7          	jalr	8(ra) # 80002dd2 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003dd2:	874a                	mv	a4,s2
    80003dd4:	5094                	lw	a3,32(s1)
    80003dd6:	864e                	mv	a2,s3
    80003dd8:	4585                	li	a1,1
    80003dda:	6c88                	ld	a0,24(s1)
    80003ddc:	fffff097          	auipc	ra,0xfffff
    80003de0:	2aa080e7          	jalr	682(ra) # 80003086 <readi>
    80003de4:	892a                	mv	s2,a0
    80003de6:	00a05563          	blez	a0,80003df0 <fileread+0x56>
      f->off += r;
    80003dea:	509c                	lw	a5,32(s1)
    80003dec:	9fa9                	addw	a5,a5,a0
    80003dee:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003df0:	6c88                	ld	a0,24(s1)
    80003df2:	fffff097          	auipc	ra,0xfffff
    80003df6:	0a2080e7          	jalr	162(ra) # 80002e94 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003dfa:	854a                	mv	a0,s2
    80003dfc:	70a2                	ld	ra,40(sp)
    80003dfe:	7402                	ld	s0,32(sp)
    80003e00:	64e2                	ld	s1,24(sp)
    80003e02:	6942                	ld	s2,16(sp)
    80003e04:	69a2                	ld	s3,8(sp)
    80003e06:	6145                	addi	sp,sp,48
    80003e08:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003e0a:	6908                	ld	a0,16(a0)
    80003e0c:	00000097          	auipc	ra,0x0
    80003e10:	3ce080e7          	jalr	974(ra) # 800041da <piperead>
    80003e14:	892a                	mv	s2,a0
    80003e16:	b7d5                	j	80003dfa <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003e18:	02451783          	lh	a5,36(a0)
    80003e1c:	03079693          	slli	a3,a5,0x30
    80003e20:	92c1                	srli	a3,a3,0x30
    80003e22:	4725                	li	a4,9
    80003e24:	02d76863          	bltu	a4,a3,80003e54 <fileread+0xba>
    80003e28:	0792                	slli	a5,a5,0x4
    80003e2a:	00035717          	auipc	a4,0x35
    80003e2e:	d2670713          	addi	a4,a4,-730 # 80038b50 <devsw>
    80003e32:	97ba                	add	a5,a5,a4
    80003e34:	639c                	ld	a5,0(a5)
    80003e36:	c38d                	beqz	a5,80003e58 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003e38:	4505                	li	a0,1
    80003e3a:	9782                	jalr	a5
    80003e3c:	892a                	mv	s2,a0
    80003e3e:	bf75                	j	80003dfa <fileread+0x60>
    panic("fileread");
    80003e40:	00005517          	auipc	a0,0x5
    80003e44:	9a050513          	addi	a0,a0,-1632 # 800087e0 <syscalls+0x258>
    80003e48:	00002097          	auipc	ra,0x2
    80003e4c:	08a080e7          	jalr	138(ra) # 80005ed2 <panic>
    return -1;
    80003e50:	597d                	li	s2,-1
    80003e52:	b765                	j	80003dfa <fileread+0x60>
      return -1;
    80003e54:	597d                	li	s2,-1
    80003e56:	b755                	j	80003dfa <fileread+0x60>
    80003e58:	597d                	li	s2,-1
    80003e5a:	b745                	j	80003dfa <fileread+0x60>

0000000080003e5c <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003e5c:	715d                	addi	sp,sp,-80
    80003e5e:	e486                	sd	ra,72(sp)
    80003e60:	e0a2                	sd	s0,64(sp)
    80003e62:	fc26                	sd	s1,56(sp)
    80003e64:	f84a                	sd	s2,48(sp)
    80003e66:	f44e                	sd	s3,40(sp)
    80003e68:	f052                	sd	s4,32(sp)
    80003e6a:	ec56                	sd	s5,24(sp)
    80003e6c:	e85a                	sd	s6,16(sp)
    80003e6e:	e45e                	sd	s7,8(sp)
    80003e70:	e062                	sd	s8,0(sp)
    80003e72:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003e74:	00954783          	lbu	a5,9(a0)
    80003e78:	10078663          	beqz	a5,80003f84 <filewrite+0x128>
    80003e7c:	892a                	mv	s2,a0
    80003e7e:	8aae                	mv	s5,a1
    80003e80:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e82:	411c                	lw	a5,0(a0)
    80003e84:	4705                	li	a4,1
    80003e86:	02e78263          	beq	a5,a4,80003eaa <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e8a:	470d                	li	a4,3
    80003e8c:	02e78663          	beq	a5,a4,80003eb8 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e90:	4709                	li	a4,2
    80003e92:	0ee79163          	bne	a5,a4,80003f74 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e96:	0ac05d63          	blez	a2,80003f50 <filewrite+0xf4>
    int i = 0;
    80003e9a:	4981                	li	s3,0
    80003e9c:	6b05                	lui	s6,0x1
    80003e9e:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003ea2:	6b85                	lui	s7,0x1
    80003ea4:	c00b8b9b          	addiw	s7,s7,-1024
    80003ea8:	a861                	j	80003f40 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003eaa:	6908                	ld	a0,16(a0)
    80003eac:	00000097          	auipc	ra,0x0
    80003eb0:	22e080e7          	jalr	558(ra) # 800040da <pipewrite>
    80003eb4:	8a2a                	mv	s4,a0
    80003eb6:	a045                	j	80003f56 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003eb8:	02451783          	lh	a5,36(a0)
    80003ebc:	03079693          	slli	a3,a5,0x30
    80003ec0:	92c1                	srli	a3,a3,0x30
    80003ec2:	4725                	li	a4,9
    80003ec4:	0cd76263          	bltu	a4,a3,80003f88 <filewrite+0x12c>
    80003ec8:	0792                	slli	a5,a5,0x4
    80003eca:	00035717          	auipc	a4,0x35
    80003ece:	c8670713          	addi	a4,a4,-890 # 80038b50 <devsw>
    80003ed2:	97ba                	add	a5,a5,a4
    80003ed4:	679c                	ld	a5,8(a5)
    80003ed6:	cbdd                	beqz	a5,80003f8c <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003ed8:	4505                	li	a0,1
    80003eda:	9782                	jalr	a5
    80003edc:	8a2a                	mv	s4,a0
    80003ede:	a8a5                	j	80003f56 <filewrite+0xfa>
    80003ee0:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003ee4:	00000097          	auipc	ra,0x0
    80003ee8:	8b0080e7          	jalr	-1872(ra) # 80003794 <begin_op>
      ilock(f->ip);
    80003eec:	01893503          	ld	a0,24(s2)
    80003ef0:	fffff097          	auipc	ra,0xfffff
    80003ef4:	ee2080e7          	jalr	-286(ra) # 80002dd2 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003ef8:	8762                	mv	a4,s8
    80003efa:	02092683          	lw	a3,32(s2)
    80003efe:	01598633          	add	a2,s3,s5
    80003f02:	4585                	li	a1,1
    80003f04:	01893503          	ld	a0,24(s2)
    80003f08:	fffff097          	auipc	ra,0xfffff
    80003f0c:	276080e7          	jalr	630(ra) # 8000317e <writei>
    80003f10:	84aa                	mv	s1,a0
    80003f12:	00a05763          	blez	a0,80003f20 <filewrite+0xc4>
        f->off += r;
    80003f16:	02092783          	lw	a5,32(s2)
    80003f1a:	9fa9                	addw	a5,a5,a0
    80003f1c:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003f20:	01893503          	ld	a0,24(s2)
    80003f24:	fffff097          	auipc	ra,0xfffff
    80003f28:	f70080e7          	jalr	-144(ra) # 80002e94 <iunlock>
      end_op();
    80003f2c:	00000097          	auipc	ra,0x0
    80003f30:	8e8080e7          	jalr	-1816(ra) # 80003814 <end_op>

      if(r != n1){
    80003f34:	009c1f63          	bne	s8,s1,80003f52 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003f38:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003f3c:	0149db63          	bge	s3,s4,80003f52 <filewrite+0xf6>
      int n1 = n - i;
    80003f40:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003f44:	84be                	mv	s1,a5
    80003f46:	2781                	sext.w	a5,a5
    80003f48:	f8fb5ce3          	bge	s6,a5,80003ee0 <filewrite+0x84>
    80003f4c:	84de                	mv	s1,s7
    80003f4e:	bf49                	j	80003ee0 <filewrite+0x84>
    int i = 0;
    80003f50:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003f52:	013a1f63          	bne	s4,s3,80003f70 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003f56:	8552                	mv	a0,s4
    80003f58:	60a6                	ld	ra,72(sp)
    80003f5a:	6406                	ld	s0,64(sp)
    80003f5c:	74e2                	ld	s1,56(sp)
    80003f5e:	7942                	ld	s2,48(sp)
    80003f60:	79a2                	ld	s3,40(sp)
    80003f62:	7a02                	ld	s4,32(sp)
    80003f64:	6ae2                	ld	s5,24(sp)
    80003f66:	6b42                	ld	s6,16(sp)
    80003f68:	6ba2                	ld	s7,8(sp)
    80003f6a:	6c02                	ld	s8,0(sp)
    80003f6c:	6161                	addi	sp,sp,80
    80003f6e:	8082                	ret
    ret = (i == n ? n : -1);
    80003f70:	5a7d                	li	s4,-1
    80003f72:	b7d5                	j	80003f56 <filewrite+0xfa>
    panic("filewrite");
    80003f74:	00005517          	auipc	a0,0x5
    80003f78:	87c50513          	addi	a0,a0,-1924 # 800087f0 <syscalls+0x268>
    80003f7c:	00002097          	auipc	ra,0x2
    80003f80:	f56080e7          	jalr	-170(ra) # 80005ed2 <panic>
    return -1;
    80003f84:	5a7d                	li	s4,-1
    80003f86:	bfc1                	j	80003f56 <filewrite+0xfa>
      return -1;
    80003f88:	5a7d                	li	s4,-1
    80003f8a:	b7f1                	j	80003f56 <filewrite+0xfa>
    80003f8c:	5a7d                	li	s4,-1
    80003f8e:	b7e1                	j	80003f56 <filewrite+0xfa>

0000000080003f90 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f90:	7179                	addi	sp,sp,-48
    80003f92:	f406                	sd	ra,40(sp)
    80003f94:	f022                	sd	s0,32(sp)
    80003f96:	ec26                	sd	s1,24(sp)
    80003f98:	e84a                	sd	s2,16(sp)
    80003f9a:	e44e                	sd	s3,8(sp)
    80003f9c:	e052                	sd	s4,0(sp)
    80003f9e:	1800                	addi	s0,sp,48
    80003fa0:	84aa                	mv	s1,a0
    80003fa2:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003fa4:	0005b023          	sd	zero,0(a1)
    80003fa8:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003fac:	00000097          	auipc	ra,0x0
    80003fb0:	bf8080e7          	jalr	-1032(ra) # 80003ba4 <filealloc>
    80003fb4:	e088                	sd	a0,0(s1)
    80003fb6:	c551                	beqz	a0,80004042 <pipealloc+0xb2>
    80003fb8:	00000097          	auipc	ra,0x0
    80003fbc:	bec080e7          	jalr	-1044(ra) # 80003ba4 <filealloc>
    80003fc0:	00aa3023          	sd	a0,0(s4)
    80003fc4:	c92d                	beqz	a0,80004036 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003fc6:	ffffc097          	auipc	ra,0xffffc
    80003fca:	23c080e7          	jalr	572(ra) # 80000202 <kalloc>
    80003fce:	892a                	mv	s2,a0
    80003fd0:	c125                	beqz	a0,80004030 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003fd2:	4985                	li	s3,1
    80003fd4:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003fd8:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003fdc:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003fe0:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003fe4:	00005597          	auipc	a1,0x5
    80003fe8:	81c58593          	addi	a1,a1,-2020 # 80008800 <syscalls+0x278>
    80003fec:	00002097          	auipc	ra,0x2
    80003ff0:	3a0080e7          	jalr	928(ra) # 8000638c <initlock>
  (*f0)->type = FD_PIPE;
    80003ff4:	609c                	ld	a5,0(s1)
    80003ff6:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003ffa:	609c                	ld	a5,0(s1)
    80003ffc:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80004000:	609c                	ld	a5,0(s1)
    80004002:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004006:	609c                	ld	a5,0(s1)
    80004008:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000400c:	000a3783          	ld	a5,0(s4)
    80004010:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004014:	000a3783          	ld	a5,0(s4)
    80004018:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000401c:	000a3783          	ld	a5,0(s4)
    80004020:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004024:	000a3783          	ld	a5,0(s4)
    80004028:	0127b823          	sd	s2,16(a5)
  return 0;
    8000402c:	4501                	li	a0,0
    8000402e:	a025                	j	80004056 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004030:	6088                	ld	a0,0(s1)
    80004032:	e501                	bnez	a0,8000403a <pipealloc+0xaa>
    80004034:	a039                	j	80004042 <pipealloc+0xb2>
    80004036:	6088                	ld	a0,0(s1)
    80004038:	c51d                	beqz	a0,80004066 <pipealloc+0xd6>
    fileclose(*f0);
    8000403a:	00000097          	auipc	ra,0x0
    8000403e:	c26080e7          	jalr	-986(ra) # 80003c60 <fileclose>
  if(*f1)
    80004042:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004046:	557d                	li	a0,-1
  if(*f1)
    80004048:	c799                	beqz	a5,80004056 <pipealloc+0xc6>
    fileclose(*f1);
    8000404a:	853e                	mv	a0,a5
    8000404c:	00000097          	auipc	ra,0x0
    80004050:	c14080e7          	jalr	-1004(ra) # 80003c60 <fileclose>
  return -1;
    80004054:	557d                	li	a0,-1
}
    80004056:	70a2                	ld	ra,40(sp)
    80004058:	7402                	ld	s0,32(sp)
    8000405a:	64e2                	ld	s1,24(sp)
    8000405c:	6942                	ld	s2,16(sp)
    8000405e:	69a2                	ld	s3,8(sp)
    80004060:	6a02                	ld	s4,0(sp)
    80004062:	6145                	addi	sp,sp,48
    80004064:	8082                	ret
  return -1;
    80004066:	557d                	li	a0,-1
    80004068:	b7fd                	j	80004056 <pipealloc+0xc6>

000000008000406a <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000406a:	1101                	addi	sp,sp,-32
    8000406c:	ec06                	sd	ra,24(sp)
    8000406e:	e822                	sd	s0,16(sp)
    80004070:	e426                	sd	s1,8(sp)
    80004072:	e04a                	sd	s2,0(sp)
    80004074:	1000                	addi	s0,sp,32
    80004076:	84aa                	mv	s1,a0
    80004078:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000407a:	00002097          	auipc	ra,0x2
    8000407e:	3a2080e7          	jalr	930(ra) # 8000641c <acquire>
  if(writable){
    80004082:	02090d63          	beqz	s2,800040bc <pipeclose+0x52>
    pi->writeopen = 0;
    80004086:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000408a:	21848513          	addi	a0,s1,536
    8000408e:	ffffd097          	auipc	ra,0xffffd
    80004092:	780080e7          	jalr	1920(ra) # 8000180e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004096:	2204b783          	ld	a5,544(s1)
    8000409a:	eb95                	bnez	a5,800040ce <pipeclose+0x64>
    release(&pi->lock);
    8000409c:	8526                	mv	a0,s1
    8000409e:	00002097          	auipc	ra,0x2
    800040a2:	432080e7          	jalr	1074(ra) # 800064d0 <release>
    kfree((char*)pi);
    800040a6:	8526                	mv	a0,s1
    800040a8:	ffffc097          	auipc	ra,0xffffc
    800040ac:	014080e7          	jalr	20(ra) # 800000bc <kfree>
  } else
    release(&pi->lock);
}
    800040b0:	60e2                	ld	ra,24(sp)
    800040b2:	6442                	ld	s0,16(sp)
    800040b4:	64a2                	ld	s1,8(sp)
    800040b6:	6902                	ld	s2,0(sp)
    800040b8:	6105                	addi	sp,sp,32
    800040ba:	8082                	ret
    pi->readopen = 0;
    800040bc:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800040c0:	21c48513          	addi	a0,s1,540
    800040c4:	ffffd097          	auipc	ra,0xffffd
    800040c8:	74a080e7          	jalr	1866(ra) # 8000180e <wakeup>
    800040cc:	b7e9                	j	80004096 <pipeclose+0x2c>
    release(&pi->lock);
    800040ce:	8526                	mv	a0,s1
    800040d0:	00002097          	auipc	ra,0x2
    800040d4:	400080e7          	jalr	1024(ra) # 800064d0 <release>
}
    800040d8:	bfe1                	j	800040b0 <pipeclose+0x46>

00000000800040da <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800040da:	7159                	addi	sp,sp,-112
    800040dc:	f486                	sd	ra,104(sp)
    800040de:	f0a2                	sd	s0,96(sp)
    800040e0:	eca6                	sd	s1,88(sp)
    800040e2:	e8ca                	sd	s2,80(sp)
    800040e4:	e4ce                	sd	s3,72(sp)
    800040e6:	e0d2                	sd	s4,64(sp)
    800040e8:	fc56                	sd	s5,56(sp)
    800040ea:	f85a                	sd	s6,48(sp)
    800040ec:	f45e                	sd	s7,40(sp)
    800040ee:	f062                	sd	s8,32(sp)
    800040f0:	ec66                	sd	s9,24(sp)
    800040f2:	1880                	addi	s0,sp,112
    800040f4:	84aa                	mv	s1,a0
    800040f6:	8aae                	mv	s5,a1
    800040f8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800040fa:	ffffd097          	auipc	ra,0xffffd
    800040fe:	008080e7          	jalr	8(ra) # 80001102 <myproc>
    80004102:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004104:	8526                	mv	a0,s1
    80004106:	00002097          	auipc	ra,0x2
    8000410a:	316080e7          	jalr	790(ra) # 8000641c <acquire>
  while(i < n){
    8000410e:	0d405463          	blez	s4,800041d6 <pipewrite+0xfc>
    80004112:	8ba6                	mv	s7,s1
  int i = 0;
    80004114:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004116:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004118:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    8000411c:	21c48c13          	addi	s8,s1,540
    80004120:	a08d                	j	80004182 <pipewrite+0xa8>
      release(&pi->lock);
    80004122:	8526                	mv	a0,s1
    80004124:	00002097          	auipc	ra,0x2
    80004128:	3ac080e7          	jalr	940(ra) # 800064d0 <release>
      return -1;
    8000412c:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000412e:	854a                	mv	a0,s2
    80004130:	70a6                	ld	ra,104(sp)
    80004132:	7406                	ld	s0,96(sp)
    80004134:	64e6                	ld	s1,88(sp)
    80004136:	6946                	ld	s2,80(sp)
    80004138:	69a6                	ld	s3,72(sp)
    8000413a:	6a06                	ld	s4,64(sp)
    8000413c:	7ae2                	ld	s5,56(sp)
    8000413e:	7b42                	ld	s6,48(sp)
    80004140:	7ba2                	ld	s7,40(sp)
    80004142:	7c02                	ld	s8,32(sp)
    80004144:	6ce2                	ld	s9,24(sp)
    80004146:	6165                	addi	sp,sp,112
    80004148:	8082                	ret
      wakeup(&pi->nread);
    8000414a:	8566                	mv	a0,s9
    8000414c:	ffffd097          	auipc	ra,0xffffd
    80004150:	6c2080e7          	jalr	1730(ra) # 8000180e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004154:	85de                	mv	a1,s7
    80004156:	8562                	mv	a0,s8
    80004158:	ffffd097          	auipc	ra,0xffffd
    8000415c:	652080e7          	jalr	1618(ra) # 800017aa <sleep>
    80004160:	a839                	j	8000417e <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004162:	21c4a783          	lw	a5,540(s1)
    80004166:	0017871b          	addiw	a4,a5,1
    8000416a:	20e4ae23          	sw	a4,540(s1)
    8000416e:	1ff7f793          	andi	a5,a5,511
    80004172:	97a6                	add	a5,a5,s1
    80004174:	f9f44703          	lbu	a4,-97(s0)
    80004178:	00e78c23          	sb	a4,24(a5)
      i++;
    8000417c:	2905                	addiw	s2,s2,1
  while(i < n){
    8000417e:	05495063          	bge	s2,s4,800041be <pipewrite+0xe4>
    if(pi->readopen == 0 || killed(pr)){
    80004182:	2204a783          	lw	a5,544(s1)
    80004186:	dfd1                	beqz	a5,80004122 <pipewrite+0x48>
    80004188:	854e                	mv	a0,s3
    8000418a:	ffffe097          	auipc	ra,0xffffe
    8000418e:	8c8080e7          	jalr	-1848(ra) # 80001a52 <killed>
    80004192:	f941                	bnez	a0,80004122 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004194:	2184a783          	lw	a5,536(s1)
    80004198:	21c4a703          	lw	a4,540(s1)
    8000419c:	2007879b          	addiw	a5,a5,512
    800041a0:	faf705e3          	beq	a4,a5,8000414a <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800041a4:	4685                	li	a3,1
    800041a6:	01590633          	add	a2,s2,s5
    800041aa:	f9f40593          	addi	a1,s0,-97
    800041ae:	0509b503          	ld	a0,80(s3)
    800041b2:	ffffd097          	auipc	ra,0xffffd
    800041b6:	c9a080e7          	jalr	-870(ra) # 80000e4c <copyin>
    800041ba:	fb6514e3          	bne	a0,s6,80004162 <pipewrite+0x88>
  wakeup(&pi->nread);
    800041be:	21848513          	addi	a0,s1,536
    800041c2:	ffffd097          	auipc	ra,0xffffd
    800041c6:	64c080e7          	jalr	1612(ra) # 8000180e <wakeup>
  release(&pi->lock);
    800041ca:	8526                	mv	a0,s1
    800041cc:	00002097          	auipc	ra,0x2
    800041d0:	304080e7          	jalr	772(ra) # 800064d0 <release>
  return i;
    800041d4:	bfa9                	j	8000412e <pipewrite+0x54>
  int i = 0;
    800041d6:	4901                	li	s2,0
    800041d8:	b7dd                	j	800041be <pipewrite+0xe4>

00000000800041da <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800041da:	715d                	addi	sp,sp,-80
    800041dc:	e486                	sd	ra,72(sp)
    800041de:	e0a2                	sd	s0,64(sp)
    800041e0:	fc26                	sd	s1,56(sp)
    800041e2:	f84a                	sd	s2,48(sp)
    800041e4:	f44e                	sd	s3,40(sp)
    800041e6:	f052                	sd	s4,32(sp)
    800041e8:	ec56                	sd	s5,24(sp)
    800041ea:	e85a                	sd	s6,16(sp)
    800041ec:	0880                	addi	s0,sp,80
    800041ee:	84aa                	mv	s1,a0
    800041f0:	892e                	mv	s2,a1
    800041f2:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800041f4:	ffffd097          	auipc	ra,0xffffd
    800041f8:	f0e080e7          	jalr	-242(ra) # 80001102 <myproc>
    800041fc:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800041fe:	8b26                	mv	s6,s1
    80004200:	8526                	mv	a0,s1
    80004202:	00002097          	auipc	ra,0x2
    80004206:	21a080e7          	jalr	538(ra) # 8000641c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000420a:	2184a703          	lw	a4,536(s1)
    8000420e:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004212:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004216:	02f71763          	bne	a4,a5,80004244 <piperead+0x6a>
    8000421a:	2244a783          	lw	a5,548(s1)
    8000421e:	c39d                	beqz	a5,80004244 <piperead+0x6a>
    if(killed(pr)){
    80004220:	8552                	mv	a0,s4
    80004222:	ffffe097          	auipc	ra,0xffffe
    80004226:	830080e7          	jalr	-2000(ra) # 80001a52 <killed>
    8000422a:	e941                	bnez	a0,800042ba <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000422c:	85da                	mv	a1,s6
    8000422e:	854e                	mv	a0,s3
    80004230:	ffffd097          	auipc	ra,0xffffd
    80004234:	57a080e7          	jalr	1402(ra) # 800017aa <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004238:	2184a703          	lw	a4,536(s1)
    8000423c:	21c4a783          	lw	a5,540(s1)
    80004240:	fcf70de3          	beq	a4,a5,8000421a <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004244:	09505263          	blez	s5,800042c8 <piperead+0xee>
    80004248:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000424a:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    8000424c:	2184a783          	lw	a5,536(s1)
    80004250:	21c4a703          	lw	a4,540(s1)
    80004254:	02f70d63          	beq	a4,a5,8000428e <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004258:	0017871b          	addiw	a4,a5,1
    8000425c:	20e4ac23          	sw	a4,536(s1)
    80004260:	1ff7f793          	andi	a5,a5,511
    80004264:	97a6                	add	a5,a5,s1
    80004266:	0187c783          	lbu	a5,24(a5)
    8000426a:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000426e:	4685                	li	a3,1
    80004270:	fbf40613          	addi	a2,s0,-65
    80004274:	85ca                	mv	a1,s2
    80004276:	050a3503          	ld	a0,80(s4)
    8000427a:	ffffd097          	auipc	ra,0xffffd
    8000427e:	ace080e7          	jalr	-1330(ra) # 80000d48 <copyout>
    80004282:	01650663          	beq	a0,s6,8000428e <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004286:	2985                	addiw	s3,s3,1
    80004288:	0905                	addi	s2,s2,1
    8000428a:	fd3a91e3          	bne	s5,s3,8000424c <piperead+0x72>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000428e:	21c48513          	addi	a0,s1,540
    80004292:	ffffd097          	auipc	ra,0xffffd
    80004296:	57c080e7          	jalr	1404(ra) # 8000180e <wakeup>
  release(&pi->lock);
    8000429a:	8526                	mv	a0,s1
    8000429c:	00002097          	auipc	ra,0x2
    800042a0:	234080e7          	jalr	564(ra) # 800064d0 <release>
  return i;
}
    800042a4:	854e                	mv	a0,s3
    800042a6:	60a6                	ld	ra,72(sp)
    800042a8:	6406                	ld	s0,64(sp)
    800042aa:	74e2                	ld	s1,56(sp)
    800042ac:	7942                	ld	s2,48(sp)
    800042ae:	79a2                	ld	s3,40(sp)
    800042b0:	7a02                	ld	s4,32(sp)
    800042b2:	6ae2                	ld	s5,24(sp)
    800042b4:	6b42                	ld	s6,16(sp)
    800042b6:	6161                	addi	sp,sp,80
    800042b8:	8082                	ret
      release(&pi->lock);
    800042ba:	8526                	mv	a0,s1
    800042bc:	00002097          	auipc	ra,0x2
    800042c0:	214080e7          	jalr	532(ra) # 800064d0 <release>
      return -1;
    800042c4:	59fd                	li	s3,-1
    800042c6:	bff9                	j	800042a4 <piperead+0xca>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800042c8:	4981                	li	s3,0
    800042ca:	b7d1                	j	8000428e <piperead+0xb4>

00000000800042cc <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800042cc:	1141                	addi	sp,sp,-16
    800042ce:	e422                	sd	s0,8(sp)
    800042d0:	0800                	addi	s0,sp,16
    800042d2:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800042d4:	8905                	andi	a0,a0,1
    800042d6:	c111                	beqz	a0,800042da <flags2perm+0xe>
      perm = PTE_X;
    800042d8:	4521                	li	a0,8
    if(flags & 0x2)
    800042da:	8b89                	andi	a5,a5,2
    800042dc:	c399                	beqz	a5,800042e2 <flags2perm+0x16>
      perm |= PTE_W;
    800042de:	00456513          	ori	a0,a0,4
    return perm;
}
    800042e2:	6422                	ld	s0,8(sp)
    800042e4:	0141                	addi	sp,sp,16
    800042e6:	8082                	ret

00000000800042e8 <exec>:

int
exec(char *path, char **argv)
{
    800042e8:	df010113          	addi	sp,sp,-528
    800042ec:	20113423          	sd	ra,520(sp)
    800042f0:	20813023          	sd	s0,512(sp)
    800042f4:	ffa6                	sd	s1,504(sp)
    800042f6:	fbca                	sd	s2,496(sp)
    800042f8:	f7ce                	sd	s3,488(sp)
    800042fa:	f3d2                	sd	s4,480(sp)
    800042fc:	efd6                	sd	s5,472(sp)
    800042fe:	ebda                	sd	s6,464(sp)
    80004300:	e7de                	sd	s7,456(sp)
    80004302:	e3e2                	sd	s8,448(sp)
    80004304:	ff66                	sd	s9,440(sp)
    80004306:	fb6a                	sd	s10,432(sp)
    80004308:	f76e                	sd	s11,424(sp)
    8000430a:	0c00                	addi	s0,sp,528
    8000430c:	84aa                	mv	s1,a0
    8000430e:	dea43c23          	sd	a0,-520(s0)
    80004312:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004316:	ffffd097          	auipc	ra,0xffffd
    8000431a:	dec080e7          	jalr	-532(ra) # 80001102 <myproc>
    8000431e:	892a                	mv	s2,a0

  begin_op();
    80004320:	fffff097          	auipc	ra,0xfffff
    80004324:	474080e7          	jalr	1140(ra) # 80003794 <begin_op>

  if((ip = namei(path)) == 0){
    80004328:	8526                	mv	a0,s1
    8000432a:	fffff097          	auipc	ra,0xfffff
    8000432e:	24e080e7          	jalr	590(ra) # 80003578 <namei>
    80004332:	c92d                	beqz	a0,800043a4 <exec+0xbc>
    80004334:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004336:	fffff097          	auipc	ra,0xfffff
    8000433a:	a9c080e7          	jalr	-1380(ra) # 80002dd2 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000433e:	04000713          	li	a4,64
    80004342:	4681                	li	a3,0
    80004344:	e5040613          	addi	a2,s0,-432
    80004348:	4581                	li	a1,0
    8000434a:	8526                	mv	a0,s1
    8000434c:	fffff097          	auipc	ra,0xfffff
    80004350:	d3a080e7          	jalr	-710(ra) # 80003086 <readi>
    80004354:	04000793          	li	a5,64
    80004358:	00f51a63          	bne	a0,a5,8000436c <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    8000435c:	e5042703          	lw	a4,-432(s0)
    80004360:	464c47b7          	lui	a5,0x464c4
    80004364:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004368:	04f70463          	beq	a4,a5,800043b0 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000436c:	8526                	mv	a0,s1
    8000436e:	fffff097          	auipc	ra,0xfffff
    80004372:	cc6080e7          	jalr	-826(ra) # 80003034 <iunlockput>
    end_op();
    80004376:	fffff097          	auipc	ra,0xfffff
    8000437a:	49e080e7          	jalr	1182(ra) # 80003814 <end_op>
  }
  return -1;
    8000437e:	557d                	li	a0,-1
}
    80004380:	20813083          	ld	ra,520(sp)
    80004384:	20013403          	ld	s0,512(sp)
    80004388:	74fe                	ld	s1,504(sp)
    8000438a:	795e                	ld	s2,496(sp)
    8000438c:	79be                	ld	s3,488(sp)
    8000438e:	7a1e                	ld	s4,480(sp)
    80004390:	6afe                	ld	s5,472(sp)
    80004392:	6b5e                	ld	s6,464(sp)
    80004394:	6bbe                	ld	s7,456(sp)
    80004396:	6c1e                	ld	s8,448(sp)
    80004398:	7cfa                	ld	s9,440(sp)
    8000439a:	7d5a                	ld	s10,432(sp)
    8000439c:	7dba                	ld	s11,424(sp)
    8000439e:	21010113          	addi	sp,sp,528
    800043a2:	8082                	ret
    end_op();
    800043a4:	fffff097          	auipc	ra,0xfffff
    800043a8:	470080e7          	jalr	1136(ra) # 80003814 <end_op>
    return -1;
    800043ac:	557d                	li	a0,-1
    800043ae:	bfc9                	j	80004380 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    800043b0:	854a                	mv	a0,s2
    800043b2:	ffffd097          	auipc	ra,0xffffd
    800043b6:	e18080e7          	jalr	-488(ra) # 800011ca <proc_pagetable>
    800043ba:	8baa                	mv	s7,a0
    800043bc:	d945                	beqz	a0,8000436c <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800043be:	e7042983          	lw	s3,-400(s0)
    800043c2:	e8845783          	lhu	a5,-376(s0)
    800043c6:	c7ad                	beqz	a5,80004430 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800043c8:	4a01                	li	s4,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800043ca:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    800043cc:	6c85                	lui	s9,0x1
    800043ce:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800043d2:	def43823          	sd	a5,-528(s0)
    800043d6:	ac0d                	j	80004608 <exec+0x320>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800043d8:	00004517          	auipc	a0,0x4
    800043dc:	43050513          	addi	a0,a0,1072 # 80008808 <syscalls+0x280>
    800043e0:	00002097          	auipc	ra,0x2
    800043e4:	af2080e7          	jalr	-1294(ra) # 80005ed2 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800043e8:	8756                	mv	a4,s5
    800043ea:	012d86bb          	addw	a3,s11,s2
    800043ee:	4581                	li	a1,0
    800043f0:	8526                	mv	a0,s1
    800043f2:	fffff097          	auipc	ra,0xfffff
    800043f6:	c94080e7          	jalr	-876(ra) # 80003086 <readi>
    800043fa:	2501                	sext.w	a0,a0
    800043fc:	1aaa9a63          	bne	s5,a0,800045b0 <exec+0x2c8>
  for(i = 0; i < sz; i += PGSIZE){
    80004400:	6785                	lui	a5,0x1
    80004402:	0127893b          	addw	s2,a5,s2
    80004406:	77fd                	lui	a5,0xfffff
    80004408:	01478a3b          	addw	s4,a5,s4
    8000440c:	1f897563          	bgeu	s2,s8,800045f6 <exec+0x30e>
    pa = walkaddr(pagetable, va + i);
    80004410:	02091593          	slli	a1,s2,0x20
    80004414:	9181                	srli	a1,a1,0x20
    80004416:	95ea                	add	a1,a1,s10
    80004418:	855e                	mv	a0,s7
    8000441a:	ffffc097          	auipc	ra,0xffffc
    8000441e:	23c080e7          	jalr	572(ra) # 80000656 <walkaddr>
    80004422:	862a                	mv	a2,a0
    if(pa == 0)
    80004424:	d955                	beqz	a0,800043d8 <exec+0xf0>
      n = PGSIZE;
    80004426:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    80004428:	fd9a70e3          	bgeu	s4,s9,800043e8 <exec+0x100>
      n = sz - i;
    8000442c:	8ad2                	mv	s5,s4
    8000442e:	bf6d                	j	800043e8 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004430:	4a01                	li	s4,0
  iunlockput(ip);
    80004432:	8526                	mv	a0,s1
    80004434:	fffff097          	auipc	ra,0xfffff
    80004438:	c00080e7          	jalr	-1024(ra) # 80003034 <iunlockput>
  end_op();
    8000443c:	fffff097          	auipc	ra,0xfffff
    80004440:	3d8080e7          	jalr	984(ra) # 80003814 <end_op>
  p = myproc();
    80004444:	ffffd097          	auipc	ra,0xffffd
    80004448:	cbe080e7          	jalr	-834(ra) # 80001102 <myproc>
    8000444c:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    8000444e:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004452:	6785                	lui	a5,0x1
    80004454:	17fd                	addi	a5,a5,-1
    80004456:	9a3e                	add	s4,s4,a5
    80004458:	757d                	lui	a0,0xfffff
    8000445a:	00aa77b3          	and	a5,s4,a0
    8000445e:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004462:	4691                	li	a3,4
    80004464:	6609                	lui	a2,0x2
    80004466:	963e                	add	a2,a2,a5
    80004468:	85be                	mv	a1,a5
    8000446a:	855e                	mv	a0,s7
    8000446c:	ffffc097          	auipc	ra,0xffffc
    80004470:	6a4080e7          	jalr	1700(ra) # 80000b10 <uvmalloc>
    80004474:	8b2a                	mv	s6,a0
  ip = 0;
    80004476:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004478:	12050c63          	beqz	a0,800045b0 <exec+0x2c8>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000447c:	75f9                	lui	a1,0xffffe
    8000447e:	95aa                	add	a1,a1,a0
    80004480:	855e                	mv	a0,s7
    80004482:	ffffd097          	auipc	ra,0xffffd
    80004486:	894080e7          	jalr	-1900(ra) # 80000d16 <uvmclear>
  stackbase = sp - PGSIZE;
    8000448a:	7c7d                	lui	s8,0xfffff
    8000448c:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    8000448e:	e0043783          	ld	a5,-512(s0)
    80004492:	6388                	ld	a0,0(a5)
    80004494:	c535                	beqz	a0,80004500 <exec+0x218>
    80004496:	e9040993          	addi	s3,s0,-368
    8000449a:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000449e:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    800044a0:	ffffc097          	auipc	ra,0xffffc
    800044a4:	f68080e7          	jalr	-152(ra) # 80000408 <strlen>
    800044a8:	2505                	addiw	a0,a0,1
    800044aa:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800044ae:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800044b2:	13896663          	bltu	s2,s8,800045de <exec+0x2f6>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800044b6:	e0043d83          	ld	s11,-512(s0)
    800044ba:	000dba03          	ld	s4,0(s11)
    800044be:	8552                	mv	a0,s4
    800044c0:	ffffc097          	auipc	ra,0xffffc
    800044c4:	f48080e7          	jalr	-184(ra) # 80000408 <strlen>
    800044c8:	0015069b          	addiw	a3,a0,1
    800044cc:	8652                	mv	a2,s4
    800044ce:	85ca                	mv	a1,s2
    800044d0:	855e                	mv	a0,s7
    800044d2:	ffffd097          	auipc	ra,0xffffd
    800044d6:	876080e7          	jalr	-1930(ra) # 80000d48 <copyout>
    800044da:	10054663          	bltz	a0,800045e6 <exec+0x2fe>
    ustack[argc] = sp;
    800044de:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800044e2:	0485                	addi	s1,s1,1
    800044e4:	008d8793          	addi	a5,s11,8
    800044e8:	e0f43023          	sd	a5,-512(s0)
    800044ec:	008db503          	ld	a0,8(s11)
    800044f0:	c911                	beqz	a0,80004504 <exec+0x21c>
    if(argc >= MAXARG)
    800044f2:	09a1                	addi	s3,s3,8
    800044f4:	fb3c96e3          	bne	s9,s3,800044a0 <exec+0x1b8>
  sz = sz1;
    800044f8:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800044fc:	4481                	li	s1,0
    800044fe:	a84d                	j	800045b0 <exec+0x2c8>
  sp = sz;
    80004500:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    80004502:	4481                	li	s1,0
  ustack[argc] = 0;
    80004504:	00349793          	slli	a5,s1,0x3
    80004508:	f9040713          	addi	a4,s0,-112
    8000450c:	97ba                	add	a5,a5,a4
    8000450e:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    80004512:	00148693          	addi	a3,s1,1
    80004516:	068e                	slli	a3,a3,0x3
    80004518:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000451c:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004520:	01897663          	bgeu	s2,s8,8000452c <exec+0x244>
  sz = sz1;
    80004524:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004528:	4481                	li	s1,0
    8000452a:	a059                	j	800045b0 <exec+0x2c8>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000452c:	e9040613          	addi	a2,s0,-368
    80004530:	85ca                	mv	a1,s2
    80004532:	855e                	mv	a0,s7
    80004534:	ffffd097          	auipc	ra,0xffffd
    80004538:	814080e7          	jalr	-2028(ra) # 80000d48 <copyout>
    8000453c:	0a054963          	bltz	a0,800045ee <exec+0x306>
  p->trapframe->a1 = sp;
    80004540:	058ab783          	ld	a5,88(s5)
    80004544:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004548:	df843783          	ld	a5,-520(s0)
    8000454c:	0007c703          	lbu	a4,0(a5)
    80004550:	cf11                	beqz	a4,8000456c <exec+0x284>
    80004552:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004554:	02f00693          	li	a3,47
    80004558:	a039                	j	80004566 <exec+0x27e>
      last = s+1;
    8000455a:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    8000455e:	0785                	addi	a5,a5,1
    80004560:	fff7c703          	lbu	a4,-1(a5)
    80004564:	c701                	beqz	a4,8000456c <exec+0x284>
    if(*s == '/')
    80004566:	fed71ce3          	bne	a4,a3,8000455e <exec+0x276>
    8000456a:	bfc5                	j	8000455a <exec+0x272>
  safestrcpy(p->name, last, sizeof(p->name));
    8000456c:	4641                	li	a2,16
    8000456e:	df843583          	ld	a1,-520(s0)
    80004572:	158a8513          	addi	a0,s5,344
    80004576:	ffffc097          	auipc	ra,0xffffc
    8000457a:	e60080e7          	jalr	-416(ra) # 800003d6 <safestrcpy>
  oldpagetable = p->pagetable;
    8000457e:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80004582:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    80004586:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000458a:	058ab783          	ld	a5,88(s5)
    8000458e:	e6843703          	ld	a4,-408(s0)
    80004592:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004594:	058ab783          	ld	a5,88(s5)
    80004598:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000459c:	85ea                	mv	a1,s10
    8000459e:	ffffd097          	auipc	ra,0xffffd
    800045a2:	cc8080e7          	jalr	-824(ra) # 80001266 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800045a6:	0004851b          	sext.w	a0,s1
    800045aa:	bbd9                	j	80004380 <exec+0x98>
    800045ac:	e1443423          	sd	s4,-504(s0)
    proc_freepagetable(pagetable, sz);
    800045b0:	e0843583          	ld	a1,-504(s0)
    800045b4:	855e                	mv	a0,s7
    800045b6:	ffffd097          	auipc	ra,0xffffd
    800045ba:	cb0080e7          	jalr	-848(ra) # 80001266 <proc_freepagetable>
  if(ip){
    800045be:	da0497e3          	bnez	s1,8000436c <exec+0x84>
  return -1;
    800045c2:	557d                	li	a0,-1
    800045c4:	bb75                	j	80004380 <exec+0x98>
    800045c6:	e1443423          	sd	s4,-504(s0)
    800045ca:	b7dd                	j	800045b0 <exec+0x2c8>
    800045cc:	e1443423          	sd	s4,-504(s0)
    800045d0:	b7c5                	j	800045b0 <exec+0x2c8>
    800045d2:	e1443423          	sd	s4,-504(s0)
    800045d6:	bfe9                	j	800045b0 <exec+0x2c8>
    800045d8:	e1443423          	sd	s4,-504(s0)
    800045dc:	bfd1                	j	800045b0 <exec+0x2c8>
  sz = sz1;
    800045de:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045e2:	4481                	li	s1,0
    800045e4:	b7f1                	j	800045b0 <exec+0x2c8>
  sz = sz1;
    800045e6:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045ea:	4481                	li	s1,0
    800045ec:	b7d1                	j	800045b0 <exec+0x2c8>
  sz = sz1;
    800045ee:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045f2:	4481                	li	s1,0
    800045f4:	bf75                	j	800045b0 <exec+0x2c8>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800045f6:	e0843a03          	ld	s4,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800045fa:	2b05                	addiw	s6,s6,1
    800045fc:	0389899b          	addiw	s3,s3,56
    80004600:	e8845783          	lhu	a5,-376(s0)
    80004604:	e2fb57e3          	bge	s6,a5,80004432 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004608:	2981                	sext.w	s3,s3
    8000460a:	03800713          	li	a4,56
    8000460e:	86ce                	mv	a3,s3
    80004610:	e1840613          	addi	a2,s0,-488
    80004614:	4581                	li	a1,0
    80004616:	8526                	mv	a0,s1
    80004618:	fffff097          	auipc	ra,0xfffff
    8000461c:	a6e080e7          	jalr	-1426(ra) # 80003086 <readi>
    80004620:	03800793          	li	a5,56
    80004624:	f8f514e3          	bne	a0,a5,800045ac <exec+0x2c4>
    if(ph.type != ELF_PROG_LOAD)
    80004628:	e1842783          	lw	a5,-488(s0)
    8000462c:	4705                	li	a4,1
    8000462e:	fce796e3          	bne	a5,a4,800045fa <exec+0x312>
    if(ph.memsz < ph.filesz)
    80004632:	e4043903          	ld	s2,-448(s0)
    80004636:	e3843783          	ld	a5,-456(s0)
    8000463a:	f8f966e3          	bltu	s2,a5,800045c6 <exec+0x2de>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    8000463e:	e2843783          	ld	a5,-472(s0)
    80004642:	993e                	add	s2,s2,a5
    80004644:	f8f964e3          	bltu	s2,a5,800045cc <exec+0x2e4>
    if(ph.vaddr % PGSIZE != 0)
    80004648:	df043703          	ld	a4,-528(s0)
    8000464c:	8ff9                	and	a5,a5,a4
    8000464e:	f3d1                	bnez	a5,800045d2 <exec+0x2ea>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004650:	e1c42503          	lw	a0,-484(s0)
    80004654:	00000097          	auipc	ra,0x0
    80004658:	c78080e7          	jalr	-904(ra) # 800042cc <flags2perm>
    8000465c:	86aa                	mv	a3,a0
    8000465e:	864a                	mv	a2,s2
    80004660:	85d2                	mv	a1,s4
    80004662:	855e                	mv	a0,s7
    80004664:	ffffc097          	auipc	ra,0xffffc
    80004668:	4ac080e7          	jalr	1196(ra) # 80000b10 <uvmalloc>
    8000466c:	e0a43423          	sd	a0,-504(s0)
    80004670:	d525                	beqz	a0,800045d8 <exec+0x2f0>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004672:	e2843d03          	ld	s10,-472(s0)
    80004676:	e2042d83          	lw	s11,-480(s0)
    8000467a:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000467e:	f60c0ce3          	beqz	s8,800045f6 <exec+0x30e>
    80004682:	8a62                	mv	s4,s8
    80004684:	4901                	li	s2,0
    80004686:	b369                	j	80004410 <exec+0x128>

0000000080004688 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004688:	7179                	addi	sp,sp,-48
    8000468a:	f406                	sd	ra,40(sp)
    8000468c:	f022                	sd	s0,32(sp)
    8000468e:	ec26                	sd	s1,24(sp)
    80004690:	e84a                	sd	s2,16(sp)
    80004692:	1800                	addi	s0,sp,48
    80004694:	892e                	mv	s2,a1
    80004696:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80004698:	fdc40593          	addi	a1,s0,-36
    8000469c:	ffffe097          	auipc	ra,0xffffe
    800046a0:	bbc080e7          	jalr	-1092(ra) # 80002258 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800046a4:	fdc42703          	lw	a4,-36(s0)
    800046a8:	47bd                	li	a5,15
    800046aa:	02e7eb63          	bltu	a5,a4,800046e0 <argfd+0x58>
    800046ae:	ffffd097          	auipc	ra,0xffffd
    800046b2:	a54080e7          	jalr	-1452(ra) # 80001102 <myproc>
    800046b6:	fdc42703          	lw	a4,-36(s0)
    800046ba:	01a70793          	addi	a5,a4,26
    800046be:	078e                	slli	a5,a5,0x3
    800046c0:	953e                	add	a0,a0,a5
    800046c2:	611c                	ld	a5,0(a0)
    800046c4:	c385                	beqz	a5,800046e4 <argfd+0x5c>
    return -1;
  if(pfd)
    800046c6:	00090463          	beqz	s2,800046ce <argfd+0x46>
    *pfd = fd;
    800046ca:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800046ce:	4501                	li	a0,0
  if(pf)
    800046d0:	c091                	beqz	s1,800046d4 <argfd+0x4c>
    *pf = f;
    800046d2:	e09c                	sd	a5,0(s1)
}
    800046d4:	70a2                	ld	ra,40(sp)
    800046d6:	7402                	ld	s0,32(sp)
    800046d8:	64e2                	ld	s1,24(sp)
    800046da:	6942                	ld	s2,16(sp)
    800046dc:	6145                	addi	sp,sp,48
    800046de:	8082                	ret
    return -1;
    800046e0:	557d                	li	a0,-1
    800046e2:	bfcd                	j	800046d4 <argfd+0x4c>
    800046e4:	557d                	li	a0,-1
    800046e6:	b7fd                	j	800046d4 <argfd+0x4c>

00000000800046e8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800046e8:	1101                	addi	sp,sp,-32
    800046ea:	ec06                	sd	ra,24(sp)
    800046ec:	e822                	sd	s0,16(sp)
    800046ee:	e426                	sd	s1,8(sp)
    800046f0:	1000                	addi	s0,sp,32
    800046f2:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800046f4:	ffffd097          	auipc	ra,0xffffd
    800046f8:	a0e080e7          	jalr	-1522(ra) # 80001102 <myproc>
    800046fc:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800046fe:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffbd1a0>
    80004702:	4501                	li	a0,0
    80004704:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004706:	6398                	ld	a4,0(a5)
    80004708:	cb19                	beqz	a4,8000471e <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    8000470a:	2505                	addiw	a0,a0,1
    8000470c:	07a1                	addi	a5,a5,8
    8000470e:	fed51ce3          	bne	a0,a3,80004706 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004712:	557d                	li	a0,-1
}
    80004714:	60e2                	ld	ra,24(sp)
    80004716:	6442                	ld	s0,16(sp)
    80004718:	64a2                	ld	s1,8(sp)
    8000471a:	6105                	addi	sp,sp,32
    8000471c:	8082                	ret
      p->ofile[fd] = f;
    8000471e:	01a50793          	addi	a5,a0,26
    80004722:	078e                	slli	a5,a5,0x3
    80004724:	963e                	add	a2,a2,a5
    80004726:	e204                	sd	s1,0(a2)
      return fd;
    80004728:	b7f5                	j	80004714 <fdalloc+0x2c>

000000008000472a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000472a:	715d                	addi	sp,sp,-80
    8000472c:	e486                	sd	ra,72(sp)
    8000472e:	e0a2                	sd	s0,64(sp)
    80004730:	fc26                	sd	s1,56(sp)
    80004732:	f84a                	sd	s2,48(sp)
    80004734:	f44e                	sd	s3,40(sp)
    80004736:	f052                	sd	s4,32(sp)
    80004738:	ec56                	sd	s5,24(sp)
    8000473a:	e85a                	sd	s6,16(sp)
    8000473c:	0880                	addi	s0,sp,80
    8000473e:	8b2e                	mv	s6,a1
    80004740:	89b2                	mv	s3,a2
    80004742:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004744:	fb040593          	addi	a1,s0,-80
    80004748:	fffff097          	auipc	ra,0xfffff
    8000474c:	e4e080e7          	jalr	-434(ra) # 80003596 <nameiparent>
    80004750:	84aa                	mv	s1,a0
    80004752:	16050063          	beqz	a0,800048b2 <create+0x188>
    return 0;

  ilock(dp);
    80004756:	ffffe097          	auipc	ra,0xffffe
    8000475a:	67c080e7          	jalr	1660(ra) # 80002dd2 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000475e:	4601                	li	a2,0
    80004760:	fb040593          	addi	a1,s0,-80
    80004764:	8526                	mv	a0,s1
    80004766:	fffff097          	auipc	ra,0xfffff
    8000476a:	b50080e7          	jalr	-1200(ra) # 800032b6 <dirlookup>
    8000476e:	8aaa                	mv	s5,a0
    80004770:	c931                	beqz	a0,800047c4 <create+0x9a>
    iunlockput(dp);
    80004772:	8526                	mv	a0,s1
    80004774:	fffff097          	auipc	ra,0xfffff
    80004778:	8c0080e7          	jalr	-1856(ra) # 80003034 <iunlockput>
    ilock(ip);
    8000477c:	8556                	mv	a0,s5
    8000477e:	ffffe097          	auipc	ra,0xffffe
    80004782:	654080e7          	jalr	1620(ra) # 80002dd2 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004786:	000b059b          	sext.w	a1,s6
    8000478a:	4789                	li	a5,2
    8000478c:	02f59563          	bne	a1,a5,800047b6 <create+0x8c>
    80004790:	044ad783          	lhu	a5,68(s5)
    80004794:	37f9                	addiw	a5,a5,-2
    80004796:	17c2                	slli	a5,a5,0x30
    80004798:	93c1                	srli	a5,a5,0x30
    8000479a:	4705                	li	a4,1
    8000479c:	00f76d63          	bltu	a4,a5,800047b6 <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800047a0:	8556                	mv	a0,s5
    800047a2:	60a6                	ld	ra,72(sp)
    800047a4:	6406                	ld	s0,64(sp)
    800047a6:	74e2                	ld	s1,56(sp)
    800047a8:	7942                	ld	s2,48(sp)
    800047aa:	79a2                	ld	s3,40(sp)
    800047ac:	7a02                	ld	s4,32(sp)
    800047ae:	6ae2                	ld	s5,24(sp)
    800047b0:	6b42                	ld	s6,16(sp)
    800047b2:	6161                	addi	sp,sp,80
    800047b4:	8082                	ret
    iunlockput(ip);
    800047b6:	8556                	mv	a0,s5
    800047b8:	fffff097          	auipc	ra,0xfffff
    800047bc:	87c080e7          	jalr	-1924(ra) # 80003034 <iunlockput>
    return 0;
    800047c0:	4a81                	li	s5,0
    800047c2:	bff9                	j	800047a0 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    800047c4:	85da                	mv	a1,s6
    800047c6:	4088                	lw	a0,0(s1)
    800047c8:	ffffe097          	auipc	ra,0xffffe
    800047cc:	46e080e7          	jalr	1134(ra) # 80002c36 <ialloc>
    800047d0:	8a2a                	mv	s4,a0
    800047d2:	c921                	beqz	a0,80004822 <create+0xf8>
  ilock(ip);
    800047d4:	ffffe097          	auipc	ra,0xffffe
    800047d8:	5fe080e7          	jalr	1534(ra) # 80002dd2 <ilock>
  ip->major = major;
    800047dc:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800047e0:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800047e4:	4785                	li	a5,1
    800047e6:	04fa1523          	sh	a5,74(s4)
  iupdate(ip);
    800047ea:	8552                	mv	a0,s4
    800047ec:	ffffe097          	auipc	ra,0xffffe
    800047f0:	51c080e7          	jalr	1308(ra) # 80002d08 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800047f4:	000b059b          	sext.w	a1,s6
    800047f8:	4785                	li	a5,1
    800047fa:	02f58b63          	beq	a1,a5,80004830 <create+0x106>
  if(dirlink(dp, name, ip->inum) < 0)
    800047fe:	004a2603          	lw	a2,4(s4)
    80004802:	fb040593          	addi	a1,s0,-80
    80004806:	8526                	mv	a0,s1
    80004808:	fffff097          	auipc	ra,0xfffff
    8000480c:	cbe080e7          	jalr	-834(ra) # 800034c6 <dirlink>
    80004810:	06054f63          	bltz	a0,8000488e <create+0x164>
  iunlockput(dp);
    80004814:	8526                	mv	a0,s1
    80004816:	fffff097          	auipc	ra,0xfffff
    8000481a:	81e080e7          	jalr	-2018(ra) # 80003034 <iunlockput>
  return ip;
    8000481e:	8ad2                	mv	s5,s4
    80004820:	b741                	j	800047a0 <create+0x76>
    iunlockput(dp);
    80004822:	8526                	mv	a0,s1
    80004824:	fffff097          	auipc	ra,0xfffff
    80004828:	810080e7          	jalr	-2032(ra) # 80003034 <iunlockput>
    return 0;
    8000482c:	8ad2                	mv	s5,s4
    8000482e:	bf8d                	j	800047a0 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004830:	004a2603          	lw	a2,4(s4)
    80004834:	00004597          	auipc	a1,0x4
    80004838:	ff458593          	addi	a1,a1,-12 # 80008828 <syscalls+0x2a0>
    8000483c:	8552                	mv	a0,s4
    8000483e:	fffff097          	auipc	ra,0xfffff
    80004842:	c88080e7          	jalr	-888(ra) # 800034c6 <dirlink>
    80004846:	04054463          	bltz	a0,8000488e <create+0x164>
    8000484a:	40d0                	lw	a2,4(s1)
    8000484c:	00004597          	auipc	a1,0x4
    80004850:	fe458593          	addi	a1,a1,-28 # 80008830 <syscalls+0x2a8>
    80004854:	8552                	mv	a0,s4
    80004856:	fffff097          	auipc	ra,0xfffff
    8000485a:	c70080e7          	jalr	-912(ra) # 800034c6 <dirlink>
    8000485e:	02054863          	bltz	a0,8000488e <create+0x164>
  if(dirlink(dp, name, ip->inum) < 0)
    80004862:	004a2603          	lw	a2,4(s4)
    80004866:	fb040593          	addi	a1,s0,-80
    8000486a:	8526                	mv	a0,s1
    8000486c:	fffff097          	auipc	ra,0xfffff
    80004870:	c5a080e7          	jalr	-934(ra) # 800034c6 <dirlink>
    80004874:	00054d63          	bltz	a0,8000488e <create+0x164>
    dp->nlink++;  // for ".."
    80004878:	04a4d783          	lhu	a5,74(s1)
    8000487c:	2785                	addiw	a5,a5,1
    8000487e:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004882:	8526                	mv	a0,s1
    80004884:	ffffe097          	auipc	ra,0xffffe
    80004888:	484080e7          	jalr	1156(ra) # 80002d08 <iupdate>
    8000488c:	b761                	j	80004814 <create+0xea>
  ip->nlink = 0;
    8000488e:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004892:	8552                	mv	a0,s4
    80004894:	ffffe097          	auipc	ra,0xffffe
    80004898:	474080e7          	jalr	1140(ra) # 80002d08 <iupdate>
  iunlockput(ip);
    8000489c:	8552                	mv	a0,s4
    8000489e:	ffffe097          	auipc	ra,0xffffe
    800048a2:	796080e7          	jalr	1942(ra) # 80003034 <iunlockput>
  iunlockput(dp);
    800048a6:	8526                	mv	a0,s1
    800048a8:	ffffe097          	auipc	ra,0xffffe
    800048ac:	78c080e7          	jalr	1932(ra) # 80003034 <iunlockput>
  return 0;
    800048b0:	bdc5                	j	800047a0 <create+0x76>
    return 0;
    800048b2:	8aaa                	mv	s5,a0
    800048b4:	b5f5                	j	800047a0 <create+0x76>

00000000800048b6 <sys_dup>:
{
    800048b6:	7179                	addi	sp,sp,-48
    800048b8:	f406                	sd	ra,40(sp)
    800048ba:	f022                	sd	s0,32(sp)
    800048bc:	ec26                	sd	s1,24(sp)
    800048be:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800048c0:	fd840613          	addi	a2,s0,-40
    800048c4:	4581                	li	a1,0
    800048c6:	4501                	li	a0,0
    800048c8:	00000097          	auipc	ra,0x0
    800048cc:	dc0080e7          	jalr	-576(ra) # 80004688 <argfd>
    return -1;
    800048d0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800048d2:	02054363          	bltz	a0,800048f8 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800048d6:	fd843503          	ld	a0,-40(s0)
    800048da:	00000097          	auipc	ra,0x0
    800048de:	e0e080e7          	jalr	-498(ra) # 800046e8 <fdalloc>
    800048e2:	84aa                	mv	s1,a0
    return -1;
    800048e4:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800048e6:	00054963          	bltz	a0,800048f8 <sys_dup+0x42>
  filedup(f);
    800048ea:	fd843503          	ld	a0,-40(s0)
    800048ee:	fffff097          	auipc	ra,0xfffff
    800048f2:	320080e7          	jalr	800(ra) # 80003c0e <filedup>
  return fd;
    800048f6:	87a6                	mv	a5,s1
}
    800048f8:	853e                	mv	a0,a5
    800048fa:	70a2                	ld	ra,40(sp)
    800048fc:	7402                	ld	s0,32(sp)
    800048fe:	64e2                	ld	s1,24(sp)
    80004900:	6145                	addi	sp,sp,48
    80004902:	8082                	ret

0000000080004904 <sys_read>:
{
    80004904:	7179                	addi	sp,sp,-48
    80004906:	f406                	sd	ra,40(sp)
    80004908:	f022                	sd	s0,32(sp)
    8000490a:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000490c:	fd840593          	addi	a1,s0,-40
    80004910:	4505                	li	a0,1
    80004912:	ffffe097          	auipc	ra,0xffffe
    80004916:	966080e7          	jalr	-1690(ra) # 80002278 <argaddr>
  argint(2, &n);
    8000491a:	fe440593          	addi	a1,s0,-28
    8000491e:	4509                	li	a0,2
    80004920:	ffffe097          	auipc	ra,0xffffe
    80004924:	938080e7          	jalr	-1736(ra) # 80002258 <argint>
  if(argfd(0, 0, &f) < 0)
    80004928:	fe840613          	addi	a2,s0,-24
    8000492c:	4581                	li	a1,0
    8000492e:	4501                	li	a0,0
    80004930:	00000097          	auipc	ra,0x0
    80004934:	d58080e7          	jalr	-680(ra) # 80004688 <argfd>
    80004938:	87aa                	mv	a5,a0
    return -1;
    8000493a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000493c:	0007cc63          	bltz	a5,80004954 <sys_read+0x50>
  return fileread(f, p, n);
    80004940:	fe442603          	lw	a2,-28(s0)
    80004944:	fd843583          	ld	a1,-40(s0)
    80004948:	fe843503          	ld	a0,-24(s0)
    8000494c:	fffff097          	auipc	ra,0xfffff
    80004950:	44e080e7          	jalr	1102(ra) # 80003d9a <fileread>
}
    80004954:	70a2                	ld	ra,40(sp)
    80004956:	7402                	ld	s0,32(sp)
    80004958:	6145                	addi	sp,sp,48
    8000495a:	8082                	ret

000000008000495c <sys_write>:
{
    8000495c:	7179                	addi	sp,sp,-48
    8000495e:	f406                	sd	ra,40(sp)
    80004960:	f022                	sd	s0,32(sp)
    80004962:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004964:	fd840593          	addi	a1,s0,-40
    80004968:	4505                	li	a0,1
    8000496a:	ffffe097          	auipc	ra,0xffffe
    8000496e:	90e080e7          	jalr	-1778(ra) # 80002278 <argaddr>
  argint(2, &n);
    80004972:	fe440593          	addi	a1,s0,-28
    80004976:	4509                	li	a0,2
    80004978:	ffffe097          	auipc	ra,0xffffe
    8000497c:	8e0080e7          	jalr	-1824(ra) # 80002258 <argint>
  if(argfd(0, 0, &f) < 0)
    80004980:	fe840613          	addi	a2,s0,-24
    80004984:	4581                	li	a1,0
    80004986:	4501                	li	a0,0
    80004988:	00000097          	auipc	ra,0x0
    8000498c:	d00080e7          	jalr	-768(ra) # 80004688 <argfd>
    80004990:	87aa                	mv	a5,a0
    return -1;
    80004992:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004994:	0007cc63          	bltz	a5,800049ac <sys_write+0x50>
  return filewrite(f, p, n);
    80004998:	fe442603          	lw	a2,-28(s0)
    8000499c:	fd843583          	ld	a1,-40(s0)
    800049a0:	fe843503          	ld	a0,-24(s0)
    800049a4:	fffff097          	auipc	ra,0xfffff
    800049a8:	4b8080e7          	jalr	1208(ra) # 80003e5c <filewrite>
}
    800049ac:	70a2                	ld	ra,40(sp)
    800049ae:	7402                	ld	s0,32(sp)
    800049b0:	6145                	addi	sp,sp,48
    800049b2:	8082                	ret

00000000800049b4 <sys_close>:
{
    800049b4:	1101                	addi	sp,sp,-32
    800049b6:	ec06                	sd	ra,24(sp)
    800049b8:	e822                	sd	s0,16(sp)
    800049ba:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800049bc:	fe040613          	addi	a2,s0,-32
    800049c0:	fec40593          	addi	a1,s0,-20
    800049c4:	4501                	li	a0,0
    800049c6:	00000097          	auipc	ra,0x0
    800049ca:	cc2080e7          	jalr	-830(ra) # 80004688 <argfd>
    return -1;
    800049ce:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800049d0:	02054463          	bltz	a0,800049f8 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800049d4:	ffffc097          	auipc	ra,0xffffc
    800049d8:	72e080e7          	jalr	1838(ra) # 80001102 <myproc>
    800049dc:	fec42783          	lw	a5,-20(s0)
    800049e0:	07e9                	addi	a5,a5,26
    800049e2:	078e                	slli	a5,a5,0x3
    800049e4:	97aa                	add	a5,a5,a0
    800049e6:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    800049ea:	fe043503          	ld	a0,-32(s0)
    800049ee:	fffff097          	auipc	ra,0xfffff
    800049f2:	272080e7          	jalr	626(ra) # 80003c60 <fileclose>
  return 0;
    800049f6:	4781                	li	a5,0
}
    800049f8:	853e                	mv	a0,a5
    800049fa:	60e2                	ld	ra,24(sp)
    800049fc:	6442                	ld	s0,16(sp)
    800049fe:	6105                	addi	sp,sp,32
    80004a00:	8082                	ret

0000000080004a02 <sys_fstat>:
{
    80004a02:	1101                	addi	sp,sp,-32
    80004a04:	ec06                	sd	ra,24(sp)
    80004a06:	e822                	sd	s0,16(sp)
    80004a08:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004a0a:	fe040593          	addi	a1,s0,-32
    80004a0e:	4505                	li	a0,1
    80004a10:	ffffe097          	auipc	ra,0xffffe
    80004a14:	868080e7          	jalr	-1944(ra) # 80002278 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004a18:	fe840613          	addi	a2,s0,-24
    80004a1c:	4581                	li	a1,0
    80004a1e:	4501                	li	a0,0
    80004a20:	00000097          	auipc	ra,0x0
    80004a24:	c68080e7          	jalr	-920(ra) # 80004688 <argfd>
    80004a28:	87aa                	mv	a5,a0
    return -1;
    80004a2a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004a2c:	0007ca63          	bltz	a5,80004a40 <sys_fstat+0x3e>
  return filestat(f, st);
    80004a30:	fe043583          	ld	a1,-32(s0)
    80004a34:	fe843503          	ld	a0,-24(s0)
    80004a38:	fffff097          	auipc	ra,0xfffff
    80004a3c:	2f0080e7          	jalr	752(ra) # 80003d28 <filestat>
}
    80004a40:	60e2                	ld	ra,24(sp)
    80004a42:	6442                	ld	s0,16(sp)
    80004a44:	6105                	addi	sp,sp,32
    80004a46:	8082                	ret

0000000080004a48 <sys_link>:
{
    80004a48:	7169                	addi	sp,sp,-304
    80004a4a:	f606                	sd	ra,296(sp)
    80004a4c:	f222                	sd	s0,288(sp)
    80004a4e:	ee26                	sd	s1,280(sp)
    80004a50:	ea4a                	sd	s2,272(sp)
    80004a52:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a54:	08000613          	li	a2,128
    80004a58:	ed040593          	addi	a1,s0,-304
    80004a5c:	4501                	li	a0,0
    80004a5e:	ffffe097          	auipc	ra,0xffffe
    80004a62:	83a080e7          	jalr	-1990(ra) # 80002298 <argstr>
    return -1;
    80004a66:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a68:	10054e63          	bltz	a0,80004b84 <sys_link+0x13c>
    80004a6c:	08000613          	li	a2,128
    80004a70:	f5040593          	addi	a1,s0,-176
    80004a74:	4505                	li	a0,1
    80004a76:	ffffe097          	auipc	ra,0xffffe
    80004a7a:	822080e7          	jalr	-2014(ra) # 80002298 <argstr>
    return -1;
    80004a7e:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a80:	10054263          	bltz	a0,80004b84 <sys_link+0x13c>
  begin_op();
    80004a84:	fffff097          	auipc	ra,0xfffff
    80004a88:	d10080e7          	jalr	-752(ra) # 80003794 <begin_op>
  if((ip = namei(old)) == 0){
    80004a8c:	ed040513          	addi	a0,s0,-304
    80004a90:	fffff097          	auipc	ra,0xfffff
    80004a94:	ae8080e7          	jalr	-1304(ra) # 80003578 <namei>
    80004a98:	84aa                	mv	s1,a0
    80004a9a:	c551                	beqz	a0,80004b26 <sys_link+0xde>
  ilock(ip);
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	336080e7          	jalr	822(ra) # 80002dd2 <ilock>
  if(ip->type == T_DIR){
    80004aa4:	04449703          	lh	a4,68(s1)
    80004aa8:	4785                	li	a5,1
    80004aaa:	08f70463          	beq	a4,a5,80004b32 <sys_link+0xea>
  ip->nlink++;
    80004aae:	04a4d783          	lhu	a5,74(s1)
    80004ab2:	2785                	addiw	a5,a5,1
    80004ab4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004ab8:	8526                	mv	a0,s1
    80004aba:	ffffe097          	auipc	ra,0xffffe
    80004abe:	24e080e7          	jalr	590(ra) # 80002d08 <iupdate>
  iunlock(ip);
    80004ac2:	8526                	mv	a0,s1
    80004ac4:	ffffe097          	auipc	ra,0xffffe
    80004ac8:	3d0080e7          	jalr	976(ra) # 80002e94 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004acc:	fd040593          	addi	a1,s0,-48
    80004ad0:	f5040513          	addi	a0,s0,-176
    80004ad4:	fffff097          	auipc	ra,0xfffff
    80004ad8:	ac2080e7          	jalr	-1342(ra) # 80003596 <nameiparent>
    80004adc:	892a                	mv	s2,a0
    80004ade:	c935                	beqz	a0,80004b52 <sys_link+0x10a>
  ilock(dp);
    80004ae0:	ffffe097          	auipc	ra,0xffffe
    80004ae4:	2f2080e7          	jalr	754(ra) # 80002dd2 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004ae8:	00092703          	lw	a4,0(s2)
    80004aec:	409c                	lw	a5,0(s1)
    80004aee:	04f71d63          	bne	a4,a5,80004b48 <sys_link+0x100>
    80004af2:	40d0                	lw	a2,4(s1)
    80004af4:	fd040593          	addi	a1,s0,-48
    80004af8:	854a                	mv	a0,s2
    80004afa:	fffff097          	auipc	ra,0xfffff
    80004afe:	9cc080e7          	jalr	-1588(ra) # 800034c6 <dirlink>
    80004b02:	04054363          	bltz	a0,80004b48 <sys_link+0x100>
  iunlockput(dp);
    80004b06:	854a                	mv	a0,s2
    80004b08:	ffffe097          	auipc	ra,0xffffe
    80004b0c:	52c080e7          	jalr	1324(ra) # 80003034 <iunlockput>
  iput(ip);
    80004b10:	8526                	mv	a0,s1
    80004b12:	ffffe097          	auipc	ra,0xffffe
    80004b16:	47a080e7          	jalr	1146(ra) # 80002f8c <iput>
  end_op();
    80004b1a:	fffff097          	auipc	ra,0xfffff
    80004b1e:	cfa080e7          	jalr	-774(ra) # 80003814 <end_op>
  return 0;
    80004b22:	4781                	li	a5,0
    80004b24:	a085                	j	80004b84 <sys_link+0x13c>
    end_op();
    80004b26:	fffff097          	auipc	ra,0xfffff
    80004b2a:	cee080e7          	jalr	-786(ra) # 80003814 <end_op>
    return -1;
    80004b2e:	57fd                	li	a5,-1
    80004b30:	a891                	j	80004b84 <sys_link+0x13c>
    iunlockput(ip);
    80004b32:	8526                	mv	a0,s1
    80004b34:	ffffe097          	auipc	ra,0xffffe
    80004b38:	500080e7          	jalr	1280(ra) # 80003034 <iunlockput>
    end_op();
    80004b3c:	fffff097          	auipc	ra,0xfffff
    80004b40:	cd8080e7          	jalr	-808(ra) # 80003814 <end_op>
    return -1;
    80004b44:	57fd                	li	a5,-1
    80004b46:	a83d                	j	80004b84 <sys_link+0x13c>
    iunlockput(dp);
    80004b48:	854a                	mv	a0,s2
    80004b4a:	ffffe097          	auipc	ra,0xffffe
    80004b4e:	4ea080e7          	jalr	1258(ra) # 80003034 <iunlockput>
  ilock(ip);
    80004b52:	8526                	mv	a0,s1
    80004b54:	ffffe097          	auipc	ra,0xffffe
    80004b58:	27e080e7          	jalr	638(ra) # 80002dd2 <ilock>
  ip->nlink--;
    80004b5c:	04a4d783          	lhu	a5,74(s1)
    80004b60:	37fd                	addiw	a5,a5,-1
    80004b62:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004b66:	8526                	mv	a0,s1
    80004b68:	ffffe097          	auipc	ra,0xffffe
    80004b6c:	1a0080e7          	jalr	416(ra) # 80002d08 <iupdate>
  iunlockput(ip);
    80004b70:	8526                	mv	a0,s1
    80004b72:	ffffe097          	auipc	ra,0xffffe
    80004b76:	4c2080e7          	jalr	1218(ra) # 80003034 <iunlockput>
  end_op();
    80004b7a:	fffff097          	auipc	ra,0xfffff
    80004b7e:	c9a080e7          	jalr	-870(ra) # 80003814 <end_op>
  return -1;
    80004b82:	57fd                	li	a5,-1
}
    80004b84:	853e                	mv	a0,a5
    80004b86:	70b2                	ld	ra,296(sp)
    80004b88:	7412                	ld	s0,288(sp)
    80004b8a:	64f2                	ld	s1,280(sp)
    80004b8c:	6952                	ld	s2,272(sp)
    80004b8e:	6155                	addi	sp,sp,304
    80004b90:	8082                	ret

0000000080004b92 <sys_unlink>:
{
    80004b92:	7151                	addi	sp,sp,-240
    80004b94:	f586                	sd	ra,232(sp)
    80004b96:	f1a2                	sd	s0,224(sp)
    80004b98:	eda6                	sd	s1,216(sp)
    80004b9a:	e9ca                	sd	s2,208(sp)
    80004b9c:	e5ce                	sd	s3,200(sp)
    80004b9e:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004ba0:	08000613          	li	a2,128
    80004ba4:	f3040593          	addi	a1,s0,-208
    80004ba8:	4501                	li	a0,0
    80004baa:	ffffd097          	auipc	ra,0xffffd
    80004bae:	6ee080e7          	jalr	1774(ra) # 80002298 <argstr>
    80004bb2:	18054163          	bltz	a0,80004d34 <sys_unlink+0x1a2>
  begin_op();
    80004bb6:	fffff097          	auipc	ra,0xfffff
    80004bba:	bde080e7          	jalr	-1058(ra) # 80003794 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004bbe:	fb040593          	addi	a1,s0,-80
    80004bc2:	f3040513          	addi	a0,s0,-208
    80004bc6:	fffff097          	auipc	ra,0xfffff
    80004bca:	9d0080e7          	jalr	-1584(ra) # 80003596 <nameiparent>
    80004bce:	84aa                	mv	s1,a0
    80004bd0:	c979                	beqz	a0,80004ca6 <sys_unlink+0x114>
  ilock(dp);
    80004bd2:	ffffe097          	auipc	ra,0xffffe
    80004bd6:	200080e7          	jalr	512(ra) # 80002dd2 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004bda:	00004597          	auipc	a1,0x4
    80004bde:	c4e58593          	addi	a1,a1,-946 # 80008828 <syscalls+0x2a0>
    80004be2:	fb040513          	addi	a0,s0,-80
    80004be6:	ffffe097          	auipc	ra,0xffffe
    80004bea:	6b6080e7          	jalr	1718(ra) # 8000329c <namecmp>
    80004bee:	14050a63          	beqz	a0,80004d42 <sys_unlink+0x1b0>
    80004bf2:	00004597          	auipc	a1,0x4
    80004bf6:	c3e58593          	addi	a1,a1,-962 # 80008830 <syscalls+0x2a8>
    80004bfa:	fb040513          	addi	a0,s0,-80
    80004bfe:	ffffe097          	auipc	ra,0xffffe
    80004c02:	69e080e7          	jalr	1694(ra) # 8000329c <namecmp>
    80004c06:	12050e63          	beqz	a0,80004d42 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004c0a:	f2c40613          	addi	a2,s0,-212
    80004c0e:	fb040593          	addi	a1,s0,-80
    80004c12:	8526                	mv	a0,s1
    80004c14:	ffffe097          	auipc	ra,0xffffe
    80004c18:	6a2080e7          	jalr	1698(ra) # 800032b6 <dirlookup>
    80004c1c:	892a                	mv	s2,a0
    80004c1e:	12050263          	beqz	a0,80004d42 <sys_unlink+0x1b0>
  ilock(ip);
    80004c22:	ffffe097          	auipc	ra,0xffffe
    80004c26:	1b0080e7          	jalr	432(ra) # 80002dd2 <ilock>
  if(ip->nlink < 1)
    80004c2a:	04a91783          	lh	a5,74(s2)
    80004c2e:	08f05263          	blez	a5,80004cb2 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004c32:	04491703          	lh	a4,68(s2)
    80004c36:	4785                	li	a5,1
    80004c38:	08f70563          	beq	a4,a5,80004cc2 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004c3c:	4641                	li	a2,16
    80004c3e:	4581                	li	a1,0
    80004c40:	fc040513          	addi	a0,s0,-64
    80004c44:	ffffb097          	auipc	ra,0xffffb
    80004c48:	640080e7          	jalr	1600(ra) # 80000284 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c4c:	4741                	li	a4,16
    80004c4e:	f2c42683          	lw	a3,-212(s0)
    80004c52:	fc040613          	addi	a2,s0,-64
    80004c56:	4581                	li	a1,0
    80004c58:	8526                	mv	a0,s1
    80004c5a:	ffffe097          	auipc	ra,0xffffe
    80004c5e:	524080e7          	jalr	1316(ra) # 8000317e <writei>
    80004c62:	47c1                	li	a5,16
    80004c64:	0af51563          	bne	a0,a5,80004d0e <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004c68:	04491703          	lh	a4,68(s2)
    80004c6c:	4785                	li	a5,1
    80004c6e:	0af70863          	beq	a4,a5,80004d1e <sys_unlink+0x18c>
  iunlockput(dp);
    80004c72:	8526                	mv	a0,s1
    80004c74:	ffffe097          	auipc	ra,0xffffe
    80004c78:	3c0080e7          	jalr	960(ra) # 80003034 <iunlockput>
  ip->nlink--;
    80004c7c:	04a95783          	lhu	a5,74(s2)
    80004c80:	37fd                	addiw	a5,a5,-1
    80004c82:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004c86:	854a                	mv	a0,s2
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	080080e7          	jalr	128(ra) # 80002d08 <iupdate>
  iunlockput(ip);
    80004c90:	854a                	mv	a0,s2
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	3a2080e7          	jalr	930(ra) # 80003034 <iunlockput>
  end_op();
    80004c9a:	fffff097          	auipc	ra,0xfffff
    80004c9e:	b7a080e7          	jalr	-1158(ra) # 80003814 <end_op>
  return 0;
    80004ca2:	4501                	li	a0,0
    80004ca4:	a84d                	j	80004d56 <sys_unlink+0x1c4>
    end_op();
    80004ca6:	fffff097          	auipc	ra,0xfffff
    80004caa:	b6e080e7          	jalr	-1170(ra) # 80003814 <end_op>
    return -1;
    80004cae:	557d                	li	a0,-1
    80004cb0:	a05d                	j	80004d56 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004cb2:	00004517          	auipc	a0,0x4
    80004cb6:	b8650513          	addi	a0,a0,-1146 # 80008838 <syscalls+0x2b0>
    80004cba:	00001097          	auipc	ra,0x1
    80004cbe:	218080e7          	jalr	536(ra) # 80005ed2 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004cc2:	04c92703          	lw	a4,76(s2)
    80004cc6:	02000793          	li	a5,32
    80004cca:	f6e7f9e3          	bgeu	a5,a4,80004c3c <sys_unlink+0xaa>
    80004cce:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004cd2:	4741                	li	a4,16
    80004cd4:	86ce                	mv	a3,s3
    80004cd6:	f1840613          	addi	a2,s0,-232
    80004cda:	4581                	li	a1,0
    80004cdc:	854a                	mv	a0,s2
    80004cde:	ffffe097          	auipc	ra,0xffffe
    80004ce2:	3a8080e7          	jalr	936(ra) # 80003086 <readi>
    80004ce6:	47c1                	li	a5,16
    80004ce8:	00f51b63          	bne	a0,a5,80004cfe <sys_unlink+0x16c>
    if(de.inum != 0)
    80004cec:	f1845783          	lhu	a5,-232(s0)
    80004cf0:	e7a1                	bnez	a5,80004d38 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004cf2:	29c1                	addiw	s3,s3,16
    80004cf4:	04c92783          	lw	a5,76(s2)
    80004cf8:	fcf9ede3          	bltu	s3,a5,80004cd2 <sys_unlink+0x140>
    80004cfc:	b781                	j	80004c3c <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004cfe:	00004517          	auipc	a0,0x4
    80004d02:	b5250513          	addi	a0,a0,-1198 # 80008850 <syscalls+0x2c8>
    80004d06:	00001097          	auipc	ra,0x1
    80004d0a:	1cc080e7          	jalr	460(ra) # 80005ed2 <panic>
    panic("unlink: writei");
    80004d0e:	00004517          	auipc	a0,0x4
    80004d12:	b5a50513          	addi	a0,a0,-1190 # 80008868 <syscalls+0x2e0>
    80004d16:	00001097          	auipc	ra,0x1
    80004d1a:	1bc080e7          	jalr	444(ra) # 80005ed2 <panic>
    dp->nlink--;
    80004d1e:	04a4d783          	lhu	a5,74(s1)
    80004d22:	37fd                	addiw	a5,a5,-1
    80004d24:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004d28:	8526                	mv	a0,s1
    80004d2a:	ffffe097          	auipc	ra,0xffffe
    80004d2e:	fde080e7          	jalr	-34(ra) # 80002d08 <iupdate>
    80004d32:	b781                	j	80004c72 <sys_unlink+0xe0>
    return -1;
    80004d34:	557d                	li	a0,-1
    80004d36:	a005                	j	80004d56 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004d38:	854a                	mv	a0,s2
    80004d3a:	ffffe097          	auipc	ra,0xffffe
    80004d3e:	2fa080e7          	jalr	762(ra) # 80003034 <iunlockput>
  iunlockput(dp);
    80004d42:	8526                	mv	a0,s1
    80004d44:	ffffe097          	auipc	ra,0xffffe
    80004d48:	2f0080e7          	jalr	752(ra) # 80003034 <iunlockput>
  end_op();
    80004d4c:	fffff097          	auipc	ra,0xfffff
    80004d50:	ac8080e7          	jalr	-1336(ra) # 80003814 <end_op>
  return -1;
    80004d54:	557d                	li	a0,-1
}
    80004d56:	70ae                	ld	ra,232(sp)
    80004d58:	740e                	ld	s0,224(sp)
    80004d5a:	64ee                	ld	s1,216(sp)
    80004d5c:	694e                	ld	s2,208(sp)
    80004d5e:	69ae                	ld	s3,200(sp)
    80004d60:	616d                	addi	sp,sp,240
    80004d62:	8082                	ret

0000000080004d64 <sys_open>:

uint64
sys_open(void)
{
    80004d64:	7131                	addi	sp,sp,-192
    80004d66:	fd06                	sd	ra,184(sp)
    80004d68:	f922                	sd	s0,176(sp)
    80004d6a:	f526                	sd	s1,168(sp)
    80004d6c:	f14a                	sd	s2,160(sp)
    80004d6e:	ed4e                	sd	s3,152(sp)
    80004d70:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004d72:	f4c40593          	addi	a1,s0,-180
    80004d76:	4505                	li	a0,1
    80004d78:	ffffd097          	auipc	ra,0xffffd
    80004d7c:	4e0080e7          	jalr	1248(ra) # 80002258 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d80:	08000613          	li	a2,128
    80004d84:	f5040593          	addi	a1,s0,-176
    80004d88:	4501                	li	a0,0
    80004d8a:	ffffd097          	auipc	ra,0xffffd
    80004d8e:	50e080e7          	jalr	1294(ra) # 80002298 <argstr>
    80004d92:	87aa                	mv	a5,a0
    return -1;
    80004d94:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d96:	0a07c963          	bltz	a5,80004e48 <sys_open+0xe4>

  begin_op();
    80004d9a:	fffff097          	auipc	ra,0xfffff
    80004d9e:	9fa080e7          	jalr	-1542(ra) # 80003794 <begin_op>

  if(omode & O_CREATE){
    80004da2:	f4c42783          	lw	a5,-180(s0)
    80004da6:	2007f793          	andi	a5,a5,512
    80004daa:	cfc5                	beqz	a5,80004e62 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004dac:	4681                	li	a3,0
    80004dae:	4601                	li	a2,0
    80004db0:	4589                	li	a1,2
    80004db2:	f5040513          	addi	a0,s0,-176
    80004db6:	00000097          	auipc	ra,0x0
    80004dba:	974080e7          	jalr	-1676(ra) # 8000472a <create>
    80004dbe:	84aa                	mv	s1,a0
    if(ip == 0){
    80004dc0:	c959                	beqz	a0,80004e56 <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004dc2:	04449703          	lh	a4,68(s1)
    80004dc6:	478d                	li	a5,3
    80004dc8:	00f71763          	bne	a4,a5,80004dd6 <sys_open+0x72>
    80004dcc:	0464d703          	lhu	a4,70(s1)
    80004dd0:	47a5                	li	a5,9
    80004dd2:	0ce7ed63          	bltu	a5,a4,80004eac <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004dd6:	fffff097          	auipc	ra,0xfffff
    80004dda:	dce080e7          	jalr	-562(ra) # 80003ba4 <filealloc>
    80004dde:	89aa                	mv	s3,a0
    80004de0:	10050363          	beqz	a0,80004ee6 <sys_open+0x182>
    80004de4:	00000097          	auipc	ra,0x0
    80004de8:	904080e7          	jalr	-1788(ra) # 800046e8 <fdalloc>
    80004dec:	892a                	mv	s2,a0
    80004dee:	0e054763          	bltz	a0,80004edc <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004df2:	04449703          	lh	a4,68(s1)
    80004df6:	478d                	li	a5,3
    80004df8:	0cf70563          	beq	a4,a5,80004ec2 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004dfc:	4789                	li	a5,2
    80004dfe:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004e02:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004e06:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004e0a:	f4c42783          	lw	a5,-180(s0)
    80004e0e:	0017c713          	xori	a4,a5,1
    80004e12:	8b05                	andi	a4,a4,1
    80004e14:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004e18:	0037f713          	andi	a4,a5,3
    80004e1c:	00e03733          	snez	a4,a4
    80004e20:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004e24:	4007f793          	andi	a5,a5,1024
    80004e28:	c791                	beqz	a5,80004e34 <sys_open+0xd0>
    80004e2a:	04449703          	lh	a4,68(s1)
    80004e2e:	4789                	li	a5,2
    80004e30:	0af70063          	beq	a4,a5,80004ed0 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004e34:	8526                	mv	a0,s1
    80004e36:	ffffe097          	auipc	ra,0xffffe
    80004e3a:	05e080e7          	jalr	94(ra) # 80002e94 <iunlock>
  end_op();
    80004e3e:	fffff097          	auipc	ra,0xfffff
    80004e42:	9d6080e7          	jalr	-1578(ra) # 80003814 <end_op>

  return fd;
    80004e46:	854a                	mv	a0,s2
}
    80004e48:	70ea                	ld	ra,184(sp)
    80004e4a:	744a                	ld	s0,176(sp)
    80004e4c:	74aa                	ld	s1,168(sp)
    80004e4e:	790a                	ld	s2,160(sp)
    80004e50:	69ea                	ld	s3,152(sp)
    80004e52:	6129                	addi	sp,sp,192
    80004e54:	8082                	ret
      end_op();
    80004e56:	fffff097          	auipc	ra,0xfffff
    80004e5a:	9be080e7          	jalr	-1602(ra) # 80003814 <end_op>
      return -1;
    80004e5e:	557d                	li	a0,-1
    80004e60:	b7e5                	j	80004e48 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004e62:	f5040513          	addi	a0,s0,-176
    80004e66:	ffffe097          	auipc	ra,0xffffe
    80004e6a:	712080e7          	jalr	1810(ra) # 80003578 <namei>
    80004e6e:	84aa                	mv	s1,a0
    80004e70:	c905                	beqz	a0,80004ea0 <sys_open+0x13c>
    ilock(ip);
    80004e72:	ffffe097          	auipc	ra,0xffffe
    80004e76:	f60080e7          	jalr	-160(ra) # 80002dd2 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004e7a:	04449703          	lh	a4,68(s1)
    80004e7e:	4785                	li	a5,1
    80004e80:	f4f711e3          	bne	a4,a5,80004dc2 <sys_open+0x5e>
    80004e84:	f4c42783          	lw	a5,-180(s0)
    80004e88:	d7b9                	beqz	a5,80004dd6 <sys_open+0x72>
      iunlockput(ip);
    80004e8a:	8526                	mv	a0,s1
    80004e8c:	ffffe097          	auipc	ra,0xffffe
    80004e90:	1a8080e7          	jalr	424(ra) # 80003034 <iunlockput>
      end_op();
    80004e94:	fffff097          	auipc	ra,0xfffff
    80004e98:	980080e7          	jalr	-1664(ra) # 80003814 <end_op>
      return -1;
    80004e9c:	557d                	li	a0,-1
    80004e9e:	b76d                	j	80004e48 <sys_open+0xe4>
      end_op();
    80004ea0:	fffff097          	auipc	ra,0xfffff
    80004ea4:	974080e7          	jalr	-1676(ra) # 80003814 <end_op>
      return -1;
    80004ea8:	557d                	li	a0,-1
    80004eaa:	bf79                	j	80004e48 <sys_open+0xe4>
    iunlockput(ip);
    80004eac:	8526                	mv	a0,s1
    80004eae:	ffffe097          	auipc	ra,0xffffe
    80004eb2:	186080e7          	jalr	390(ra) # 80003034 <iunlockput>
    end_op();
    80004eb6:	fffff097          	auipc	ra,0xfffff
    80004eba:	95e080e7          	jalr	-1698(ra) # 80003814 <end_op>
    return -1;
    80004ebe:	557d                	li	a0,-1
    80004ec0:	b761                	j	80004e48 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004ec2:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004ec6:	04649783          	lh	a5,70(s1)
    80004eca:	02f99223          	sh	a5,36(s3)
    80004ece:	bf25                	j	80004e06 <sys_open+0xa2>
    itrunc(ip);
    80004ed0:	8526                	mv	a0,s1
    80004ed2:	ffffe097          	auipc	ra,0xffffe
    80004ed6:	00e080e7          	jalr	14(ra) # 80002ee0 <itrunc>
    80004eda:	bfa9                	j	80004e34 <sys_open+0xd0>
      fileclose(f);
    80004edc:	854e                	mv	a0,s3
    80004ede:	fffff097          	auipc	ra,0xfffff
    80004ee2:	d82080e7          	jalr	-638(ra) # 80003c60 <fileclose>
    iunlockput(ip);
    80004ee6:	8526                	mv	a0,s1
    80004ee8:	ffffe097          	auipc	ra,0xffffe
    80004eec:	14c080e7          	jalr	332(ra) # 80003034 <iunlockput>
    end_op();
    80004ef0:	fffff097          	auipc	ra,0xfffff
    80004ef4:	924080e7          	jalr	-1756(ra) # 80003814 <end_op>
    return -1;
    80004ef8:	557d                	li	a0,-1
    80004efa:	b7b9                	j	80004e48 <sys_open+0xe4>

0000000080004efc <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004efc:	7175                	addi	sp,sp,-144
    80004efe:	e506                	sd	ra,136(sp)
    80004f00:	e122                	sd	s0,128(sp)
    80004f02:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004f04:	fffff097          	auipc	ra,0xfffff
    80004f08:	890080e7          	jalr	-1904(ra) # 80003794 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004f0c:	08000613          	li	a2,128
    80004f10:	f7040593          	addi	a1,s0,-144
    80004f14:	4501                	li	a0,0
    80004f16:	ffffd097          	auipc	ra,0xffffd
    80004f1a:	382080e7          	jalr	898(ra) # 80002298 <argstr>
    80004f1e:	02054963          	bltz	a0,80004f50 <sys_mkdir+0x54>
    80004f22:	4681                	li	a3,0
    80004f24:	4601                	li	a2,0
    80004f26:	4585                	li	a1,1
    80004f28:	f7040513          	addi	a0,s0,-144
    80004f2c:	fffff097          	auipc	ra,0xfffff
    80004f30:	7fe080e7          	jalr	2046(ra) # 8000472a <create>
    80004f34:	cd11                	beqz	a0,80004f50 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f36:	ffffe097          	auipc	ra,0xffffe
    80004f3a:	0fe080e7          	jalr	254(ra) # 80003034 <iunlockput>
  end_op();
    80004f3e:	fffff097          	auipc	ra,0xfffff
    80004f42:	8d6080e7          	jalr	-1834(ra) # 80003814 <end_op>
  return 0;
    80004f46:	4501                	li	a0,0
}
    80004f48:	60aa                	ld	ra,136(sp)
    80004f4a:	640a                	ld	s0,128(sp)
    80004f4c:	6149                	addi	sp,sp,144
    80004f4e:	8082                	ret
    end_op();
    80004f50:	fffff097          	auipc	ra,0xfffff
    80004f54:	8c4080e7          	jalr	-1852(ra) # 80003814 <end_op>
    return -1;
    80004f58:	557d                	li	a0,-1
    80004f5a:	b7fd                	j	80004f48 <sys_mkdir+0x4c>

0000000080004f5c <sys_mknod>:

uint64
sys_mknod(void)
{
    80004f5c:	7135                	addi	sp,sp,-160
    80004f5e:	ed06                	sd	ra,152(sp)
    80004f60:	e922                	sd	s0,144(sp)
    80004f62:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004f64:	fffff097          	auipc	ra,0xfffff
    80004f68:	830080e7          	jalr	-2000(ra) # 80003794 <begin_op>
  argint(1, &major);
    80004f6c:	f6c40593          	addi	a1,s0,-148
    80004f70:	4505                	li	a0,1
    80004f72:	ffffd097          	auipc	ra,0xffffd
    80004f76:	2e6080e7          	jalr	742(ra) # 80002258 <argint>
  argint(2, &minor);
    80004f7a:	f6840593          	addi	a1,s0,-152
    80004f7e:	4509                	li	a0,2
    80004f80:	ffffd097          	auipc	ra,0xffffd
    80004f84:	2d8080e7          	jalr	728(ra) # 80002258 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f88:	08000613          	li	a2,128
    80004f8c:	f7040593          	addi	a1,s0,-144
    80004f90:	4501                	li	a0,0
    80004f92:	ffffd097          	auipc	ra,0xffffd
    80004f96:	306080e7          	jalr	774(ra) # 80002298 <argstr>
    80004f9a:	02054b63          	bltz	a0,80004fd0 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004f9e:	f6841683          	lh	a3,-152(s0)
    80004fa2:	f6c41603          	lh	a2,-148(s0)
    80004fa6:	458d                	li	a1,3
    80004fa8:	f7040513          	addi	a0,s0,-144
    80004fac:	fffff097          	auipc	ra,0xfffff
    80004fb0:	77e080e7          	jalr	1918(ra) # 8000472a <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fb4:	cd11                	beqz	a0,80004fd0 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004fb6:	ffffe097          	auipc	ra,0xffffe
    80004fba:	07e080e7          	jalr	126(ra) # 80003034 <iunlockput>
  end_op();
    80004fbe:	fffff097          	auipc	ra,0xfffff
    80004fc2:	856080e7          	jalr	-1962(ra) # 80003814 <end_op>
  return 0;
    80004fc6:	4501                	li	a0,0
}
    80004fc8:	60ea                	ld	ra,152(sp)
    80004fca:	644a                	ld	s0,144(sp)
    80004fcc:	610d                	addi	sp,sp,160
    80004fce:	8082                	ret
    end_op();
    80004fd0:	fffff097          	auipc	ra,0xfffff
    80004fd4:	844080e7          	jalr	-1980(ra) # 80003814 <end_op>
    return -1;
    80004fd8:	557d                	li	a0,-1
    80004fda:	b7fd                	j	80004fc8 <sys_mknod+0x6c>

0000000080004fdc <sys_chdir>:

uint64
sys_chdir(void)
{
    80004fdc:	7135                	addi	sp,sp,-160
    80004fde:	ed06                	sd	ra,152(sp)
    80004fe0:	e922                	sd	s0,144(sp)
    80004fe2:	e526                	sd	s1,136(sp)
    80004fe4:	e14a                	sd	s2,128(sp)
    80004fe6:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004fe8:	ffffc097          	auipc	ra,0xffffc
    80004fec:	11a080e7          	jalr	282(ra) # 80001102 <myproc>
    80004ff0:	892a                	mv	s2,a0
  
  begin_op();
    80004ff2:	ffffe097          	auipc	ra,0xffffe
    80004ff6:	7a2080e7          	jalr	1954(ra) # 80003794 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004ffa:	08000613          	li	a2,128
    80004ffe:	f6040593          	addi	a1,s0,-160
    80005002:	4501                	li	a0,0
    80005004:	ffffd097          	auipc	ra,0xffffd
    80005008:	294080e7          	jalr	660(ra) # 80002298 <argstr>
    8000500c:	04054b63          	bltz	a0,80005062 <sys_chdir+0x86>
    80005010:	f6040513          	addi	a0,s0,-160
    80005014:	ffffe097          	auipc	ra,0xffffe
    80005018:	564080e7          	jalr	1380(ra) # 80003578 <namei>
    8000501c:	84aa                	mv	s1,a0
    8000501e:	c131                	beqz	a0,80005062 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005020:	ffffe097          	auipc	ra,0xffffe
    80005024:	db2080e7          	jalr	-590(ra) # 80002dd2 <ilock>
  if(ip->type != T_DIR){
    80005028:	04449703          	lh	a4,68(s1)
    8000502c:	4785                	li	a5,1
    8000502e:	04f71063          	bne	a4,a5,8000506e <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005032:	8526                	mv	a0,s1
    80005034:	ffffe097          	auipc	ra,0xffffe
    80005038:	e60080e7          	jalr	-416(ra) # 80002e94 <iunlock>
  iput(p->cwd);
    8000503c:	15093503          	ld	a0,336(s2)
    80005040:	ffffe097          	auipc	ra,0xffffe
    80005044:	f4c080e7          	jalr	-180(ra) # 80002f8c <iput>
  end_op();
    80005048:	ffffe097          	auipc	ra,0xffffe
    8000504c:	7cc080e7          	jalr	1996(ra) # 80003814 <end_op>
  p->cwd = ip;
    80005050:	14993823          	sd	s1,336(s2)
  return 0;
    80005054:	4501                	li	a0,0
}
    80005056:	60ea                	ld	ra,152(sp)
    80005058:	644a                	ld	s0,144(sp)
    8000505a:	64aa                	ld	s1,136(sp)
    8000505c:	690a                	ld	s2,128(sp)
    8000505e:	610d                	addi	sp,sp,160
    80005060:	8082                	ret
    end_op();
    80005062:	ffffe097          	auipc	ra,0xffffe
    80005066:	7b2080e7          	jalr	1970(ra) # 80003814 <end_op>
    return -1;
    8000506a:	557d                	li	a0,-1
    8000506c:	b7ed                	j	80005056 <sys_chdir+0x7a>
    iunlockput(ip);
    8000506e:	8526                	mv	a0,s1
    80005070:	ffffe097          	auipc	ra,0xffffe
    80005074:	fc4080e7          	jalr	-60(ra) # 80003034 <iunlockput>
    end_op();
    80005078:	ffffe097          	auipc	ra,0xffffe
    8000507c:	79c080e7          	jalr	1948(ra) # 80003814 <end_op>
    return -1;
    80005080:	557d                	li	a0,-1
    80005082:	bfd1                	j	80005056 <sys_chdir+0x7a>

0000000080005084 <sys_exec>:

uint64
sys_exec(void)
{
    80005084:	7145                	addi	sp,sp,-464
    80005086:	e786                	sd	ra,456(sp)
    80005088:	e3a2                	sd	s0,448(sp)
    8000508a:	ff26                	sd	s1,440(sp)
    8000508c:	fb4a                	sd	s2,432(sp)
    8000508e:	f74e                	sd	s3,424(sp)
    80005090:	f352                	sd	s4,416(sp)
    80005092:	ef56                	sd	s5,408(sp)
    80005094:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005096:	e3840593          	addi	a1,s0,-456
    8000509a:	4505                	li	a0,1
    8000509c:	ffffd097          	auipc	ra,0xffffd
    800050a0:	1dc080e7          	jalr	476(ra) # 80002278 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800050a4:	08000613          	li	a2,128
    800050a8:	f4040593          	addi	a1,s0,-192
    800050ac:	4501                	li	a0,0
    800050ae:	ffffd097          	auipc	ra,0xffffd
    800050b2:	1ea080e7          	jalr	490(ra) # 80002298 <argstr>
    800050b6:	87aa                	mv	a5,a0
    return -1;
    800050b8:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    800050ba:	0c07c263          	bltz	a5,8000517e <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    800050be:	10000613          	li	a2,256
    800050c2:	4581                	li	a1,0
    800050c4:	e4040513          	addi	a0,s0,-448
    800050c8:	ffffb097          	auipc	ra,0xffffb
    800050cc:	1bc080e7          	jalr	444(ra) # 80000284 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800050d0:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800050d4:	89a6                	mv	s3,s1
    800050d6:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800050d8:	02000a13          	li	s4,32
    800050dc:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800050e0:	00391513          	slli	a0,s2,0x3
    800050e4:	e3040593          	addi	a1,s0,-464
    800050e8:	e3843783          	ld	a5,-456(s0)
    800050ec:	953e                	add	a0,a0,a5
    800050ee:	ffffd097          	auipc	ra,0xffffd
    800050f2:	0cc080e7          	jalr	204(ra) # 800021ba <fetchaddr>
    800050f6:	02054a63          	bltz	a0,8000512a <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    800050fa:	e3043783          	ld	a5,-464(s0)
    800050fe:	c3b9                	beqz	a5,80005144 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005100:	ffffb097          	auipc	ra,0xffffb
    80005104:	102080e7          	jalr	258(ra) # 80000202 <kalloc>
    80005108:	85aa                	mv	a1,a0
    8000510a:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    8000510e:	cd11                	beqz	a0,8000512a <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005110:	6605                	lui	a2,0x1
    80005112:	e3043503          	ld	a0,-464(s0)
    80005116:	ffffd097          	auipc	ra,0xffffd
    8000511a:	0f6080e7          	jalr	246(ra) # 8000220c <fetchstr>
    8000511e:	00054663          	bltz	a0,8000512a <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80005122:	0905                	addi	s2,s2,1
    80005124:	09a1                	addi	s3,s3,8
    80005126:	fb491be3          	bne	s2,s4,800050dc <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000512a:	10048913          	addi	s2,s1,256
    8000512e:	6088                	ld	a0,0(s1)
    80005130:	c531                	beqz	a0,8000517c <sys_exec+0xf8>
    kfree(argv[i]);
    80005132:	ffffb097          	auipc	ra,0xffffb
    80005136:	f8a080e7          	jalr	-118(ra) # 800000bc <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000513a:	04a1                	addi	s1,s1,8
    8000513c:	ff2499e3          	bne	s1,s2,8000512e <sys_exec+0xaa>
  return -1;
    80005140:	557d                	li	a0,-1
    80005142:	a835                	j	8000517e <sys_exec+0xfa>
      argv[i] = 0;
    80005144:	0a8e                	slli	s5,s5,0x3
    80005146:	fc040793          	addi	a5,s0,-64
    8000514a:	9abe                	add	s5,s5,a5
    8000514c:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005150:	e4040593          	addi	a1,s0,-448
    80005154:	f4040513          	addi	a0,s0,-192
    80005158:	fffff097          	auipc	ra,0xfffff
    8000515c:	190080e7          	jalr	400(ra) # 800042e8 <exec>
    80005160:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005162:	10048993          	addi	s3,s1,256
    80005166:	6088                	ld	a0,0(s1)
    80005168:	c901                	beqz	a0,80005178 <sys_exec+0xf4>
    kfree(argv[i]);
    8000516a:	ffffb097          	auipc	ra,0xffffb
    8000516e:	f52080e7          	jalr	-174(ra) # 800000bc <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005172:	04a1                	addi	s1,s1,8
    80005174:	ff3499e3          	bne	s1,s3,80005166 <sys_exec+0xe2>
  return ret;
    80005178:	854a                	mv	a0,s2
    8000517a:	a011                	j	8000517e <sys_exec+0xfa>
  return -1;
    8000517c:	557d                	li	a0,-1
}
    8000517e:	60be                	ld	ra,456(sp)
    80005180:	641e                	ld	s0,448(sp)
    80005182:	74fa                	ld	s1,440(sp)
    80005184:	795a                	ld	s2,432(sp)
    80005186:	79ba                	ld	s3,424(sp)
    80005188:	7a1a                	ld	s4,416(sp)
    8000518a:	6afa                	ld	s5,408(sp)
    8000518c:	6179                	addi	sp,sp,464
    8000518e:	8082                	ret

0000000080005190 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005190:	7139                	addi	sp,sp,-64
    80005192:	fc06                	sd	ra,56(sp)
    80005194:	f822                	sd	s0,48(sp)
    80005196:	f426                	sd	s1,40(sp)
    80005198:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000519a:	ffffc097          	auipc	ra,0xffffc
    8000519e:	f68080e7          	jalr	-152(ra) # 80001102 <myproc>
    800051a2:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    800051a4:	fd840593          	addi	a1,s0,-40
    800051a8:	4501                	li	a0,0
    800051aa:	ffffd097          	auipc	ra,0xffffd
    800051ae:	0ce080e7          	jalr	206(ra) # 80002278 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800051b2:	fc840593          	addi	a1,s0,-56
    800051b6:	fd040513          	addi	a0,s0,-48
    800051ba:	fffff097          	auipc	ra,0xfffff
    800051be:	dd6080e7          	jalr	-554(ra) # 80003f90 <pipealloc>
    return -1;
    800051c2:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800051c4:	0c054463          	bltz	a0,8000528c <sys_pipe+0xfc>
  fd0 = -1;
    800051c8:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800051cc:	fd043503          	ld	a0,-48(s0)
    800051d0:	fffff097          	auipc	ra,0xfffff
    800051d4:	518080e7          	jalr	1304(ra) # 800046e8 <fdalloc>
    800051d8:	fca42223          	sw	a0,-60(s0)
    800051dc:	08054b63          	bltz	a0,80005272 <sys_pipe+0xe2>
    800051e0:	fc843503          	ld	a0,-56(s0)
    800051e4:	fffff097          	auipc	ra,0xfffff
    800051e8:	504080e7          	jalr	1284(ra) # 800046e8 <fdalloc>
    800051ec:	fca42023          	sw	a0,-64(s0)
    800051f0:	06054863          	bltz	a0,80005260 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051f4:	4691                	li	a3,4
    800051f6:	fc440613          	addi	a2,s0,-60
    800051fa:	fd843583          	ld	a1,-40(s0)
    800051fe:	68a8                	ld	a0,80(s1)
    80005200:	ffffc097          	auipc	ra,0xffffc
    80005204:	b48080e7          	jalr	-1208(ra) # 80000d48 <copyout>
    80005208:	02054063          	bltz	a0,80005228 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000520c:	4691                	li	a3,4
    8000520e:	fc040613          	addi	a2,s0,-64
    80005212:	fd843583          	ld	a1,-40(s0)
    80005216:	0591                	addi	a1,a1,4
    80005218:	68a8                	ld	a0,80(s1)
    8000521a:	ffffc097          	auipc	ra,0xffffc
    8000521e:	b2e080e7          	jalr	-1234(ra) # 80000d48 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005222:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005224:	06055463          	bgez	a0,8000528c <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005228:	fc442783          	lw	a5,-60(s0)
    8000522c:	07e9                	addi	a5,a5,26
    8000522e:	078e                	slli	a5,a5,0x3
    80005230:	97a6                	add	a5,a5,s1
    80005232:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005236:	fc042503          	lw	a0,-64(s0)
    8000523a:	0569                	addi	a0,a0,26
    8000523c:	050e                	slli	a0,a0,0x3
    8000523e:	94aa                	add	s1,s1,a0
    80005240:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80005244:	fd043503          	ld	a0,-48(s0)
    80005248:	fffff097          	auipc	ra,0xfffff
    8000524c:	a18080e7          	jalr	-1512(ra) # 80003c60 <fileclose>
    fileclose(wf);
    80005250:	fc843503          	ld	a0,-56(s0)
    80005254:	fffff097          	auipc	ra,0xfffff
    80005258:	a0c080e7          	jalr	-1524(ra) # 80003c60 <fileclose>
    return -1;
    8000525c:	57fd                	li	a5,-1
    8000525e:	a03d                	j	8000528c <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005260:	fc442783          	lw	a5,-60(s0)
    80005264:	0007c763          	bltz	a5,80005272 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80005268:	07e9                	addi	a5,a5,26
    8000526a:	078e                	slli	a5,a5,0x3
    8000526c:	94be                	add	s1,s1,a5
    8000526e:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80005272:	fd043503          	ld	a0,-48(s0)
    80005276:	fffff097          	auipc	ra,0xfffff
    8000527a:	9ea080e7          	jalr	-1558(ra) # 80003c60 <fileclose>
    fileclose(wf);
    8000527e:	fc843503          	ld	a0,-56(s0)
    80005282:	fffff097          	auipc	ra,0xfffff
    80005286:	9de080e7          	jalr	-1570(ra) # 80003c60 <fileclose>
    return -1;
    8000528a:	57fd                	li	a5,-1
}
    8000528c:	853e                	mv	a0,a5
    8000528e:	70e2                	ld	ra,56(sp)
    80005290:	7442                	ld	s0,48(sp)
    80005292:	74a2                	ld	s1,40(sp)
    80005294:	6121                	addi	sp,sp,64
    80005296:	8082                	ret
	...

00000000800052a0 <kernelvec>:
    800052a0:	7111                	addi	sp,sp,-256
    800052a2:	e006                	sd	ra,0(sp)
    800052a4:	e40a                	sd	sp,8(sp)
    800052a6:	e80e                	sd	gp,16(sp)
    800052a8:	ec12                	sd	tp,24(sp)
    800052aa:	f016                	sd	t0,32(sp)
    800052ac:	f41a                	sd	t1,40(sp)
    800052ae:	f81e                	sd	t2,48(sp)
    800052b0:	fc22                	sd	s0,56(sp)
    800052b2:	e0a6                	sd	s1,64(sp)
    800052b4:	e4aa                	sd	a0,72(sp)
    800052b6:	e8ae                	sd	a1,80(sp)
    800052b8:	ecb2                	sd	a2,88(sp)
    800052ba:	f0b6                	sd	a3,96(sp)
    800052bc:	f4ba                	sd	a4,104(sp)
    800052be:	f8be                	sd	a5,112(sp)
    800052c0:	fcc2                	sd	a6,120(sp)
    800052c2:	e146                	sd	a7,128(sp)
    800052c4:	e54a                	sd	s2,136(sp)
    800052c6:	e94e                	sd	s3,144(sp)
    800052c8:	ed52                	sd	s4,152(sp)
    800052ca:	f156                	sd	s5,160(sp)
    800052cc:	f55a                	sd	s6,168(sp)
    800052ce:	f95e                	sd	s7,176(sp)
    800052d0:	fd62                	sd	s8,184(sp)
    800052d2:	e1e6                	sd	s9,192(sp)
    800052d4:	e5ea                	sd	s10,200(sp)
    800052d6:	e9ee                	sd	s11,208(sp)
    800052d8:	edf2                	sd	t3,216(sp)
    800052da:	f1f6                	sd	t4,224(sp)
    800052dc:	f5fa                	sd	t5,232(sp)
    800052de:	f9fe                	sd	t6,240(sp)
    800052e0:	da7fc0ef          	jal	ra,80002086 <kerneltrap>
    800052e4:	6082                	ld	ra,0(sp)
    800052e6:	6122                	ld	sp,8(sp)
    800052e8:	61c2                	ld	gp,16(sp)
    800052ea:	7282                	ld	t0,32(sp)
    800052ec:	7322                	ld	t1,40(sp)
    800052ee:	73c2                	ld	t2,48(sp)
    800052f0:	7462                	ld	s0,56(sp)
    800052f2:	6486                	ld	s1,64(sp)
    800052f4:	6526                	ld	a0,72(sp)
    800052f6:	65c6                	ld	a1,80(sp)
    800052f8:	6666                	ld	a2,88(sp)
    800052fa:	7686                	ld	a3,96(sp)
    800052fc:	7726                	ld	a4,104(sp)
    800052fe:	77c6                	ld	a5,112(sp)
    80005300:	7866                	ld	a6,120(sp)
    80005302:	688a                	ld	a7,128(sp)
    80005304:	692a                	ld	s2,136(sp)
    80005306:	69ca                	ld	s3,144(sp)
    80005308:	6a6a                	ld	s4,152(sp)
    8000530a:	7a8a                	ld	s5,160(sp)
    8000530c:	7b2a                	ld	s6,168(sp)
    8000530e:	7bca                	ld	s7,176(sp)
    80005310:	7c6a                	ld	s8,184(sp)
    80005312:	6c8e                	ld	s9,192(sp)
    80005314:	6d2e                	ld	s10,200(sp)
    80005316:	6dce                	ld	s11,208(sp)
    80005318:	6e6e                	ld	t3,216(sp)
    8000531a:	7e8e                	ld	t4,224(sp)
    8000531c:	7f2e                	ld	t5,232(sp)
    8000531e:	7fce                	ld	t6,240(sp)
    80005320:	6111                	addi	sp,sp,256
    80005322:	10200073          	sret
    80005326:	00000013          	nop
    8000532a:	00000013          	nop
    8000532e:	0001                	nop

0000000080005330 <timervec>:
    80005330:	34051573          	csrrw	a0,mscratch,a0
    80005334:	e10c                	sd	a1,0(a0)
    80005336:	e510                	sd	a2,8(a0)
    80005338:	e914                	sd	a3,16(a0)
    8000533a:	6d0c                	ld	a1,24(a0)
    8000533c:	7110                	ld	a2,32(a0)
    8000533e:	6194                	ld	a3,0(a1)
    80005340:	96b2                	add	a3,a3,a2
    80005342:	e194                	sd	a3,0(a1)
    80005344:	4589                	li	a1,2
    80005346:	14459073          	csrw	sip,a1
    8000534a:	6914                	ld	a3,16(a0)
    8000534c:	6510                	ld	a2,8(a0)
    8000534e:	610c                	ld	a1,0(a0)
    80005350:	34051573          	csrrw	a0,mscratch,a0
    80005354:	30200073          	mret
	...

000000008000535a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000535a:	1141                	addi	sp,sp,-16
    8000535c:	e422                	sd	s0,8(sp)
    8000535e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005360:	0c0007b7          	lui	a5,0xc000
    80005364:	4705                	li	a4,1
    80005366:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005368:	c3d8                	sw	a4,4(a5)
}
    8000536a:	6422                	ld	s0,8(sp)
    8000536c:	0141                	addi	sp,sp,16
    8000536e:	8082                	ret

0000000080005370 <plicinithart>:

void
plicinithart(void)
{
    80005370:	1141                	addi	sp,sp,-16
    80005372:	e406                	sd	ra,8(sp)
    80005374:	e022                	sd	s0,0(sp)
    80005376:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005378:	ffffc097          	auipc	ra,0xffffc
    8000537c:	d5e080e7          	jalr	-674(ra) # 800010d6 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005380:	0085171b          	slliw	a4,a0,0x8
    80005384:	0c0027b7          	lui	a5,0xc002
    80005388:	97ba                	add	a5,a5,a4
    8000538a:	40200713          	li	a4,1026
    8000538e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005392:	00d5151b          	slliw	a0,a0,0xd
    80005396:	0c2017b7          	lui	a5,0xc201
    8000539a:	953e                	add	a0,a0,a5
    8000539c:	00052023          	sw	zero,0(a0)
}
    800053a0:	60a2                	ld	ra,8(sp)
    800053a2:	6402                	ld	s0,0(sp)
    800053a4:	0141                	addi	sp,sp,16
    800053a6:	8082                	ret

00000000800053a8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800053a8:	1141                	addi	sp,sp,-16
    800053aa:	e406                	sd	ra,8(sp)
    800053ac:	e022                	sd	s0,0(sp)
    800053ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800053b0:	ffffc097          	auipc	ra,0xffffc
    800053b4:	d26080e7          	jalr	-730(ra) # 800010d6 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800053b8:	00d5179b          	slliw	a5,a0,0xd
    800053bc:	0c201537          	lui	a0,0xc201
    800053c0:	953e                	add	a0,a0,a5
  return irq;
}
    800053c2:	4148                	lw	a0,4(a0)
    800053c4:	60a2                	ld	ra,8(sp)
    800053c6:	6402                	ld	s0,0(sp)
    800053c8:	0141                	addi	sp,sp,16
    800053ca:	8082                	ret

00000000800053cc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800053cc:	1101                	addi	sp,sp,-32
    800053ce:	ec06                	sd	ra,24(sp)
    800053d0:	e822                	sd	s0,16(sp)
    800053d2:	e426                	sd	s1,8(sp)
    800053d4:	1000                	addi	s0,sp,32
    800053d6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800053d8:	ffffc097          	auipc	ra,0xffffc
    800053dc:	cfe080e7          	jalr	-770(ra) # 800010d6 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800053e0:	00d5151b          	slliw	a0,a0,0xd
    800053e4:	0c2017b7          	lui	a5,0xc201
    800053e8:	97aa                	add	a5,a5,a0
    800053ea:	c3c4                	sw	s1,4(a5)
}
    800053ec:	60e2                	ld	ra,24(sp)
    800053ee:	6442                	ld	s0,16(sp)
    800053f0:	64a2                	ld	s1,8(sp)
    800053f2:	6105                	addi	sp,sp,32
    800053f4:	8082                	ret

00000000800053f6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800053f6:	1141                	addi	sp,sp,-16
    800053f8:	e406                	sd	ra,8(sp)
    800053fa:	e022                	sd	s0,0(sp)
    800053fc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800053fe:	479d                	li	a5,7
    80005400:	04a7cc63          	blt	a5,a0,80005458 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005404:	00034797          	auipc	a5,0x34
    80005408:	7a478793          	addi	a5,a5,1956 # 80039ba8 <disk>
    8000540c:	97aa                	add	a5,a5,a0
    8000540e:	0187c783          	lbu	a5,24(a5)
    80005412:	ebb9                	bnez	a5,80005468 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005414:	00451613          	slli	a2,a0,0x4
    80005418:	00034797          	auipc	a5,0x34
    8000541c:	79078793          	addi	a5,a5,1936 # 80039ba8 <disk>
    80005420:	6394                	ld	a3,0(a5)
    80005422:	96b2                	add	a3,a3,a2
    80005424:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005428:	6398                	ld	a4,0(a5)
    8000542a:	9732                	add	a4,a4,a2
    8000542c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005430:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005434:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005438:	953e                	add	a0,a0,a5
    8000543a:	4785                	li	a5,1
    8000543c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005440:	00034517          	auipc	a0,0x34
    80005444:	78050513          	addi	a0,a0,1920 # 80039bc0 <disk+0x18>
    80005448:	ffffc097          	auipc	ra,0xffffc
    8000544c:	3c6080e7          	jalr	966(ra) # 8000180e <wakeup>
}
    80005450:	60a2                	ld	ra,8(sp)
    80005452:	6402                	ld	s0,0(sp)
    80005454:	0141                	addi	sp,sp,16
    80005456:	8082                	ret
    panic("free_desc 1");
    80005458:	00003517          	auipc	a0,0x3
    8000545c:	42050513          	addi	a0,a0,1056 # 80008878 <syscalls+0x2f0>
    80005460:	00001097          	auipc	ra,0x1
    80005464:	a72080e7          	jalr	-1422(ra) # 80005ed2 <panic>
    panic("free_desc 2");
    80005468:	00003517          	auipc	a0,0x3
    8000546c:	42050513          	addi	a0,a0,1056 # 80008888 <syscalls+0x300>
    80005470:	00001097          	auipc	ra,0x1
    80005474:	a62080e7          	jalr	-1438(ra) # 80005ed2 <panic>

0000000080005478 <virtio_disk_init>:
{
    80005478:	1101                	addi	sp,sp,-32
    8000547a:	ec06                	sd	ra,24(sp)
    8000547c:	e822                	sd	s0,16(sp)
    8000547e:	e426                	sd	s1,8(sp)
    80005480:	e04a                	sd	s2,0(sp)
    80005482:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005484:	00003597          	auipc	a1,0x3
    80005488:	41458593          	addi	a1,a1,1044 # 80008898 <syscalls+0x310>
    8000548c:	00035517          	auipc	a0,0x35
    80005490:	84450513          	addi	a0,a0,-1980 # 80039cd0 <disk+0x128>
    80005494:	00001097          	auipc	ra,0x1
    80005498:	ef8080e7          	jalr	-264(ra) # 8000638c <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000549c:	100017b7          	lui	a5,0x10001
    800054a0:	4398                	lw	a4,0(a5)
    800054a2:	2701                	sext.w	a4,a4
    800054a4:	747277b7          	lui	a5,0x74727
    800054a8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800054ac:	14f71e63          	bne	a4,a5,80005608 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800054b0:	100017b7          	lui	a5,0x10001
    800054b4:	43dc                	lw	a5,4(a5)
    800054b6:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800054b8:	4709                	li	a4,2
    800054ba:	14e79763          	bne	a5,a4,80005608 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800054be:	100017b7          	lui	a5,0x10001
    800054c2:	479c                	lw	a5,8(a5)
    800054c4:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800054c6:	14e79163          	bne	a5,a4,80005608 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800054ca:	100017b7          	lui	a5,0x10001
    800054ce:	47d8                	lw	a4,12(a5)
    800054d0:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800054d2:	554d47b7          	lui	a5,0x554d4
    800054d6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800054da:	12f71763          	bne	a4,a5,80005608 <virtio_disk_init+0x190>
  *R(VIRTIO_MMIO_STATUS) = status;
    800054de:	100017b7          	lui	a5,0x10001
    800054e2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800054e6:	4705                	li	a4,1
    800054e8:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054ea:	470d                	li	a4,3
    800054ec:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800054ee:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800054f0:	c7ffe737          	lui	a4,0xc7ffe
    800054f4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fbc82f>
    800054f8:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800054fa:	2701                	sext.w	a4,a4
    800054fc:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054fe:	472d                	li	a4,11
    80005500:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005502:	0707a903          	lw	s2,112(a5)
    80005506:	2901                	sext.w	s2,s2
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005508:	00897793          	andi	a5,s2,8
    8000550c:	10078663          	beqz	a5,80005618 <virtio_disk_init+0x1a0>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005510:	100017b7          	lui	a5,0x10001
    80005514:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005518:	43fc                	lw	a5,68(a5)
    8000551a:	2781                	sext.w	a5,a5
    8000551c:	10079663          	bnez	a5,80005628 <virtio_disk_init+0x1b0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005520:	100017b7          	lui	a5,0x10001
    80005524:	5bdc                	lw	a5,52(a5)
    80005526:	2781                	sext.w	a5,a5
  if(max == 0)
    80005528:	10078863          	beqz	a5,80005638 <virtio_disk_init+0x1c0>
  if(max < NUM)
    8000552c:	471d                	li	a4,7
    8000552e:	10f77d63          	bgeu	a4,a5,80005648 <virtio_disk_init+0x1d0>
  disk.desc = kalloc();
    80005532:	ffffb097          	auipc	ra,0xffffb
    80005536:	cd0080e7          	jalr	-816(ra) # 80000202 <kalloc>
    8000553a:	00034497          	auipc	s1,0x34
    8000553e:	66e48493          	addi	s1,s1,1646 # 80039ba8 <disk>
    80005542:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005544:	ffffb097          	auipc	ra,0xffffb
    80005548:	cbe080e7          	jalr	-834(ra) # 80000202 <kalloc>
    8000554c:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000554e:	ffffb097          	auipc	ra,0xffffb
    80005552:	cb4080e7          	jalr	-844(ra) # 80000202 <kalloc>
    80005556:	87aa                	mv	a5,a0
    80005558:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    8000555a:	6088                	ld	a0,0(s1)
    8000555c:	cd75                	beqz	a0,80005658 <virtio_disk_init+0x1e0>
    8000555e:	00034717          	auipc	a4,0x34
    80005562:	65273703          	ld	a4,1618(a4) # 80039bb0 <disk+0x8>
    80005566:	cb6d                	beqz	a4,80005658 <virtio_disk_init+0x1e0>
    80005568:	cbe5                	beqz	a5,80005658 <virtio_disk_init+0x1e0>
  memset(disk.desc, 0, PGSIZE);
    8000556a:	6605                	lui	a2,0x1
    8000556c:	4581                	li	a1,0
    8000556e:	ffffb097          	auipc	ra,0xffffb
    80005572:	d16080e7          	jalr	-746(ra) # 80000284 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005576:	00034497          	auipc	s1,0x34
    8000557a:	63248493          	addi	s1,s1,1586 # 80039ba8 <disk>
    8000557e:	6605                	lui	a2,0x1
    80005580:	4581                	li	a1,0
    80005582:	6488                	ld	a0,8(s1)
    80005584:	ffffb097          	auipc	ra,0xffffb
    80005588:	d00080e7          	jalr	-768(ra) # 80000284 <memset>
  memset(disk.used, 0, PGSIZE);
    8000558c:	6605                	lui	a2,0x1
    8000558e:	4581                	li	a1,0
    80005590:	6888                	ld	a0,16(s1)
    80005592:	ffffb097          	auipc	ra,0xffffb
    80005596:	cf2080e7          	jalr	-782(ra) # 80000284 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000559a:	100017b7          	lui	a5,0x10001
    8000559e:	4721                	li	a4,8
    800055a0:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800055a2:	4098                	lw	a4,0(s1)
    800055a4:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800055a8:	40d8                	lw	a4,4(s1)
    800055aa:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800055ae:	6498                	ld	a4,8(s1)
    800055b0:	0007069b          	sext.w	a3,a4
    800055b4:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800055b8:	9701                	srai	a4,a4,0x20
    800055ba:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800055be:	6898                	ld	a4,16(s1)
    800055c0:	0007069b          	sext.w	a3,a4
    800055c4:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800055c8:	9701                	srai	a4,a4,0x20
    800055ca:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800055ce:	4685                	li	a3,1
    800055d0:	c3f4                	sw	a3,68(a5)
    disk.free[i] = 1;
    800055d2:	4705                	li	a4,1
    800055d4:	00d48c23          	sb	a3,24(s1)
    800055d8:	00e48ca3          	sb	a4,25(s1)
    800055dc:	00e48d23          	sb	a4,26(s1)
    800055e0:	00e48da3          	sb	a4,27(s1)
    800055e4:	00e48e23          	sb	a4,28(s1)
    800055e8:	00e48ea3          	sb	a4,29(s1)
    800055ec:	00e48f23          	sb	a4,30(s1)
    800055f0:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800055f4:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800055f8:	0727a823          	sw	s2,112(a5)
}
    800055fc:	60e2                	ld	ra,24(sp)
    800055fe:	6442                	ld	s0,16(sp)
    80005600:	64a2                	ld	s1,8(sp)
    80005602:	6902                	ld	s2,0(sp)
    80005604:	6105                	addi	sp,sp,32
    80005606:	8082                	ret
    panic("could not find virtio disk");
    80005608:	00003517          	auipc	a0,0x3
    8000560c:	2a050513          	addi	a0,a0,672 # 800088a8 <syscalls+0x320>
    80005610:	00001097          	auipc	ra,0x1
    80005614:	8c2080e7          	jalr	-1854(ra) # 80005ed2 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005618:	00003517          	auipc	a0,0x3
    8000561c:	2b050513          	addi	a0,a0,688 # 800088c8 <syscalls+0x340>
    80005620:	00001097          	auipc	ra,0x1
    80005624:	8b2080e7          	jalr	-1870(ra) # 80005ed2 <panic>
    panic("virtio disk should not be ready");
    80005628:	00003517          	auipc	a0,0x3
    8000562c:	2c050513          	addi	a0,a0,704 # 800088e8 <syscalls+0x360>
    80005630:	00001097          	auipc	ra,0x1
    80005634:	8a2080e7          	jalr	-1886(ra) # 80005ed2 <panic>
    panic("virtio disk has no queue 0");
    80005638:	00003517          	auipc	a0,0x3
    8000563c:	2d050513          	addi	a0,a0,720 # 80008908 <syscalls+0x380>
    80005640:	00001097          	auipc	ra,0x1
    80005644:	892080e7          	jalr	-1902(ra) # 80005ed2 <panic>
    panic("virtio disk max queue too short");
    80005648:	00003517          	auipc	a0,0x3
    8000564c:	2e050513          	addi	a0,a0,736 # 80008928 <syscalls+0x3a0>
    80005650:	00001097          	auipc	ra,0x1
    80005654:	882080e7          	jalr	-1918(ra) # 80005ed2 <panic>
    panic("virtio disk kalloc");
    80005658:	00003517          	auipc	a0,0x3
    8000565c:	2f050513          	addi	a0,a0,752 # 80008948 <syscalls+0x3c0>
    80005660:	00001097          	auipc	ra,0x1
    80005664:	872080e7          	jalr	-1934(ra) # 80005ed2 <panic>

0000000080005668 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005668:	7159                	addi	sp,sp,-112
    8000566a:	f486                	sd	ra,104(sp)
    8000566c:	f0a2                	sd	s0,96(sp)
    8000566e:	eca6                	sd	s1,88(sp)
    80005670:	e8ca                	sd	s2,80(sp)
    80005672:	e4ce                	sd	s3,72(sp)
    80005674:	e0d2                	sd	s4,64(sp)
    80005676:	fc56                	sd	s5,56(sp)
    80005678:	f85a                	sd	s6,48(sp)
    8000567a:	f45e                	sd	s7,40(sp)
    8000567c:	f062                	sd	s8,32(sp)
    8000567e:	ec66                	sd	s9,24(sp)
    80005680:	e86a                	sd	s10,16(sp)
    80005682:	1880                	addi	s0,sp,112
    80005684:	892a                	mv	s2,a0
    80005686:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005688:	00c52c83          	lw	s9,12(a0)
    8000568c:	001c9c9b          	slliw	s9,s9,0x1
    80005690:	1c82                	slli	s9,s9,0x20
    80005692:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005696:	00034517          	auipc	a0,0x34
    8000569a:	63a50513          	addi	a0,a0,1594 # 80039cd0 <disk+0x128>
    8000569e:	00001097          	auipc	ra,0x1
    800056a2:	d7e080e7          	jalr	-642(ra) # 8000641c <acquire>
  for(int i = 0; i < 3; i++){
    800056a6:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800056a8:	4ba1                	li	s7,8
      disk.free[i] = 0;
    800056aa:	00034b17          	auipc	s6,0x34
    800056ae:	4feb0b13          	addi	s6,s6,1278 # 80039ba8 <disk>
  for(int i = 0; i < 3; i++){
    800056b2:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    800056b4:	8a4e                	mv	s4,s3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800056b6:	00034c17          	auipc	s8,0x34
    800056ba:	61ac0c13          	addi	s8,s8,1562 # 80039cd0 <disk+0x128>
    800056be:	a8b5                	j	8000573a <virtio_disk_rw+0xd2>
      disk.free[i] = 0;
    800056c0:	00fb06b3          	add	a3,s6,a5
    800056c4:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    800056c8:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    800056ca:	0207c563          	bltz	a5,800056f4 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    800056ce:	2485                	addiw	s1,s1,1
    800056d0:	0711                	addi	a4,a4,4
    800056d2:	1f548a63          	beq	s1,s5,800058c6 <virtio_disk_rw+0x25e>
    idx[i] = alloc_desc();
    800056d6:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    800056d8:	00034697          	auipc	a3,0x34
    800056dc:	4d068693          	addi	a3,a3,1232 # 80039ba8 <disk>
    800056e0:	87d2                	mv	a5,s4
    if(disk.free[i]){
    800056e2:	0186c583          	lbu	a1,24(a3)
    800056e6:	fde9                	bnez	a1,800056c0 <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    800056e8:	2785                	addiw	a5,a5,1
    800056ea:	0685                	addi	a3,a3,1
    800056ec:	ff779be3          	bne	a5,s7,800056e2 <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    800056f0:	57fd                	li	a5,-1
    800056f2:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    800056f4:	02905a63          	blez	s1,80005728 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056f8:	f9042503          	lw	a0,-112(s0)
    800056fc:	00000097          	auipc	ra,0x0
    80005700:	cfa080e7          	jalr	-774(ra) # 800053f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005704:	4785                	li	a5,1
    80005706:	0297d163          	bge	a5,s1,80005728 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    8000570a:	f9442503          	lw	a0,-108(s0)
    8000570e:	00000097          	auipc	ra,0x0
    80005712:	ce8080e7          	jalr	-792(ra) # 800053f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005716:	4789                	li	a5,2
    80005718:	0097d863          	bge	a5,s1,80005728 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    8000571c:	f9842503          	lw	a0,-104(s0)
    80005720:	00000097          	auipc	ra,0x0
    80005724:	cd6080e7          	jalr	-810(ra) # 800053f6 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005728:	85e2                	mv	a1,s8
    8000572a:	00034517          	auipc	a0,0x34
    8000572e:	49650513          	addi	a0,a0,1174 # 80039bc0 <disk+0x18>
    80005732:	ffffc097          	auipc	ra,0xffffc
    80005736:	078080e7          	jalr	120(ra) # 800017aa <sleep>
  for(int i = 0; i < 3; i++){
    8000573a:	f9040713          	addi	a4,s0,-112
    8000573e:	84ce                	mv	s1,s3
    80005740:	bf59                	j	800056d6 <virtio_disk_rw+0x6e>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005742:	00a60793          	addi	a5,a2,10 # 100a <_entry-0x7fffeff6>
    80005746:	00479693          	slli	a3,a5,0x4
    8000574a:	00034797          	auipc	a5,0x34
    8000574e:	45e78793          	addi	a5,a5,1118 # 80039ba8 <disk>
    80005752:	97b6                	add	a5,a5,a3
    80005754:	4685                	li	a3,1
    80005756:	c794                	sw	a3,8(a5)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005758:	00034597          	auipc	a1,0x34
    8000575c:	45058593          	addi	a1,a1,1104 # 80039ba8 <disk>
    80005760:	00a60793          	addi	a5,a2,10
    80005764:	0792                	slli	a5,a5,0x4
    80005766:	97ae                	add	a5,a5,a1
    80005768:	0007a623          	sw	zero,12(a5)
  buf0->sector = sector;
    8000576c:	0197b823          	sd	s9,16(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005770:	f6070693          	addi	a3,a4,-160
    80005774:	619c                	ld	a5,0(a1)
    80005776:	97b6                	add	a5,a5,a3
    80005778:	e388                	sd	a0,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000577a:	6188                	ld	a0,0(a1)
    8000577c:	96aa                	add	a3,a3,a0
    8000577e:	47c1                	li	a5,16
    80005780:	c69c                	sw	a5,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005782:	4785                	li	a5,1
    80005784:	00f69623          	sh	a5,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80005788:	f9442783          	lw	a5,-108(s0)
    8000578c:	00f69723          	sh	a5,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005790:	0792                	slli	a5,a5,0x4
    80005792:	953e                	add	a0,a0,a5
    80005794:	05890693          	addi	a3,s2,88
    80005798:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    8000579a:	6188                	ld	a0,0(a1)
    8000579c:	97aa                	add	a5,a5,a0
    8000579e:	40000693          	li	a3,1024
    800057a2:	c794                	sw	a3,8(a5)
  if(write)
    800057a4:	100d0d63          	beqz	s10,800058be <virtio_disk_rw+0x256>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800057a8:	00079623          	sh	zero,12(a5)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800057ac:	00c7d683          	lhu	a3,12(a5)
    800057b0:	0016e693          	ori	a3,a3,1
    800057b4:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[1]].next = idx[2];
    800057b8:	f9842583          	lw	a1,-104(s0)
    800057bc:	00b79723          	sh	a1,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800057c0:	00034697          	auipc	a3,0x34
    800057c4:	3e868693          	addi	a3,a3,1000 # 80039ba8 <disk>
    800057c8:	00260793          	addi	a5,a2,2
    800057cc:	0792                	slli	a5,a5,0x4
    800057ce:	97b6                	add	a5,a5,a3
    800057d0:	587d                	li	a6,-1
    800057d2:	01078823          	sb	a6,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800057d6:	0592                	slli	a1,a1,0x4
    800057d8:	952e                	add	a0,a0,a1
    800057da:	f9070713          	addi	a4,a4,-112
    800057de:	9736                	add	a4,a4,a3
    800057e0:	e118                	sd	a4,0(a0)
  disk.desc[idx[2]].len = 1;
    800057e2:	6298                	ld	a4,0(a3)
    800057e4:	972e                	add	a4,a4,a1
    800057e6:	4585                	li	a1,1
    800057e8:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800057ea:	4509                	li	a0,2
    800057ec:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[2]].next = 0;
    800057f0:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800057f4:	00b92223          	sw	a1,4(s2)
  disk.info[idx[0]].b = b;
    800057f8:	0127b423          	sd	s2,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800057fc:	6698                	ld	a4,8(a3)
    800057fe:	00275783          	lhu	a5,2(a4)
    80005802:	8b9d                	andi	a5,a5,7
    80005804:	0786                	slli	a5,a5,0x1
    80005806:	97ba                	add	a5,a5,a4
    80005808:	00c79223          	sh	a2,4(a5)

  __sync_synchronize();
    8000580c:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005810:	6698                	ld	a4,8(a3)
    80005812:	00275783          	lhu	a5,2(a4)
    80005816:	2785                	addiw	a5,a5,1
    80005818:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    8000581c:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005820:	100017b7          	lui	a5,0x10001
    80005824:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005828:	00492703          	lw	a4,4(s2)
    8000582c:	4785                	li	a5,1
    8000582e:	02f71163          	bne	a4,a5,80005850 <virtio_disk_rw+0x1e8>
    sleep(b, &disk.vdisk_lock);
    80005832:	00034997          	auipc	s3,0x34
    80005836:	49e98993          	addi	s3,s3,1182 # 80039cd0 <disk+0x128>
  while(b->disk == 1) {
    8000583a:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000583c:	85ce                	mv	a1,s3
    8000583e:	854a                	mv	a0,s2
    80005840:	ffffc097          	auipc	ra,0xffffc
    80005844:	f6a080e7          	jalr	-150(ra) # 800017aa <sleep>
  while(b->disk == 1) {
    80005848:	00492783          	lw	a5,4(s2)
    8000584c:	fe9788e3          	beq	a5,s1,8000583c <virtio_disk_rw+0x1d4>
  }

  disk.info[idx[0]].b = 0;
    80005850:	f9042903          	lw	s2,-112(s0)
    80005854:	00290793          	addi	a5,s2,2
    80005858:	00479713          	slli	a4,a5,0x4
    8000585c:	00034797          	auipc	a5,0x34
    80005860:	34c78793          	addi	a5,a5,844 # 80039ba8 <disk>
    80005864:	97ba                	add	a5,a5,a4
    80005866:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000586a:	00034997          	auipc	s3,0x34
    8000586e:	33e98993          	addi	s3,s3,830 # 80039ba8 <disk>
    80005872:	00491713          	slli	a4,s2,0x4
    80005876:	0009b783          	ld	a5,0(s3)
    8000587a:	97ba                	add	a5,a5,a4
    8000587c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005880:	854a                	mv	a0,s2
    80005882:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005886:	00000097          	auipc	ra,0x0
    8000588a:	b70080e7          	jalr	-1168(ra) # 800053f6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000588e:	8885                	andi	s1,s1,1
    80005890:	f0ed                	bnez	s1,80005872 <virtio_disk_rw+0x20a>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005892:	00034517          	auipc	a0,0x34
    80005896:	43e50513          	addi	a0,a0,1086 # 80039cd0 <disk+0x128>
    8000589a:	00001097          	auipc	ra,0x1
    8000589e:	c36080e7          	jalr	-970(ra) # 800064d0 <release>
}
    800058a2:	70a6                	ld	ra,104(sp)
    800058a4:	7406                	ld	s0,96(sp)
    800058a6:	64e6                	ld	s1,88(sp)
    800058a8:	6946                	ld	s2,80(sp)
    800058aa:	69a6                	ld	s3,72(sp)
    800058ac:	6a06                	ld	s4,64(sp)
    800058ae:	7ae2                	ld	s5,56(sp)
    800058b0:	7b42                	ld	s6,48(sp)
    800058b2:	7ba2                	ld	s7,40(sp)
    800058b4:	7c02                	ld	s8,32(sp)
    800058b6:	6ce2                	ld	s9,24(sp)
    800058b8:	6d42                	ld	s10,16(sp)
    800058ba:	6165                	addi	sp,sp,112
    800058bc:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800058be:	4689                	li	a3,2
    800058c0:	00d79623          	sh	a3,12(a5)
    800058c4:	b5e5                	j	800057ac <virtio_disk_rw+0x144>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800058c6:	f9042603          	lw	a2,-112(s0)
    800058ca:	00a60713          	addi	a4,a2,10
    800058ce:	0712                	slli	a4,a4,0x4
    800058d0:	00034517          	auipc	a0,0x34
    800058d4:	2e050513          	addi	a0,a0,736 # 80039bb0 <disk+0x8>
    800058d8:	953a                	add	a0,a0,a4
  if(write)
    800058da:	e60d14e3          	bnez	s10,80005742 <virtio_disk_rw+0xda>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    800058de:	00a60793          	addi	a5,a2,10
    800058e2:	00479693          	slli	a3,a5,0x4
    800058e6:	00034797          	auipc	a5,0x34
    800058ea:	2c278793          	addi	a5,a5,706 # 80039ba8 <disk>
    800058ee:	97b6                	add	a5,a5,a3
    800058f0:	0007a423          	sw	zero,8(a5)
    800058f4:	b595                	j	80005758 <virtio_disk_rw+0xf0>

00000000800058f6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800058f6:	1101                	addi	sp,sp,-32
    800058f8:	ec06                	sd	ra,24(sp)
    800058fa:	e822                	sd	s0,16(sp)
    800058fc:	e426                	sd	s1,8(sp)
    800058fe:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005900:	00034497          	auipc	s1,0x34
    80005904:	2a848493          	addi	s1,s1,680 # 80039ba8 <disk>
    80005908:	00034517          	auipc	a0,0x34
    8000590c:	3c850513          	addi	a0,a0,968 # 80039cd0 <disk+0x128>
    80005910:	00001097          	auipc	ra,0x1
    80005914:	b0c080e7          	jalr	-1268(ra) # 8000641c <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005918:	10001737          	lui	a4,0x10001
    8000591c:	533c                	lw	a5,96(a4)
    8000591e:	8b8d                	andi	a5,a5,3
    80005920:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005922:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005926:	689c                	ld	a5,16(s1)
    80005928:	0204d703          	lhu	a4,32(s1)
    8000592c:	0027d783          	lhu	a5,2(a5)
    80005930:	04f70863          	beq	a4,a5,80005980 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005934:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005938:	6898                	ld	a4,16(s1)
    8000593a:	0204d783          	lhu	a5,32(s1)
    8000593e:	8b9d                	andi	a5,a5,7
    80005940:	078e                	slli	a5,a5,0x3
    80005942:	97ba                	add	a5,a5,a4
    80005944:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005946:	00278713          	addi	a4,a5,2
    8000594a:	0712                	slli	a4,a4,0x4
    8000594c:	9726                	add	a4,a4,s1
    8000594e:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005952:	e721                	bnez	a4,8000599a <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005954:	0789                	addi	a5,a5,2
    80005956:	0792                	slli	a5,a5,0x4
    80005958:	97a6                	add	a5,a5,s1
    8000595a:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000595c:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005960:	ffffc097          	auipc	ra,0xffffc
    80005964:	eae080e7          	jalr	-338(ra) # 8000180e <wakeup>

    disk.used_idx += 1;
    80005968:	0204d783          	lhu	a5,32(s1)
    8000596c:	2785                	addiw	a5,a5,1
    8000596e:	17c2                	slli	a5,a5,0x30
    80005970:	93c1                	srli	a5,a5,0x30
    80005972:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005976:	6898                	ld	a4,16(s1)
    80005978:	00275703          	lhu	a4,2(a4)
    8000597c:	faf71ce3          	bne	a4,a5,80005934 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005980:	00034517          	auipc	a0,0x34
    80005984:	35050513          	addi	a0,a0,848 # 80039cd0 <disk+0x128>
    80005988:	00001097          	auipc	ra,0x1
    8000598c:	b48080e7          	jalr	-1208(ra) # 800064d0 <release>
}
    80005990:	60e2                	ld	ra,24(sp)
    80005992:	6442                	ld	s0,16(sp)
    80005994:	64a2                	ld	s1,8(sp)
    80005996:	6105                	addi	sp,sp,32
    80005998:	8082                	ret
      panic("virtio_disk_intr status");
    8000599a:	00003517          	auipc	a0,0x3
    8000599e:	fc650513          	addi	a0,a0,-58 # 80008960 <syscalls+0x3d8>
    800059a2:	00000097          	auipc	ra,0x0
    800059a6:	530080e7          	jalr	1328(ra) # 80005ed2 <panic>

00000000800059aa <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800059aa:	1141                	addi	sp,sp,-16
    800059ac:	e422                	sd	s0,8(sp)
    800059ae:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800059b0:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800059b4:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800059b8:	0037979b          	slliw	a5,a5,0x3
    800059bc:	02004737          	lui	a4,0x2004
    800059c0:	97ba                	add	a5,a5,a4
    800059c2:	0200c737          	lui	a4,0x200c
    800059c6:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800059ca:	000f4637          	lui	a2,0xf4
    800059ce:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800059d2:	95b2                	add	a1,a1,a2
    800059d4:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800059d6:	00269713          	slli	a4,a3,0x2
    800059da:	9736                	add	a4,a4,a3
    800059dc:	00371693          	slli	a3,a4,0x3
    800059e0:	00034717          	auipc	a4,0x34
    800059e4:	31070713          	addi	a4,a4,784 # 80039cf0 <timer_scratch>
    800059e8:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    800059ea:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    800059ec:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800059ee:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800059f2:	00000797          	auipc	a5,0x0
    800059f6:	93e78793          	addi	a5,a5,-1730 # 80005330 <timervec>
    800059fa:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800059fe:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005a02:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a06:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005a0a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005a0e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005a12:	30479073          	csrw	mie,a5
}
    80005a16:	6422                	ld	s0,8(sp)
    80005a18:	0141                	addi	sp,sp,16
    80005a1a:	8082                	ret

0000000080005a1c <start>:
{
    80005a1c:	1141                	addi	sp,sp,-16
    80005a1e:	e406                	sd	ra,8(sp)
    80005a20:	e022                	sd	s0,0(sp)
    80005a22:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a24:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005a28:	7779                	lui	a4,0xffffe
    80005a2a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffbc8cf>
    80005a2e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005a30:	6705                	lui	a4,0x1
    80005a32:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005a36:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a38:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005a3c:	ffffb797          	auipc	a5,0xffffb
    80005a40:	9f678793          	addi	a5,a5,-1546 # 80000432 <main>
    80005a44:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005a48:	4781                	li	a5,0
    80005a4a:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005a4e:	67c1                	lui	a5,0x10
    80005a50:	17fd                	addi	a5,a5,-1
    80005a52:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005a56:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005a5a:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005a5e:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005a62:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005a66:	57fd                	li	a5,-1
    80005a68:	83a9                	srli	a5,a5,0xa
    80005a6a:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005a6e:	47bd                	li	a5,15
    80005a70:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005a74:	00000097          	auipc	ra,0x0
    80005a78:	f36080e7          	jalr	-202(ra) # 800059aa <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005a7c:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005a80:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005a82:	823e                	mv	tp,a5
  asm volatile("mret");
    80005a84:	30200073          	mret
}
    80005a88:	60a2                	ld	ra,8(sp)
    80005a8a:	6402                	ld	s0,0(sp)
    80005a8c:	0141                	addi	sp,sp,16
    80005a8e:	8082                	ret

0000000080005a90 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005a90:	715d                	addi	sp,sp,-80
    80005a92:	e486                	sd	ra,72(sp)
    80005a94:	e0a2                	sd	s0,64(sp)
    80005a96:	fc26                	sd	s1,56(sp)
    80005a98:	f84a                	sd	s2,48(sp)
    80005a9a:	f44e                	sd	s3,40(sp)
    80005a9c:	f052                	sd	s4,32(sp)
    80005a9e:	ec56                	sd	s5,24(sp)
    80005aa0:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005aa2:	04c05663          	blez	a2,80005aee <consolewrite+0x5e>
    80005aa6:	8a2a                	mv	s4,a0
    80005aa8:	84ae                	mv	s1,a1
    80005aaa:	89b2                	mv	s3,a2
    80005aac:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005aae:	5afd                	li	s5,-1
    80005ab0:	4685                	li	a3,1
    80005ab2:	8626                	mv	a2,s1
    80005ab4:	85d2                	mv	a1,s4
    80005ab6:	fbf40513          	addi	a0,s0,-65
    80005aba:	ffffc097          	auipc	ra,0xffffc
    80005abe:	14e080e7          	jalr	334(ra) # 80001c08 <either_copyin>
    80005ac2:	01550c63          	beq	a0,s5,80005ada <consolewrite+0x4a>
      break;
    uartputc(c);
    80005ac6:	fbf44503          	lbu	a0,-65(s0)
    80005aca:	00000097          	auipc	ra,0x0
    80005ace:	794080e7          	jalr	1940(ra) # 8000625e <uartputc>
  for(i = 0; i < n; i++){
    80005ad2:	2905                	addiw	s2,s2,1
    80005ad4:	0485                	addi	s1,s1,1
    80005ad6:	fd299de3          	bne	s3,s2,80005ab0 <consolewrite+0x20>
  }

  return i;
}
    80005ada:	854a                	mv	a0,s2
    80005adc:	60a6                	ld	ra,72(sp)
    80005ade:	6406                	ld	s0,64(sp)
    80005ae0:	74e2                	ld	s1,56(sp)
    80005ae2:	7942                	ld	s2,48(sp)
    80005ae4:	79a2                	ld	s3,40(sp)
    80005ae6:	7a02                	ld	s4,32(sp)
    80005ae8:	6ae2                	ld	s5,24(sp)
    80005aea:	6161                	addi	sp,sp,80
    80005aec:	8082                	ret
  for(i = 0; i < n; i++){
    80005aee:	4901                	li	s2,0
    80005af0:	b7ed                	j	80005ada <consolewrite+0x4a>

0000000080005af2 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005af2:	7119                	addi	sp,sp,-128
    80005af4:	fc86                	sd	ra,120(sp)
    80005af6:	f8a2                	sd	s0,112(sp)
    80005af8:	f4a6                	sd	s1,104(sp)
    80005afa:	f0ca                	sd	s2,96(sp)
    80005afc:	ecce                	sd	s3,88(sp)
    80005afe:	e8d2                	sd	s4,80(sp)
    80005b00:	e4d6                	sd	s5,72(sp)
    80005b02:	e0da                	sd	s6,64(sp)
    80005b04:	fc5e                	sd	s7,56(sp)
    80005b06:	f862                	sd	s8,48(sp)
    80005b08:	f466                	sd	s9,40(sp)
    80005b0a:	f06a                	sd	s10,32(sp)
    80005b0c:	ec6e                	sd	s11,24(sp)
    80005b0e:	0100                	addi	s0,sp,128
    80005b10:	8b2a                	mv	s6,a0
    80005b12:	8aae                	mv	s5,a1
    80005b14:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005b16:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005b1a:	0003c517          	auipc	a0,0x3c
    80005b1e:	31650513          	addi	a0,a0,790 # 80041e30 <cons>
    80005b22:	00001097          	auipc	ra,0x1
    80005b26:	8fa080e7          	jalr	-1798(ra) # 8000641c <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005b2a:	0003c497          	auipc	s1,0x3c
    80005b2e:	30648493          	addi	s1,s1,774 # 80041e30 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005b32:	89a6                	mv	s3,s1
    80005b34:	0003c917          	auipc	s2,0x3c
    80005b38:	39490913          	addi	s2,s2,916 # 80041ec8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    80005b3c:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005b3e:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005b40:	4da9                	li	s11,10
  while(n > 0){
    80005b42:	07405b63          	blez	s4,80005bb8 <consoleread+0xc6>
    while(cons.r == cons.w){
    80005b46:	0984a783          	lw	a5,152(s1)
    80005b4a:	09c4a703          	lw	a4,156(s1)
    80005b4e:	02f71763          	bne	a4,a5,80005b7c <consoleread+0x8a>
      if(killed(myproc())){
    80005b52:	ffffb097          	auipc	ra,0xffffb
    80005b56:	5b0080e7          	jalr	1456(ra) # 80001102 <myproc>
    80005b5a:	ffffc097          	auipc	ra,0xffffc
    80005b5e:	ef8080e7          	jalr	-264(ra) # 80001a52 <killed>
    80005b62:	e535                	bnez	a0,80005bce <consoleread+0xdc>
      sleep(&cons.r, &cons.lock);
    80005b64:	85ce                	mv	a1,s3
    80005b66:	854a                	mv	a0,s2
    80005b68:	ffffc097          	auipc	ra,0xffffc
    80005b6c:	c42080e7          	jalr	-958(ra) # 800017aa <sleep>
    while(cons.r == cons.w){
    80005b70:	0984a783          	lw	a5,152(s1)
    80005b74:	09c4a703          	lw	a4,156(s1)
    80005b78:	fcf70de3          	beq	a4,a5,80005b52 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005b7c:	0017871b          	addiw	a4,a5,1
    80005b80:	08e4ac23          	sw	a4,152(s1)
    80005b84:	07f7f713          	andi	a4,a5,127
    80005b88:	9726                	add	a4,a4,s1
    80005b8a:	01874703          	lbu	a4,24(a4)
    80005b8e:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005b92:	079c0663          	beq	s8,s9,80005bfe <consoleread+0x10c>
    cbuf = c;
    80005b96:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005b9a:	4685                	li	a3,1
    80005b9c:	f8f40613          	addi	a2,s0,-113
    80005ba0:	85d6                	mv	a1,s5
    80005ba2:	855a                	mv	a0,s6
    80005ba4:	ffffc097          	auipc	ra,0xffffc
    80005ba8:	00e080e7          	jalr	14(ra) # 80001bb2 <either_copyout>
    80005bac:	01a50663          	beq	a0,s10,80005bb8 <consoleread+0xc6>
    dst++;
    80005bb0:	0a85                	addi	s5,s5,1
    --n;
    80005bb2:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005bb4:	f9bc17e3          	bne	s8,s11,80005b42 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005bb8:	0003c517          	auipc	a0,0x3c
    80005bbc:	27850513          	addi	a0,a0,632 # 80041e30 <cons>
    80005bc0:	00001097          	auipc	ra,0x1
    80005bc4:	910080e7          	jalr	-1776(ra) # 800064d0 <release>

  return target - n;
    80005bc8:	414b853b          	subw	a0,s7,s4
    80005bcc:	a811                	j	80005be0 <consoleread+0xee>
        release(&cons.lock);
    80005bce:	0003c517          	auipc	a0,0x3c
    80005bd2:	26250513          	addi	a0,a0,610 # 80041e30 <cons>
    80005bd6:	00001097          	auipc	ra,0x1
    80005bda:	8fa080e7          	jalr	-1798(ra) # 800064d0 <release>
        return -1;
    80005bde:	557d                	li	a0,-1
}
    80005be0:	70e6                	ld	ra,120(sp)
    80005be2:	7446                	ld	s0,112(sp)
    80005be4:	74a6                	ld	s1,104(sp)
    80005be6:	7906                	ld	s2,96(sp)
    80005be8:	69e6                	ld	s3,88(sp)
    80005bea:	6a46                	ld	s4,80(sp)
    80005bec:	6aa6                	ld	s5,72(sp)
    80005bee:	6b06                	ld	s6,64(sp)
    80005bf0:	7be2                	ld	s7,56(sp)
    80005bf2:	7c42                	ld	s8,48(sp)
    80005bf4:	7ca2                	ld	s9,40(sp)
    80005bf6:	7d02                	ld	s10,32(sp)
    80005bf8:	6de2                	ld	s11,24(sp)
    80005bfa:	6109                	addi	sp,sp,128
    80005bfc:	8082                	ret
      if(n < target){
    80005bfe:	000a071b          	sext.w	a4,s4
    80005c02:	fb777be3          	bgeu	a4,s7,80005bb8 <consoleread+0xc6>
        cons.r--;
    80005c06:	0003c717          	auipc	a4,0x3c
    80005c0a:	2cf72123          	sw	a5,706(a4) # 80041ec8 <cons+0x98>
    80005c0e:	b76d                	j	80005bb8 <consoleread+0xc6>

0000000080005c10 <consputc>:
{
    80005c10:	1141                	addi	sp,sp,-16
    80005c12:	e406                	sd	ra,8(sp)
    80005c14:	e022                	sd	s0,0(sp)
    80005c16:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005c18:	10000793          	li	a5,256
    80005c1c:	00f50a63          	beq	a0,a5,80005c30 <consputc+0x20>
    uartputc_sync(c);
    80005c20:	00000097          	auipc	ra,0x0
    80005c24:	564080e7          	jalr	1380(ra) # 80006184 <uartputc_sync>
}
    80005c28:	60a2                	ld	ra,8(sp)
    80005c2a:	6402                	ld	s0,0(sp)
    80005c2c:	0141                	addi	sp,sp,16
    80005c2e:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005c30:	4521                	li	a0,8
    80005c32:	00000097          	auipc	ra,0x0
    80005c36:	552080e7          	jalr	1362(ra) # 80006184 <uartputc_sync>
    80005c3a:	02000513          	li	a0,32
    80005c3e:	00000097          	auipc	ra,0x0
    80005c42:	546080e7          	jalr	1350(ra) # 80006184 <uartputc_sync>
    80005c46:	4521                	li	a0,8
    80005c48:	00000097          	auipc	ra,0x0
    80005c4c:	53c080e7          	jalr	1340(ra) # 80006184 <uartputc_sync>
    80005c50:	bfe1                	j	80005c28 <consputc+0x18>

0000000080005c52 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005c52:	1101                	addi	sp,sp,-32
    80005c54:	ec06                	sd	ra,24(sp)
    80005c56:	e822                	sd	s0,16(sp)
    80005c58:	e426                	sd	s1,8(sp)
    80005c5a:	e04a                	sd	s2,0(sp)
    80005c5c:	1000                	addi	s0,sp,32
    80005c5e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005c60:	0003c517          	auipc	a0,0x3c
    80005c64:	1d050513          	addi	a0,a0,464 # 80041e30 <cons>
    80005c68:	00000097          	auipc	ra,0x0
    80005c6c:	7b4080e7          	jalr	1972(ra) # 8000641c <acquire>

  switch(c){
    80005c70:	47d5                	li	a5,21
    80005c72:	0af48663          	beq	s1,a5,80005d1e <consoleintr+0xcc>
    80005c76:	0297ca63          	blt	a5,s1,80005caa <consoleintr+0x58>
    80005c7a:	47a1                	li	a5,8
    80005c7c:	0ef48763          	beq	s1,a5,80005d6a <consoleintr+0x118>
    80005c80:	47c1                	li	a5,16
    80005c82:	10f49a63          	bne	s1,a5,80005d96 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005c86:	ffffc097          	auipc	ra,0xffffc
    80005c8a:	fd8080e7          	jalr	-40(ra) # 80001c5e <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005c8e:	0003c517          	auipc	a0,0x3c
    80005c92:	1a250513          	addi	a0,a0,418 # 80041e30 <cons>
    80005c96:	00001097          	auipc	ra,0x1
    80005c9a:	83a080e7          	jalr	-1990(ra) # 800064d0 <release>
}
    80005c9e:	60e2                	ld	ra,24(sp)
    80005ca0:	6442                	ld	s0,16(sp)
    80005ca2:	64a2                	ld	s1,8(sp)
    80005ca4:	6902                	ld	s2,0(sp)
    80005ca6:	6105                	addi	sp,sp,32
    80005ca8:	8082                	ret
  switch(c){
    80005caa:	07f00793          	li	a5,127
    80005cae:	0af48e63          	beq	s1,a5,80005d6a <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005cb2:	0003c717          	auipc	a4,0x3c
    80005cb6:	17e70713          	addi	a4,a4,382 # 80041e30 <cons>
    80005cba:	0a072783          	lw	a5,160(a4)
    80005cbe:	09872703          	lw	a4,152(a4)
    80005cc2:	9f99                	subw	a5,a5,a4
    80005cc4:	07f00713          	li	a4,127
    80005cc8:	fcf763e3          	bltu	a4,a5,80005c8e <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005ccc:	47b5                	li	a5,13
    80005cce:	0cf48763          	beq	s1,a5,80005d9c <consoleintr+0x14a>
      consputc(c);
    80005cd2:	8526                	mv	a0,s1
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	f3c080e7          	jalr	-196(ra) # 80005c10 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005cdc:	0003c797          	auipc	a5,0x3c
    80005ce0:	15478793          	addi	a5,a5,340 # 80041e30 <cons>
    80005ce4:	0a07a683          	lw	a3,160(a5)
    80005ce8:	0016871b          	addiw	a4,a3,1
    80005cec:	0007061b          	sext.w	a2,a4
    80005cf0:	0ae7a023          	sw	a4,160(a5)
    80005cf4:	07f6f693          	andi	a3,a3,127
    80005cf8:	97b6                	add	a5,a5,a3
    80005cfa:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005cfe:	47a9                	li	a5,10
    80005d00:	0cf48563          	beq	s1,a5,80005dca <consoleintr+0x178>
    80005d04:	4791                	li	a5,4
    80005d06:	0cf48263          	beq	s1,a5,80005dca <consoleintr+0x178>
    80005d0a:	0003c797          	auipc	a5,0x3c
    80005d0e:	1be7a783          	lw	a5,446(a5) # 80041ec8 <cons+0x98>
    80005d12:	9f1d                	subw	a4,a4,a5
    80005d14:	08000793          	li	a5,128
    80005d18:	f6f71be3          	bne	a4,a5,80005c8e <consoleintr+0x3c>
    80005d1c:	a07d                	j	80005dca <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005d1e:	0003c717          	auipc	a4,0x3c
    80005d22:	11270713          	addi	a4,a4,274 # 80041e30 <cons>
    80005d26:	0a072783          	lw	a5,160(a4)
    80005d2a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005d2e:	0003c497          	auipc	s1,0x3c
    80005d32:	10248493          	addi	s1,s1,258 # 80041e30 <cons>
    while(cons.e != cons.w &&
    80005d36:	4929                	li	s2,10
    80005d38:	f4f70be3          	beq	a4,a5,80005c8e <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005d3c:	37fd                	addiw	a5,a5,-1
    80005d3e:	07f7f713          	andi	a4,a5,127
    80005d42:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005d44:	01874703          	lbu	a4,24(a4)
    80005d48:	f52703e3          	beq	a4,s2,80005c8e <consoleintr+0x3c>
      cons.e--;
    80005d4c:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005d50:	10000513          	li	a0,256
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	ebc080e7          	jalr	-324(ra) # 80005c10 <consputc>
    while(cons.e != cons.w &&
    80005d5c:	0a04a783          	lw	a5,160(s1)
    80005d60:	09c4a703          	lw	a4,156(s1)
    80005d64:	fcf71ce3          	bne	a4,a5,80005d3c <consoleintr+0xea>
    80005d68:	b71d                	j	80005c8e <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005d6a:	0003c717          	auipc	a4,0x3c
    80005d6e:	0c670713          	addi	a4,a4,198 # 80041e30 <cons>
    80005d72:	0a072783          	lw	a5,160(a4)
    80005d76:	09c72703          	lw	a4,156(a4)
    80005d7a:	f0f70ae3          	beq	a4,a5,80005c8e <consoleintr+0x3c>
      cons.e--;
    80005d7e:	37fd                	addiw	a5,a5,-1
    80005d80:	0003c717          	auipc	a4,0x3c
    80005d84:	14f72823          	sw	a5,336(a4) # 80041ed0 <cons+0xa0>
      consputc(BACKSPACE);
    80005d88:	10000513          	li	a0,256
    80005d8c:	00000097          	auipc	ra,0x0
    80005d90:	e84080e7          	jalr	-380(ra) # 80005c10 <consputc>
    80005d94:	bded                	j	80005c8e <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005d96:	ee048ce3          	beqz	s1,80005c8e <consoleintr+0x3c>
    80005d9a:	bf21                	j	80005cb2 <consoleintr+0x60>
      consputc(c);
    80005d9c:	4529                	li	a0,10
    80005d9e:	00000097          	auipc	ra,0x0
    80005da2:	e72080e7          	jalr	-398(ra) # 80005c10 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005da6:	0003c797          	auipc	a5,0x3c
    80005daa:	08a78793          	addi	a5,a5,138 # 80041e30 <cons>
    80005dae:	0a07a703          	lw	a4,160(a5)
    80005db2:	0017069b          	addiw	a3,a4,1
    80005db6:	0006861b          	sext.w	a2,a3
    80005dba:	0ad7a023          	sw	a3,160(a5)
    80005dbe:	07f77713          	andi	a4,a4,127
    80005dc2:	97ba                	add	a5,a5,a4
    80005dc4:	4729                	li	a4,10
    80005dc6:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005dca:	0003c797          	auipc	a5,0x3c
    80005dce:	10c7a123          	sw	a2,258(a5) # 80041ecc <cons+0x9c>
        wakeup(&cons.r);
    80005dd2:	0003c517          	auipc	a0,0x3c
    80005dd6:	0f650513          	addi	a0,a0,246 # 80041ec8 <cons+0x98>
    80005dda:	ffffc097          	auipc	ra,0xffffc
    80005dde:	a34080e7          	jalr	-1484(ra) # 8000180e <wakeup>
    80005de2:	b575                	j	80005c8e <consoleintr+0x3c>

0000000080005de4 <consoleinit>:

void
consoleinit(void)
{
    80005de4:	1141                	addi	sp,sp,-16
    80005de6:	e406                	sd	ra,8(sp)
    80005de8:	e022                	sd	s0,0(sp)
    80005dea:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005dec:	00003597          	auipc	a1,0x3
    80005df0:	b8c58593          	addi	a1,a1,-1140 # 80008978 <syscalls+0x3f0>
    80005df4:	0003c517          	auipc	a0,0x3c
    80005df8:	03c50513          	addi	a0,a0,60 # 80041e30 <cons>
    80005dfc:	00000097          	auipc	ra,0x0
    80005e00:	590080e7          	jalr	1424(ra) # 8000638c <initlock>

  uartinit();
    80005e04:	00000097          	auipc	ra,0x0
    80005e08:	330080e7          	jalr	816(ra) # 80006134 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005e0c:	00033797          	auipc	a5,0x33
    80005e10:	d4478793          	addi	a5,a5,-700 # 80038b50 <devsw>
    80005e14:	00000717          	auipc	a4,0x0
    80005e18:	cde70713          	addi	a4,a4,-802 # 80005af2 <consoleread>
    80005e1c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005e1e:	00000717          	auipc	a4,0x0
    80005e22:	c7270713          	addi	a4,a4,-910 # 80005a90 <consolewrite>
    80005e26:	ef98                	sd	a4,24(a5)
}
    80005e28:	60a2                	ld	ra,8(sp)
    80005e2a:	6402                	ld	s0,0(sp)
    80005e2c:	0141                	addi	sp,sp,16
    80005e2e:	8082                	ret

0000000080005e30 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005e30:	7179                	addi	sp,sp,-48
    80005e32:	f406                	sd	ra,40(sp)
    80005e34:	f022                	sd	s0,32(sp)
    80005e36:	ec26                	sd	s1,24(sp)
    80005e38:	e84a                	sd	s2,16(sp)
    80005e3a:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005e3c:	c219                	beqz	a2,80005e42 <printint+0x12>
    80005e3e:	08054663          	bltz	a0,80005eca <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80005e42:	2501                	sext.w	a0,a0
    80005e44:	4881                	li	a7,0
    80005e46:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005e4a:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005e4c:	2581                	sext.w	a1,a1
    80005e4e:	00003617          	auipc	a2,0x3
    80005e52:	b5a60613          	addi	a2,a2,-1190 # 800089a8 <digits>
    80005e56:	883a                	mv	a6,a4
    80005e58:	2705                	addiw	a4,a4,1
    80005e5a:	02b577bb          	remuw	a5,a0,a1
    80005e5e:	1782                	slli	a5,a5,0x20
    80005e60:	9381                	srli	a5,a5,0x20
    80005e62:	97b2                	add	a5,a5,a2
    80005e64:	0007c783          	lbu	a5,0(a5)
    80005e68:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005e6c:	0005079b          	sext.w	a5,a0
    80005e70:	02b5553b          	divuw	a0,a0,a1
    80005e74:	0685                	addi	a3,a3,1
    80005e76:	feb7f0e3          	bgeu	a5,a1,80005e56 <printint+0x26>

  if(sign)
    80005e7a:	00088b63          	beqz	a7,80005e90 <printint+0x60>
    buf[i++] = '-';
    80005e7e:	fe040793          	addi	a5,s0,-32
    80005e82:	973e                	add	a4,a4,a5
    80005e84:	02d00793          	li	a5,45
    80005e88:	fef70823          	sb	a5,-16(a4)
    80005e8c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005e90:	02e05763          	blez	a4,80005ebe <printint+0x8e>
    80005e94:	fd040793          	addi	a5,s0,-48
    80005e98:	00e784b3          	add	s1,a5,a4
    80005e9c:	fff78913          	addi	s2,a5,-1
    80005ea0:	993a                	add	s2,s2,a4
    80005ea2:	377d                	addiw	a4,a4,-1
    80005ea4:	1702                	slli	a4,a4,0x20
    80005ea6:	9301                	srli	a4,a4,0x20
    80005ea8:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005eac:	fff4c503          	lbu	a0,-1(s1)
    80005eb0:	00000097          	auipc	ra,0x0
    80005eb4:	d60080e7          	jalr	-672(ra) # 80005c10 <consputc>
  while(--i >= 0)
    80005eb8:	14fd                	addi	s1,s1,-1
    80005eba:	ff2499e3          	bne	s1,s2,80005eac <printint+0x7c>
}
    80005ebe:	70a2                	ld	ra,40(sp)
    80005ec0:	7402                	ld	s0,32(sp)
    80005ec2:	64e2                	ld	s1,24(sp)
    80005ec4:	6942                	ld	s2,16(sp)
    80005ec6:	6145                	addi	sp,sp,48
    80005ec8:	8082                	ret
    x = -xx;
    80005eca:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005ece:	4885                	li	a7,1
    x = -xx;
    80005ed0:	bf9d                	j	80005e46 <printint+0x16>

0000000080005ed2 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005ed2:	1101                	addi	sp,sp,-32
    80005ed4:	ec06                	sd	ra,24(sp)
    80005ed6:	e822                	sd	s0,16(sp)
    80005ed8:	e426                	sd	s1,8(sp)
    80005eda:	1000                	addi	s0,sp,32
    80005edc:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005ede:	0003c797          	auipc	a5,0x3c
    80005ee2:	0007a923          	sw	zero,18(a5) # 80041ef0 <pr+0x18>
  printf("panic: ");
    80005ee6:	00003517          	auipc	a0,0x3
    80005eea:	a9a50513          	addi	a0,a0,-1382 # 80008980 <syscalls+0x3f8>
    80005eee:	00000097          	auipc	ra,0x0
    80005ef2:	02e080e7          	jalr	46(ra) # 80005f1c <printf>
  printf(s);
    80005ef6:	8526                	mv	a0,s1
    80005ef8:	00000097          	auipc	ra,0x0
    80005efc:	024080e7          	jalr	36(ra) # 80005f1c <printf>
  printf("\n");
    80005f00:	00002517          	auipc	a0,0x2
    80005f04:	15850513          	addi	a0,a0,344 # 80008058 <etext+0x58>
    80005f08:	00000097          	auipc	ra,0x0
    80005f0c:	014080e7          	jalr	20(ra) # 80005f1c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005f10:	4785                	li	a5,1
    80005f12:	00003717          	auipc	a4,0x3
    80005f16:	b6f72d23          	sw	a5,-1158(a4) # 80008a8c <panicked>
  for(;;)
    80005f1a:	a001                	j	80005f1a <panic+0x48>

0000000080005f1c <printf>:
{
    80005f1c:	7131                	addi	sp,sp,-192
    80005f1e:	fc86                	sd	ra,120(sp)
    80005f20:	f8a2                	sd	s0,112(sp)
    80005f22:	f4a6                	sd	s1,104(sp)
    80005f24:	f0ca                	sd	s2,96(sp)
    80005f26:	ecce                	sd	s3,88(sp)
    80005f28:	e8d2                	sd	s4,80(sp)
    80005f2a:	e4d6                	sd	s5,72(sp)
    80005f2c:	e0da                	sd	s6,64(sp)
    80005f2e:	fc5e                	sd	s7,56(sp)
    80005f30:	f862                	sd	s8,48(sp)
    80005f32:	f466                	sd	s9,40(sp)
    80005f34:	f06a                	sd	s10,32(sp)
    80005f36:	ec6e                	sd	s11,24(sp)
    80005f38:	0100                	addi	s0,sp,128
    80005f3a:	8a2a                	mv	s4,a0
    80005f3c:	e40c                	sd	a1,8(s0)
    80005f3e:	e810                	sd	a2,16(s0)
    80005f40:	ec14                	sd	a3,24(s0)
    80005f42:	f018                	sd	a4,32(s0)
    80005f44:	f41c                	sd	a5,40(s0)
    80005f46:	03043823          	sd	a6,48(s0)
    80005f4a:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005f4e:	0003cd97          	auipc	s11,0x3c
    80005f52:	fa2dad83          	lw	s11,-94(s11) # 80041ef0 <pr+0x18>
  if(locking)
    80005f56:	020d9b63          	bnez	s11,80005f8c <printf+0x70>
  if (fmt == 0)
    80005f5a:	040a0263          	beqz	s4,80005f9e <printf+0x82>
  va_start(ap, fmt);
    80005f5e:	00840793          	addi	a5,s0,8
    80005f62:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f66:	000a4503          	lbu	a0,0(s4)
    80005f6a:	16050263          	beqz	a0,800060ce <printf+0x1b2>
    80005f6e:	4481                	li	s1,0
    if(c != '%'){
    80005f70:	02500a93          	li	s5,37
    switch(c){
    80005f74:	07000b13          	li	s6,112
  consputc('x');
    80005f78:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005f7a:	00003b97          	auipc	s7,0x3
    80005f7e:	a2eb8b93          	addi	s7,s7,-1490 # 800089a8 <digits>
    switch(c){
    80005f82:	07300c93          	li	s9,115
    80005f86:	06400c13          	li	s8,100
    80005f8a:	a82d                	j	80005fc4 <printf+0xa8>
    acquire(&pr.lock);
    80005f8c:	0003c517          	auipc	a0,0x3c
    80005f90:	f4c50513          	addi	a0,a0,-180 # 80041ed8 <pr>
    80005f94:	00000097          	auipc	ra,0x0
    80005f98:	488080e7          	jalr	1160(ra) # 8000641c <acquire>
    80005f9c:	bf7d                	j	80005f5a <printf+0x3e>
    panic("null fmt");
    80005f9e:	00003517          	auipc	a0,0x3
    80005fa2:	9f250513          	addi	a0,a0,-1550 # 80008990 <syscalls+0x408>
    80005fa6:	00000097          	auipc	ra,0x0
    80005faa:	f2c080e7          	jalr	-212(ra) # 80005ed2 <panic>
      consputc(c);
    80005fae:	00000097          	auipc	ra,0x0
    80005fb2:	c62080e7          	jalr	-926(ra) # 80005c10 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005fb6:	2485                	addiw	s1,s1,1
    80005fb8:	009a07b3          	add	a5,s4,s1
    80005fbc:	0007c503          	lbu	a0,0(a5)
    80005fc0:	10050763          	beqz	a0,800060ce <printf+0x1b2>
    if(c != '%'){
    80005fc4:	ff5515e3          	bne	a0,s5,80005fae <printf+0x92>
    c = fmt[++i] & 0xff;
    80005fc8:	2485                	addiw	s1,s1,1
    80005fca:	009a07b3          	add	a5,s4,s1
    80005fce:	0007c783          	lbu	a5,0(a5)
    80005fd2:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80005fd6:	cfe5                	beqz	a5,800060ce <printf+0x1b2>
    switch(c){
    80005fd8:	05678a63          	beq	a5,s6,8000602c <printf+0x110>
    80005fdc:	02fb7663          	bgeu	s6,a5,80006008 <printf+0xec>
    80005fe0:	09978963          	beq	a5,s9,80006072 <printf+0x156>
    80005fe4:	07800713          	li	a4,120
    80005fe8:	0ce79863          	bne	a5,a4,800060b8 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80005fec:	f8843783          	ld	a5,-120(s0)
    80005ff0:	00878713          	addi	a4,a5,8
    80005ff4:	f8e43423          	sd	a4,-120(s0)
    80005ff8:	4605                	li	a2,1
    80005ffa:	85ea                	mv	a1,s10
    80005ffc:	4388                	lw	a0,0(a5)
    80005ffe:	00000097          	auipc	ra,0x0
    80006002:	e32080e7          	jalr	-462(ra) # 80005e30 <printint>
      break;
    80006006:	bf45                	j	80005fb6 <printf+0x9a>
    switch(c){
    80006008:	0b578263          	beq	a5,s5,800060ac <printf+0x190>
    8000600c:	0b879663          	bne	a5,s8,800060b8 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80006010:	f8843783          	ld	a5,-120(s0)
    80006014:	00878713          	addi	a4,a5,8
    80006018:	f8e43423          	sd	a4,-120(s0)
    8000601c:	4605                	li	a2,1
    8000601e:	45a9                	li	a1,10
    80006020:	4388                	lw	a0,0(a5)
    80006022:	00000097          	auipc	ra,0x0
    80006026:	e0e080e7          	jalr	-498(ra) # 80005e30 <printint>
      break;
    8000602a:	b771                	j	80005fb6 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    8000602c:	f8843783          	ld	a5,-120(s0)
    80006030:	00878713          	addi	a4,a5,8
    80006034:	f8e43423          	sd	a4,-120(s0)
    80006038:	0007b983          	ld	s3,0(a5)
  consputc('0');
    8000603c:	03000513          	li	a0,48
    80006040:	00000097          	auipc	ra,0x0
    80006044:	bd0080e7          	jalr	-1072(ra) # 80005c10 <consputc>
  consputc('x');
    80006048:	07800513          	li	a0,120
    8000604c:	00000097          	auipc	ra,0x0
    80006050:	bc4080e7          	jalr	-1084(ra) # 80005c10 <consputc>
    80006054:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006056:	03c9d793          	srli	a5,s3,0x3c
    8000605a:	97de                	add	a5,a5,s7
    8000605c:	0007c503          	lbu	a0,0(a5)
    80006060:	00000097          	auipc	ra,0x0
    80006064:	bb0080e7          	jalr	-1104(ra) # 80005c10 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80006068:	0992                	slli	s3,s3,0x4
    8000606a:	397d                	addiw	s2,s2,-1
    8000606c:	fe0915e3          	bnez	s2,80006056 <printf+0x13a>
    80006070:	b799                	j	80005fb6 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80006072:	f8843783          	ld	a5,-120(s0)
    80006076:	00878713          	addi	a4,a5,8
    8000607a:	f8e43423          	sd	a4,-120(s0)
    8000607e:	0007b903          	ld	s2,0(a5)
    80006082:	00090e63          	beqz	s2,8000609e <printf+0x182>
      for(; *s; s++)
    80006086:	00094503          	lbu	a0,0(s2)
    8000608a:	d515                	beqz	a0,80005fb6 <printf+0x9a>
        consputc(*s);
    8000608c:	00000097          	auipc	ra,0x0
    80006090:	b84080e7          	jalr	-1148(ra) # 80005c10 <consputc>
      for(; *s; s++)
    80006094:	0905                	addi	s2,s2,1
    80006096:	00094503          	lbu	a0,0(s2)
    8000609a:	f96d                	bnez	a0,8000608c <printf+0x170>
    8000609c:	bf29                	j	80005fb6 <printf+0x9a>
        s = "(null)";
    8000609e:	00003917          	auipc	s2,0x3
    800060a2:	8ea90913          	addi	s2,s2,-1814 # 80008988 <syscalls+0x400>
      for(; *s; s++)
    800060a6:	02800513          	li	a0,40
    800060aa:	b7cd                	j	8000608c <printf+0x170>
      consputc('%');
    800060ac:	8556                	mv	a0,s5
    800060ae:	00000097          	auipc	ra,0x0
    800060b2:	b62080e7          	jalr	-1182(ra) # 80005c10 <consputc>
      break;
    800060b6:	b701                	j	80005fb6 <printf+0x9a>
      consputc('%');
    800060b8:	8556                	mv	a0,s5
    800060ba:	00000097          	auipc	ra,0x0
    800060be:	b56080e7          	jalr	-1194(ra) # 80005c10 <consputc>
      consputc(c);
    800060c2:	854a                	mv	a0,s2
    800060c4:	00000097          	auipc	ra,0x0
    800060c8:	b4c080e7          	jalr	-1204(ra) # 80005c10 <consputc>
      break;
    800060cc:	b5ed                	j	80005fb6 <printf+0x9a>
  if(locking)
    800060ce:	020d9163          	bnez	s11,800060f0 <printf+0x1d4>
}
    800060d2:	70e6                	ld	ra,120(sp)
    800060d4:	7446                	ld	s0,112(sp)
    800060d6:	74a6                	ld	s1,104(sp)
    800060d8:	7906                	ld	s2,96(sp)
    800060da:	69e6                	ld	s3,88(sp)
    800060dc:	6a46                	ld	s4,80(sp)
    800060de:	6aa6                	ld	s5,72(sp)
    800060e0:	6b06                	ld	s6,64(sp)
    800060e2:	7be2                	ld	s7,56(sp)
    800060e4:	7c42                	ld	s8,48(sp)
    800060e6:	7ca2                	ld	s9,40(sp)
    800060e8:	7d02                	ld	s10,32(sp)
    800060ea:	6de2                	ld	s11,24(sp)
    800060ec:	6129                	addi	sp,sp,192
    800060ee:	8082                	ret
    release(&pr.lock);
    800060f0:	0003c517          	auipc	a0,0x3c
    800060f4:	de850513          	addi	a0,a0,-536 # 80041ed8 <pr>
    800060f8:	00000097          	auipc	ra,0x0
    800060fc:	3d8080e7          	jalr	984(ra) # 800064d0 <release>
}
    80006100:	bfc9                	j	800060d2 <printf+0x1b6>

0000000080006102 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006102:	1101                	addi	sp,sp,-32
    80006104:	ec06                	sd	ra,24(sp)
    80006106:	e822                	sd	s0,16(sp)
    80006108:	e426                	sd	s1,8(sp)
    8000610a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000610c:	0003c497          	auipc	s1,0x3c
    80006110:	dcc48493          	addi	s1,s1,-564 # 80041ed8 <pr>
    80006114:	00003597          	auipc	a1,0x3
    80006118:	88c58593          	addi	a1,a1,-1908 # 800089a0 <syscalls+0x418>
    8000611c:	8526                	mv	a0,s1
    8000611e:	00000097          	auipc	ra,0x0
    80006122:	26e080e7          	jalr	622(ra) # 8000638c <initlock>
  pr.locking = 1;
    80006126:	4785                	li	a5,1
    80006128:	cc9c                	sw	a5,24(s1)
}
    8000612a:	60e2                	ld	ra,24(sp)
    8000612c:	6442                	ld	s0,16(sp)
    8000612e:	64a2                	ld	s1,8(sp)
    80006130:	6105                	addi	sp,sp,32
    80006132:	8082                	ret

0000000080006134 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006134:	1141                	addi	sp,sp,-16
    80006136:	e406                	sd	ra,8(sp)
    80006138:	e022                	sd	s0,0(sp)
    8000613a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000613c:	100007b7          	lui	a5,0x10000
    80006140:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80006144:	f8000713          	li	a4,-128
    80006148:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    8000614c:	470d                	li	a4,3
    8000614e:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80006152:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80006156:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    8000615a:	469d                	li	a3,7
    8000615c:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80006160:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80006164:	00003597          	auipc	a1,0x3
    80006168:	85c58593          	addi	a1,a1,-1956 # 800089c0 <digits+0x18>
    8000616c:	0003c517          	auipc	a0,0x3c
    80006170:	d8c50513          	addi	a0,a0,-628 # 80041ef8 <uart_tx_lock>
    80006174:	00000097          	auipc	ra,0x0
    80006178:	218080e7          	jalr	536(ra) # 8000638c <initlock>
}
    8000617c:	60a2                	ld	ra,8(sp)
    8000617e:	6402                	ld	s0,0(sp)
    80006180:	0141                	addi	sp,sp,16
    80006182:	8082                	ret

0000000080006184 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80006184:	1101                	addi	sp,sp,-32
    80006186:	ec06                	sd	ra,24(sp)
    80006188:	e822                	sd	s0,16(sp)
    8000618a:	e426                	sd	s1,8(sp)
    8000618c:	1000                	addi	s0,sp,32
    8000618e:	84aa                	mv	s1,a0
  push_off();
    80006190:	00000097          	auipc	ra,0x0
    80006194:	240080e7          	jalr	576(ra) # 800063d0 <push_off>

  if(panicked){
    80006198:	00003797          	auipc	a5,0x3
    8000619c:	8f47a783          	lw	a5,-1804(a5) # 80008a8c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800061a0:	10000737          	lui	a4,0x10000
  if(panicked){
    800061a4:	c391                	beqz	a5,800061a8 <uartputc_sync+0x24>
    for(;;)
    800061a6:	a001                	j	800061a6 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800061a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800061ac:	0ff7f793          	andi	a5,a5,255
    800061b0:	0207f793          	andi	a5,a5,32
    800061b4:	dbf5                	beqz	a5,800061a8 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800061b6:	0ff4f793          	andi	a5,s1,255
    800061ba:	10000737          	lui	a4,0x10000
    800061be:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    800061c2:	00000097          	auipc	ra,0x0
    800061c6:	2ae080e7          	jalr	686(ra) # 80006470 <pop_off>
}
    800061ca:	60e2                	ld	ra,24(sp)
    800061cc:	6442                	ld	s0,16(sp)
    800061ce:	64a2                	ld	s1,8(sp)
    800061d0:	6105                	addi	sp,sp,32
    800061d2:	8082                	ret

00000000800061d4 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800061d4:	00003717          	auipc	a4,0x3
    800061d8:	8bc73703          	ld	a4,-1860(a4) # 80008a90 <uart_tx_r>
    800061dc:	00003797          	auipc	a5,0x3
    800061e0:	8bc7b783          	ld	a5,-1860(a5) # 80008a98 <uart_tx_w>
    800061e4:	06e78c63          	beq	a5,a4,8000625c <uartstart+0x88>
{
    800061e8:	7139                	addi	sp,sp,-64
    800061ea:	fc06                	sd	ra,56(sp)
    800061ec:	f822                	sd	s0,48(sp)
    800061ee:	f426                	sd	s1,40(sp)
    800061f0:	f04a                	sd	s2,32(sp)
    800061f2:	ec4e                	sd	s3,24(sp)
    800061f4:	e852                	sd	s4,16(sp)
    800061f6:	e456                	sd	s5,8(sp)
    800061f8:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800061fa:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800061fe:	0003ca17          	auipc	s4,0x3c
    80006202:	cfaa0a13          	addi	s4,s4,-774 # 80041ef8 <uart_tx_lock>
    uart_tx_r += 1;
    80006206:	00003497          	auipc	s1,0x3
    8000620a:	88a48493          	addi	s1,s1,-1910 # 80008a90 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000620e:	00003997          	auipc	s3,0x3
    80006212:	88a98993          	addi	s3,s3,-1910 # 80008a98 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006216:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000621a:	0ff7f793          	andi	a5,a5,255
    8000621e:	0207f793          	andi	a5,a5,32
    80006222:	c785                	beqz	a5,8000624a <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006224:	01f77793          	andi	a5,a4,31
    80006228:	97d2                	add	a5,a5,s4
    8000622a:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    8000622e:	0705                	addi	a4,a4,1
    80006230:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006232:	8526                	mv	a0,s1
    80006234:	ffffb097          	auipc	ra,0xffffb
    80006238:	5da080e7          	jalr	1498(ra) # 8000180e <wakeup>
    
    WriteReg(THR, c);
    8000623c:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80006240:	6098                	ld	a4,0(s1)
    80006242:	0009b783          	ld	a5,0(s3)
    80006246:	fce798e3          	bne	a5,a4,80006216 <uartstart+0x42>
  }
}
    8000624a:	70e2                	ld	ra,56(sp)
    8000624c:	7442                	ld	s0,48(sp)
    8000624e:	74a2                	ld	s1,40(sp)
    80006250:	7902                	ld	s2,32(sp)
    80006252:	69e2                	ld	s3,24(sp)
    80006254:	6a42                	ld	s4,16(sp)
    80006256:	6aa2                	ld	s5,8(sp)
    80006258:	6121                	addi	sp,sp,64
    8000625a:	8082                	ret
    8000625c:	8082                	ret

000000008000625e <uartputc>:
{
    8000625e:	7179                	addi	sp,sp,-48
    80006260:	f406                	sd	ra,40(sp)
    80006262:	f022                	sd	s0,32(sp)
    80006264:	ec26                	sd	s1,24(sp)
    80006266:	e84a                	sd	s2,16(sp)
    80006268:	e44e                	sd	s3,8(sp)
    8000626a:	e052                	sd	s4,0(sp)
    8000626c:	1800                	addi	s0,sp,48
    8000626e:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    80006270:	0003c517          	auipc	a0,0x3c
    80006274:	c8850513          	addi	a0,a0,-888 # 80041ef8 <uart_tx_lock>
    80006278:	00000097          	auipc	ra,0x0
    8000627c:	1a4080e7          	jalr	420(ra) # 8000641c <acquire>
  if(panicked){
    80006280:	00003797          	auipc	a5,0x3
    80006284:	80c7a783          	lw	a5,-2036(a5) # 80008a8c <panicked>
    80006288:	e7c9                	bnez	a5,80006312 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000628a:	00003797          	auipc	a5,0x3
    8000628e:	80e7b783          	ld	a5,-2034(a5) # 80008a98 <uart_tx_w>
    80006292:	00002717          	auipc	a4,0x2
    80006296:	7fe73703          	ld	a4,2046(a4) # 80008a90 <uart_tx_r>
    8000629a:	02070713          	addi	a4,a4,32
    sleep(&uart_tx_r, &uart_tx_lock);
    8000629e:	0003ca17          	auipc	s4,0x3c
    800062a2:	c5aa0a13          	addi	s4,s4,-934 # 80041ef8 <uart_tx_lock>
    800062a6:	00002497          	auipc	s1,0x2
    800062aa:	7ea48493          	addi	s1,s1,2026 # 80008a90 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800062ae:	00002917          	auipc	s2,0x2
    800062b2:	7ea90913          	addi	s2,s2,2026 # 80008a98 <uart_tx_w>
    800062b6:	00f71f63          	bne	a4,a5,800062d4 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    800062ba:	85d2                	mv	a1,s4
    800062bc:	8526                	mv	a0,s1
    800062be:	ffffb097          	auipc	ra,0xffffb
    800062c2:	4ec080e7          	jalr	1260(ra) # 800017aa <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800062c6:	00093783          	ld	a5,0(s2)
    800062ca:	6098                	ld	a4,0(s1)
    800062cc:	02070713          	addi	a4,a4,32
    800062d0:	fef705e3          	beq	a4,a5,800062ba <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800062d4:	0003c497          	auipc	s1,0x3c
    800062d8:	c2448493          	addi	s1,s1,-988 # 80041ef8 <uart_tx_lock>
    800062dc:	01f7f713          	andi	a4,a5,31
    800062e0:	9726                	add	a4,a4,s1
    800062e2:	01370c23          	sb	s3,24(a4)
  uart_tx_w += 1;
    800062e6:	0785                	addi	a5,a5,1
    800062e8:	00002717          	auipc	a4,0x2
    800062ec:	7af73823          	sd	a5,1968(a4) # 80008a98 <uart_tx_w>
  uartstart();
    800062f0:	00000097          	auipc	ra,0x0
    800062f4:	ee4080e7          	jalr	-284(ra) # 800061d4 <uartstart>
  release(&uart_tx_lock);
    800062f8:	8526                	mv	a0,s1
    800062fa:	00000097          	auipc	ra,0x0
    800062fe:	1d6080e7          	jalr	470(ra) # 800064d0 <release>
}
    80006302:	70a2                	ld	ra,40(sp)
    80006304:	7402                	ld	s0,32(sp)
    80006306:	64e2                	ld	s1,24(sp)
    80006308:	6942                	ld	s2,16(sp)
    8000630a:	69a2                	ld	s3,8(sp)
    8000630c:	6a02                	ld	s4,0(sp)
    8000630e:	6145                	addi	sp,sp,48
    80006310:	8082                	ret
    for(;;)
    80006312:	a001                	j	80006312 <uartputc+0xb4>

0000000080006314 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006314:	1141                	addi	sp,sp,-16
    80006316:	e422                	sd	s0,8(sp)
    80006318:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000631a:	100007b7          	lui	a5,0x10000
    8000631e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006322:	8b85                	andi	a5,a5,1
    80006324:	cb91                	beqz	a5,80006338 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006326:	100007b7          	lui	a5,0x10000
    8000632a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000632e:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80006332:	6422                	ld	s0,8(sp)
    80006334:	0141                	addi	sp,sp,16
    80006336:	8082                	ret
    return -1;
    80006338:	557d                	li	a0,-1
    8000633a:	bfe5                	j	80006332 <uartgetc+0x1e>

000000008000633c <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000633c:	1101                	addi	sp,sp,-32
    8000633e:	ec06                	sd	ra,24(sp)
    80006340:	e822                	sd	s0,16(sp)
    80006342:	e426                	sd	s1,8(sp)
    80006344:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006346:	54fd                	li	s1,-1
    int c = uartgetc();
    80006348:	00000097          	auipc	ra,0x0
    8000634c:	fcc080e7          	jalr	-52(ra) # 80006314 <uartgetc>
    if(c == -1)
    80006350:	00950763          	beq	a0,s1,8000635e <uartintr+0x22>
      break;
    consoleintr(c);
    80006354:	00000097          	auipc	ra,0x0
    80006358:	8fe080e7          	jalr	-1794(ra) # 80005c52 <consoleintr>
  while(1){
    8000635c:	b7f5                	j	80006348 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000635e:	0003c497          	auipc	s1,0x3c
    80006362:	b9a48493          	addi	s1,s1,-1126 # 80041ef8 <uart_tx_lock>
    80006366:	8526                	mv	a0,s1
    80006368:	00000097          	auipc	ra,0x0
    8000636c:	0b4080e7          	jalr	180(ra) # 8000641c <acquire>
  uartstart();
    80006370:	00000097          	auipc	ra,0x0
    80006374:	e64080e7          	jalr	-412(ra) # 800061d4 <uartstart>
  release(&uart_tx_lock);
    80006378:	8526                	mv	a0,s1
    8000637a:	00000097          	auipc	ra,0x0
    8000637e:	156080e7          	jalr	342(ra) # 800064d0 <release>
}
    80006382:	60e2                	ld	ra,24(sp)
    80006384:	6442                	ld	s0,16(sp)
    80006386:	64a2                	ld	s1,8(sp)
    80006388:	6105                	addi	sp,sp,32
    8000638a:	8082                	ret

000000008000638c <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000638c:	1141                	addi	sp,sp,-16
    8000638e:	e422                	sd	s0,8(sp)
    80006390:	0800                	addi	s0,sp,16
  lk->name = name;
    80006392:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006394:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006398:	00053823          	sd	zero,16(a0)
}
    8000639c:	6422                	ld	s0,8(sp)
    8000639e:	0141                	addi	sp,sp,16
    800063a0:	8082                	ret

00000000800063a2 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800063a2:	411c                	lw	a5,0(a0)
    800063a4:	e399                	bnez	a5,800063aa <holding+0x8>
    800063a6:	4501                	li	a0,0
  return r;
}
    800063a8:	8082                	ret
{
    800063aa:	1101                	addi	sp,sp,-32
    800063ac:	ec06                	sd	ra,24(sp)
    800063ae:	e822                	sd	s0,16(sp)
    800063b0:	e426                	sd	s1,8(sp)
    800063b2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800063b4:	6904                	ld	s1,16(a0)
    800063b6:	ffffb097          	auipc	ra,0xffffb
    800063ba:	d30080e7          	jalr	-720(ra) # 800010e6 <mycpu>
    800063be:	40a48533          	sub	a0,s1,a0
    800063c2:	00153513          	seqz	a0,a0
}
    800063c6:	60e2                	ld	ra,24(sp)
    800063c8:	6442                	ld	s0,16(sp)
    800063ca:	64a2                	ld	s1,8(sp)
    800063cc:	6105                	addi	sp,sp,32
    800063ce:	8082                	ret

00000000800063d0 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800063d0:	1101                	addi	sp,sp,-32
    800063d2:	ec06                	sd	ra,24(sp)
    800063d4:	e822                	sd	s0,16(sp)
    800063d6:	e426                	sd	s1,8(sp)
    800063d8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800063da:	100024f3          	csrr	s1,sstatus
    800063de:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800063e2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800063e4:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800063e8:	ffffb097          	auipc	ra,0xffffb
    800063ec:	cfe080e7          	jalr	-770(ra) # 800010e6 <mycpu>
    800063f0:	5d3c                	lw	a5,120(a0)
    800063f2:	cf89                	beqz	a5,8000640c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800063f4:	ffffb097          	auipc	ra,0xffffb
    800063f8:	cf2080e7          	jalr	-782(ra) # 800010e6 <mycpu>
    800063fc:	5d3c                	lw	a5,120(a0)
    800063fe:	2785                	addiw	a5,a5,1
    80006400:	dd3c                	sw	a5,120(a0)
}
    80006402:	60e2                	ld	ra,24(sp)
    80006404:	6442                	ld	s0,16(sp)
    80006406:	64a2                	ld	s1,8(sp)
    80006408:	6105                	addi	sp,sp,32
    8000640a:	8082                	ret
    mycpu()->intena = old;
    8000640c:	ffffb097          	auipc	ra,0xffffb
    80006410:	cda080e7          	jalr	-806(ra) # 800010e6 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006414:	8085                	srli	s1,s1,0x1
    80006416:	8885                	andi	s1,s1,1
    80006418:	dd64                	sw	s1,124(a0)
    8000641a:	bfe9                	j	800063f4 <push_off+0x24>

000000008000641c <acquire>:
{
    8000641c:	1101                	addi	sp,sp,-32
    8000641e:	ec06                	sd	ra,24(sp)
    80006420:	e822                	sd	s0,16(sp)
    80006422:	e426                	sd	s1,8(sp)
    80006424:	1000                	addi	s0,sp,32
    80006426:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006428:	00000097          	auipc	ra,0x0
    8000642c:	fa8080e7          	jalr	-88(ra) # 800063d0 <push_off>
  if(holding(lk))
    80006430:	8526                	mv	a0,s1
    80006432:	00000097          	auipc	ra,0x0
    80006436:	f70080e7          	jalr	-144(ra) # 800063a2 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000643a:	4705                	li	a4,1
  if(holding(lk))
    8000643c:	e115                	bnez	a0,80006460 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000643e:	87ba                	mv	a5,a4
    80006440:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006444:	2781                	sext.w	a5,a5
    80006446:	ffe5                	bnez	a5,8000643e <acquire+0x22>
  __sync_synchronize();
    80006448:	0ff0000f          	fence
  lk->cpu = mycpu();
    8000644c:	ffffb097          	auipc	ra,0xffffb
    80006450:	c9a080e7          	jalr	-870(ra) # 800010e6 <mycpu>
    80006454:	e888                	sd	a0,16(s1)
}
    80006456:	60e2                	ld	ra,24(sp)
    80006458:	6442                	ld	s0,16(sp)
    8000645a:	64a2                	ld	s1,8(sp)
    8000645c:	6105                	addi	sp,sp,32
    8000645e:	8082                	ret
    panic("acquire");
    80006460:	00002517          	auipc	a0,0x2
    80006464:	56850513          	addi	a0,a0,1384 # 800089c8 <digits+0x20>
    80006468:	00000097          	auipc	ra,0x0
    8000646c:	a6a080e7          	jalr	-1430(ra) # 80005ed2 <panic>

0000000080006470 <pop_off>:

void
pop_off(void)
{
    80006470:	1141                	addi	sp,sp,-16
    80006472:	e406                	sd	ra,8(sp)
    80006474:	e022                	sd	s0,0(sp)
    80006476:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006478:	ffffb097          	auipc	ra,0xffffb
    8000647c:	c6e080e7          	jalr	-914(ra) # 800010e6 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006480:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006484:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006486:	e78d                	bnez	a5,800064b0 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006488:	5d3c                	lw	a5,120(a0)
    8000648a:	02f05b63          	blez	a5,800064c0 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000648e:	37fd                	addiw	a5,a5,-1
    80006490:	0007871b          	sext.w	a4,a5
    80006494:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006496:	eb09                	bnez	a4,800064a8 <pop_off+0x38>
    80006498:	5d7c                	lw	a5,124(a0)
    8000649a:	c799                	beqz	a5,800064a8 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000649c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800064a0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800064a4:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800064a8:	60a2                	ld	ra,8(sp)
    800064aa:	6402                	ld	s0,0(sp)
    800064ac:	0141                	addi	sp,sp,16
    800064ae:	8082                	ret
    panic("pop_off - interruptible");
    800064b0:	00002517          	auipc	a0,0x2
    800064b4:	52050513          	addi	a0,a0,1312 # 800089d0 <digits+0x28>
    800064b8:	00000097          	auipc	ra,0x0
    800064bc:	a1a080e7          	jalr	-1510(ra) # 80005ed2 <panic>
    panic("pop_off");
    800064c0:	00002517          	auipc	a0,0x2
    800064c4:	52850513          	addi	a0,a0,1320 # 800089e8 <digits+0x40>
    800064c8:	00000097          	auipc	ra,0x0
    800064cc:	a0a080e7          	jalr	-1526(ra) # 80005ed2 <panic>

00000000800064d0 <release>:
{
    800064d0:	1101                	addi	sp,sp,-32
    800064d2:	ec06                	sd	ra,24(sp)
    800064d4:	e822                	sd	s0,16(sp)
    800064d6:	e426                	sd	s1,8(sp)
    800064d8:	1000                	addi	s0,sp,32
    800064da:	84aa                	mv	s1,a0
  if(!holding(lk))
    800064dc:	00000097          	auipc	ra,0x0
    800064e0:	ec6080e7          	jalr	-314(ra) # 800063a2 <holding>
    800064e4:	c115                	beqz	a0,80006508 <release+0x38>
  lk->cpu = 0;
    800064e6:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800064ea:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800064ee:	0f50000f          	fence	iorw,ow
    800064f2:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800064f6:	00000097          	auipc	ra,0x0
    800064fa:	f7a080e7          	jalr	-134(ra) # 80006470 <pop_off>
}
    800064fe:	60e2                	ld	ra,24(sp)
    80006500:	6442                	ld	s0,16(sp)
    80006502:	64a2                	ld	s1,8(sp)
    80006504:	6105                	addi	sp,sp,32
    80006506:	8082                	ret
    panic("release");
    80006508:	00002517          	auipc	a0,0x2
    8000650c:	4e850513          	addi	a0,a0,1256 # 800089f0 <digits+0x48>
    80006510:	00000097          	auipc	ra,0x0
    80006514:	9c2080e7          	jalr	-1598(ra) # 80005ed2 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
