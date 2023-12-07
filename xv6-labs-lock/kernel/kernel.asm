
kernel/kernel：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	98013103          	ld	sp,-1664(sp) # 80008980 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	50b050ef          	jal	ra,80005d20 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	7139                	addi	sp,sp,-64
    8000001e:	fc06                	sd	ra,56(sp)
    80000020:	f822                	sd	s0,48(sp)
    80000022:	f426                	sd	s1,40(sp)
    80000024:	f04a                	sd	s2,32(sp)
    80000026:	ec4e                	sd	s3,24(sp)
    80000028:	e852                	sd	s4,16(sp)
    8000002a:	e456                	sd	s5,8(sp)
    8000002c:	0080                	addi	s0,sp,64
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    8000002e:	03451793          	slli	a5,a0,0x34
    80000032:	e3c1                	bnez	a5,800000b2 <kfree+0x96>
    80000034:	84aa                	mv	s1,a0
    80000036:	00028797          	auipc	a5,0x28
    8000003a:	9f278793          	addi	a5,a5,-1550 # 80027a28 <end>
    8000003e:	06f56a63          	bltu	a0,a5,800000b2 <kfree+0x96>
    80000042:	47c5                	li	a5,17
    80000044:	07ee                	slli	a5,a5,0x1b
    80000046:	06f57663          	bgeu	a0,a5,800000b2 <kfree+0x96>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000004a:	6605                	lui	a2,0x1
    8000004c:	4585                	li	a1,1
    8000004e:	00000097          	auipc	ra,0x0
    80000052:	222080e7          	jalr	546(ra) # 80000270 <memset>

  r = (struct run*)pa;

  push_off();
    80000056:	00006097          	auipc	ra,0x6
    8000005a:	668080e7          	jalr	1640(ra) # 800066be <push_off>
  int cid = cpuid();
    8000005e:	00001097          	auipc	ra,0x1
    80000062:	f2e080e7          	jalr	-210(ra) # 80000f8c <cpuid>
  
  acquire(&(kmems[cid].lock));
    80000066:	00009a97          	auipc	s5,0x9
    8000006a:	96aa8a93          	addi	s5,s5,-1686 # 800089d0 <kmems>
    8000006e:	00251993          	slli	s3,a0,0x2
    80000072:	00a98933          	add	s2,s3,a0
    80000076:	090e                	slli	s2,s2,0x3
    80000078:	9956                	add	s2,s2,s5
    8000007a:	854a                	mv	a0,s2
    8000007c:	00006097          	auipc	ra,0x6
    80000080:	68e080e7          	jalr	1678(ra) # 8000670a <acquire>
  r->next = kmems[cid].freelist;
    80000084:	02093783          	ld	a5,32(s2)
    80000088:	e09c                	sd	a5,0(s1)
  kmems[cid].freelist = r;
    8000008a:	02993023          	sd	s1,32(s2)
  release(&(kmems[cid].lock));
    8000008e:	854a                	mv	a0,s2
    80000090:	00006097          	auipc	ra,0x6
    80000094:	74a080e7          	jalr	1866(ra) # 800067da <release>
  
  pop_off();
    80000098:	00006097          	auipc	ra,0x6
    8000009c:	6e2080e7          	jalr	1762(ra) # 8000677a <pop_off>
}
    800000a0:	70e2                	ld	ra,56(sp)
    800000a2:	7442                	ld	s0,48(sp)
    800000a4:	74a2                	ld	s1,40(sp)
    800000a6:	7902                	ld	s2,32(sp)
    800000a8:	69e2                	ld	s3,24(sp)
    800000aa:	6a42                	ld	s4,16(sp)
    800000ac:	6aa2                	ld	s5,8(sp)
    800000ae:	6121                	addi	sp,sp,64
    800000b0:	8082                	ret
    panic("kfree");
    800000b2:	00008517          	auipc	a0,0x8
    800000b6:	f5e50513          	addi	a0,a0,-162 # 80008010 <etext+0x10>
    800000ba:	00006097          	auipc	ra,0x6
    800000be:	11c080e7          	jalr	284(ra) # 800061d6 <panic>

00000000800000c2 <freerange>:
{
    800000c2:	7179                	addi	sp,sp,-48
    800000c4:	f406                	sd	ra,40(sp)
    800000c6:	f022                	sd	s0,32(sp)
    800000c8:	ec26                	sd	s1,24(sp)
    800000ca:	e84a                	sd	s2,16(sp)
    800000cc:	e44e                	sd	s3,8(sp)
    800000ce:	e052                	sd	s4,0(sp)
    800000d0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000d2:	6785                	lui	a5,0x1
    800000d4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000d8:	94aa                	add	s1,s1,a0
    800000da:	757d                	lui	a0,0xfffff
    800000dc:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000de:	94be                	add	s1,s1,a5
    800000e0:	0095ee63          	bltu	a1,s1,800000fc <freerange+0x3a>
    800000e4:	892e                	mv	s2,a1
    kfree(p);
    800000e6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000e8:	6985                	lui	s3,0x1
    kfree(p);
    800000ea:	01448533          	add	a0,s1,s4
    800000ee:	00000097          	auipc	ra,0x0
    800000f2:	f2e080e7          	jalr	-210(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000f6:	94ce                	add	s1,s1,s3
    800000f8:	fe9979e3          	bgeu	s2,s1,800000ea <freerange+0x28>
}
    800000fc:	70a2                	ld	ra,40(sp)
    800000fe:	7402                	ld	s0,32(sp)
    80000100:	64e2                	ld	s1,24(sp)
    80000102:	6942                	ld	s2,16(sp)
    80000104:	69a2                	ld	s3,8(sp)
    80000106:	6a02                	ld	s4,0(sp)
    80000108:	6145                	addi	sp,sp,48
    8000010a:	8082                	ret

000000008000010c <kinit>:
{
    8000010c:	7179                	addi	sp,sp,-48
    8000010e:	f406                	sd	ra,40(sp)
    80000110:	f022                	sd	s0,32(sp)
    80000112:	ec26                	sd	s1,24(sp)
    80000114:	e84a                	sd	s2,16(sp)
    80000116:	e44e                	sd	s3,8(sp)
    80000118:	1800                	addi	s0,sp,48
  for(i=0; i<NCPU; ++i){
    8000011a:	00009497          	auipc	s1,0x9
    8000011e:	8b648493          	addi	s1,s1,-1866 # 800089d0 <kmems>
    80000122:	00009997          	auipc	s3,0x9
    80000126:	9ee98993          	addi	s3,s3,-1554 # 80008b10 <pid_lock>
    initlock(&(kmems[i].lock), "kmem");
    8000012a:	00008917          	auipc	s2,0x8
    8000012e:	eee90913          	addi	s2,s2,-274 # 80008018 <etext+0x18>
    80000132:	85ca                	mv	a1,s2
    80000134:	8526                	mv	a0,s1
    80000136:	00006097          	auipc	ra,0x6
    8000013a:	750080e7          	jalr	1872(ra) # 80006886 <initlock>
  for(i=0; i<NCPU; ++i){
    8000013e:	02848493          	addi	s1,s1,40
    80000142:	ff3498e3          	bne	s1,s3,80000132 <kinit+0x26>
  freerange(end, (void*)PHYSTOP);
    80000146:	45c5                	li	a1,17
    80000148:	05ee                	slli	a1,a1,0x1b
    8000014a:	00028517          	auipc	a0,0x28
    8000014e:	8de50513          	addi	a0,a0,-1826 # 80027a28 <end>
    80000152:	00000097          	auipc	ra,0x0
    80000156:	f70080e7          	jalr	-144(ra) # 800000c2 <freerange>
}
    8000015a:	70a2                	ld	ra,40(sp)
    8000015c:	7402                	ld	s0,32(sp)
    8000015e:	64e2                	ld	s1,24(sp)
    80000160:	6942                	ld	s2,16(sp)
    80000162:	69a2                	ld	s3,8(sp)
    80000164:	6145                	addi	sp,sp,48
    80000166:	8082                	ret

0000000080000168 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000168:	715d                	addi	sp,sp,-80
    8000016a:	e486                	sd	ra,72(sp)
    8000016c:	e0a2                	sd	s0,64(sp)
    8000016e:	fc26                	sd	s1,56(sp)
    80000170:	f84a                	sd	s2,48(sp)
    80000172:	f44e                	sd	s3,40(sp)
    80000174:	f052                	sd	s4,32(sp)
    80000176:	ec56                	sd	s5,24(sp)
    80000178:	e85a                	sd	s6,16(sp)
    8000017a:	e45e                	sd	s7,8(sp)
    8000017c:	e062                	sd	s8,0(sp)
    8000017e:	0880                	addi	s0,sp,80
  struct run *r;

  push_off();
    80000180:	00006097          	auipc	ra,0x6
    80000184:	53e080e7          	jalr	1342(ra) # 800066be <push_off>
  int cid = cpuid();
    80000188:	00001097          	auipc	ra,0x1
    8000018c:	e04080e7          	jalr	-508(ra) # 80000f8c <cpuid>
    80000190:	892a                	mv	s2,a0
  acquire(&(kmems[cid].lock));
    80000192:	00251a13          	slli	s4,a0,0x2
    80000196:	9a2a                	add	s4,s4,a0
    80000198:	003a1793          	slli	a5,s4,0x3
    8000019c:	00009a17          	auipc	s4,0x9
    800001a0:	834a0a13          	addi	s4,s4,-1996 # 800089d0 <kmems>
    800001a4:	9a3e                	add	s4,s4,a5
    800001a6:	8552                	mv	a0,s4
    800001a8:	00006097          	auipc	ra,0x6
    800001ac:	562080e7          	jalr	1378(ra) # 8000670a <acquire>
  r = kmems[cid].freelist;
    800001b0:	020a3a83          	ld	s5,32(s4)
  if(r)
    800001b4:	040a8363          	beqz	s5,800001fa <kalloc+0x92>
    kmems[cid].freelist = r->next;
    800001b8:	000ab703          	ld	a4,0(s5)
    800001bc:	02ea3023          	sd	a4,32(s4)
        break;
      }
  	  release(&(kmems[i].lock));
    }
  }
  release(&(kmems[cid].lock));
    800001c0:	8552                	mv	a0,s4
    800001c2:	00006097          	auipc	ra,0x6
    800001c6:	618080e7          	jalr	1560(ra) # 800067da <release>
  
  pop_off();
    800001ca:	00006097          	auipc	ra,0x6
    800001ce:	5b0080e7          	jalr	1456(ra) # 8000677a <pop_off>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    800001d2:	6605                	lui	a2,0x1
    800001d4:	4595                	li	a1,5
    800001d6:	8556                	mv	a0,s5
    800001d8:	00000097          	auipc	ra,0x0
    800001dc:	098080e7          	jalr	152(ra) # 80000270 <memset>
  return (void*)r;
}
    800001e0:	8556                	mv	a0,s5
    800001e2:	60a6                	ld	ra,72(sp)
    800001e4:	6406                	ld	s0,64(sp)
    800001e6:	74e2                	ld	s1,56(sp)
    800001e8:	7942                	ld	s2,48(sp)
    800001ea:	79a2                	ld	s3,40(sp)
    800001ec:	7a02                	ld	s4,32(sp)
    800001ee:	6ae2                	ld	s5,24(sp)
    800001f0:	6b42                	ld	s6,16(sp)
    800001f2:	6ba2                	ld	s7,8(sp)
    800001f4:	6c02                	ld	s8,0(sp)
    800001f6:	6161                	addi	sp,sp,80
    800001f8:	8082                	ret
    800001fa:	00008497          	auipc	s1,0x8
    800001fe:	7d648493          	addi	s1,s1,2006 # 800089d0 <kmems>
    for(i=0; i<NCPU; ++i){
    80000202:	4981                	li	s3,0
    80000204:	4ba1                	li	s7,8
    80000206:	a815                	j	8000023a <kalloc+0xd2>
        kmems[i].freelist = r->next;
    80000208:	000b3703          	ld	a4,0(s6)
    8000020c:	00299793          	slli	a5,s3,0x2
    80000210:	99be                	add	s3,s3,a5
    80000212:	098e                	slli	s3,s3,0x3
    80000214:	00008797          	auipc	a5,0x8
    80000218:	7bc78793          	addi	a5,a5,1980 # 800089d0 <kmems>
    8000021c:	99be                	add	s3,s3,a5
    8000021e:	02e9b023          	sd	a4,32(s3)
        release(&(kmems[i].lock));
    80000222:	8526                	mv	a0,s1
    80000224:	00006097          	auipc	ra,0x6
    80000228:	5b6080e7          	jalr	1462(ra) # 800067da <release>
      r = kmems[i].freelist;
    8000022c:	8ada                	mv	s5,s6
        break;
    8000022e:	bf49                	j	800001c0 <kalloc+0x58>
    for(i=0; i<NCPU; ++i){
    80000230:	2985                	addiw	s3,s3,1
    80000232:	02848493          	addi	s1,s1,40
    80000236:	03798363          	beq	s3,s7,8000025c <kalloc+0xf4>
      if(i == cid)
    8000023a:	ff390be3          	beq	s2,s3,80000230 <kalloc+0xc8>
      acquire(&(kmems[i].lock));
    8000023e:	8526                	mv	a0,s1
    80000240:	00006097          	auipc	ra,0x6
    80000244:	4ca080e7          	jalr	1226(ra) # 8000670a <acquire>
      r = kmems[i].freelist;
    80000248:	0204bb03          	ld	s6,32(s1)
  	  if(r){
    8000024c:	fa0b1ee3          	bnez	s6,80000208 <kalloc+0xa0>
  	  release(&(kmems[i].lock));
    80000250:	8526                	mv	a0,s1
    80000252:	00006097          	auipc	ra,0x6
    80000256:	588080e7          	jalr	1416(ra) # 800067da <release>
    8000025a:	bfd9                	j	80000230 <kalloc+0xc8>
  release(&(kmems[cid].lock));
    8000025c:	8552                	mv	a0,s4
    8000025e:	00006097          	auipc	ra,0x6
    80000262:	57c080e7          	jalr	1404(ra) # 800067da <release>
  pop_off();
    80000266:	00006097          	auipc	ra,0x6
    8000026a:	514080e7          	jalr	1300(ra) # 8000677a <pop_off>
  return (void*)r;
    8000026e:	bf8d                	j	800001e0 <kalloc+0x78>

0000000080000270 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000270:	1141                	addi	sp,sp,-16
    80000272:	e422                	sd	s0,8(sp)
    80000274:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000276:	ce09                	beqz	a2,80000290 <memset+0x20>
    80000278:	87aa                	mv	a5,a0
    8000027a:	fff6071b          	addiw	a4,a2,-1
    8000027e:	1702                	slli	a4,a4,0x20
    80000280:	9301                	srli	a4,a4,0x20
    80000282:	0705                	addi	a4,a4,1
    80000284:	972a                	add	a4,a4,a0
    cdst[i] = c;
    80000286:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    8000028a:	0785                	addi	a5,a5,1
    8000028c:	fee79de3          	bne	a5,a4,80000286 <memset+0x16>
  }
  return dst;
}
    80000290:	6422                	ld	s0,8(sp)
    80000292:	0141                	addi	sp,sp,16
    80000294:	8082                	ret

0000000080000296 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000296:	1141                	addi	sp,sp,-16
    80000298:	e422                	sd	s0,8(sp)
    8000029a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000029c:	ca05                	beqz	a2,800002cc <memcmp+0x36>
    8000029e:	fff6069b          	addiw	a3,a2,-1
    800002a2:	1682                	slli	a3,a3,0x20
    800002a4:	9281                	srli	a3,a3,0x20
    800002a6:	0685                	addi	a3,a3,1
    800002a8:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800002aa:	00054783          	lbu	a5,0(a0)
    800002ae:	0005c703          	lbu	a4,0(a1)
    800002b2:	00e79863          	bne	a5,a4,800002c2 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800002b6:	0505                	addi	a0,a0,1
    800002b8:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800002ba:	fed518e3          	bne	a0,a3,800002aa <memcmp+0x14>
  }

  return 0;
    800002be:	4501                	li	a0,0
    800002c0:	a019                	j	800002c6 <memcmp+0x30>
      return *s1 - *s2;
    800002c2:	40e7853b          	subw	a0,a5,a4
}
    800002c6:	6422                	ld	s0,8(sp)
    800002c8:	0141                	addi	sp,sp,16
    800002ca:	8082                	ret
  return 0;
    800002cc:	4501                	li	a0,0
    800002ce:	bfe5                	j	800002c6 <memcmp+0x30>

00000000800002d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800002d0:	1141                	addi	sp,sp,-16
    800002d2:	e422                	sd	s0,8(sp)
    800002d4:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800002d6:	ca0d                	beqz	a2,80000308 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800002d8:	00a5f963          	bgeu	a1,a0,800002ea <memmove+0x1a>
    800002dc:	02061693          	slli	a3,a2,0x20
    800002e0:	9281                	srli	a3,a3,0x20
    800002e2:	00d58733          	add	a4,a1,a3
    800002e6:	02e56463          	bltu	a0,a4,8000030e <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800002ea:	fff6079b          	addiw	a5,a2,-1
    800002ee:	1782                	slli	a5,a5,0x20
    800002f0:	9381                	srli	a5,a5,0x20
    800002f2:	0785                	addi	a5,a5,1
    800002f4:	97ae                	add	a5,a5,a1
    800002f6:	872a                	mv	a4,a0
      *d++ = *s++;
    800002f8:	0585                	addi	a1,a1,1
    800002fa:	0705                	addi	a4,a4,1
    800002fc:	fff5c683          	lbu	a3,-1(a1)
    80000300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000304:	fef59ae3          	bne	a1,a5,800002f8 <memmove+0x28>

  return dst;
}
    80000308:	6422                	ld	s0,8(sp)
    8000030a:	0141                	addi	sp,sp,16
    8000030c:	8082                	ret
    d += n;
    8000030e:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000310:	fff6079b          	addiw	a5,a2,-1
    80000314:	1782                	slli	a5,a5,0x20
    80000316:	9381                	srli	a5,a5,0x20
    80000318:	fff7c793          	not	a5,a5
    8000031c:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000031e:	177d                	addi	a4,a4,-1
    80000320:	16fd                	addi	a3,a3,-1
    80000322:	00074603          	lbu	a2,0(a4)
    80000326:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000032a:	fef71ae3          	bne	a4,a5,8000031e <memmove+0x4e>
    8000032e:	bfe9                	j	80000308 <memmove+0x38>

0000000080000330 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000330:	1141                	addi	sp,sp,-16
    80000332:	e406                	sd	ra,8(sp)
    80000334:	e022                	sd	s0,0(sp)
    80000336:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000338:	00000097          	auipc	ra,0x0
    8000033c:	f98080e7          	jalr	-104(ra) # 800002d0 <memmove>
}
    80000340:	60a2                	ld	ra,8(sp)
    80000342:	6402                	ld	s0,0(sp)
    80000344:	0141                	addi	sp,sp,16
    80000346:	8082                	ret

0000000080000348 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000348:	1141                	addi	sp,sp,-16
    8000034a:	e422                	sd	s0,8(sp)
    8000034c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000034e:	ce11                	beqz	a2,8000036a <strncmp+0x22>
    80000350:	00054783          	lbu	a5,0(a0)
    80000354:	cf89                	beqz	a5,8000036e <strncmp+0x26>
    80000356:	0005c703          	lbu	a4,0(a1)
    8000035a:	00f71a63          	bne	a4,a5,8000036e <strncmp+0x26>
    n--, p++, q++;
    8000035e:	367d                	addiw	a2,a2,-1
    80000360:	0505                	addi	a0,a0,1
    80000362:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000364:	f675                	bnez	a2,80000350 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000366:	4501                	li	a0,0
    80000368:	a809                	j	8000037a <strncmp+0x32>
    8000036a:	4501                	li	a0,0
    8000036c:	a039                	j	8000037a <strncmp+0x32>
  if(n == 0)
    8000036e:	ca09                	beqz	a2,80000380 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000370:	00054503          	lbu	a0,0(a0)
    80000374:	0005c783          	lbu	a5,0(a1)
    80000378:	9d1d                	subw	a0,a0,a5
}
    8000037a:	6422                	ld	s0,8(sp)
    8000037c:	0141                	addi	sp,sp,16
    8000037e:	8082                	ret
    return 0;
    80000380:	4501                	li	a0,0
    80000382:	bfe5                	j	8000037a <strncmp+0x32>

0000000080000384 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000384:	1141                	addi	sp,sp,-16
    80000386:	e422                	sd	s0,8(sp)
    80000388:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000038a:	872a                	mv	a4,a0
    8000038c:	8832                	mv	a6,a2
    8000038e:	367d                	addiw	a2,a2,-1
    80000390:	01005963          	blez	a6,800003a2 <strncpy+0x1e>
    80000394:	0705                	addi	a4,a4,1
    80000396:	0005c783          	lbu	a5,0(a1)
    8000039a:	fef70fa3          	sb	a5,-1(a4)
    8000039e:	0585                	addi	a1,a1,1
    800003a0:	f7f5                	bnez	a5,8000038c <strncpy+0x8>
    ;
  while(n-- > 0)
    800003a2:	00c05d63          	blez	a2,800003bc <strncpy+0x38>
    800003a6:	86ba                	mv	a3,a4
    *s++ = 0;
    800003a8:	0685                	addi	a3,a3,1
    800003aa:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800003ae:	fff6c793          	not	a5,a3
    800003b2:	9fb9                	addw	a5,a5,a4
    800003b4:	010787bb          	addw	a5,a5,a6
    800003b8:	fef048e3          	bgtz	a5,800003a8 <strncpy+0x24>
  return os;
}
    800003bc:	6422                	ld	s0,8(sp)
    800003be:	0141                	addi	sp,sp,16
    800003c0:	8082                	ret

00000000800003c2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800003c2:	1141                	addi	sp,sp,-16
    800003c4:	e422                	sd	s0,8(sp)
    800003c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800003c8:	02c05363          	blez	a2,800003ee <safestrcpy+0x2c>
    800003cc:	fff6069b          	addiw	a3,a2,-1
    800003d0:	1682                	slli	a3,a3,0x20
    800003d2:	9281                	srli	a3,a3,0x20
    800003d4:	96ae                	add	a3,a3,a1
    800003d6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800003d8:	00d58963          	beq	a1,a3,800003ea <safestrcpy+0x28>
    800003dc:	0585                	addi	a1,a1,1
    800003de:	0785                	addi	a5,a5,1
    800003e0:	fff5c703          	lbu	a4,-1(a1)
    800003e4:	fee78fa3          	sb	a4,-1(a5)
    800003e8:	fb65                	bnez	a4,800003d8 <safestrcpy+0x16>
    ;
  *s = 0;
    800003ea:	00078023          	sb	zero,0(a5)
  return os;
}
    800003ee:	6422                	ld	s0,8(sp)
    800003f0:	0141                	addi	sp,sp,16
    800003f2:	8082                	ret

00000000800003f4 <strlen>:

int
strlen(const char *s)
{
    800003f4:	1141                	addi	sp,sp,-16
    800003f6:	e422                	sd	s0,8(sp)
    800003f8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800003fa:	00054783          	lbu	a5,0(a0)
    800003fe:	cf91                	beqz	a5,8000041a <strlen+0x26>
    80000400:	0505                	addi	a0,a0,1
    80000402:	87aa                	mv	a5,a0
    80000404:	4685                	li	a3,1
    80000406:	9e89                	subw	a3,a3,a0
    80000408:	00f6853b          	addw	a0,a3,a5
    8000040c:	0785                	addi	a5,a5,1
    8000040e:	fff7c703          	lbu	a4,-1(a5)
    80000412:	fb7d                	bnez	a4,80000408 <strlen+0x14>
    ;
  return n;
}
    80000414:	6422                	ld	s0,8(sp)
    80000416:	0141                	addi	sp,sp,16
    80000418:	8082                	ret
  for(n = 0; s[n]; n++)
    8000041a:	4501                	li	a0,0
    8000041c:	bfe5                	j	80000414 <strlen+0x20>

000000008000041e <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    8000041e:	1101                	addi	sp,sp,-32
    80000420:	ec06                	sd	ra,24(sp)
    80000422:	e822                	sd	s0,16(sp)
    80000424:	e426                	sd	s1,8(sp)
    80000426:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    80000428:	00001097          	auipc	ra,0x1
    8000042c:	b64080e7          	jalr	-1180(ra) # 80000f8c <cpuid>
    kcsaninit();
#endif
    __sync_synchronize();
    started = 1;
  } else {
    while(atomic_read4((int *) &started) == 0)
    80000430:	00008497          	auipc	s1,0x8
    80000434:	57048493          	addi	s1,s1,1392 # 800089a0 <started>
  if(cpuid() == 0){
    80000438:	c531                	beqz	a0,80000484 <main+0x66>
    while(atomic_read4((int *) &started) == 0)
    8000043a:	8526                	mv	a0,s1
    8000043c:	00006097          	auipc	ra,0x6
    80000440:	4ca080e7          	jalr	1226(ra) # 80006906 <atomic_read4>
    80000444:	d97d                	beqz	a0,8000043a <main+0x1c>
      ;
    __sync_synchronize();
    80000446:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000044a:	00001097          	auipc	ra,0x1
    8000044e:	b42080e7          	jalr	-1214(ra) # 80000f8c <cpuid>
    80000452:	85aa                	mv	a1,a0
    80000454:	00008517          	auipc	a0,0x8
    80000458:	be450513          	addi	a0,a0,-1052 # 80008038 <etext+0x38>
    8000045c:	00006097          	auipc	ra,0x6
    80000460:	dc4080e7          	jalr	-572(ra) # 80006220 <printf>
    kvminithart();    // turn on paging
    80000464:	00000097          	auipc	ra,0x0
    80000468:	0e0080e7          	jalr	224(ra) # 80000544 <kvminithart>
    trapinithart();   // install kernel trap vector
    8000046c:	00001097          	auipc	ra,0x1
    80000470:	7e8080e7          	jalr	2024(ra) # 80001c54 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000474:	00005097          	auipc	ra,0x5
    80000478:	ecc080e7          	jalr	-308(ra) # 80005340 <plicinithart>
  }

  scheduler();        
    8000047c:	00001097          	auipc	ra,0x1
    80000480:	032080e7          	jalr	50(ra) # 800014ae <scheduler>
    consoleinit();
    80000484:	00006097          	auipc	ra,0x6
    80000488:	c64080e7          	jalr	-924(ra) # 800060e8 <consoleinit>
    statsinit();
    8000048c:	00005097          	auipc	ra,0x5
    80000490:	5ce080e7          	jalr	1486(ra) # 80005a5a <statsinit>
    printfinit();
    80000494:	00006097          	auipc	ra,0x6
    80000498:	f72080e7          	jalr	-142(ra) # 80006406 <printfinit>
    printf("\n");
    8000049c:	00008517          	auipc	a0,0x8
    800004a0:	43c50513          	addi	a0,a0,1084 # 800088d8 <digits+0x88>
    800004a4:	00006097          	auipc	ra,0x6
    800004a8:	d7c080e7          	jalr	-644(ra) # 80006220 <printf>
    printf("xv6 kernel is booting\n");
    800004ac:	00008517          	auipc	a0,0x8
    800004b0:	b7450513          	addi	a0,a0,-1164 # 80008020 <etext+0x20>
    800004b4:	00006097          	auipc	ra,0x6
    800004b8:	d6c080e7          	jalr	-660(ra) # 80006220 <printf>
    printf("\n");
    800004bc:	00008517          	auipc	a0,0x8
    800004c0:	41c50513          	addi	a0,a0,1052 # 800088d8 <digits+0x88>
    800004c4:	00006097          	auipc	ra,0x6
    800004c8:	d5c080e7          	jalr	-676(ra) # 80006220 <printf>
    kinit();         // physical page allocator
    800004cc:	00000097          	auipc	ra,0x0
    800004d0:	c40080e7          	jalr	-960(ra) # 8000010c <kinit>
    kvminit();       // create kernel page table
    800004d4:	00000097          	auipc	ra,0x0
    800004d8:	34a080e7          	jalr	842(ra) # 8000081e <kvminit>
    kvminithart();   // turn on paging
    800004dc:	00000097          	auipc	ra,0x0
    800004e0:	068080e7          	jalr	104(ra) # 80000544 <kvminithart>
    procinit();      // process table
    800004e4:	00001097          	auipc	ra,0x1
    800004e8:	9f4080e7          	jalr	-1548(ra) # 80000ed8 <procinit>
    trapinit();      // trap vectors
    800004ec:	00001097          	auipc	ra,0x1
    800004f0:	740080e7          	jalr	1856(ra) # 80001c2c <trapinit>
    trapinithart();  // install kernel trap vector
    800004f4:	00001097          	auipc	ra,0x1
    800004f8:	760080e7          	jalr	1888(ra) # 80001c54 <trapinithart>
    plicinit();      // set up interrupt controller
    800004fc:	00005097          	auipc	ra,0x5
    80000500:	e2e080e7          	jalr	-466(ra) # 8000532a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000504:	00005097          	auipc	ra,0x5
    80000508:	e3c080e7          	jalr	-452(ra) # 80005340 <plicinithart>
    binit();         // buffer cache
    8000050c:	00002097          	auipc	ra,0x2
    80000510:	ea4080e7          	jalr	-348(ra) # 800023b0 <binit>
    iinit();         // inode table
    80000514:	00002097          	auipc	ra,0x2
    80000518:	676080e7          	jalr	1654(ra) # 80002b8a <iinit>
    fileinit();      // file table
    8000051c:	00003097          	auipc	ra,0x3
    80000520:	628080e7          	jalr	1576(ra) # 80003b44 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000524:	00005097          	auipc	ra,0x5
    80000528:	f24080e7          	jalr	-220(ra) # 80005448 <virtio_disk_init>
    userinit();      // first user process
    8000052c:	00001097          	auipc	ra,0x1
    80000530:	d68080e7          	jalr	-664(ra) # 80001294 <userinit>
    __sync_synchronize();
    80000534:	0ff0000f          	fence
    started = 1;
    80000538:	4785                	li	a5,1
    8000053a:	00008717          	auipc	a4,0x8
    8000053e:	46f72323          	sw	a5,1126(a4) # 800089a0 <started>
    80000542:	bf2d                	j	8000047c <main+0x5e>

0000000080000544 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000544:	1141                	addi	sp,sp,-16
    80000546:	e422                	sd	s0,8(sp)
    80000548:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    8000054a:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    8000054e:	00008797          	auipc	a5,0x8
    80000552:	45a7b783          	ld	a5,1114(a5) # 800089a8 <kernel_pagetable>
    80000556:	83b1                	srli	a5,a5,0xc
    80000558:	577d                	li	a4,-1
    8000055a:	177e                	slli	a4,a4,0x3f
    8000055c:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    8000055e:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000562:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000566:	6422                	ld	s0,8(sp)
    80000568:	0141                	addi	sp,sp,16
    8000056a:	8082                	ret

000000008000056c <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000056c:	7139                	addi	sp,sp,-64
    8000056e:	fc06                	sd	ra,56(sp)
    80000570:	f822                	sd	s0,48(sp)
    80000572:	f426                	sd	s1,40(sp)
    80000574:	f04a                	sd	s2,32(sp)
    80000576:	ec4e                	sd	s3,24(sp)
    80000578:	e852                	sd	s4,16(sp)
    8000057a:	e456                	sd	s5,8(sp)
    8000057c:	e05a                	sd	s6,0(sp)
    8000057e:	0080                	addi	s0,sp,64
    80000580:	84aa                	mv	s1,a0
    80000582:	89ae                	mv	s3,a1
    80000584:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000586:	57fd                	li	a5,-1
    80000588:	83e9                	srli	a5,a5,0x1a
    8000058a:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000058c:	4b31                	li	s6,12
  if(va >= MAXVA)
    8000058e:	04b7f263          	bgeu	a5,a1,800005d2 <walk+0x66>
    panic("walk");
    80000592:	00008517          	auipc	a0,0x8
    80000596:	abe50513          	addi	a0,a0,-1346 # 80008050 <etext+0x50>
    8000059a:	00006097          	auipc	ra,0x6
    8000059e:	c3c080e7          	jalr	-964(ra) # 800061d6 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800005a2:	060a8663          	beqz	s5,8000060e <walk+0xa2>
    800005a6:	00000097          	auipc	ra,0x0
    800005aa:	bc2080e7          	jalr	-1086(ra) # 80000168 <kalloc>
    800005ae:	84aa                	mv	s1,a0
    800005b0:	c529                	beqz	a0,800005fa <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800005b2:	6605                	lui	a2,0x1
    800005b4:	4581                	li	a1,0
    800005b6:	00000097          	auipc	ra,0x0
    800005ba:	cba080e7          	jalr	-838(ra) # 80000270 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800005be:	00c4d793          	srli	a5,s1,0xc
    800005c2:	07aa                	slli	a5,a5,0xa
    800005c4:	0017e793          	ori	a5,a5,1
    800005c8:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800005cc:	3a5d                	addiw	s4,s4,-9
    800005ce:	036a0063          	beq	s4,s6,800005ee <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800005d2:	0149d933          	srl	s2,s3,s4
    800005d6:	1ff97913          	andi	s2,s2,511
    800005da:	090e                	slli	s2,s2,0x3
    800005dc:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800005de:	00093483          	ld	s1,0(s2)
    800005e2:	0014f793          	andi	a5,s1,1
    800005e6:	dfd5                	beqz	a5,800005a2 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800005e8:	80a9                	srli	s1,s1,0xa
    800005ea:	04b2                	slli	s1,s1,0xc
    800005ec:	b7c5                	j	800005cc <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800005ee:	00c9d513          	srli	a0,s3,0xc
    800005f2:	1ff57513          	andi	a0,a0,511
    800005f6:	050e                	slli	a0,a0,0x3
    800005f8:	9526                	add	a0,a0,s1
}
    800005fa:	70e2                	ld	ra,56(sp)
    800005fc:	7442                	ld	s0,48(sp)
    800005fe:	74a2                	ld	s1,40(sp)
    80000600:	7902                	ld	s2,32(sp)
    80000602:	69e2                	ld	s3,24(sp)
    80000604:	6a42                	ld	s4,16(sp)
    80000606:	6aa2                	ld	s5,8(sp)
    80000608:	6b02                	ld	s6,0(sp)
    8000060a:	6121                	addi	sp,sp,64
    8000060c:	8082                	ret
        return 0;
    8000060e:	4501                	li	a0,0
    80000610:	b7ed                	j	800005fa <walk+0x8e>

0000000080000612 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000612:	57fd                	li	a5,-1
    80000614:	83e9                	srli	a5,a5,0x1a
    80000616:	00b7f463          	bgeu	a5,a1,8000061e <walkaddr+0xc>
    return 0;
    8000061a:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000061c:	8082                	ret
{
    8000061e:	1141                	addi	sp,sp,-16
    80000620:	e406                	sd	ra,8(sp)
    80000622:	e022                	sd	s0,0(sp)
    80000624:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000626:	4601                	li	a2,0
    80000628:	00000097          	auipc	ra,0x0
    8000062c:	f44080e7          	jalr	-188(ra) # 8000056c <walk>
  if(pte == 0)
    80000630:	c105                	beqz	a0,80000650 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000632:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000634:	0117f693          	andi	a3,a5,17
    80000638:	4745                	li	a4,17
    return 0;
    8000063a:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000063c:	00e68663          	beq	a3,a4,80000648 <walkaddr+0x36>
}
    80000640:	60a2                	ld	ra,8(sp)
    80000642:	6402                	ld	s0,0(sp)
    80000644:	0141                	addi	sp,sp,16
    80000646:	8082                	ret
  pa = PTE2PA(*pte);
    80000648:	00a7d513          	srli	a0,a5,0xa
    8000064c:	0532                	slli	a0,a0,0xc
  return pa;
    8000064e:	bfcd                	j	80000640 <walkaddr+0x2e>
    return 0;
    80000650:	4501                	li	a0,0
    80000652:	b7fd                	j	80000640 <walkaddr+0x2e>

0000000080000654 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000654:	715d                	addi	sp,sp,-80
    80000656:	e486                	sd	ra,72(sp)
    80000658:	e0a2                	sd	s0,64(sp)
    8000065a:	fc26                	sd	s1,56(sp)
    8000065c:	f84a                	sd	s2,48(sp)
    8000065e:	f44e                	sd	s3,40(sp)
    80000660:	f052                	sd	s4,32(sp)
    80000662:	ec56                	sd	s5,24(sp)
    80000664:	e85a                	sd	s6,16(sp)
    80000666:	e45e                	sd	s7,8(sp)
    80000668:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000066a:	03459793          	slli	a5,a1,0x34
    8000066e:	e385                	bnez	a5,8000068e <mappages+0x3a>
    80000670:	8aaa                	mv	s5,a0
    80000672:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    80000674:	03461793          	slli	a5,a2,0x34
    80000678:	e39d                	bnez	a5,8000069e <mappages+0x4a>
    panic("mappages: size not aligned");

  if(size == 0)
    8000067a:	ca15                	beqz	a2,800006ae <mappages+0x5a>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    8000067c:	79fd                	lui	s3,0xfffff
    8000067e:	964e                	add	a2,a2,s3
    80000680:	00b609b3          	add	s3,a2,a1
  a = va;
    80000684:	892e                	mv	s2,a1
    80000686:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000068a:	6b85                	lui	s7,0x1
    8000068c:	a091                	j	800006d0 <mappages+0x7c>
    panic("mappages: va not aligned");
    8000068e:	00008517          	auipc	a0,0x8
    80000692:	9ca50513          	addi	a0,a0,-1590 # 80008058 <etext+0x58>
    80000696:	00006097          	auipc	ra,0x6
    8000069a:	b40080e7          	jalr	-1216(ra) # 800061d6 <panic>
    panic("mappages: size not aligned");
    8000069e:	00008517          	auipc	a0,0x8
    800006a2:	9da50513          	addi	a0,a0,-1574 # 80008078 <etext+0x78>
    800006a6:	00006097          	auipc	ra,0x6
    800006aa:	b30080e7          	jalr	-1232(ra) # 800061d6 <panic>
    panic("mappages: size");
    800006ae:	00008517          	auipc	a0,0x8
    800006b2:	9ea50513          	addi	a0,a0,-1558 # 80008098 <etext+0x98>
    800006b6:	00006097          	auipc	ra,0x6
    800006ba:	b20080e7          	jalr	-1248(ra) # 800061d6 <panic>
      panic("mappages: remap");
    800006be:	00008517          	auipc	a0,0x8
    800006c2:	9ea50513          	addi	a0,a0,-1558 # 800080a8 <etext+0xa8>
    800006c6:	00006097          	auipc	ra,0x6
    800006ca:	b10080e7          	jalr	-1264(ra) # 800061d6 <panic>
    a += PGSIZE;
    800006ce:	995e                	add	s2,s2,s7
  for(;;){
    800006d0:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800006d4:	4605                	li	a2,1
    800006d6:	85ca                	mv	a1,s2
    800006d8:	8556                	mv	a0,s5
    800006da:	00000097          	auipc	ra,0x0
    800006de:	e92080e7          	jalr	-366(ra) # 8000056c <walk>
    800006e2:	cd19                	beqz	a0,80000700 <mappages+0xac>
    if(*pte & PTE_V)
    800006e4:	611c                	ld	a5,0(a0)
    800006e6:	8b85                	andi	a5,a5,1
    800006e8:	fbf9                	bnez	a5,800006be <mappages+0x6a>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800006ea:	80b1                	srli	s1,s1,0xc
    800006ec:	04aa                	slli	s1,s1,0xa
    800006ee:	0164e4b3          	or	s1,s1,s6
    800006f2:	0014e493          	ori	s1,s1,1
    800006f6:	e104                	sd	s1,0(a0)
    if(a == last)
    800006f8:	fd391be3          	bne	s2,s3,800006ce <mappages+0x7a>
    pa += PGSIZE;
  }
  return 0;
    800006fc:	4501                	li	a0,0
    800006fe:	a011                	j	80000702 <mappages+0xae>
      return -1;
    80000700:	557d                	li	a0,-1
}
    80000702:	60a6                	ld	ra,72(sp)
    80000704:	6406                	ld	s0,64(sp)
    80000706:	74e2                	ld	s1,56(sp)
    80000708:	7942                	ld	s2,48(sp)
    8000070a:	79a2                	ld	s3,40(sp)
    8000070c:	7a02                	ld	s4,32(sp)
    8000070e:	6ae2                	ld	s5,24(sp)
    80000710:	6b42                	ld	s6,16(sp)
    80000712:	6ba2                	ld	s7,8(sp)
    80000714:	6161                	addi	sp,sp,80
    80000716:	8082                	ret

0000000080000718 <kvmmap>:
{
    80000718:	1141                	addi	sp,sp,-16
    8000071a:	e406                	sd	ra,8(sp)
    8000071c:	e022                	sd	s0,0(sp)
    8000071e:	0800                	addi	s0,sp,16
    80000720:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000722:	86b2                	mv	a3,a2
    80000724:	863e                	mv	a2,a5
    80000726:	00000097          	auipc	ra,0x0
    8000072a:	f2e080e7          	jalr	-210(ra) # 80000654 <mappages>
    8000072e:	e509                	bnez	a0,80000738 <kvmmap+0x20>
}
    80000730:	60a2                	ld	ra,8(sp)
    80000732:	6402                	ld	s0,0(sp)
    80000734:	0141                	addi	sp,sp,16
    80000736:	8082                	ret
    panic("kvmmap");
    80000738:	00008517          	auipc	a0,0x8
    8000073c:	98050513          	addi	a0,a0,-1664 # 800080b8 <etext+0xb8>
    80000740:	00006097          	auipc	ra,0x6
    80000744:	a96080e7          	jalr	-1386(ra) # 800061d6 <panic>

0000000080000748 <kvmmake>:
{
    80000748:	1101                	addi	sp,sp,-32
    8000074a:	ec06                	sd	ra,24(sp)
    8000074c:	e822                	sd	s0,16(sp)
    8000074e:	e426                	sd	s1,8(sp)
    80000750:	e04a                	sd	s2,0(sp)
    80000752:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000754:	00000097          	auipc	ra,0x0
    80000758:	a14080e7          	jalr	-1516(ra) # 80000168 <kalloc>
    8000075c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000075e:	6605                	lui	a2,0x1
    80000760:	4581                	li	a1,0
    80000762:	00000097          	auipc	ra,0x0
    80000766:	b0e080e7          	jalr	-1266(ra) # 80000270 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000076a:	4719                	li	a4,6
    8000076c:	6685                	lui	a3,0x1
    8000076e:	10000637          	lui	a2,0x10000
    80000772:	100005b7          	lui	a1,0x10000
    80000776:	8526                	mv	a0,s1
    80000778:	00000097          	auipc	ra,0x0
    8000077c:	fa0080e7          	jalr	-96(ra) # 80000718 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000780:	4719                	li	a4,6
    80000782:	6685                	lui	a3,0x1
    80000784:	10001637          	lui	a2,0x10001
    80000788:	100015b7          	lui	a1,0x10001
    8000078c:	8526                	mv	a0,s1
    8000078e:	00000097          	auipc	ra,0x0
    80000792:	f8a080e7          	jalr	-118(ra) # 80000718 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000796:	4719                	li	a4,6
    80000798:	004006b7          	lui	a3,0x400
    8000079c:	0c000637          	lui	a2,0xc000
    800007a0:	0c0005b7          	lui	a1,0xc000
    800007a4:	8526                	mv	a0,s1
    800007a6:	00000097          	auipc	ra,0x0
    800007aa:	f72080e7          	jalr	-142(ra) # 80000718 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800007ae:	00008917          	auipc	s2,0x8
    800007b2:	85290913          	addi	s2,s2,-1966 # 80008000 <etext>
    800007b6:	4729                	li	a4,10
    800007b8:	80008697          	auipc	a3,0x80008
    800007bc:	84868693          	addi	a3,a3,-1976 # 8000 <_entry-0x7fff8000>
    800007c0:	4605                	li	a2,1
    800007c2:	067e                	slli	a2,a2,0x1f
    800007c4:	85b2                	mv	a1,a2
    800007c6:	8526                	mv	a0,s1
    800007c8:	00000097          	auipc	ra,0x0
    800007cc:	f50080e7          	jalr	-176(ra) # 80000718 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800007d0:	4719                	li	a4,6
    800007d2:	46c5                	li	a3,17
    800007d4:	06ee                	slli	a3,a3,0x1b
    800007d6:	412686b3          	sub	a3,a3,s2
    800007da:	864a                	mv	a2,s2
    800007dc:	85ca                	mv	a1,s2
    800007de:	8526                	mv	a0,s1
    800007e0:	00000097          	auipc	ra,0x0
    800007e4:	f38080e7          	jalr	-200(ra) # 80000718 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800007e8:	4729                	li	a4,10
    800007ea:	6685                	lui	a3,0x1
    800007ec:	00007617          	auipc	a2,0x7
    800007f0:	81460613          	addi	a2,a2,-2028 # 80007000 <_trampoline>
    800007f4:	040005b7          	lui	a1,0x4000
    800007f8:	15fd                	addi	a1,a1,-1
    800007fa:	05b2                	slli	a1,a1,0xc
    800007fc:	8526                	mv	a0,s1
    800007fe:	00000097          	auipc	ra,0x0
    80000802:	f1a080e7          	jalr	-230(ra) # 80000718 <kvmmap>
  proc_mapstacks(kpgtbl);
    80000806:	8526                	mv	a0,s1
    80000808:	00000097          	auipc	ra,0x0
    8000080c:	63a080e7          	jalr	1594(ra) # 80000e42 <proc_mapstacks>
}
    80000810:	8526                	mv	a0,s1
    80000812:	60e2                	ld	ra,24(sp)
    80000814:	6442                	ld	s0,16(sp)
    80000816:	64a2                	ld	s1,8(sp)
    80000818:	6902                	ld	s2,0(sp)
    8000081a:	6105                	addi	sp,sp,32
    8000081c:	8082                	ret

000000008000081e <kvminit>:
{
    8000081e:	1141                	addi	sp,sp,-16
    80000820:	e406                	sd	ra,8(sp)
    80000822:	e022                	sd	s0,0(sp)
    80000824:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000826:	00000097          	auipc	ra,0x0
    8000082a:	f22080e7          	jalr	-222(ra) # 80000748 <kvmmake>
    8000082e:	00008797          	auipc	a5,0x8
    80000832:	16a7bd23          	sd	a0,378(a5) # 800089a8 <kernel_pagetable>
}
    80000836:	60a2                	ld	ra,8(sp)
    80000838:	6402                	ld	s0,0(sp)
    8000083a:	0141                	addi	sp,sp,16
    8000083c:	8082                	ret

000000008000083e <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000083e:	715d                	addi	sp,sp,-80
    80000840:	e486                	sd	ra,72(sp)
    80000842:	e0a2                	sd	s0,64(sp)
    80000844:	fc26                	sd	s1,56(sp)
    80000846:	f84a                	sd	s2,48(sp)
    80000848:	f44e                	sd	s3,40(sp)
    8000084a:	f052                	sd	s4,32(sp)
    8000084c:	ec56                	sd	s5,24(sp)
    8000084e:	e85a                	sd	s6,16(sp)
    80000850:	e45e                	sd	s7,8(sp)
    80000852:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000854:	03459793          	slli	a5,a1,0x34
    80000858:	e795                	bnez	a5,80000884 <uvmunmap+0x46>
    8000085a:	8a2a                	mv	s4,a0
    8000085c:	892e                	mv	s2,a1
    8000085e:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000860:	0632                	slli	a2,a2,0xc
    80000862:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000866:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000868:	6b05                	lui	s6,0x1
    8000086a:	0735e863          	bltu	a1,s3,800008da <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000086e:	60a6                	ld	ra,72(sp)
    80000870:	6406                	ld	s0,64(sp)
    80000872:	74e2                	ld	s1,56(sp)
    80000874:	7942                	ld	s2,48(sp)
    80000876:	79a2                	ld	s3,40(sp)
    80000878:	7a02                	ld	s4,32(sp)
    8000087a:	6ae2                	ld	s5,24(sp)
    8000087c:	6b42                	ld	s6,16(sp)
    8000087e:	6ba2                	ld	s7,8(sp)
    80000880:	6161                	addi	sp,sp,80
    80000882:	8082                	ret
    panic("uvmunmap: not aligned");
    80000884:	00008517          	auipc	a0,0x8
    80000888:	83c50513          	addi	a0,a0,-1988 # 800080c0 <etext+0xc0>
    8000088c:	00006097          	auipc	ra,0x6
    80000890:	94a080e7          	jalr	-1718(ra) # 800061d6 <panic>
      panic("uvmunmap: walk");
    80000894:	00008517          	auipc	a0,0x8
    80000898:	84450513          	addi	a0,a0,-1980 # 800080d8 <etext+0xd8>
    8000089c:	00006097          	auipc	ra,0x6
    800008a0:	93a080e7          	jalr	-1734(ra) # 800061d6 <panic>
      panic("uvmunmap: not mapped");
    800008a4:	00008517          	auipc	a0,0x8
    800008a8:	84450513          	addi	a0,a0,-1980 # 800080e8 <etext+0xe8>
    800008ac:	00006097          	auipc	ra,0x6
    800008b0:	92a080e7          	jalr	-1750(ra) # 800061d6 <panic>
      panic("uvmunmap: not a leaf");
    800008b4:	00008517          	auipc	a0,0x8
    800008b8:	84c50513          	addi	a0,a0,-1972 # 80008100 <etext+0x100>
    800008bc:	00006097          	auipc	ra,0x6
    800008c0:	91a080e7          	jalr	-1766(ra) # 800061d6 <panic>
      uint64 pa = PTE2PA(*pte);
    800008c4:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800008c6:	0532                	slli	a0,a0,0xc
    800008c8:	fffff097          	auipc	ra,0xfffff
    800008cc:	754080e7          	jalr	1876(ra) # 8000001c <kfree>
    *pte = 0;
    800008d0:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800008d4:	995a                	add	s2,s2,s6
    800008d6:	f9397ce3          	bgeu	s2,s3,8000086e <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800008da:	4601                	li	a2,0
    800008dc:	85ca                	mv	a1,s2
    800008de:	8552                	mv	a0,s4
    800008e0:	00000097          	auipc	ra,0x0
    800008e4:	c8c080e7          	jalr	-884(ra) # 8000056c <walk>
    800008e8:	84aa                	mv	s1,a0
    800008ea:	d54d                	beqz	a0,80000894 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800008ec:	6108                	ld	a0,0(a0)
    800008ee:	00157793          	andi	a5,a0,1
    800008f2:	dbcd                	beqz	a5,800008a4 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800008f4:	3ff57793          	andi	a5,a0,1023
    800008f8:	fb778ee3          	beq	a5,s7,800008b4 <uvmunmap+0x76>
    if(do_free){
    800008fc:	fc0a8ae3          	beqz	s5,800008d0 <uvmunmap+0x92>
    80000900:	b7d1                	j	800008c4 <uvmunmap+0x86>

0000000080000902 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000902:	1101                	addi	sp,sp,-32
    80000904:	ec06                	sd	ra,24(sp)
    80000906:	e822                	sd	s0,16(sp)
    80000908:	e426                	sd	s1,8(sp)
    8000090a:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000090c:	00000097          	auipc	ra,0x0
    80000910:	85c080e7          	jalr	-1956(ra) # 80000168 <kalloc>
    80000914:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000916:	c519                	beqz	a0,80000924 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000918:	6605                	lui	a2,0x1
    8000091a:	4581                	li	a1,0
    8000091c:	00000097          	auipc	ra,0x0
    80000920:	954080e7          	jalr	-1708(ra) # 80000270 <memset>
  return pagetable;
}
    80000924:	8526                	mv	a0,s1
    80000926:	60e2                	ld	ra,24(sp)
    80000928:	6442                	ld	s0,16(sp)
    8000092a:	64a2                	ld	s1,8(sp)
    8000092c:	6105                	addi	sp,sp,32
    8000092e:	8082                	ret

0000000080000930 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000930:	7179                	addi	sp,sp,-48
    80000932:	f406                	sd	ra,40(sp)
    80000934:	f022                	sd	s0,32(sp)
    80000936:	ec26                	sd	s1,24(sp)
    80000938:	e84a                	sd	s2,16(sp)
    8000093a:	e44e                	sd	s3,8(sp)
    8000093c:	e052                	sd	s4,0(sp)
    8000093e:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000940:	6785                	lui	a5,0x1
    80000942:	04f67863          	bgeu	a2,a5,80000992 <uvmfirst+0x62>
    80000946:	8a2a                	mv	s4,a0
    80000948:	89ae                	mv	s3,a1
    8000094a:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    8000094c:	00000097          	auipc	ra,0x0
    80000950:	81c080e7          	jalr	-2020(ra) # 80000168 <kalloc>
    80000954:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000956:	6605                	lui	a2,0x1
    80000958:	4581                	li	a1,0
    8000095a:	00000097          	auipc	ra,0x0
    8000095e:	916080e7          	jalr	-1770(ra) # 80000270 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000962:	4779                	li	a4,30
    80000964:	86ca                	mv	a3,s2
    80000966:	6605                	lui	a2,0x1
    80000968:	4581                	li	a1,0
    8000096a:	8552                	mv	a0,s4
    8000096c:	00000097          	auipc	ra,0x0
    80000970:	ce8080e7          	jalr	-792(ra) # 80000654 <mappages>
  memmove(mem, src, sz);
    80000974:	8626                	mv	a2,s1
    80000976:	85ce                	mv	a1,s3
    80000978:	854a                	mv	a0,s2
    8000097a:	00000097          	auipc	ra,0x0
    8000097e:	956080e7          	jalr	-1706(ra) # 800002d0 <memmove>
}
    80000982:	70a2                	ld	ra,40(sp)
    80000984:	7402                	ld	s0,32(sp)
    80000986:	64e2                	ld	s1,24(sp)
    80000988:	6942                	ld	s2,16(sp)
    8000098a:	69a2                	ld	s3,8(sp)
    8000098c:	6a02                	ld	s4,0(sp)
    8000098e:	6145                	addi	sp,sp,48
    80000990:	8082                	ret
    panic("uvmfirst: more than a page");
    80000992:	00007517          	auipc	a0,0x7
    80000996:	78650513          	addi	a0,a0,1926 # 80008118 <etext+0x118>
    8000099a:	00006097          	auipc	ra,0x6
    8000099e:	83c080e7          	jalr	-1988(ra) # 800061d6 <panic>

00000000800009a2 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800009a2:	1101                	addi	sp,sp,-32
    800009a4:	ec06                	sd	ra,24(sp)
    800009a6:	e822                	sd	s0,16(sp)
    800009a8:	e426                	sd	s1,8(sp)
    800009aa:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800009ac:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800009ae:	00b67d63          	bgeu	a2,a1,800009c8 <uvmdealloc+0x26>
    800009b2:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800009b4:	6785                	lui	a5,0x1
    800009b6:	17fd                	addi	a5,a5,-1
    800009b8:	00f60733          	add	a4,a2,a5
    800009bc:	767d                	lui	a2,0xfffff
    800009be:	8f71                	and	a4,a4,a2
    800009c0:	97ae                	add	a5,a5,a1
    800009c2:	8ff1                	and	a5,a5,a2
    800009c4:	00f76863          	bltu	a4,a5,800009d4 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800009c8:	8526                	mv	a0,s1
    800009ca:	60e2                	ld	ra,24(sp)
    800009cc:	6442                	ld	s0,16(sp)
    800009ce:	64a2                	ld	s1,8(sp)
    800009d0:	6105                	addi	sp,sp,32
    800009d2:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800009d4:	8f99                	sub	a5,a5,a4
    800009d6:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800009d8:	4685                	li	a3,1
    800009da:	0007861b          	sext.w	a2,a5
    800009de:	85ba                	mv	a1,a4
    800009e0:	00000097          	auipc	ra,0x0
    800009e4:	e5e080e7          	jalr	-418(ra) # 8000083e <uvmunmap>
    800009e8:	b7c5                	j	800009c8 <uvmdealloc+0x26>

00000000800009ea <uvmalloc>:
  if(newsz < oldsz)
    800009ea:	0ab66563          	bltu	a2,a1,80000a94 <uvmalloc+0xaa>
{
    800009ee:	7139                	addi	sp,sp,-64
    800009f0:	fc06                	sd	ra,56(sp)
    800009f2:	f822                	sd	s0,48(sp)
    800009f4:	f426                	sd	s1,40(sp)
    800009f6:	f04a                	sd	s2,32(sp)
    800009f8:	ec4e                	sd	s3,24(sp)
    800009fa:	e852                	sd	s4,16(sp)
    800009fc:	e456                	sd	s5,8(sp)
    800009fe:	e05a                	sd	s6,0(sp)
    80000a00:	0080                	addi	s0,sp,64
    80000a02:	8aaa                	mv	s5,a0
    80000a04:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80000a06:	6985                	lui	s3,0x1
    80000a08:	19fd                	addi	s3,s3,-1
    80000a0a:	95ce                	add	a1,a1,s3
    80000a0c:	79fd                	lui	s3,0xfffff
    80000a0e:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a12:	08c9f363          	bgeu	s3,a2,80000a98 <uvmalloc+0xae>
    80000a16:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000a18:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000a1c:	fffff097          	auipc	ra,0xfffff
    80000a20:	74c080e7          	jalr	1868(ra) # 80000168 <kalloc>
    80000a24:	84aa                	mv	s1,a0
    if(mem == 0){
    80000a26:	c51d                	beqz	a0,80000a54 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80000a28:	6605                	lui	a2,0x1
    80000a2a:	4581                	li	a1,0
    80000a2c:	00000097          	auipc	ra,0x0
    80000a30:	844080e7          	jalr	-1980(ra) # 80000270 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000a34:	875a                	mv	a4,s6
    80000a36:	86a6                	mv	a3,s1
    80000a38:	6605                	lui	a2,0x1
    80000a3a:	85ca                	mv	a1,s2
    80000a3c:	8556                	mv	a0,s5
    80000a3e:	00000097          	auipc	ra,0x0
    80000a42:	c16080e7          	jalr	-1002(ra) # 80000654 <mappages>
    80000a46:	e90d                	bnez	a0,80000a78 <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a48:	6785                	lui	a5,0x1
    80000a4a:	993e                	add	s2,s2,a5
    80000a4c:	fd4968e3          	bltu	s2,s4,80000a1c <uvmalloc+0x32>
  return newsz;
    80000a50:	8552                	mv	a0,s4
    80000a52:	a809                	j	80000a64 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000a54:	864e                	mv	a2,s3
    80000a56:	85ca                	mv	a1,s2
    80000a58:	8556                	mv	a0,s5
    80000a5a:	00000097          	auipc	ra,0x0
    80000a5e:	f48080e7          	jalr	-184(ra) # 800009a2 <uvmdealloc>
      return 0;
    80000a62:	4501                	li	a0,0
}
    80000a64:	70e2                	ld	ra,56(sp)
    80000a66:	7442                	ld	s0,48(sp)
    80000a68:	74a2                	ld	s1,40(sp)
    80000a6a:	7902                	ld	s2,32(sp)
    80000a6c:	69e2                	ld	s3,24(sp)
    80000a6e:	6a42                	ld	s4,16(sp)
    80000a70:	6aa2                	ld	s5,8(sp)
    80000a72:	6b02                	ld	s6,0(sp)
    80000a74:	6121                	addi	sp,sp,64
    80000a76:	8082                	ret
      kfree(mem);
    80000a78:	8526                	mv	a0,s1
    80000a7a:	fffff097          	auipc	ra,0xfffff
    80000a7e:	5a2080e7          	jalr	1442(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000a82:	864e                	mv	a2,s3
    80000a84:	85ca                	mv	a1,s2
    80000a86:	8556                	mv	a0,s5
    80000a88:	00000097          	auipc	ra,0x0
    80000a8c:	f1a080e7          	jalr	-230(ra) # 800009a2 <uvmdealloc>
      return 0;
    80000a90:	4501                	li	a0,0
    80000a92:	bfc9                	j	80000a64 <uvmalloc+0x7a>
    return oldsz;
    80000a94:	852e                	mv	a0,a1
}
    80000a96:	8082                	ret
  return newsz;
    80000a98:	8532                	mv	a0,a2
    80000a9a:	b7e9                	j	80000a64 <uvmalloc+0x7a>

0000000080000a9c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000a9c:	7179                	addi	sp,sp,-48
    80000a9e:	f406                	sd	ra,40(sp)
    80000aa0:	f022                	sd	s0,32(sp)
    80000aa2:	ec26                	sd	s1,24(sp)
    80000aa4:	e84a                	sd	s2,16(sp)
    80000aa6:	e44e                	sd	s3,8(sp)
    80000aa8:	e052                	sd	s4,0(sp)
    80000aaa:	1800                	addi	s0,sp,48
    80000aac:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000aae:	84aa                	mv	s1,a0
    80000ab0:	6905                	lui	s2,0x1
    80000ab2:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000ab4:	4985                	li	s3,1
    80000ab6:	a821                	j	80000ace <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000ab8:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80000aba:	0532                	slli	a0,a0,0xc
    80000abc:	00000097          	auipc	ra,0x0
    80000ac0:	fe0080e7          	jalr	-32(ra) # 80000a9c <freewalk>
      pagetable[i] = 0;
    80000ac4:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000ac8:	04a1                	addi	s1,s1,8
    80000aca:	03248163          	beq	s1,s2,80000aec <freewalk+0x50>
    pte_t pte = pagetable[i];
    80000ace:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000ad0:	00f57793          	andi	a5,a0,15
    80000ad4:	ff3782e3          	beq	a5,s3,80000ab8 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000ad8:	8905                	andi	a0,a0,1
    80000ada:	d57d                	beqz	a0,80000ac8 <freewalk+0x2c>
      panic("freewalk: leaf");
    80000adc:	00007517          	auipc	a0,0x7
    80000ae0:	65c50513          	addi	a0,a0,1628 # 80008138 <etext+0x138>
    80000ae4:	00005097          	auipc	ra,0x5
    80000ae8:	6f2080e7          	jalr	1778(ra) # 800061d6 <panic>
    }
  }
  kfree((void*)pagetable);
    80000aec:	8552                	mv	a0,s4
    80000aee:	fffff097          	auipc	ra,0xfffff
    80000af2:	52e080e7          	jalr	1326(ra) # 8000001c <kfree>
}
    80000af6:	70a2                	ld	ra,40(sp)
    80000af8:	7402                	ld	s0,32(sp)
    80000afa:	64e2                	ld	s1,24(sp)
    80000afc:	6942                	ld	s2,16(sp)
    80000afe:	69a2                	ld	s3,8(sp)
    80000b00:	6a02                	ld	s4,0(sp)
    80000b02:	6145                	addi	sp,sp,48
    80000b04:	8082                	ret

0000000080000b06 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000b06:	1101                	addi	sp,sp,-32
    80000b08:	ec06                	sd	ra,24(sp)
    80000b0a:	e822                	sd	s0,16(sp)
    80000b0c:	e426                	sd	s1,8(sp)
    80000b0e:	1000                	addi	s0,sp,32
    80000b10:	84aa                	mv	s1,a0
  if(sz > 0)
    80000b12:	e999                	bnez	a1,80000b28 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000b14:	8526                	mv	a0,s1
    80000b16:	00000097          	auipc	ra,0x0
    80000b1a:	f86080e7          	jalr	-122(ra) # 80000a9c <freewalk>
}
    80000b1e:	60e2                	ld	ra,24(sp)
    80000b20:	6442                	ld	s0,16(sp)
    80000b22:	64a2                	ld	s1,8(sp)
    80000b24:	6105                	addi	sp,sp,32
    80000b26:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000b28:	6605                	lui	a2,0x1
    80000b2a:	167d                	addi	a2,a2,-1
    80000b2c:	962e                	add	a2,a2,a1
    80000b2e:	4685                	li	a3,1
    80000b30:	8231                	srli	a2,a2,0xc
    80000b32:	4581                	li	a1,0
    80000b34:	00000097          	auipc	ra,0x0
    80000b38:	d0a080e7          	jalr	-758(ra) # 8000083e <uvmunmap>
    80000b3c:	bfe1                	j	80000b14 <uvmfree+0xe>

0000000080000b3e <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000b3e:	c679                	beqz	a2,80000c0c <uvmcopy+0xce>
{
    80000b40:	715d                	addi	sp,sp,-80
    80000b42:	e486                	sd	ra,72(sp)
    80000b44:	e0a2                	sd	s0,64(sp)
    80000b46:	fc26                	sd	s1,56(sp)
    80000b48:	f84a                	sd	s2,48(sp)
    80000b4a:	f44e                	sd	s3,40(sp)
    80000b4c:	f052                	sd	s4,32(sp)
    80000b4e:	ec56                	sd	s5,24(sp)
    80000b50:	e85a                	sd	s6,16(sp)
    80000b52:	e45e                	sd	s7,8(sp)
    80000b54:	0880                	addi	s0,sp,80
    80000b56:	8b2a                	mv	s6,a0
    80000b58:	8aae                	mv	s5,a1
    80000b5a:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000b5c:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000b5e:	4601                	li	a2,0
    80000b60:	85ce                	mv	a1,s3
    80000b62:	855a                	mv	a0,s6
    80000b64:	00000097          	auipc	ra,0x0
    80000b68:	a08080e7          	jalr	-1528(ra) # 8000056c <walk>
    80000b6c:	c531                	beqz	a0,80000bb8 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000b6e:	6118                	ld	a4,0(a0)
    80000b70:	00177793          	andi	a5,a4,1
    80000b74:	cbb1                	beqz	a5,80000bc8 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000b76:	00a75593          	srli	a1,a4,0xa
    80000b7a:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000b7e:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000b82:	fffff097          	auipc	ra,0xfffff
    80000b86:	5e6080e7          	jalr	1510(ra) # 80000168 <kalloc>
    80000b8a:	892a                	mv	s2,a0
    80000b8c:	c939                	beqz	a0,80000be2 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000b8e:	6605                	lui	a2,0x1
    80000b90:	85de                	mv	a1,s7
    80000b92:	fffff097          	auipc	ra,0xfffff
    80000b96:	73e080e7          	jalr	1854(ra) # 800002d0 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000b9a:	8726                	mv	a4,s1
    80000b9c:	86ca                	mv	a3,s2
    80000b9e:	6605                	lui	a2,0x1
    80000ba0:	85ce                	mv	a1,s3
    80000ba2:	8556                	mv	a0,s5
    80000ba4:	00000097          	auipc	ra,0x0
    80000ba8:	ab0080e7          	jalr	-1360(ra) # 80000654 <mappages>
    80000bac:	e515                	bnez	a0,80000bd8 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000bae:	6785                	lui	a5,0x1
    80000bb0:	99be                	add	s3,s3,a5
    80000bb2:	fb49e6e3          	bltu	s3,s4,80000b5e <uvmcopy+0x20>
    80000bb6:	a081                	j	80000bf6 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000bb8:	00007517          	auipc	a0,0x7
    80000bbc:	59050513          	addi	a0,a0,1424 # 80008148 <etext+0x148>
    80000bc0:	00005097          	auipc	ra,0x5
    80000bc4:	616080e7          	jalr	1558(ra) # 800061d6 <panic>
      panic("uvmcopy: page not present");
    80000bc8:	00007517          	auipc	a0,0x7
    80000bcc:	5a050513          	addi	a0,a0,1440 # 80008168 <etext+0x168>
    80000bd0:	00005097          	auipc	ra,0x5
    80000bd4:	606080e7          	jalr	1542(ra) # 800061d6 <panic>
      kfree(mem);
    80000bd8:	854a                	mv	a0,s2
    80000bda:	fffff097          	auipc	ra,0xfffff
    80000bde:	442080e7          	jalr	1090(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000be2:	4685                	li	a3,1
    80000be4:	00c9d613          	srli	a2,s3,0xc
    80000be8:	4581                	li	a1,0
    80000bea:	8556                	mv	a0,s5
    80000bec:	00000097          	auipc	ra,0x0
    80000bf0:	c52080e7          	jalr	-942(ra) # 8000083e <uvmunmap>
  return -1;
    80000bf4:	557d                	li	a0,-1
}
    80000bf6:	60a6                	ld	ra,72(sp)
    80000bf8:	6406                	ld	s0,64(sp)
    80000bfa:	74e2                	ld	s1,56(sp)
    80000bfc:	7942                	ld	s2,48(sp)
    80000bfe:	79a2                	ld	s3,40(sp)
    80000c00:	7a02                	ld	s4,32(sp)
    80000c02:	6ae2                	ld	s5,24(sp)
    80000c04:	6b42                	ld	s6,16(sp)
    80000c06:	6ba2                	ld	s7,8(sp)
    80000c08:	6161                	addi	sp,sp,80
    80000c0a:	8082                	ret
  return 0;
    80000c0c:	4501                	li	a0,0
}
    80000c0e:	8082                	ret

0000000080000c10 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000c10:	1141                	addi	sp,sp,-16
    80000c12:	e406                	sd	ra,8(sp)
    80000c14:	e022                	sd	s0,0(sp)
    80000c16:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000c18:	4601                	li	a2,0
    80000c1a:	00000097          	auipc	ra,0x0
    80000c1e:	952080e7          	jalr	-1710(ra) # 8000056c <walk>
  if(pte == 0)
    80000c22:	c901                	beqz	a0,80000c32 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000c24:	611c                	ld	a5,0(a0)
    80000c26:	9bbd                	andi	a5,a5,-17
    80000c28:	e11c                	sd	a5,0(a0)
}
    80000c2a:	60a2                	ld	ra,8(sp)
    80000c2c:	6402                	ld	s0,0(sp)
    80000c2e:	0141                	addi	sp,sp,16
    80000c30:	8082                	ret
    panic("uvmclear");
    80000c32:	00007517          	auipc	a0,0x7
    80000c36:	55650513          	addi	a0,a0,1366 # 80008188 <etext+0x188>
    80000c3a:	00005097          	auipc	ra,0x5
    80000c3e:	59c080e7          	jalr	1436(ra) # 800061d6 <panic>

0000000080000c42 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    80000c42:	cac9                	beqz	a3,80000cd4 <copyout+0x92>
{
    80000c44:	711d                	addi	sp,sp,-96
    80000c46:	ec86                	sd	ra,88(sp)
    80000c48:	e8a2                	sd	s0,80(sp)
    80000c4a:	e4a6                	sd	s1,72(sp)
    80000c4c:	e0ca                	sd	s2,64(sp)
    80000c4e:	fc4e                	sd	s3,56(sp)
    80000c50:	f852                	sd	s4,48(sp)
    80000c52:	f456                	sd	s5,40(sp)
    80000c54:	f05a                	sd	s6,32(sp)
    80000c56:	ec5e                	sd	s7,24(sp)
    80000c58:	e862                	sd	s8,16(sp)
    80000c5a:	e466                	sd	s9,8(sp)
    80000c5c:	e06a                	sd	s10,0(sp)
    80000c5e:	1080                	addi	s0,sp,96
    80000c60:	8baa                	mv	s7,a0
    80000c62:	8aae                	mv	s5,a1
    80000c64:	8b32                	mv	s6,a2
    80000c66:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000c68:	74fd                	lui	s1,0xfffff
    80000c6a:	8ced                	and	s1,s1,a1
    if(va0 >= MAXVA)
    80000c6c:	57fd                	li	a5,-1
    80000c6e:	83e9                	srli	a5,a5,0x1a
    80000c70:	0697e463          	bltu	a5,s1,80000cd8 <copyout+0x96>
      return -1;
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000c74:	4cd5                	li	s9,21
    80000c76:	6d05                	lui	s10,0x1
    if(va0 >= MAXVA)
    80000c78:	8c3e                	mv	s8,a5
    80000c7a:	a035                	j	80000ca6 <copyout+0x64>
       (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    80000c7c:	83a9                	srli	a5,a5,0xa
    80000c7e:	07b2                	slli	a5,a5,0xc
    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000c80:	409a8533          	sub	a0,s5,s1
    80000c84:	0009061b          	sext.w	a2,s2
    80000c88:	85da                	mv	a1,s6
    80000c8a:	953e                	add	a0,a0,a5
    80000c8c:	fffff097          	auipc	ra,0xfffff
    80000c90:	644080e7          	jalr	1604(ra) # 800002d0 <memmove>

    len -= n;
    80000c94:	412989b3          	sub	s3,s3,s2
    src += n;
    80000c98:	9b4a                	add	s6,s6,s2
  while(len > 0){
    80000c9a:	02098b63          	beqz	s3,80000cd0 <copyout+0x8e>
    if(va0 >= MAXVA)
    80000c9e:	034c6f63          	bltu	s8,s4,80000cdc <copyout+0x9a>
    va0 = PGROUNDDOWN(dstva);
    80000ca2:	84d2                	mv	s1,s4
    dstva = va0 + PGSIZE;
    80000ca4:	8ad2                	mv	s5,s4
    pte = walk(pagetable, va0, 0);
    80000ca6:	4601                	li	a2,0
    80000ca8:	85a6                	mv	a1,s1
    80000caa:	855e                	mv	a0,s7
    80000cac:	00000097          	auipc	ra,0x0
    80000cb0:	8c0080e7          	jalr	-1856(ra) # 8000056c <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000cb4:	c515                	beqz	a0,80000ce0 <copyout+0x9e>
    80000cb6:	611c                	ld	a5,0(a0)
    80000cb8:	0157f713          	andi	a4,a5,21
    80000cbc:	05971163          	bne	a4,s9,80000cfe <copyout+0xbc>
    n = PGSIZE - (dstva - va0);
    80000cc0:	01a48a33          	add	s4,s1,s10
    80000cc4:	415a0933          	sub	s2,s4,s5
    if(n > len)
    80000cc8:	fb29fae3          	bgeu	s3,s2,80000c7c <copyout+0x3a>
    80000ccc:	894e                	mv	s2,s3
    80000cce:	b77d                	j	80000c7c <copyout+0x3a>
  }
  return 0;
    80000cd0:	4501                	li	a0,0
    80000cd2:	a801                	j	80000ce2 <copyout+0xa0>
    80000cd4:	4501                	li	a0,0
}
    80000cd6:	8082                	ret
      return -1;
    80000cd8:	557d                	li	a0,-1
    80000cda:	a021                	j	80000ce2 <copyout+0xa0>
    80000cdc:	557d                	li	a0,-1
    80000cde:	a011                	j	80000ce2 <copyout+0xa0>
      return -1;
    80000ce0:	557d                	li	a0,-1
}
    80000ce2:	60e6                	ld	ra,88(sp)
    80000ce4:	6446                	ld	s0,80(sp)
    80000ce6:	64a6                	ld	s1,72(sp)
    80000ce8:	6906                	ld	s2,64(sp)
    80000cea:	79e2                	ld	s3,56(sp)
    80000cec:	7a42                	ld	s4,48(sp)
    80000cee:	7aa2                	ld	s5,40(sp)
    80000cf0:	7b02                	ld	s6,32(sp)
    80000cf2:	6be2                	ld	s7,24(sp)
    80000cf4:	6c42                	ld	s8,16(sp)
    80000cf6:	6ca2                	ld	s9,8(sp)
    80000cf8:	6d02                	ld	s10,0(sp)
    80000cfa:	6125                	addi	sp,sp,96
    80000cfc:	8082                	ret
      return -1;
    80000cfe:	557d                	li	a0,-1
    80000d00:	b7cd                	j	80000ce2 <copyout+0xa0>

0000000080000d02 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000d02:	c6bd                	beqz	a3,80000d70 <copyin+0x6e>
{
    80000d04:	715d                	addi	sp,sp,-80
    80000d06:	e486                	sd	ra,72(sp)
    80000d08:	e0a2                	sd	s0,64(sp)
    80000d0a:	fc26                	sd	s1,56(sp)
    80000d0c:	f84a                	sd	s2,48(sp)
    80000d0e:	f44e                	sd	s3,40(sp)
    80000d10:	f052                	sd	s4,32(sp)
    80000d12:	ec56                	sd	s5,24(sp)
    80000d14:	e85a                	sd	s6,16(sp)
    80000d16:	e45e                	sd	s7,8(sp)
    80000d18:	e062                	sd	s8,0(sp)
    80000d1a:	0880                	addi	s0,sp,80
    80000d1c:	8b2a                	mv	s6,a0
    80000d1e:	8a2e                	mv	s4,a1
    80000d20:	8c32                	mv	s8,a2
    80000d22:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000d24:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000d26:	6a85                	lui	s5,0x1
    80000d28:	a015                	j	80000d4c <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000d2a:	9562                	add	a0,a0,s8
    80000d2c:	0004861b          	sext.w	a2,s1
    80000d30:	412505b3          	sub	a1,a0,s2
    80000d34:	8552                	mv	a0,s4
    80000d36:	fffff097          	auipc	ra,0xfffff
    80000d3a:	59a080e7          	jalr	1434(ra) # 800002d0 <memmove>

    len -= n;
    80000d3e:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000d42:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000d44:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000d48:	02098263          	beqz	s3,80000d6c <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000d4c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000d50:	85ca                	mv	a1,s2
    80000d52:	855a                	mv	a0,s6
    80000d54:	00000097          	auipc	ra,0x0
    80000d58:	8be080e7          	jalr	-1858(ra) # 80000612 <walkaddr>
    if(pa0 == 0)
    80000d5c:	cd01                	beqz	a0,80000d74 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000d5e:	418904b3          	sub	s1,s2,s8
    80000d62:	94d6                	add	s1,s1,s5
    if(n > len)
    80000d64:	fc99f3e3          	bgeu	s3,s1,80000d2a <copyin+0x28>
    80000d68:	84ce                	mv	s1,s3
    80000d6a:	b7c1                	j	80000d2a <copyin+0x28>
  }
  return 0;
    80000d6c:	4501                	li	a0,0
    80000d6e:	a021                	j	80000d76 <copyin+0x74>
    80000d70:	4501                	li	a0,0
}
    80000d72:	8082                	ret
      return -1;
    80000d74:	557d                	li	a0,-1
}
    80000d76:	60a6                	ld	ra,72(sp)
    80000d78:	6406                	ld	s0,64(sp)
    80000d7a:	74e2                	ld	s1,56(sp)
    80000d7c:	7942                	ld	s2,48(sp)
    80000d7e:	79a2                	ld	s3,40(sp)
    80000d80:	7a02                	ld	s4,32(sp)
    80000d82:	6ae2                	ld	s5,24(sp)
    80000d84:	6b42                	ld	s6,16(sp)
    80000d86:	6ba2                	ld	s7,8(sp)
    80000d88:	6c02                	ld	s8,0(sp)
    80000d8a:	6161                	addi	sp,sp,80
    80000d8c:	8082                	ret

0000000080000d8e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000d8e:	c6c5                	beqz	a3,80000e36 <copyinstr+0xa8>
{
    80000d90:	715d                	addi	sp,sp,-80
    80000d92:	e486                	sd	ra,72(sp)
    80000d94:	e0a2                	sd	s0,64(sp)
    80000d96:	fc26                	sd	s1,56(sp)
    80000d98:	f84a                	sd	s2,48(sp)
    80000d9a:	f44e                	sd	s3,40(sp)
    80000d9c:	f052                	sd	s4,32(sp)
    80000d9e:	ec56                	sd	s5,24(sp)
    80000da0:	e85a                	sd	s6,16(sp)
    80000da2:	e45e                	sd	s7,8(sp)
    80000da4:	0880                	addi	s0,sp,80
    80000da6:	8a2a                	mv	s4,a0
    80000da8:	8b2e                	mv	s6,a1
    80000daa:	8bb2                	mv	s7,a2
    80000dac:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000dae:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000db0:	6985                	lui	s3,0x1
    80000db2:	a035                	j	80000dde <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000db4:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000db8:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000dba:	0017b793          	seqz	a5,a5
    80000dbe:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000dc2:	60a6                	ld	ra,72(sp)
    80000dc4:	6406                	ld	s0,64(sp)
    80000dc6:	74e2                	ld	s1,56(sp)
    80000dc8:	7942                	ld	s2,48(sp)
    80000dca:	79a2                	ld	s3,40(sp)
    80000dcc:	7a02                	ld	s4,32(sp)
    80000dce:	6ae2                	ld	s5,24(sp)
    80000dd0:	6b42                	ld	s6,16(sp)
    80000dd2:	6ba2                	ld	s7,8(sp)
    80000dd4:	6161                	addi	sp,sp,80
    80000dd6:	8082                	ret
    srcva = va0 + PGSIZE;
    80000dd8:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000ddc:	c8a9                	beqz	s1,80000e2e <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000dde:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000de2:	85ca                	mv	a1,s2
    80000de4:	8552                	mv	a0,s4
    80000de6:	00000097          	auipc	ra,0x0
    80000dea:	82c080e7          	jalr	-2004(ra) # 80000612 <walkaddr>
    if(pa0 == 0)
    80000dee:	c131                	beqz	a0,80000e32 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000df0:	41790833          	sub	a6,s2,s7
    80000df4:	984e                	add	a6,a6,s3
    if(n > max)
    80000df6:	0104f363          	bgeu	s1,a6,80000dfc <copyinstr+0x6e>
    80000dfa:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000dfc:	955e                	add	a0,a0,s7
    80000dfe:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000e02:	fc080be3          	beqz	a6,80000dd8 <copyinstr+0x4a>
    80000e06:	985a                	add	a6,a6,s6
    80000e08:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000e0a:	41650633          	sub	a2,a0,s6
    80000e0e:	14fd                	addi	s1,s1,-1
    80000e10:	9b26                	add	s6,s6,s1
    80000e12:	00f60733          	add	a4,a2,a5
    80000e16:	00074703          	lbu	a4,0(a4)
    80000e1a:	df49                	beqz	a4,80000db4 <copyinstr+0x26>
        *dst = *p;
    80000e1c:	00e78023          	sb	a4,0(a5)
      --max;
    80000e20:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000e24:	0785                	addi	a5,a5,1
    while(n > 0){
    80000e26:	ff0796e3          	bne	a5,a6,80000e12 <copyinstr+0x84>
      dst++;
    80000e2a:	8b42                	mv	s6,a6
    80000e2c:	b775                	j	80000dd8 <copyinstr+0x4a>
    80000e2e:	4781                	li	a5,0
    80000e30:	b769                	j	80000dba <copyinstr+0x2c>
      return -1;
    80000e32:	557d                	li	a0,-1
    80000e34:	b779                	j	80000dc2 <copyinstr+0x34>
  int got_null = 0;
    80000e36:	4781                	li	a5,0
  if(got_null){
    80000e38:	0017b793          	seqz	a5,a5
    80000e3c:	40f00533          	neg	a0,a5
}
    80000e40:	8082                	ret

0000000080000e42 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000e42:	7139                	addi	sp,sp,-64
    80000e44:	fc06                	sd	ra,56(sp)
    80000e46:	f822                	sd	s0,48(sp)
    80000e48:	f426                	sd	s1,40(sp)
    80000e4a:	f04a                	sd	s2,32(sp)
    80000e4c:	ec4e                	sd	s3,24(sp)
    80000e4e:	e852                	sd	s4,16(sp)
    80000e50:	e456                	sd	s5,8(sp)
    80000e52:	e05a                	sd	s6,0(sp)
    80000e54:	0080                	addi	s0,sp,64
    80000e56:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e58:	00008497          	auipc	s1,0x8
    80000e5c:	0f848493          	addi	s1,s1,248 # 80008f50 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000e60:	8b26                	mv	s6,s1
    80000e62:	00007a97          	auipc	s5,0x7
    80000e66:	19ea8a93          	addi	s5,s5,414 # 80008000 <etext>
    80000e6a:	04000937          	lui	s2,0x4000
    80000e6e:	197d                	addi	s2,s2,-1
    80000e70:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e72:	0000ea17          	auipc	s4,0xe
    80000e76:	cdea0a13          	addi	s4,s4,-802 # 8000eb50 <tickslock>
    char *pa = kalloc();
    80000e7a:	fffff097          	auipc	ra,0xfffff
    80000e7e:	2ee080e7          	jalr	750(ra) # 80000168 <kalloc>
    80000e82:	862a                	mv	a2,a0
    if(pa == 0)
    80000e84:	c131                	beqz	a0,80000ec8 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000e86:	416485b3          	sub	a1,s1,s6
    80000e8a:	8591                	srai	a1,a1,0x4
    80000e8c:	000ab783          	ld	a5,0(s5)
    80000e90:	02f585b3          	mul	a1,a1,a5
    80000e94:	2585                	addiw	a1,a1,1
    80000e96:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e9a:	4719                	li	a4,6
    80000e9c:	6685                	lui	a3,0x1
    80000e9e:	40b905b3          	sub	a1,s2,a1
    80000ea2:	854e                	mv	a0,s3
    80000ea4:	00000097          	auipc	ra,0x0
    80000ea8:	874080e7          	jalr	-1932(ra) # 80000718 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000eac:	17048493          	addi	s1,s1,368
    80000eb0:	fd4495e3          	bne	s1,s4,80000e7a <proc_mapstacks+0x38>
  }
}
    80000eb4:	70e2                	ld	ra,56(sp)
    80000eb6:	7442                	ld	s0,48(sp)
    80000eb8:	74a2                	ld	s1,40(sp)
    80000eba:	7902                	ld	s2,32(sp)
    80000ebc:	69e2                	ld	s3,24(sp)
    80000ebe:	6a42                	ld	s4,16(sp)
    80000ec0:	6aa2                	ld	s5,8(sp)
    80000ec2:	6b02                	ld	s6,0(sp)
    80000ec4:	6121                	addi	sp,sp,64
    80000ec6:	8082                	ret
      panic("kalloc");
    80000ec8:	00007517          	auipc	a0,0x7
    80000ecc:	2d050513          	addi	a0,a0,720 # 80008198 <etext+0x198>
    80000ed0:	00005097          	auipc	ra,0x5
    80000ed4:	306080e7          	jalr	774(ra) # 800061d6 <panic>

0000000080000ed8 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000ed8:	7139                	addi	sp,sp,-64
    80000eda:	fc06                	sd	ra,56(sp)
    80000edc:	f822                	sd	s0,48(sp)
    80000ede:	f426                	sd	s1,40(sp)
    80000ee0:	f04a                	sd	s2,32(sp)
    80000ee2:	ec4e                	sd	s3,24(sp)
    80000ee4:	e852                	sd	s4,16(sp)
    80000ee6:	e456                	sd	s5,8(sp)
    80000ee8:	e05a                	sd	s6,0(sp)
    80000eea:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000eec:	00007597          	auipc	a1,0x7
    80000ef0:	2b458593          	addi	a1,a1,692 # 800081a0 <etext+0x1a0>
    80000ef4:	00008517          	auipc	a0,0x8
    80000ef8:	c1c50513          	addi	a0,a0,-996 # 80008b10 <pid_lock>
    80000efc:	00006097          	auipc	ra,0x6
    80000f00:	98a080e7          	jalr	-1654(ra) # 80006886 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000f04:	00007597          	auipc	a1,0x7
    80000f08:	2a458593          	addi	a1,a1,676 # 800081a8 <etext+0x1a8>
    80000f0c:	00008517          	auipc	a0,0x8
    80000f10:	c2450513          	addi	a0,a0,-988 # 80008b30 <wait_lock>
    80000f14:	00006097          	auipc	ra,0x6
    80000f18:	972080e7          	jalr	-1678(ra) # 80006886 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f1c:	00008497          	auipc	s1,0x8
    80000f20:	03448493          	addi	s1,s1,52 # 80008f50 <proc>
      initlock(&p->lock, "proc");
    80000f24:	00007b17          	auipc	s6,0x7
    80000f28:	294b0b13          	addi	s6,s6,660 # 800081b8 <etext+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000f2c:	8aa6                	mv	s5,s1
    80000f2e:	00007a17          	auipc	s4,0x7
    80000f32:	0d2a0a13          	addi	s4,s4,210 # 80008000 <etext>
    80000f36:	04000937          	lui	s2,0x4000
    80000f3a:	197d                	addi	s2,s2,-1
    80000f3c:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f3e:	0000e997          	auipc	s3,0xe
    80000f42:	c1298993          	addi	s3,s3,-1006 # 8000eb50 <tickslock>
      initlock(&p->lock, "proc");
    80000f46:	85da                	mv	a1,s6
    80000f48:	8526                	mv	a0,s1
    80000f4a:	00006097          	auipc	ra,0x6
    80000f4e:	93c080e7          	jalr	-1732(ra) # 80006886 <initlock>
      p->state = UNUSED;
    80000f52:	0204a023          	sw	zero,32(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000f56:	415487b3          	sub	a5,s1,s5
    80000f5a:	8791                	srai	a5,a5,0x4
    80000f5c:	000a3703          	ld	a4,0(s4)
    80000f60:	02e787b3          	mul	a5,a5,a4
    80000f64:	2785                	addiw	a5,a5,1
    80000f66:	00d7979b          	slliw	a5,a5,0xd
    80000f6a:	40f907b3          	sub	a5,s2,a5
    80000f6e:	e4bc                	sd	a5,72(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f70:	17048493          	addi	s1,s1,368
    80000f74:	fd3499e3          	bne	s1,s3,80000f46 <procinit+0x6e>
  }
}
    80000f78:	70e2                	ld	ra,56(sp)
    80000f7a:	7442                	ld	s0,48(sp)
    80000f7c:	74a2                	ld	s1,40(sp)
    80000f7e:	7902                	ld	s2,32(sp)
    80000f80:	69e2                	ld	s3,24(sp)
    80000f82:	6a42                	ld	s4,16(sp)
    80000f84:	6aa2                	ld	s5,8(sp)
    80000f86:	6b02                	ld	s6,0(sp)
    80000f88:	6121                	addi	sp,sp,64
    80000f8a:	8082                	ret

0000000080000f8c <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000f8c:	1141                	addi	sp,sp,-16
    80000f8e:	e422                	sd	s0,8(sp)
    80000f90:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000f92:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000f94:	2501                	sext.w	a0,a0
    80000f96:	6422                	ld	s0,8(sp)
    80000f98:	0141                	addi	sp,sp,16
    80000f9a:	8082                	ret

0000000080000f9c <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000f9c:	1141                	addi	sp,sp,-16
    80000f9e:	e422                	sd	s0,8(sp)
    80000fa0:	0800                	addi	s0,sp,16
    80000fa2:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000fa4:	2781                	sext.w	a5,a5
    80000fa6:	079e                	slli	a5,a5,0x7
  return c;
}
    80000fa8:	00008517          	auipc	a0,0x8
    80000fac:	ba850513          	addi	a0,a0,-1112 # 80008b50 <cpus>
    80000fb0:	953e                	add	a0,a0,a5
    80000fb2:	6422                	ld	s0,8(sp)
    80000fb4:	0141                	addi	sp,sp,16
    80000fb6:	8082                	ret

0000000080000fb8 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000fb8:	1101                	addi	sp,sp,-32
    80000fba:	ec06                	sd	ra,24(sp)
    80000fbc:	e822                	sd	s0,16(sp)
    80000fbe:	e426                	sd	s1,8(sp)
    80000fc0:	1000                	addi	s0,sp,32
  push_off();
    80000fc2:	00005097          	auipc	ra,0x5
    80000fc6:	6fc080e7          	jalr	1788(ra) # 800066be <push_off>
    80000fca:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000fcc:	2781                	sext.w	a5,a5
    80000fce:	079e                	slli	a5,a5,0x7
    80000fd0:	00008717          	auipc	a4,0x8
    80000fd4:	b4070713          	addi	a4,a4,-1216 # 80008b10 <pid_lock>
    80000fd8:	97ba                	add	a5,a5,a4
    80000fda:	63a4                	ld	s1,64(a5)
  pop_off();
    80000fdc:	00005097          	auipc	ra,0x5
    80000fe0:	79e080e7          	jalr	1950(ra) # 8000677a <pop_off>
  return p;
}
    80000fe4:	8526                	mv	a0,s1
    80000fe6:	60e2                	ld	ra,24(sp)
    80000fe8:	6442                	ld	s0,16(sp)
    80000fea:	64a2                	ld	s1,8(sp)
    80000fec:	6105                	addi	sp,sp,32
    80000fee:	8082                	ret

0000000080000ff0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000ff0:	1141                	addi	sp,sp,-16
    80000ff2:	e406                	sd	ra,8(sp)
    80000ff4:	e022                	sd	s0,0(sp)
    80000ff6:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000ff8:	00000097          	auipc	ra,0x0
    80000ffc:	fc0080e7          	jalr	-64(ra) # 80000fb8 <myproc>
    80001000:	00005097          	auipc	ra,0x5
    80001004:	7da080e7          	jalr	2010(ra) # 800067da <release>

  if (first) {
    80001008:	00008797          	auipc	a5,0x8
    8000100c:	9287a783          	lw	a5,-1752(a5) # 80008930 <first.1695>
    80001010:	eb89                	bnez	a5,80001022 <forkret+0x32>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    80001012:	00001097          	auipc	ra,0x1
    80001016:	c5a080e7          	jalr	-934(ra) # 80001c6c <usertrapret>
}
    8000101a:	60a2                	ld	ra,8(sp)
    8000101c:	6402                	ld	s0,0(sp)
    8000101e:	0141                	addi	sp,sp,16
    80001020:	8082                	ret
    fsinit(ROOTDEV);
    80001022:	4505                	li	a0,1
    80001024:	00002097          	auipc	ra,0x2
    80001028:	ae6080e7          	jalr	-1306(ra) # 80002b0a <fsinit>
    first = 0;
    8000102c:	00008797          	auipc	a5,0x8
    80001030:	9007a223          	sw	zero,-1788(a5) # 80008930 <first.1695>
    __sync_synchronize();
    80001034:	0ff0000f          	fence
    80001038:	bfe9                	j	80001012 <forkret+0x22>

000000008000103a <allocpid>:
{
    8000103a:	1101                	addi	sp,sp,-32
    8000103c:	ec06                	sd	ra,24(sp)
    8000103e:	e822                	sd	s0,16(sp)
    80001040:	e426                	sd	s1,8(sp)
    80001042:	e04a                	sd	s2,0(sp)
    80001044:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001046:	00008917          	auipc	s2,0x8
    8000104a:	aca90913          	addi	s2,s2,-1334 # 80008b10 <pid_lock>
    8000104e:	854a                	mv	a0,s2
    80001050:	00005097          	auipc	ra,0x5
    80001054:	6ba080e7          	jalr	1722(ra) # 8000670a <acquire>
  pid = nextpid;
    80001058:	00008797          	auipc	a5,0x8
    8000105c:	8dc78793          	addi	a5,a5,-1828 # 80008934 <nextpid>
    80001060:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001062:	0014871b          	addiw	a4,s1,1
    80001066:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001068:	854a                	mv	a0,s2
    8000106a:	00005097          	auipc	ra,0x5
    8000106e:	770080e7          	jalr	1904(ra) # 800067da <release>
}
    80001072:	8526                	mv	a0,s1
    80001074:	60e2                	ld	ra,24(sp)
    80001076:	6442                	ld	s0,16(sp)
    80001078:	64a2                	ld	s1,8(sp)
    8000107a:	6902                	ld	s2,0(sp)
    8000107c:	6105                	addi	sp,sp,32
    8000107e:	8082                	ret

0000000080001080 <proc_pagetable>:
{
    80001080:	1101                	addi	sp,sp,-32
    80001082:	ec06                	sd	ra,24(sp)
    80001084:	e822                	sd	s0,16(sp)
    80001086:	e426                	sd	s1,8(sp)
    80001088:	e04a                	sd	s2,0(sp)
    8000108a:	1000                	addi	s0,sp,32
    8000108c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    8000108e:	00000097          	auipc	ra,0x0
    80001092:	874080e7          	jalr	-1932(ra) # 80000902 <uvmcreate>
    80001096:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001098:	c121                	beqz	a0,800010d8 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000109a:	4729                	li	a4,10
    8000109c:	00006697          	auipc	a3,0x6
    800010a0:	f6468693          	addi	a3,a3,-156 # 80007000 <_trampoline>
    800010a4:	6605                	lui	a2,0x1
    800010a6:	040005b7          	lui	a1,0x4000
    800010aa:	15fd                	addi	a1,a1,-1
    800010ac:	05b2                	slli	a1,a1,0xc
    800010ae:	fffff097          	auipc	ra,0xfffff
    800010b2:	5a6080e7          	jalr	1446(ra) # 80000654 <mappages>
    800010b6:	02054863          	bltz	a0,800010e6 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800010ba:	4719                	li	a4,6
    800010bc:	06093683          	ld	a3,96(s2)
    800010c0:	6605                	lui	a2,0x1
    800010c2:	020005b7          	lui	a1,0x2000
    800010c6:	15fd                	addi	a1,a1,-1
    800010c8:	05b6                	slli	a1,a1,0xd
    800010ca:	8526                	mv	a0,s1
    800010cc:	fffff097          	auipc	ra,0xfffff
    800010d0:	588080e7          	jalr	1416(ra) # 80000654 <mappages>
    800010d4:	02054163          	bltz	a0,800010f6 <proc_pagetable+0x76>
}
    800010d8:	8526                	mv	a0,s1
    800010da:	60e2                	ld	ra,24(sp)
    800010dc:	6442                	ld	s0,16(sp)
    800010de:	64a2                	ld	s1,8(sp)
    800010e0:	6902                	ld	s2,0(sp)
    800010e2:	6105                	addi	sp,sp,32
    800010e4:	8082                	ret
    uvmfree(pagetable, 0);
    800010e6:	4581                	li	a1,0
    800010e8:	8526                	mv	a0,s1
    800010ea:	00000097          	auipc	ra,0x0
    800010ee:	a1c080e7          	jalr	-1508(ra) # 80000b06 <uvmfree>
    return 0;
    800010f2:	4481                	li	s1,0
    800010f4:	b7d5                	j	800010d8 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800010f6:	4681                	li	a3,0
    800010f8:	4605                	li	a2,1
    800010fa:	040005b7          	lui	a1,0x4000
    800010fe:	15fd                	addi	a1,a1,-1
    80001100:	05b2                	slli	a1,a1,0xc
    80001102:	8526                	mv	a0,s1
    80001104:	fffff097          	auipc	ra,0xfffff
    80001108:	73a080e7          	jalr	1850(ra) # 8000083e <uvmunmap>
    uvmfree(pagetable, 0);
    8000110c:	4581                	li	a1,0
    8000110e:	8526                	mv	a0,s1
    80001110:	00000097          	auipc	ra,0x0
    80001114:	9f6080e7          	jalr	-1546(ra) # 80000b06 <uvmfree>
    return 0;
    80001118:	4481                	li	s1,0
    8000111a:	bf7d                	j	800010d8 <proc_pagetable+0x58>

000000008000111c <proc_freepagetable>:
{
    8000111c:	1101                	addi	sp,sp,-32
    8000111e:	ec06                	sd	ra,24(sp)
    80001120:	e822                	sd	s0,16(sp)
    80001122:	e426                	sd	s1,8(sp)
    80001124:	e04a                	sd	s2,0(sp)
    80001126:	1000                	addi	s0,sp,32
    80001128:	84aa                	mv	s1,a0
    8000112a:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    8000112c:	4681                	li	a3,0
    8000112e:	4605                	li	a2,1
    80001130:	040005b7          	lui	a1,0x4000
    80001134:	15fd                	addi	a1,a1,-1
    80001136:	05b2                	slli	a1,a1,0xc
    80001138:	fffff097          	auipc	ra,0xfffff
    8000113c:	706080e7          	jalr	1798(ra) # 8000083e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001140:	4681                	li	a3,0
    80001142:	4605                	li	a2,1
    80001144:	020005b7          	lui	a1,0x2000
    80001148:	15fd                	addi	a1,a1,-1
    8000114a:	05b6                	slli	a1,a1,0xd
    8000114c:	8526                	mv	a0,s1
    8000114e:	fffff097          	auipc	ra,0xfffff
    80001152:	6f0080e7          	jalr	1776(ra) # 8000083e <uvmunmap>
  uvmfree(pagetable, sz);
    80001156:	85ca                	mv	a1,s2
    80001158:	8526                	mv	a0,s1
    8000115a:	00000097          	auipc	ra,0x0
    8000115e:	9ac080e7          	jalr	-1620(ra) # 80000b06 <uvmfree>
}
    80001162:	60e2                	ld	ra,24(sp)
    80001164:	6442                	ld	s0,16(sp)
    80001166:	64a2                	ld	s1,8(sp)
    80001168:	6902                	ld	s2,0(sp)
    8000116a:	6105                	addi	sp,sp,32
    8000116c:	8082                	ret

000000008000116e <freeproc>:
{
    8000116e:	1101                	addi	sp,sp,-32
    80001170:	ec06                	sd	ra,24(sp)
    80001172:	e822                	sd	s0,16(sp)
    80001174:	e426                	sd	s1,8(sp)
    80001176:	1000                	addi	s0,sp,32
    80001178:	84aa                	mv	s1,a0
  if(p->trapframe)
    8000117a:	7128                	ld	a0,96(a0)
    8000117c:	c509                	beqz	a0,80001186 <freeproc+0x18>
    kfree((void*)p->trapframe);
    8000117e:	fffff097          	auipc	ra,0xfffff
    80001182:	e9e080e7          	jalr	-354(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001186:	0604b023          	sd	zero,96(s1)
  if(p->pagetable)
    8000118a:	6ca8                	ld	a0,88(s1)
    8000118c:	c511                	beqz	a0,80001198 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    8000118e:	68ac                	ld	a1,80(s1)
    80001190:	00000097          	auipc	ra,0x0
    80001194:	f8c080e7          	jalr	-116(ra) # 8000111c <proc_freepagetable>
  p->pagetable = 0;
    80001198:	0404bc23          	sd	zero,88(s1)
  p->sz = 0;
    8000119c:	0404b823          	sd	zero,80(s1)
  p->pid = 0;
    800011a0:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    800011a4:	0404b023          	sd	zero,64(s1)
  p->name[0] = 0;
    800011a8:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    800011ac:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    800011b0:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    800011b4:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    800011b8:	0204a023          	sw	zero,32(s1)
}
    800011bc:	60e2                	ld	ra,24(sp)
    800011be:	6442                	ld	s0,16(sp)
    800011c0:	64a2                	ld	s1,8(sp)
    800011c2:	6105                	addi	sp,sp,32
    800011c4:	8082                	ret

00000000800011c6 <allocproc>:
{
    800011c6:	1101                	addi	sp,sp,-32
    800011c8:	ec06                	sd	ra,24(sp)
    800011ca:	e822                	sd	s0,16(sp)
    800011cc:	e426                	sd	s1,8(sp)
    800011ce:	e04a                	sd	s2,0(sp)
    800011d0:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800011d2:	00008497          	auipc	s1,0x8
    800011d6:	d7e48493          	addi	s1,s1,-642 # 80008f50 <proc>
    800011da:	0000e917          	auipc	s2,0xe
    800011de:	97690913          	addi	s2,s2,-1674 # 8000eb50 <tickslock>
    acquire(&p->lock);
    800011e2:	8526                	mv	a0,s1
    800011e4:	00005097          	auipc	ra,0x5
    800011e8:	526080e7          	jalr	1318(ra) # 8000670a <acquire>
    if(p->state == UNUSED) {
    800011ec:	509c                	lw	a5,32(s1)
    800011ee:	cf81                	beqz	a5,80001206 <allocproc+0x40>
      release(&p->lock);
    800011f0:	8526                	mv	a0,s1
    800011f2:	00005097          	auipc	ra,0x5
    800011f6:	5e8080e7          	jalr	1512(ra) # 800067da <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800011fa:	17048493          	addi	s1,s1,368
    800011fe:	ff2492e3          	bne	s1,s2,800011e2 <allocproc+0x1c>
  return 0;
    80001202:	4481                	li	s1,0
    80001204:	a889                	j	80001256 <allocproc+0x90>
  p->pid = allocpid();
    80001206:	00000097          	auipc	ra,0x0
    8000120a:	e34080e7          	jalr	-460(ra) # 8000103a <allocpid>
    8000120e:	dc88                	sw	a0,56(s1)
  p->state = USED;
    80001210:	4785                	li	a5,1
    80001212:	d09c                	sw	a5,32(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001214:	fffff097          	auipc	ra,0xfffff
    80001218:	f54080e7          	jalr	-172(ra) # 80000168 <kalloc>
    8000121c:	892a                	mv	s2,a0
    8000121e:	f0a8                	sd	a0,96(s1)
    80001220:	c131                	beqz	a0,80001264 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001222:	8526                	mv	a0,s1
    80001224:	00000097          	auipc	ra,0x0
    80001228:	e5c080e7          	jalr	-420(ra) # 80001080 <proc_pagetable>
    8000122c:	892a                	mv	s2,a0
    8000122e:	eca8                	sd	a0,88(s1)
  if(p->pagetable == 0){
    80001230:	c531                	beqz	a0,8000127c <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001232:	07000613          	li	a2,112
    80001236:	4581                	li	a1,0
    80001238:	06848513          	addi	a0,s1,104
    8000123c:	fffff097          	auipc	ra,0xfffff
    80001240:	034080e7          	jalr	52(ra) # 80000270 <memset>
  p->context.ra = (uint64)forkret;
    80001244:	00000797          	auipc	a5,0x0
    80001248:	dac78793          	addi	a5,a5,-596 # 80000ff0 <forkret>
    8000124c:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    8000124e:	64bc                	ld	a5,72(s1)
    80001250:	6705                	lui	a4,0x1
    80001252:	97ba                	add	a5,a5,a4
    80001254:	f8bc                	sd	a5,112(s1)
}
    80001256:	8526                	mv	a0,s1
    80001258:	60e2                	ld	ra,24(sp)
    8000125a:	6442                	ld	s0,16(sp)
    8000125c:	64a2                	ld	s1,8(sp)
    8000125e:	6902                	ld	s2,0(sp)
    80001260:	6105                	addi	sp,sp,32
    80001262:	8082                	ret
    freeproc(p);
    80001264:	8526                	mv	a0,s1
    80001266:	00000097          	auipc	ra,0x0
    8000126a:	f08080e7          	jalr	-248(ra) # 8000116e <freeproc>
    release(&p->lock);
    8000126e:	8526                	mv	a0,s1
    80001270:	00005097          	auipc	ra,0x5
    80001274:	56a080e7          	jalr	1386(ra) # 800067da <release>
    return 0;
    80001278:	84ca                	mv	s1,s2
    8000127a:	bff1                	j	80001256 <allocproc+0x90>
    freeproc(p);
    8000127c:	8526                	mv	a0,s1
    8000127e:	00000097          	auipc	ra,0x0
    80001282:	ef0080e7          	jalr	-272(ra) # 8000116e <freeproc>
    release(&p->lock);
    80001286:	8526                	mv	a0,s1
    80001288:	00005097          	auipc	ra,0x5
    8000128c:	552080e7          	jalr	1362(ra) # 800067da <release>
    return 0;
    80001290:	84ca                	mv	s1,s2
    80001292:	b7d1                	j	80001256 <allocproc+0x90>

0000000080001294 <userinit>:
{
    80001294:	1101                	addi	sp,sp,-32
    80001296:	ec06                	sd	ra,24(sp)
    80001298:	e822                	sd	s0,16(sp)
    8000129a:	e426                	sd	s1,8(sp)
    8000129c:	1000                	addi	s0,sp,32
  p = allocproc();
    8000129e:	00000097          	auipc	ra,0x0
    800012a2:	f28080e7          	jalr	-216(ra) # 800011c6 <allocproc>
    800012a6:	84aa                	mv	s1,a0
  initproc = p;
    800012a8:	00007797          	auipc	a5,0x7
    800012ac:	70a7b423          	sd	a0,1800(a5) # 800089b0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800012b0:	03400613          	li	a2,52
    800012b4:	00007597          	auipc	a1,0x7
    800012b8:	68c58593          	addi	a1,a1,1676 # 80008940 <initcode>
    800012bc:	6d28                	ld	a0,88(a0)
    800012be:	fffff097          	auipc	ra,0xfffff
    800012c2:	672080e7          	jalr	1650(ra) # 80000930 <uvmfirst>
  p->sz = PGSIZE;
    800012c6:	6785                	lui	a5,0x1
    800012c8:	e8bc                	sd	a5,80(s1)
  p->trapframe->epc = 0;      // user program counter
    800012ca:	70b8                	ld	a4,96(s1)
    800012cc:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800012d0:	70b8                	ld	a4,96(s1)
    800012d2:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800012d4:	4641                	li	a2,16
    800012d6:	00007597          	auipc	a1,0x7
    800012da:	eea58593          	addi	a1,a1,-278 # 800081c0 <etext+0x1c0>
    800012de:	16048513          	addi	a0,s1,352
    800012e2:	fffff097          	auipc	ra,0xfffff
    800012e6:	0e0080e7          	jalr	224(ra) # 800003c2 <safestrcpy>
  p->cwd = namei("/");
    800012ea:	00007517          	auipc	a0,0x7
    800012ee:	ee650513          	addi	a0,a0,-282 # 800081d0 <etext+0x1d0>
    800012f2:	00002097          	auipc	ra,0x2
    800012f6:	24e080e7          	jalr	590(ra) # 80003540 <namei>
    800012fa:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    800012fe:	478d                	li	a5,3
    80001300:	d09c                	sw	a5,32(s1)
  release(&p->lock);
    80001302:	8526                	mv	a0,s1
    80001304:	00005097          	auipc	ra,0x5
    80001308:	4d6080e7          	jalr	1238(ra) # 800067da <release>
}
    8000130c:	60e2                	ld	ra,24(sp)
    8000130e:	6442                	ld	s0,16(sp)
    80001310:	64a2                	ld	s1,8(sp)
    80001312:	6105                	addi	sp,sp,32
    80001314:	8082                	ret

0000000080001316 <growproc>:
{
    80001316:	1101                	addi	sp,sp,-32
    80001318:	ec06                	sd	ra,24(sp)
    8000131a:	e822                	sd	s0,16(sp)
    8000131c:	e426                	sd	s1,8(sp)
    8000131e:	e04a                	sd	s2,0(sp)
    80001320:	1000                	addi	s0,sp,32
    80001322:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001324:	00000097          	auipc	ra,0x0
    80001328:	c94080e7          	jalr	-876(ra) # 80000fb8 <myproc>
    8000132c:	84aa                	mv	s1,a0
  sz = p->sz;
    8000132e:	692c                	ld	a1,80(a0)
  if(n > 0){
    80001330:	01204c63          	bgtz	s2,80001348 <growproc+0x32>
  } else if(n < 0){
    80001334:	02094663          	bltz	s2,80001360 <growproc+0x4a>
  p->sz = sz;
    80001338:	e8ac                	sd	a1,80(s1)
  return 0;
    8000133a:	4501                	li	a0,0
}
    8000133c:	60e2                	ld	ra,24(sp)
    8000133e:	6442                	ld	s0,16(sp)
    80001340:	64a2                	ld	s1,8(sp)
    80001342:	6902                	ld	s2,0(sp)
    80001344:	6105                	addi	sp,sp,32
    80001346:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001348:	4691                	li	a3,4
    8000134a:	00b90633          	add	a2,s2,a1
    8000134e:	6d28                	ld	a0,88(a0)
    80001350:	fffff097          	auipc	ra,0xfffff
    80001354:	69a080e7          	jalr	1690(ra) # 800009ea <uvmalloc>
    80001358:	85aa                	mv	a1,a0
    8000135a:	fd79                	bnez	a0,80001338 <growproc+0x22>
      return -1;
    8000135c:	557d                	li	a0,-1
    8000135e:	bff9                	j	8000133c <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001360:	00b90633          	add	a2,s2,a1
    80001364:	6d28                	ld	a0,88(a0)
    80001366:	fffff097          	auipc	ra,0xfffff
    8000136a:	63c080e7          	jalr	1596(ra) # 800009a2 <uvmdealloc>
    8000136e:	85aa                	mv	a1,a0
    80001370:	b7e1                	j	80001338 <growproc+0x22>

0000000080001372 <fork>:
{
    80001372:	7179                	addi	sp,sp,-48
    80001374:	f406                	sd	ra,40(sp)
    80001376:	f022                	sd	s0,32(sp)
    80001378:	ec26                	sd	s1,24(sp)
    8000137a:	e84a                	sd	s2,16(sp)
    8000137c:	e44e                	sd	s3,8(sp)
    8000137e:	e052                	sd	s4,0(sp)
    80001380:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001382:	00000097          	auipc	ra,0x0
    80001386:	c36080e7          	jalr	-970(ra) # 80000fb8 <myproc>
    8000138a:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    8000138c:	00000097          	auipc	ra,0x0
    80001390:	e3a080e7          	jalr	-454(ra) # 800011c6 <allocproc>
    80001394:	10050b63          	beqz	a0,800014aa <fork+0x138>
    80001398:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000139a:	05093603          	ld	a2,80(s2)
    8000139e:	6d2c                	ld	a1,88(a0)
    800013a0:	05893503          	ld	a0,88(s2)
    800013a4:	fffff097          	auipc	ra,0xfffff
    800013a8:	79a080e7          	jalr	1946(ra) # 80000b3e <uvmcopy>
    800013ac:	04054663          	bltz	a0,800013f8 <fork+0x86>
  np->sz = p->sz;
    800013b0:	05093783          	ld	a5,80(s2)
    800013b4:	04f9b823          	sd	a5,80(s3)
  *(np->trapframe) = *(p->trapframe);
    800013b8:	06093683          	ld	a3,96(s2)
    800013bc:	87b6                	mv	a5,a3
    800013be:	0609b703          	ld	a4,96(s3)
    800013c2:	12068693          	addi	a3,a3,288
    800013c6:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800013ca:	6788                	ld	a0,8(a5)
    800013cc:	6b8c                	ld	a1,16(a5)
    800013ce:	6f90                	ld	a2,24(a5)
    800013d0:	01073023          	sd	a6,0(a4)
    800013d4:	e708                	sd	a0,8(a4)
    800013d6:	eb0c                	sd	a1,16(a4)
    800013d8:	ef10                	sd	a2,24(a4)
    800013da:	02078793          	addi	a5,a5,32
    800013de:	02070713          	addi	a4,a4,32
    800013e2:	fed792e3          	bne	a5,a3,800013c6 <fork+0x54>
  np->trapframe->a0 = 0;
    800013e6:	0609b783          	ld	a5,96(s3)
    800013ea:	0607b823          	sd	zero,112(a5)
    800013ee:	0d800493          	li	s1,216
  for(i = 0; i < NOFILE; i++)
    800013f2:	15800a13          	li	s4,344
    800013f6:	a03d                	j	80001424 <fork+0xb2>
    freeproc(np);
    800013f8:	854e                	mv	a0,s3
    800013fa:	00000097          	auipc	ra,0x0
    800013fe:	d74080e7          	jalr	-652(ra) # 8000116e <freeproc>
    release(&np->lock);
    80001402:	854e                	mv	a0,s3
    80001404:	00005097          	auipc	ra,0x5
    80001408:	3d6080e7          	jalr	982(ra) # 800067da <release>
    return -1;
    8000140c:	5a7d                	li	s4,-1
    8000140e:	a069                	j	80001498 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    80001410:	00002097          	auipc	ra,0x2
    80001414:	7c6080e7          	jalr	1990(ra) # 80003bd6 <filedup>
    80001418:	009987b3          	add	a5,s3,s1
    8000141c:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    8000141e:	04a1                	addi	s1,s1,8
    80001420:	01448763          	beq	s1,s4,8000142e <fork+0xbc>
    if(p->ofile[i])
    80001424:	009907b3          	add	a5,s2,s1
    80001428:	6388                	ld	a0,0(a5)
    8000142a:	f17d                	bnez	a0,80001410 <fork+0x9e>
    8000142c:	bfcd                	j	8000141e <fork+0xac>
  np->cwd = idup(p->cwd);
    8000142e:	15893503          	ld	a0,344(s2)
    80001432:	00002097          	auipc	ra,0x2
    80001436:	916080e7          	jalr	-1770(ra) # 80002d48 <idup>
    8000143a:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    8000143e:	4641                	li	a2,16
    80001440:	16090593          	addi	a1,s2,352
    80001444:	16098513          	addi	a0,s3,352
    80001448:	fffff097          	auipc	ra,0xfffff
    8000144c:	f7a080e7          	jalr	-134(ra) # 800003c2 <safestrcpy>
  pid = np->pid;
    80001450:	0389aa03          	lw	s4,56(s3)
  release(&np->lock);
    80001454:	854e                	mv	a0,s3
    80001456:	00005097          	auipc	ra,0x5
    8000145a:	384080e7          	jalr	900(ra) # 800067da <release>
  acquire(&wait_lock);
    8000145e:	00007497          	auipc	s1,0x7
    80001462:	6d248493          	addi	s1,s1,1746 # 80008b30 <wait_lock>
    80001466:	8526                	mv	a0,s1
    80001468:	00005097          	auipc	ra,0x5
    8000146c:	2a2080e7          	jalr	674(ra) # 8000670a <acquire>
  np->parent = p;
    80001470:	0529b023          	sd	s2,64(s3)
  release(&wait_lock);
    80001474:	8526                	mv	a0,s1
    80001476:	00005097          	auipc	ra,0x5
    8000147a:	364080e7          	jalr	868(ra) # 800067da <release>
  acquire(&np->lock);
    8000147e:	854e                	mv	a0,s3
    80001480:	00005097          	auipc	ra,0x5
    80001484:	28a080e7          	jalr	650(ra) # 8000670a <acquire>
  np->state = RUNNABLE;
    80001488:	478d                	li	a5,3
    8000148a:	02f9a023          	sw	a5,32(s3)
  release(&np->lock);
    8000148e:	854e                	mv	a0,s3
    80001490:	00005097          	auipc	ra,0x5
    80001494:	34a080e7          	jalr	842(ra) # 800067da <release>
}
    80001498:	8552                	mv	a0,s4
    8000149a:	70a2                	ld	ra,40(sp)
    8000149c:	7402                	ld	s0,32(sp)
    8000149e:	64e2                	ld	s1,24(sp)
    800014a0:	6942                	ld	s2,16(sp)
    800014a2:	69a2                	ld	s3,8(sp)
    800014a4:	6a02                	ld	s4,0(sp)
    800014a6:	6145                	addi	sp,sp,48
    800014a8:	8082                	ret
    return -1;
    800014aa:	5a7d                	li	s4,-1
    800014ac:	b7f5                	j	80001498 <fork+0x126>

00000000800014ae <scheduler>:
{
    800014ae:	7139                	addi	sp,sp,-64
    800014b0:	fc06                	sd	ra,56(sp)
    800014b2:	f822                	sd	s0,48(sp)
    800014b4:	f426                	sd	s1,40(sp)
    800014b6:	f04a                	sd	s2,32(sp)
    800014b8:	ec4e                	sd	s3,24(sp)
    800014ba:	e852                	sd	s4,16(sp)
    800014bc:	e456                	sd	s5,8(sp)
    800014be:	e05a                	sd	s6,0(sp)
    800014c0:	0080                	addi	s0,sp,64
    800014c2:	8792                	mv	a5,tp
  int id = r_tp();
    800014c4:	2781                	sext.w	a5,a5
  c->proc = 0;
    800014c6:	00779a93          	slli	s5,a5,0x7
    800014ca:	00007717          	auipc	a4,0x7
    800014ce:	64670713          	addi	a4,a4,1606 # 80008b10 <pid_lock>
    800014d2:	9756                	add	a4,a4,s5
    800014d4:	04073023          	sd	zero,64(a4)
        swtch(&c->context, &p->context);
    800014d8:	00007717          	auipc	a4,0x7
    800014dc:	68070713          	addi	a4,a4,1664 # 80008b58 <cpus+0x8>
    800014e0:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    800014e2:	498d                	li	s3,3
        p->state = RUNNING;
    800014e4:	4b11                	li	s6,4
        c->proc = p;
    800014e6:	079e                	slli	a5,a5,0x7
    800014e8:	00007a17          	auipc	s4,0x7
    800014ec:	628a0a13          	addi	s4,s4,1576 # 80008b10 <pid_lock>
    800014f0:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800014f2:	0000d917          	auipc	s2,0xd
    800014f6:	65e90913          	addi	s2,s2,1630 # 8000eb50 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800014fa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800014fe:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001502:	10079073          	csrw	sstatus,a5
    80001506:	00008497          	auipc	s1,0x8
    8000150a:	a4a48493          	addi	s1,s1,-1462 # 80008f50 <proc>
    8000150e:	a03d                	j	8000153c <scheduler+0x8e>
        p->state = RUNNING;
    80001510:	0364a023          	sw	s6,32(s1)
        c->proc = p;
    80001514:	049a3023          	sd	s1,64(s4)
        swtch(&c->context, &p->context);
    80001518:	06848593          	addi	a1,s1,104
    8000151c:	8556                	mv	a0,s5
    8000151e:	00000097          	auipc	ra,0x0
    80001522:	6a4080e7          	jalr	1700(ra) # 80001bc2 <swtch>
        c->proc = 0;
    80001526:	040a3023          	sd	zero,64(s4)
      release(&p->lock);
    8000152a:	8526                	mv	a0,s1
    8000152c:	00005097          	auipc	ra,0x5
    80001530:	2ae080e7          	jalr	686(ra) # 800067da <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001534:	17048493          	addi	s1,s1,368
    80001538:	fd2481e3          	beq	s1,s2,800014fa <scheduler+0x4c>
      acquire(&p->lock);
    8000153c:	8526                	mv	a0,s1
    8000153e:	00005097          	auipc	ra,0x5
    80001542:	1cc080e7          	jalr	460(ra) # 8000670a <acquire>
      if(p->state == RUNNABLE) {
    80001546:	509c                	lw	a5,32(s1)
    80001548:	ff3791e3          	bne	a5,s3,8000152a <scheduler+0x7c>
    8000154c:	b7d1                	j	80001510 <scheduler+0x62>

000000008000154e <sched>:
{
    8000154e:	7179                	addi	sp,sp,-48
    80001550:	f406                	sd	ra,40(sp)
    80001552:	f022                	sd	s0,32(sp)
    80001554:	ec26                	sd	s1,24(sp)
    80001556:	e84a                	sd	s2,16(sp)
    80001558:	e44e                	sd	s3,8(sp)
    8000155a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000155c:	00000097          	auipc	ra,0x0
    80001560:	a5c080e7          	jalr	-1444(ra) # 80000fb8 <myproc>
    80001564:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001566:	00005097          	auipc	ra,0x5
    8000156a:	12a080e7          	jalr	298(ra) # 80006690 <holding>
    8000156e:	c93d                	beqz	a0,800015e4 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001570:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001572:	2781                	sext.w	a5,a5
    80001574:	079e                	slli	a5,a5,0x7
    80001576:	00007717          	auipc	a4,0x7
    8000157a:	59a70713          	addi	a4,a4,1434 # 80008b10 <pid_lock>
    8000157e:	97ba                	add	a5,a5,a4
    80001580:	0b87a703          	lw	a4,184(a5)
    80001584:	4785                	li	a5,1
    80001586:	06f71763          	bne	a4,a5,800015f4 <sched+0xa6>
  if(p->state == RUNNING)
    8000158a:	5098                	lw	a4,32(s1)
    8000158c:	4791                	li	a5,4
    8000158e:	06f70b63          	beq	a4,a5,80001604 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001592:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001596:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001598:	efb5                	bnez	a5,80001614 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000159a:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8000159c:	00007917          	auipc	s2,0x7
    800015a0:	57490913          	addi	s2,s2,1396 # 80008b10 <pid_lock>
    800015a4:	2781                	sext.w	a5,a5
    800015a6:	079e                	slli	a5,a5,0x7
    800015a8:	97ca                	add	a5,a5,s2
    800015aa:	0bc7a983          	lw	s3,188(a5)
    800015ae:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800015b0:	2781                	sext.w	a5,a5
    800015b2:	079e                	slli	a5,a5,0x7
    800015b4:	00007597          	auipc	a1,0x7
    800015b8:	5a458593          	addi	a1,a1,1444 # 80008b58 <cpus+0x8>
    800015bc:	95be                	add	a1,a1,a5
    800015be:	06848513          	addi	a0,s1,104
    800015c2:	00000097          	auipc	ra,0x0
    800015c6:	600080e7          	jalr	1536(ra) # 80001bc2 <swtch>
    800015ca:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800015cc:	2781                	sext.w	a5,a5
    800015ce:	079e                	slli	a5,a5,0x7
    800015d0:	97ca                	add	a5,a5,s2
    800015d2:	0b37ae23          	sw	s3,188(a5)
}
    800015d6:	70a2                	ld	ra,40(sp)
    800015d8:	7402                	ld	s0,32(sp)
    800015da:	64e2                	ld	s1,24(sp)
    800015dc:	6942                	ld	s2,16(sp)
    800015de:	69a2                	ld	s3,8(sp)
    800015e0:	6145                	addi	sp,sp,48
    800015e2:	8082                	ret
    panic("sched p->lock");
    800015e4:	00007517          	auipc	a0,0x7
    800015e8:	bf450513          	addi	a0,a0,-1036 # 800081d8 <etext+0x1d8>
    800015ec:	00005097          	auipc	ra,0x5
    800015f0:	bea080e7          	jalr	-1046(ra) # 800061d6 <panic>
    panic("sched locks");
    800015f4:	00007517          	auipc	a0,0x7
    800015f8:	bf450513          	addi	a0,a0,-1036 # 800081e8 <etext+0x1e8>
    800015fc:	00005097          	auipc	ra,0x5
    80001600:	bda080e7          	jalr	-1062(ra) # 800061d6 <panic>
    panic("sched running");
    80001604:	00007517          	auipc	a0,0x7
    80001608:	bf450513          	addi	a0,a0,-1036 # 800081f8 <etext+0x1f8>
    8000160c:	00005097          	auipc	ra,0x5
    80001610:	bca080e7          	jalr	-1078(ra) # 800061d6 <panic>
    panic("sched interruptible");
    80001614:	00007517          	auipc	a0,0x7
    80001618:	bf450513          	addi	a0,a0,-1036 # 80008208 <etext+0x208>
    8000161c:	00005097          	auipc	ra,0x5
    80001620:	bba080e7          	jalr	-1094(ra) # 800061d6 <panic>

0000000080001624 <yield>:
{
    80001624:	1101                	addi	sp,sp,-32
    80001626:	ec06                	sd	ra,24(sp)
    80001628:	e822                	sd	s0,16(sp)
    8000162a:	e426                	sd	s1,8(sp)
    8000162c:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    8000162e:	00000097          	auipc	ra,0x0
    80001632:	98a080e7          	jalr	-1654(ra) # 80000fb8 <myproc>
    80001636:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001638:	00005097          	auipc	ra,0x5
    8000163c:	0d2080e7          	jalr	210(ra) # 8000670a <acquire>
  p->state = RUNNABLE;
    80001640:	478d                	li	a5,3
    80001642:	d09c                	sw	a5,32(s1)
  sched();
    80001644:	00000097          	auipc	ra,0x0
    80001648:	f0a080e7          	jalr	-246(ra) # 8000154e <sched>
  release(&p->lock);
    8000164c:	8526                	mv	a0,s1
    8000164e:	00005097          	auipc	ra,0x5
    80001652:	18c080e7          	jalr	396(ra) # 800067da <release>
}
    80001656:	60e2                	ld	ra,24(sp)
    80001658:	6442                	ld	s0,16(sp)
    8000165a:	64a2                	ld	s1,8(sp)
    8000165c:	6105                	addi	sp,sp,32
    8000165e:	8082                	ret

0000000080001660 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001660:	7179                	addi	sp,sp,-48
    80001662:	f406                	sd	ra,40(sp)
    80001664:	f022                	sd	s0,32(sp)
    80001666:	ec26                	sd	s1,24(sp)
    80001668:	e84a                	sd	s2,16(sp)
    8000166a:	e44e                	sd	s3,8(sp)
    8000166c:	1800                	addi	s0,sp,48
    8000166e:	89aa                	mv	s3,a0
    80001670:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001672:	00000097          	auipc	ra,0x0
    80001676:	946080e7          	jalr	-1722(ra) # 80000fb8 <myproc>
    8000167a:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000167c:	00005097          	auipc	ra,0x5
    80001680:	08e080e7          	jalr	142(ra) # 8000670a <acquire>
  release(lk);
    80001684:	854a                	mv	a0,s2
    80001686:	00005097          	auipc	ra,0x5
    8000168a:	154080e7          	jalr	340(ra) # 800067da <release>

  // Go to sleep.
  p->chan = chan;
    8000168e:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80001692:	4789                	li	a5,2
    80001694:	d09c                	sw	a5,32(s1)

  sched();
    80001696:	00000097          	auipc	ra,0x0
    8000169a:	eb8080e7          	jalr	-328(ra) # 8000154e <sched>

  // Tidy up.
  p->chan = 0;
    8000169e:	0204b423          	sd	zero,40(s1)

  // Reacquire original lock.
  release(&p->lock);
    800016a2:	8526                	mv	a0,s1
    800016a4:	00005097          	auipc	ra,0x5
    800016a8:	136080e7          	jalr	310(ra) # 800067da <release>
  acquire(lk);
    800016ac:	854a                	mv	a0,s2
    800016ae:	00005097          	auipc	ra,0x5
    800016b2:	05c080e7          	jalr	92(ra) # 8000670a <acquire>
}
    800016b6:	70a2                	ld	ra,40(sp)
    800016b8:	7402                	ld	s0,32(sp)
    800016ba:	64e2                	ld	s1,24(sp)
    800016bc:	6942                	ld	s2,16(sp)
    800016be:	69a2                	ld	s3,8(sp)
    800016c0:	6145                	addi	sp,sp,48
    800016c2:	8082                	ret

00000000800016c4 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800016c4:	7139                	addi	sp,sp,-64
    800016c6:	fc06                	sd	ra,56(sp)
    800016c8:	f822                	sd	s0,48(sp)
    800016ca:	f426                	sd	s1,40(sp)
    800016cc:	f04a                	sd	s2,32(sp)
    800016ce:	ec4e                	sd	s3,24(sp)
    800016d0:	e852                	sd	s4,16(sp)
    800016d2:	e456                	sd	s5,8(sp)
    800016d4:	0080                	addi	s0,sp,64
    800016d6:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800016d8:	00008497          	auipc	s1,0x8
    800016dc:	87848493          	addi	s1,s1,-1928 # 80008f50 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800016e0:	4989                	li	s3,2
        p->state = RUNNABLE;
    800016e2:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800016e4:	0000d917          	auipc	s2,0xd
    800016e8:	46c90913          	addi	s2,s2,1132 # 8000eb50 <tickslock>
    800016ec:	a821                	j	80001704 <wakeup+0x40>
        p->state = RUNNABLE;
    800016ee:	0354a023          	sw	s5,32(s1)
      }
      release(&p->lock);
    800016f2:	8526                	mv	a0,s1
    800016f4:	00005097          	auipc	ra,0x5
    800016f8:	0e6080e7          	jalr	230(ra) # 800067da <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800016fc:	17048493          	addi	s1,s1,368
    80001700:	03248463          	beq	s1,s2,80001728 <wakeup+0x64>
    if(p != myproc()){
    80001704:	00000097          	auipc	ra,0x0
    80001708:	8b4080e7          	jalr	-1868(ra) # 80000fb8 <myproc>
    8000170c:	fea488e3          	beq	s1,a0,800016fc <wakeup+0x38>
      acquire(&p->lock);
    80001710:	8526                	mv	a0,s1
    80001712:	00005097          	auipc	ra,0x5
    80001716:	ff8080e7          	jalr	-8(ra) # 8000670a <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000171a:	509c                	lw	a5,32(s1)
    8000171c:	fd379be3          	bne	a5,s3,800016f2 <wakeup+0x2e>
    80001720:	749c                	ld	a5,40(s1)
    80001722:	fd4798e3          	bne	a5,s4,800016f2 <wakeup+0x2e>
    80001726:	b7e1                	j	800016ee <wakeup+0x2a>
    }
  }
}
    80001728:	70e2                	ld	ra,56(sp)
    8000172a:	7442                	ld	s0,48(sp)
    8000172c:	74a2                	ld	s1,40(sp)
    8000172e:	7902                	ld	s2,32(sp)
    80001730:	69e2                	ld	s3,24(sp)
    80001732:	6a42                	ld	s4,16(sp)
    80001734:	6aa2                	ld	s5,8(sp)
    80001736:	6121                	addi	sp,sp,64
    80001738:	8082                	ret

000000008000173a <reparent>:
{
    8000173a:	7179                	addi	sp,sp,-48
    8000173c:	f406                	sd	ra,40(sp)
    8000173e:	f022                	sd	s0,32(sp)
    80001740:	ec26                	sd	s1,24(sp)
    80001742:	e84a                	sd	s2,16(sp)
    80001744:	e44e                	sd	s3,8(sp)
    80001746:	e052                	sd	s4,0(sp)
    80001748:	1800                	addi	s0,sp,48
    8000174a:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000174c:	00008497          	auipc	s1,0x8
    80001750:	80448493          	addi	s1,s1,-2044 # 80008f50 <proc>
      pp->parent = initproc;
    80001754:	00007a17          	auipc	s4,0x7
    80001758:	25ca0a13          	addi	s4,s4,604 # 800089b0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000175c:	0000d997          	auipc	s3,0xd
    80001760:	3f498993          	addi	s3,s3,1012 # 8000eb50 <tickslock>
    80001764:	a029                	j	8000176e <reparent+0x34>
    80001766:	17048493          	addi	s1,s1,368
    8000176a:	01348d63          	beq	s1,s3,80001784 <reparent+0x4a>
    if(pp->parent == p){
    8000176e:	60bc                	ld	a5,64(s1)
    80001770:	ff279be3          	bne	a5,s2,80001766 <reparent+0x2c>
      pp->parent = initproc;
    80001774:	000a3503          	ld	a0,0(s4)
    80001778:	e0a8                	sd	a0,64(s1)
      wakeup(initproc);
    8000177a:	00000097          	auipc	ra,0x0
    8000177e:	f4a080e7          	jalr	-182(ra) # 800016c4 <wakeup>
    80001782:	b7d5                	j	80001766 <reparent+0x2c>
}
    80001784:	70a2                	ld	ra,40(sp)
    80001786:	7402                	ld	s0,32(sp)
    80001788:	64e2                	ld	s1,24(sp)
    8000178a:	6942                	ld	s2,16(sp)
    8000178c:	69a2                	ld	s3,8(sp)
    8000178e:	6a02                	ld	s4,0(sp)
    80001790:	6145                	addi	sp,sp,48
    80001792:	8082                	ret

0000000080001794 <exit>:
{
    80001794:	7179                	addi	sp,sp,-48
    80001796:	f406                	sd	ra,40(sp)
    80001798:	f022                	sd	s0,32(sp)
    8000179a:	ec26                	sd	s1,24(sp)
    8000179c:	e84a                	sd	s2,16(sp)
    8000179e:	e44e                	sd	s3,8(sp)
    800017a0:	e052                	sd	s4,0(sp)
    800017a2:	1800                	addi	s0,sp,48
    800017a4:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800017a6:	00000097          	auipc	ra,0x0
    800017aa:	812080e7          	jalr	-2030(ra) # 80000fb8 <myproc>
    800017ae:	89aa                	mv	s3,a0
  if(p == initproc)
    800017b0:	00007797          	auipc	a5,0x7
    800017b4:	2007b783          	ld	a5,512(a5) # 800089b0 <initproc>
    800017b8:	0d850493          	addi	s1,a0,216
    800017bc:	15850913          	addi	s2,a0,344
    800017c0:	02a79363          	bne	a5,a0,800017e6 <exit+0x52>
    panic("init exiting");
    800017c4:	00007517          	auipc	a0,0x7
    800017c8:	a5c50513          	addi	a0,a0,-1444 # 80008220 <etext+0x220>
    800017cc:	00005097          	auipc	ra,0x5
    800017d0:	a0a080e7          	jalr	-1526(ra) # 800061d6 <panic>
      fileclose(f);
    800017d4:	00002097          	auipc	ra,0x2
    800017d8:	454080e7          	jalr	1108(ra) # 80003c28 <fileclose>
      p->ofile[fd] = 0;
    800017dc:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800017e0:	04a1                	addi	s1,s1,8
    800017e2:	01248563          	beq	s1,s2,800017ec <exit+0x58>
    if(p->ofile[fd]){
    800017e6:	6088                	ld	a0,0(s1)
    800017e8:	f575                	bnez	a0,800017d4 <exit+0x40>
    800017ea:	bfdd                	j	800017e0 <exit+0x4c>
  begin_op();
    800017ec:	00002097          	auipc	ra,0x2
    800017f0:	f70080e7          	jalr	-144(ra) # 8000375c <begin_op>
  iput(p->cwd);
    800017f4:	1589b503          	ld	a0,344(s3)
    800017f8:	00001097          	auipc	ra,0x1
    800017fc:	75c080e7          	jalr	1884(ra) # 80002f54 <iput>
  end_op();
    80001800:	00002097          	auipc	ra,0x2
    80001804:	fdc080e7          	jalr	-36(ra) # 800037dc <end_op>
  p->cwd = 0;
    80001808:	1409bc23          	sd	zero,344(s3)
  acquire(&wait_lock);
    8000180c:	00007497          	auipc	s1,0x7
    80001810:	32448493          	addi	s1,s1,804 # 80008b30 <wait_lock>
    80001814:	8526                	mv	a0,s1
    80001816:	00005097          	auipc	ra,0x5
    8000181a:	ef4080e7          	jalr	-268(ra) # 8000670a <acquire>
  reparent(p);
    8000181e:	854e                	mv	a0,s3
    80001820:	00000097          	auipc	ra,0x0
    80001824:	f1a080e7          	jalr	-230(ra) # 8000173a <reparent>
  wakeup(p->parent);
    80001828:	0409b503          	ld	a0,64(s3)
    8000182c:	00000097          	auipc	ra,0x0
    80001830:	e98080e7          	jalr	-360(ra) # 800016c4 <wakeup>
  acquire(&p->lock);
    80001834:	854e                	mv	a0,s3
    80001836:	00005097          	auipc	ra,0x5
    8000183a:	ed4080e7          	jalr	-300(ra) # 8000670a <acquire>
  p->xstate = status;
    8000183e:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    80001842:	4795                	li	a5,5
    80001844:	02f9a023          	sw	a5,32(s3)
  release(&wait_lock);
    80001848:	8526                	mv	a0,s1
    8000184a:	00005097          	auipc	ra,0x5
    8000184e:	f90080e7          	jalr	-112(ra) # 800067da <release>
  sched();
    80001852:	00000097          	auipc	ra,0x0
    80001856:	cfc080e7          	jalr	-772(ra) # 8000154e <sched>
  panic("zombie exit");
    8000185a:	00007517          	auipc	a0,0x7
    8000185e:	9d650513          	addi	a0,a0,-1578 # 80008230 <etext+0x230>
    80001862:	00005097          	auipc	ra,0x5
    80001866:	974080e7          	jalr	-1676(ra) # 800061d6 <panic>

000000008000186a <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8000186a:	7179                	addi	sp,sp,-48
    8000186c:	f406                	sd	ra,40(sp)
    8000186e:	f022                	sd	s0,32(sp)
    80001870:	ec26                	sd	s1,24(sp)
    80001872:	e84a                	sd	s2,16(sp)
    80001874:	e44e                	sd	s3,8(sp)
    80001876:	1800                	addi	s0,sp,48
    80001878:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000187a:	00007497          	auipc	s1,0x7
    8000187e:	6d648493          	addi	s1,s1,1750 # 80008f50 <proc>
    80001882:	0000d997          	auipc	s3,0xd
    80001886:	2ce98993          	addi	s3,s3,718 # 8000eb50 <tickslock>
    acquire(&p->lock);
    8000188a:	8526                	mv	a0,s1
    8000188c:	00005097          	auipc	ra,0x5
    80001890:	e7e080e7          	jalr	-386(ra) # 8000670a <acquire>
    if(p->pid == pid){
    80001894:	5c9c                	lw	a5,56(s1)
    80001896:	01278d63          	beq	a5,s2,800018b0 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000189a:	8526                	mv	a0,s1
    8000189c:	00005097          	auipc	ra,0x5
    800018a0:	f3e080e7          	jalr	-194(ra) # 800067da <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800018a4:	17048493          	addi	s1,s1,368
    800018a8:	ff3491e3          	bne	s1,s3,8000188a <kill+0x20>
  }
  return -1;
    800018ac:	557d                	li	a0,-1
    800018ae:	a829                	j	800018c8 <kill+0x5e>
      p->killed = 1;
    800018b0:	4785                	li	a5,1
    800018b2:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    800018b4:	5098                	lw	a4,32(s1)
    800018b6:	4789                	li	a5,2
    800018b8:	00f70f63          	beq	a4,a5,800018d6 <kill+0x6c>
      release(&p->lock);
    800018bc:	8526                	mv	a0,s1
    800018be:	00005097          	auipc	ra,0x5
    800018c2:	f1c080e7          	jalr	-228(ra) # 800067da <release>
      return 0;
    800018c6:	4501                	li	a0,0
}
    800018c8:	70a2                	ld	ra,40(sp)
    800018ca:	7402                	ld	s0,32(sp)
    800018cc:	64e2                	ld	s1,24(sp)
    800018ce:	6942                	ld	s2,16(sp)
    800018d0:	69a2                	ld	s3,8(sp)
    800018d2:	6145                	addi	sp,sp,48
    800018d4:	8082                	ret
        p->state = RUNNABLE;
    800018d6:	478d                	li	a5,3
    800018d8:	d09c                	sw	a5,32(s1)
    800018da:	b7cd                	j	800018bc <kill+0x52>

00000000800018dc <setkilled>:

void
setkilled(struct proc *p)
{
    800018dc:	1101                	addi	sp,sp,-32
    800018de:	ec06                	sd	ra,24(sp)
    800018e0:	e822                	sd	s0,16(sp)
    800018e2:	e426                	sd	s1,8(sp)
    800018e4:	1000                	addi	s0,sp,32
    800018e6:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800018e8:	00005097          	auipc	ra,0x5
    800018ec:	e22080e7          	jalr	-478(ra) # 8000670a <acquire>
  p->killed = 1;
    800018f0:	4785                	li	a5,1
    800018f2:	d89c                	sw	a5,48(s1)
  release(&p->lock);
    800018f4:	8526                	mv	a0,s1
    800018f6:	00005097          	auipc	ra,0x5
    800018fa:	ee4080e7          	jalr	-284(ra) # 800067da <release>
}
    800018fe:	60e2                	ld	ra,24(sp)
    80001900:	6442                	ld	s0,16(sp)
    80001902:	64a2                	ld	s1,8(sp)
    80001904:	6105                	addi	sp,sp,32
    80001906:	8082                	ret

0000000080001908 <killed>:

int
killed(struct proc *p)
{
    80001908:	1101                	addi	sp,sp,-32
    8000190a:	ec06                	sd	ra,24(sp)
    8000190c:	e822                	sd	s0,16(sp)
    8000190e:	e426                	sd	s1,8(sp)
    80001910:	e04a                	sd	s2,0(sp)
    80001912:	1000                	addi	s0,sp,32
    80001914:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001916:	00005097          	auipc	ra,0x5
    8000191a:	df4080e7          	jalr	-524(ra) # 8000670a <acquire>
  k = p->killed;
    8000191e:	0304a903          	lw	s2,48(s1)
  release(&p->lock);
    80001922:	8526                	mv	a0,s1
    80001924:	00005097          	auipc	ra,0x5
    80001928:	eb6080e7          	jalr	-330(ra) # 800067da <release>
  return k;
}
    8000192c:	854a                	mv	a0,s2
    8000192e:	60e2                	ld	ra,24(sp)
    80001930:	6442                	ld	s0,16(sp)
    80001932:	64a2                	ld	s1,8(sp)
    80001934:	6902                	ld	s2,0(sp)
    80001936:	6105                	addi	sp,sp,32
    80001938:	8082                	ret

000000008000193a <wait>:
{
    8000193a:	715d                	addi	sp,sp,-80
    8000193c:	e486                	sd	ra,72(sp)
    8000193e:	e0a2                	sd	s0,64(sp)
    80001940:	fc26                	sd	s1,56(sp)
    80001942:	f84a                	sd	s2,48(sp)
    80001944:	f44e                	sd	s3,40(sp)
    80001946:	f052                	sd	s4,32(sp)
    80001948:	ec56                	sd	s5,24(sp)
    8000194a:	e85a                	sd	s6,16(sp)
    8000194c:	e45e                	sd	s7,8(sp)
    8000194e:	e062                	sd	s8,0(sp)
    80001950:	0880                	addi	s0,sp,80
    80001952:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001954:	fffff097          	auipc	ra,0xfffff
    80001958:	664080e7          	jalr	1636(ra) # 80000fb8 <myproc>
    8000195c:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000195e:	00007517          	auipc	a0,0x7
    80001962:	1d250513          	addi	a0,a0,466 # 80008b30 <wait_lock>
    80001966:	00005097          	auipc	ra,0x5
    8000196a:	da4080e7          	jalr	-604(ra) # 8000670a <acquire>
    havekids = 0;
    8000196e:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001970:	4a15                	li	s4,5
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001972:	0000d997          	auipc	s3,0xd
    80001976:	1de98993          	addi	s3,s3,478 # 8000eb50 <tickslock>
        havekids = 1;
    8000197a:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000197c:	00007c17          	auipc	s8,0x7
    80001980:	1b4c0c13          	addi	s8,s8,436 # 80008b30 <wait_lock>
    havekids = 0;
    80001984:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001986:	00007497          	auipc	s1,0x7
    8000198a:	5ca48493          	addi	s1,s1,1482 # 80008f50 <proc>
    8000198e:	a0bd                	j	800019fc <wait+0xc2>
          pid = pp->pid;
    80001990:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001994:	000b0e63          	beqz	s6,800019b0 <wait+0x76>
    80001998:	4691                	li	a3,4
    8000199a:	03448613          	addi	a2,s1,52
    8000199e:	85da                	mv	a1,s6
    800019a0:	05893503          	ld	a0,88(s2)
    800019a4:	fffff097          	auipc	ra,0xfffff
    800019a8:	29e080e7          	jalr	670(ra) # 80000c42 <copyout>
    800019ac:	02054563          	bltz	a0,800019d6 <wait+0x9c>
          freeproc(pp);
    800019b0:	8526                	mv	a0,s1
    800019b2:	fffff097          	auipc	ra,0xfffff
    800019b6:	7bc080e7          	jalr	1980(ra) # 8000116e <freeproc>
          release(&pp->lock);
    800019ba:	8526                	mv	a0,s1
    800019bc:	00005097          	auipc	ra,0x5
    800019c0:	e1e080e7          	jalr	-482(ra) # 800067da <release>
          release(&wait_lock);
    800019c4:	00007517          	auipc	a0,0x7
    800019c8:	16c50513          	addi	a0,a0,364 # 80008b30 <wait_lock>
    800019cc:	00005097          	auipc	ra,0x5
    800019d0:	e0e080e7          	jalr	-498(ra) # 800067da <release>
          return pid;
    800019d4:	a0b5                	j	80001a40 <wait+0x106>
            release(&pp->lock);
    800019d6:	8526                	mv	a0,s1
    800019d8:	00005097          	auipc	ra,0x5
    800019dc:	e02080e7          	jalr	-510(ra) # 800067da <release>
            release(&wait_lock);
    800019e0:	00007517          	auipc	a0,0x7
    800019e4:	15050513          	addi	a0,a0,336 # 80008b30 <wait_lock>
    800019e8:	00005097          	auipc	ra,0x5
    800019ec:	df2080e7          	jalr	-526(ra) # 800067da <release>
            return -1;
    800019f0:	59fd                	li	s3,-1
    800019f2:	a0b9                	j	80001a40 <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800019f4:	17048493          	addi	s1,s1,368
    800019f8:	03348463          	beq	s1,s3,80001a20 <wait+0xe6>
      if(pp->parent == p){
    800019fc:	60bc                	ld	a5,64(s1)
    800019fe:	ff279be3          	bne	a5,s2,800019f4 <wait+0xba>
        acquire(&pp->lock);
    80001a02:	8526                	mv	a0,s1
    80001a04:	00005097          	auipc	ra,0x5
    80001a08:	d06080e7          	jalr	-762(ra) # 8000670a <acquire>
        if(pp->state == ZOMBIE){
    80001a0c:	509c                	lw	a5,32(s1)
    80001a0e:	f94781e3          	beq	a5,s4,80001990 <wait+0x56>
        release(&pp->lock);
    80001a12:	8526                	mv	a0,s1
    80001a14:	00005097          	auipc	ra,0x5
    80001a18:	dc6080e7          	jalr	-570(ra) # 800067da <release>
        havekids = 1;
    80001a1c:	8756                	mv	a4,s5
    80001a1e:	bfd9                	j	800019f4 <wait+0xba>
    if(!havekids || killed(p)){
    80001a20:	c719                	beqz	a4,80001a2e <wait+0xf4>
    80001a22:	854a                	mv	a0,s2
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	ee4080e7          	jalr	-284(ra) # 80001908 <killed>
    80001a2c:	c51d                	beqz	a0,80001a5a <wait+0x120>
      release(&wait_lock);
    80001a2e:	00007517          	auipc	a0,0x7
    80001a32:	10250513          	addi	a0,a0,258 # 80008b30 <wait_lock>
    80001a36:	00005097          	auipc	ra,0x5
    80001a3a:	da4080e7          	jalr	-604(ra) # 800067da <release>
      return -1;
    80001a3e:	59fd                	li	s3,-1
}
    80001a40:	854e                	mv	a0,s3
    80001a42:	60a6                	ld	ra,72(sp)
    80001a44:	6406                	ld	s0,64(sp)
    80001a46:	74e2                	ld	s1,56(sp)
    80001a48:	7942                	ld	s2,48(sp)
    80001a4a:	79a2                	ld	s3,40(sp)
    80001a4c:	7a02                	ld	s4,32(sp)
    80001a4e:	6ae2                	ld	s5,24(sp)
    80001a50:	6b42                	ld	s6,16(sp)
    80001a52:	6ba2                	ld	s7,8(sp)
    80001a54:	6c02                	ld	s8,0(sp)
    80001a56:	6161                	addi	sp,sp,80
    80001a58:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001a5a:	85e2                	mv	a1,s8
    80001a5c:	854a                	mv	a0,s2
    80001a5e:	00000097          	auipc	ra,0x0
    80001a62:	c02080e7          	jalr	-1022(ra) # 80001660 <sleep>
    havekids = 0;
    80001a66:	bf39                	j	80001984 <wait+0x4a>

0000000080001a68 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001a68:	7179                	addi	sp,sp,-48
    80001a6a:	f406                	sd	ra,40(sp)
    80001a6c:	f022                	sd	s0,32(sp)
    80001a6e:	ec26                	sd	s1,24(sp)
    80001a70:	e84a                	sd	s2,16(sp)
    80001a72:	e44e                	sd	s3,8(sp)
    80001a74:	e052                	sd	s4,0(sp)
    80001a76:	1800                	addi	s0,sp,48
    80001a78:	84aa                	mv	s1,a0
    80001a7a:	892e                	mv	s2,a1
    80001a7c:	89b2                	mv	s3,a2
    80001a7e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001a80:	fffff097          	auipc	ra,0xfffff
    80001a84:	538080e7          	jalr	1336(ra) # 80000fb8 <myproc>
  if(user_dst){
    80001a88:	c08d                	beqz	s1,80001aaa <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001a8a:	86d2                	mv	a3,s4
    80001a8c:	864e                	mv	a2,s3
    80001a8e:	85ca                	mv	a1,s2
    80001a90:	6d28                	ld	a0,88(a0)
    80001a92:	fffff097          	auipc	ra,0xfffff
    80001a96:	1b0080e7          	jalr	432(ra) # 80000c42 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001a9a:	70a2                	ld	ra,40(sp)
    80001a9c:	7402                	ld	s0,32(sp)
    80001a9e:	64e2                	ld	s1,24(sp)
    80001aa0:	6942                	ld	s2,16(sp)
    80001aa2:	69a2                	ld	s3,8(sp)
    80001aa4:	6a02                	ld	s4,0(sp)
    80001aa6:	6145                	addi	sp,sp,48
    80001aa8:	8082                	ret
    memmove((char *)dst, src, len);
    80001aaa:	000a061b          	sext.w	a2,s4
    80001aae:	85ce                	mv	a1,s3
    80001ab0:	854a                	mv	a0,s2
    80001ab2:	fffff097          	auipc	ra,0xfffff
    80001ab6:	81e080e7          	jalr	-2018(ra) # 800002d0 <memmove>
    return 0;
    80001aba:	8526                	mv	a0,s1
    80001abc:	bff9                	j	80001a9a <either_copyout+0x32>

0000000080001abe <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001abe:	7179                	addi	sp,sp,-48
    80001ac0:	f406                	sd	ra,40(sp)
    80001ac2:	f022                	sd	s0,32(sp)
    80001ac4:	ec26                	sd	s1,24(sp)
    80001ac6:	e84a                	sd	s2,16(sp)
    80001ac8:	e44e                	sd	s3,8(sp)
    80001aca:	e052                	sd	s4,0(sp)
    80001acc:	1800                	addi	s0,sp,48
    80001ace:	892a                	mv	s2,a0
    80001ad0:	84ae                	mv	s1,a1
    80001ad2:	89b2                	mv	s3,a2
    80001ad4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001ad6:	fffff097          	auipc	ra,0xfffff
    80001ada:	4e2080e7          	jalr	1250(ra) # 80000fb8 <myproc>
  if(user_src){
    80001ade:	c08d                	beqz	s1,80001b00 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001ae0:	86d2                	mv	a3,s4
    80001ae2:	864e                	mv	a2,s3
    80001ae4:	85ca                	mv	a1,s2
    80001ae6:	6d28                	ld	a0,88(a0)
    80001ae8:	fffff097          	auipc	ra,0xfffff
    80001aec:	21a080e7          	jalr	538(ra) # 80000d02 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001af0:	70a2                	ld	ra,40(sp)
    80001af2:	7402                	ld	s0,32(sp)
    80001af4:	64e2                	ld	s1,24(sp)
    80001af6:	6942                	ld	s2,16(sp)
    80001af8:	69a2                	ld	s3,8(sp)
    80001afa:	6a02                	ld	s4,0(sp)
    80001afc:	6145                	addi	sp,sp,48
    80001afe:	8082                	ret
    memmove(dst, (char*)src, len);
    80001b00:	000a061b          	sext.w	a2,s4
    80001b04:	85ce                	mv	a1,s3
    80001b06:	854a                	mv	a0,s2
    80001b08:	ffffe097          	auipc	ra,0xffffe
    80001b0c:	7c8080e7          	jalr	1992(ra) # 800002d0 <memmove>
    return 0;
    80001b10:	8526                	mv	a0,s1
    80001b12:	bff9                	j	80001af0 <either_copyin+0x32>

0000000080001b14 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001b14:	715d                	addi	sp,sp,-80
    80001b16:	e486                	sd	ra,72(sp)
    80001b18:	e0a2                	sd	s0,64(sp)
    80001b1a:	fc26                	sd	s1,56(sp)
    80001b1c:	f84a                	sd	s2,48(sp)
    80001b1e:	f44e                	sd	s3,40(sp)
    80001b20:	f052                	sd	s4,32(sp)
    80001b22:	ec56                	sd	s5,24(sp)
    80001b24:	e85a                	sd	s6,16(sp)
    80001b26:	e45e                	sd	s7,8(sp)
    80001b28:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001b2a:	00007517          	auipc	a0,0x7
    80001b2e:	dae50513          	addi	a0,a0,-594 # 800088d8 <digits+0x88>
    80001b32:	00004097          	auipc	ra,0x4
    80001b36:	6ee080e7          	jalr	1774(ra) # 80006220 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001b3a:	00007497          	auipc	s1,0x7
    80001b3e:	57648493          	addi	s1,s1,1398 # 800090b0 <proc+0x160>
    80001b42:	0000d917          	auipc	s2,0xd
    80001b46:	16e90913          	addi	s2,s2,366 # 8000ecb0 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001b4a:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001b4c:	00006997          	auipc	s3,0x6
    80001b50:	6f498993          	addi	s3,s3,1780 # 80008240 <etext+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    80001b54:	00006a97          	auipc	s5,0x6
    80001b58:	6f4a8a93          	addi	s5,s5,1780 # 80008248 <etext+0x248>
    printf("\n");
    80001b5c:	00007a17          	auipc	s4,0x7
    80001b60:	d7ca0a13          	addi	s4,s4,-644 # 800088d8 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001b64:	00006b97          	auipc	s7,0x6
    80001b68:	724b8b93          	addi	s7,s7,1828 # 80008288 <states.1739>
    80001b6c:	a00d                	j	80001b8e <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001b6e:	ed86a583          	lw	a1,-296(a3)
    80001b72:	8556                	mv	a0,s5
    80001b74:	00004097          	auipc	ra,0x4
    80001b78:	6ac080e7          	jalr	1708(ra) # 80006220 <printf>
    printf("\n");
    80001b7c:	8552                	mv	a0,s4
    80001b7e:	00004097          	auipc	ra,0x4
    80001b82:	6a2080e7          	jalr	1698(ra) # 80006220 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001b86:	17048493          	addi	s1,s1,368
    80001b8a:	03248163          	beq	s1,s2,80001bac <procdump+0x98>
    if(p->state == UNUSED)
    80001b8e:	86a6                	mv	a3,s1
    80001b90:	ec04a783          	lw	a5,-320(s1)
    80001b94:	dbed                	beqz	a5,80001b86 <procdump+0x72>
      state = "???";
    80001b96:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001b98:	fcfb6be3          	bltu	s6,a5,80001b6e <procdump+0x5a>
    80001b9c:	1782                	slli	a5,a5,0x20
    80001b9e:	9381                	srli	a5,a5,0x20
    80001ba0:	078e                	slli	a5,a5,0x3
    80001ba2:	97de                	add	a5,a5,s7
    80001ba4:	6390                	ld	a2,0(a5)
    80001ba6:	f661                	bnez	a2,80001b6e <procdump+0x5a>
      state = "???";
    80001ba8:	864e                	mv	a2,s3
    80001baa:	b7d1                	j	80001b6e <procdump+0x5a>
  }
}
    80001bac:	60a6                	ld	ra,72(sp)
    80001bae:	6406                	ld	s0,64(sp)
    80001bb0:	74e2                	ld	s1,56(sp)
    80001bb2:	7942                	ld	s2,48(sp)
    80001bb4:	79a2                	ld	s3,40(sp)
    80001bb6:	7a02                	ld	s4,32(sp)
    80001bb8:	6ae2                	ld	s5,24(sp)
    80001bba:	6b42                	ld	s6,16(sp)
    80001bbc:	6ba2                	ld	s7,8(sp)
    80001bbe:	6161                	addi	sp,sp,80
    80001bc0:	8082                	ret

0000000080001bc2 <swtch>:
    80001bc2:	00153023          	sd	ra,0(a0)
    80001bc6:	00253423          	sd	sp,8(a0)
    80001bca:	e900                	sd	s0,16(a0)
    80001bcc:	ed04                	sd	s1,24(a0)
    80001bce:	03253023          	sd	s2,32(a0)
    80001bd2:	03353423          	sd	s3,40(a0)
    80001bd6:	03453823          	sd	s4,48(a0)
    80001bda:	03553c23          	sd	s5,56(a0)
    80001bde:	05653023          	sd	s6,64(a0)
    80001be2:	05753423          	sd	s7,72(a0)
    80001be6:	05853823          	sd	s8,80(a0)
    80001bea:	05953c23          	sd	s9,88(a0)
    80001bee:	07a53023          	sd	s10,96(a0)
    80001bf2:	07b53423          	sd	s11,104(a0)
    80001bf6:	0005b083          	ld	ra,0(a1)
    80001bfa:	0085b103          	ld	sp,8(a1)
    80001bfe:	6980                	ld	s0,16(a1)
    80001c00:	6d84                	ld	s1,24(a1)
    80001c02:	0205b903          	ld	s2,32(a1)
    80001c06:	0285b983          	ld	s3,40(a1)
    80001c0a:	0305ba03          	ld	s4,48(a1)
    80001c0e:	0385ba83          	ld	s5,56(a1)
    80001c12:	0405bb03          	ld	s6,64(a1)
    80001c16:	0485bb83          	ld	s7,72(a1)
    80001c1a:	0505bc03          	ld	s8,80(a1)
    80001c1e:	0585bc83          	ld	s9,88(a1)
    80001c22:	0605bd03          	ld	s10,96(a1)
    80001c26:	0685bd83          	ld	s11,104(a1)
    80001c2a:	8082                	ret

0000000080001c2c <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001c2c:	1141                	addi	sp,sp,-16
    80001c2e:	e406                	sd	ra,8(sp)
    80001c30:	e022                	sd	s0,0(sp)
    80001c32:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001c34:	00006597          	auipc	a1,0x6
    80001c38:	68458593          	addi	a1,a1,1668 # 800082b8 <states.1739+0x30>
    80001c3c:	0000d517          	auipc	a0,0xd
    80001c40:	f1450513          	addi	a0,a0,-236 # 8000eb50 <tickslock>
    80001c44:	00005097          	auipc	ra,0x5
    80001c48:	c42080e7          	jalr	-958(ra) # 80006886 <initlock>
}
    80001c4c:	60a2                	ld	ra,8(sp)
    80001c4e:	6402                	ld	s0,0(sp)
    80001c50:	0141                	addi	sp,sp,16
    80001c52:	8082                	ret

0000000080001c54 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001c54:	1141                	addi	sp,sp,-16
    80001c56:	e422                	sd	s0,8(sp)
    80001c58:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c5a:	00003797          	auipc	a5,0x3
    80001c5e:	61678793          	addi	a5,a5,1558 # 80005270 <kernelvec>
    80001c62:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001c66:	6422                	ld	s0,8(sp)
    80001c68:	0141                	addi	sp,sp,16
    80001c6a:	8082                	ret

0000000080001c6c <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001c6c:	1141                	addi	sp,sp,-16
    80001c6e:	e406                	sd	ra,8(sp)
    80001c70:	e022                	sd	s0,0(sp)
    80001c72:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001c74:	fffff097          	auipc	ra,0xfffff
    80001c78:	344080e7          	jalr	836(ra) # 80000fb8 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c7c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001c80:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c82:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001c86:	00005617          	auipc	a2,0x5
    80001c8a:	37a60613          	addi	a2,a2,890 # 80007000 <_trampoline>
    80001c8e:	00005697          	auipc	a3,0x5
    80001c92:	37268693          	addi	a3,a3,882 # 80007000 <_trampoline>
    80001c96:	8e91                	sub	a3,a3,a2
    80001c98:	040007b7          	lui	a5,0x4000
    80001c9c:	17fd                	addi	a5,a5,-1
    80001c9e:	07b2                	slli	a5,a5,0xc
    80001ca0:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ca2:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001ca6:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001ca8:	180026f3          	csrr	a3,satp
    80001cac:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001cae:	7138                	ld	a4,96(a0)
    80001cb0:	6534                	ld	a3,72(a0)
    80001cb2:	6585                	lui	a1,0x1
    80001cb4:	96ae                	add	a3,a3,a1
    80001cb6:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001cb8:	7138                	ld	a4,96(a0)
    80001cba:	00000697          	auipc	a3,0x0
    80001cbe:	13068693          	addi	a3,a3,304 # 80001dea <usertrap>
    80001cc2:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001cc4:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001cc6:	8692                	mv	a3,tp
    80001cc8:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cca:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001cce:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001cd2:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001cd6:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001cda:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001cdc:	6f18                	ld	a4,24(a4)
    80001cde:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001ce2:	6d28                	ld	a0,88(a0)
    80001ce4:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001ce6:	00005717          	auipc	a4,0x5
    80001cea:	3b670713          	addi	a4,a4,950 # 8000709c <userret>
    80001cee:	8f11                	sub	a4,a4,a2
    80001cf0:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001cf2:	577d                	li	a4,-1
    80001cf4:	177e                	slli	a4,a4,0x3f
    80001cf6:	8d59                	or	a0,a0,a4
    80001cf8:	9782                	jalr	a5
}
    80001cfa:	60a2                	ld	ra,8(sp)
    80001cfc:	6402                	ld	s0,0(sp)
    80001cfe:	0141                	addi	sp,sp,16
    80001d00:	8082                	ret

0000000080001d02 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001d02:	1101                	addi	sp,sp,-32
    80001d04:	ec06                	sd	ra,24(sp)
    80001d06:	e822                	sd	s0,16(sp)
    80001d08:	e426                	sd	s1,8(sp)
    80001d0a:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001d0c:	0000d497          	auipc	s1,0xd
    80001d10:	e4448493          	addi	s1,s1,-444 # 8000eb50 <tickslock>
    80001d14:	8526                	mv	a0,s1
    80001d16:	00005097          	auipc	ra,0x5
    80001d1a:	9f4080e7          	jalr	-1548(ra) # 8000670a <acquire>
  ticks++;
    80001d1e:	00007517          	auipc	a0,0x7
    80001d22:	c9a50513          	addi	a0,a0,-870 # 800089b8 <ticks>
    80001d26:	411c                	lw	a5,0(a0)
    80001d28:	2785                	addiw	a5,a5,1
    80001d2a:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001d2c:	00000097          	auipc	ra,0x0
    80001d30:	998080e7          	jalr	-1640(ra) # 800016c4 <wakeup>
  release(&tickslock);
    80001d34:	8526                	mv	a0,s1
    80001d36:	00005097          	auipc	ra,0x5
    80001d3a:	aa4080e7          	jalr	-1372(ra) # 800067da <release>
}
    80001d3e:	60e2                	ld	ra,24(sp)
    80001d40:	6442                	ld	s0,16(sp)
    80001d42:	64a2                	ld	s1,8(sp)
    80001d44:	6105                	addi	sp,sp,32
    80001d46:	8082                	ret

0000000080001d48 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001d48:	1101                	addi	sp,sp,-32
    80001d4a:	ec06                	sd	ra,24(sp)
    80001d4c:	e822                	sd	s0,16(sp)
    80001d4e:	e426                	sd	s1,8(sp)
    80001d50:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d52:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001d56:	00074d63          	bltz	a4,80001d70 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001d5a:	57fd                	li	a5,-1
    80001d5c:	17fe                	slli	a5,a5,0x3f
    80001d5e:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001d60:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001d62:	06f70363          	beq	a4,a5,80001dc8 <devintr+0x80>
  }
}
    80001d66:	60e2                	ld	ra,24(sp)
    80001d68:	6442                	ld	s0,16(sp)
    80001d6a:	64a2                	ld	s1,8(sp)
    80001d6c:	6105                	addi	sp,sp,32
    80001d6e:	8082                	ret
     (scause & 0xff) == 9){
    80001d70:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001d74:	46a5                	li	a3,9
    80001d76:	fed792e3          	bne	a5,a3,80001d5a <devintr+0x12>
    int irq = plic_claim();
    80001d7a:	00003097          	auipc	ra,0x3
    80001d7e:	5fe080e7          	jalr	1534(ra) # 80005378 <plic_claim>
    80001d82:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001d84:	47a9                	li	a5,10
    80001d86:	02f50763          	beq	a0,a5,80001db4 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001d8a:	4785                	li	a5,1
    80001d8c:	02f50963          	beq	a0,a5,80001dbe <devintr+0x76>
    return 1;
    80001d90:	4505                	li	a0,1
    } else if(irq){
    80001d92:	d8f1                	beqz	s1,80001d66 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001d94:	85a6                	mv	a1,s1
    80001d96:	00006517          	auipc	a0,0x6
    80001d9a:	52a50513          	addi	a0,a0,1322 # 800082c0 <states.1739+0x38>
    80001d9e:	00004097          	auipc	ra,0x4
    80001da2:	482080e7          	jalr	1154(ra) # 80006220 <printf>
      plic_complete(irq);
    80001da6:	8526                	mv	a0,s1
    80001da8:	00003097          	auipc	ra,0x3
    80001dac:	5f4080e7          	jalr	1524(ra) # 8000539c <plic_complete>
    return 1;
    80001db0:	4505                	li	a0,1
    80001db2:	bf55                	j	80001d66 <devintr+0x1e>
      uartintr();
    80001db4:	00005097          	auipc	ra,0x5
    80001db8:	88c080e7          	jalr	-1908(ra) # 80006640 <uartintr>
    80001dbc:	b7ed                	j	80001da6 <devintr+0x5e>
      virtio_disk_intr();
    80001dbe:	00004097          	auipc	ra,0x4
    80001dc2:	b08080e7          	jalr	-1272(ra) # 800058c6 <virtio_disk_intr>
    80001dc6:	b7c5                	j	80001da6 <devintr+0x5e>
    if(cpuid() == 0){
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	1c4080e7          	jalr	452(ra) # 80000f8c <cpuid>
    80001dd0:	c901                	beqz	a0,80001de0 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001dd2:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001dd6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001dd8:	14479073          	csrw	sip,a5
    return 2;
    80001ddc:	4509                	li	a0,2
    80001dde:	b761                	j	80001d66 <devintr+0x1e>
      clockintr();
    80001de0:	00000097          	auipc	ra,0x0
    80001de4:	f22080e7          	jalr	-222(ra) # 80001d02 <clockintr>
    80001de8:	b7ed                	j	80001dd2 <devintr+0x8a>

0000000080001dea <usertrap>:
{
    80001dea:	1101                	addi	sp,sp,-32
    80001dec:	ec06                	sd	ra,24(sp)
    80001dee:	e822                	sd	s0,16(sp)
    80001df0:	e426                	sd	s1,8(sp)
    80001df2:	e04a                	sd	s2,0(sp)
    80001df4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001df6:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001dfa:	1007f793          	andi	a5,a5,256
    80001dfe:	e3b1                	bnez	a5,80001e42 <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001e00:	00003797          	auipc	a5,0x3
    80001e04:	47078793          	addi	a5,a5,1136 # 80005270 <kernelvec>
    80001e08:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001e0c:	fffff097          	auipc	ra,0xfffff
    80001e10:	1ac080e7          	jalr	428(ra) # 80000fb8 <myproc>
    80001e14:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001e16:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e18:	14102773          	csrr	a4,sepc
    80001e1c:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e1e:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001e22:	47a1                	li	a5,8
    80001e24:	02f70763          	beq	a4,a5,80001e52 <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001e28:	00000097          	auipc	ra,0x0
    80001e2c:	f20080e7          	jalr	-224(ra) # 80001d48 <devintr>
    80001e30:	892a                	mv	s2,a0
    80001e32:	c151                	beqz	a0,80001eb6 <usertrap+0xcc>
  if(killed(p))
    80001e34:	8526                	mv	a0,s1
    80001e36:	00000097          	auipc	ra,0x0
    80001e3a:	ad2080e7          	jalr	-1326(ra) # 80001908 <killed>
    80001e3e:	c929                	beqz	a0,80001e90 <usertrap+0xa6>
    80001e40:	a099                	j	80001e86 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001e42:	00006517          	auipc	a0,0x6
    80001e46:	49e50513          	addi	a0,a0,1182 # 800082e0 <states.1739+0x58>
    80001e4a:	00004097          	auipc	ra,0x4
    80001e4e:	38c080e7          	jalr	908(ra) # 800061d6 <panic>
    if(killed(p))
    80001e52:	00000097          	auipc	ra,0x0
    80001e56:	ab6080e7          	jalr	-1354(ra) # 80001908 <killed>
    80001e5a:	e921                	bnez	a0,80001eaa <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001e5c:	70b8                	ld	a4,96(s1)
    80001e5e:	6f1c                	ld	a5,24(a4)
    80001e60:	0791                	addi	a5,a5,4
    80001e62:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e64:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001e68:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e6c:	10079073          	csrw	sstatus,a5
    syscall();
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	2d4080e7          	jalr	724(ra) # 80002144 <syscall>
  if(killed(p))
    80001e78:	8526                	mv	a0,s1
    80001e7a:	00000097          	auipc	ra,0x0
    80001e7e:	a8e080e7          	jalr	-1394(ra) # 80001908 <killed>
    80001e82:	c911                	beqz	a0,80001e96 <usertrap+0xac>
    80001e84:	4901                	li	s2,0
    exit(-1);
    80001e86:	557d                	li	a0,-1
    80001e88:	00000097          	auipc	ra,0x0
    80001e8c:	90c080e7          	jalr	-1780(ra) # 80001794 <exit>
  if(which_dev == 2)
    80001e90:	4789                	li	a5,2
    80001e92:	04f90f63          	beq	s2,a5,80001ef0 <usertrap+0x106>
  usertrapret();
    80001e96:	00000097          	auipc	ra,0x0
    80001e9a:	dd6080e7          	jalr	-554(ra) # 80001c6c <usertrapret>
}
    80001e9e:	60e2                	ld	ra,24(sp)
    80001ea0:	6442                	ld	s0,16(sp)
    80001ea2:	64a2                	ld	s1,8(sp)
    80001ea4:	6902                	ld	s2,0(sp)
    80001ea6:	6105                	addi	sp,sp,32
    80001ea8:	8082                	ret
      exit(-1);
    80001eaa:	557d                	li	a0,-1
    80001eac:	00000097          	auipc	ra,0x0
    80001eb0:	8e8080e7          	jalr	-1816(ra) # 80001794 <exit>
    80001eb4:	b765                	j	80001e5c <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001eb6:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001eba:	5c90                	lw	a2,56(s1)
    80001ebc:	00006517          	auipc	a0,0x6
    80001ec0:	44450513          	addi	a0,a0,1092 # 80008300 <states.1739+0x78>
    80001ec4:	00004097          	auipc	ra,0x4
    80001ec8:	35c080e7          	jalr	860(ra) # 80006220 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ecc:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001ed0:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001ed4:	00006517          	auipc	a0,0x6
    80001ed8:	45c50513          	addi	a0,a0,1116 # 80008330 <states.1739+0xa8>
    80001edc:	00004097          	auipc	ra,0x4
    80001ee0:	344080e7          	jalr	836(ra) # 80006220 <printf>
    setkilled(p);
    80001ee4:	8526                	mv	a0,s1
    80001ee6:	00000097          	auipc	ra,0x0
    80001eea:	9f6080e7          	jalr	-1546(ra) # 800018dc <setkilled>
    80001eee:	b769                	j	80001e78 <usertrap+0x8e>
    yield();
    80001ef0:	fffff097          	auipc	ra,0xfffff
    80001ef4:	734080e7          	jalr	1844(ra) # 80001624 <yield>
    80001ef8:	bf79                	j	80001e96 <usertrap+0xac>

0000000080001efa <kerneltrap>:
{
    80001efa:	7179                	addi	sp,sp,-48
    80001efc:	f406                	sd	ra,40(sp)
    80001efe:	f022                	sd	s0,32(sp)
    80001f00:	ec26                	sd	s1,24(sp)
    80001f02:	e84a                	sd	s2,16(sp)
    80001f04:	e44e                	sd	s3,8(sp)
    80001f06:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f08:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f0c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f10:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001f14:	1004f793          	andi	a5,s1,256
    80001f18:	cb85                	beqz	a5,80001f48 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f1a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f1e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001f20:	ef85                	bnez	a5,80001f58 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001f22:	00000097          	auipc	ra,0x0
    80001f26:	e26080e7          	jalr	-474(ra) # 80001d48 <devintr>
    80001f2a:	cd1d                	beqz	a0,80001f68 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f2c:	4789                	li	a5,2
    80001f2e:	06f50a63          	beq	a0,a5,80001fa2 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001f32:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f36:	10049073          	csrw	sstatus,s1
}
    80001f3a:	70a2                	ld	ra,40(sp)
    80001f3c:	7402                	ld	s0,32(sp)
    80001f3e:	64e2                	ld	s1,24(sp)
    80001f40:	6942                	ld	s2,16(sp)
    80001f42:	69a2                	ld	s3,8(sp)
    80001f44:	6145                	addi	sp,sp,48
    80001f46:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001f48:	00006517          	auipc	a0,0x6
    80001f4c:	40850513          	addi	a0,a0,1032 # 80008350 <states.1739+0xc8>
    80001f50:	00004097          	auipc	ra,0x4
    80001f54:	286080e7          	jalr	646(ra) # 800061d6 <panic>
    panic("kerneltrap: interrupts enabled");
    80001f58:	00006517          	auipc	a0,0x6
    80001f5c:	42050513          	addi	a0,a0,1056 # 80008378 <states.1739+0xf0>
    80001f60:	00004097          	auipc	ra,0x4
    80001f64:	276080e7          	jalr	630(ra) # 800061d6 <panic>
    printf("scause %p\n", scause);
    80001f68:	85ce                	mv	a1,s3
    80001f6a:	00006517          	auipc	a0,0x6
    80001f6e:	42e50513          	addi	a0,a0,1070 # 80008398 <states.1739+0x110>
    80001f72:	00004097          	auipc	ra,0x4
    80001f76:	2ae080e7          	jalr	686(ra) # 80006220 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f7a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001f7e:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001f82:	00006517          	auipc	a0,0x6
    80001f86:	42650513          	addi	a0,a0,1062 # 800083a8 <states.1739+0x120>
    80001f8a:	00004097          	auipc	ra,0x4
    80001f8e:	296080e7          	jalr	662(ra) # 80006220 <printf>
    panic("kerneltrap");
    80001f92:	00006517          	auipc	a0,0x6
    80001f96:	42e50513          	addi	a0,a0,1070 # 800083c0 <states.1739+0x138>
    80001f9a:	00004097          	auipc	ra,0x4
    80001f9e:	23c080e7          	jalr	572(ra) # 800061d6 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001fa2:	fffff097          	auipc	ra,0xfffff
    80001fa6:	016080e7          	jalr	22(ra) # 80000fb8 <myproc>
    80001faa:	d541                	beqz	a0,80001f32 <kerneltrap+0x38>
    80001fac:	fffff097          	auipc	ra,0xfffff
    80001fb0:	00c080e7          	jalr	12(ra) # 80000fb8 <myproc>
    80001fb4:	5118                	lw	a4,32(a0)
    80001fb6:	4791                	li	a5,4
    80001fb8:	f6f71de3          	bne	a4,a5,80001f32 <kerneltrap+0x38>
    yield();
    80001fbc:	fffff097          	auipc	ra,0xfffff
    80001fc0:	668080e7          	jalr	1640(ra) # 80001624 <yield>
    80001fc4:	b7bd                	j	80001f32 <kerneltrap+0x38>

0000000080001fc6 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001fc6:	1101                	addi	sp,sp,-32
    80001fc8:	ec06                	sd	ra,24(sp)
    80001fca:	e822                	sd	s0,16(sp)
    80001fcc:	e426                	sd	s1,8(sp)
    80001fce:	1000                	addi	s0,sp,32
    80001fd0:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001fd2:	fffff097          	auipc	ra,0xfffff
    80001fd6:	fe6080e7          	jalr	-26(ra) # 80000fb8 <myproc>
  switch (n) {
    80001fda:	4795                	li	a5,5
    80001fdc:	0497e163          	bltu	a5,s1,8000201e <argraw+0x58>
    80001fe0:	048a                	slli	s1,s1,0x2
    80001fe2:	00006717          	auipc	a4,0x6
    80001fe6:	41670713          	addi	a4,a4,1046 # 800083f8 <states.1739+0x170>
    80001fea:	94ba                	add	s1,s1,a4
    80001fec:	409c                	lw	a5,0(s1)
    80001fee:	97ba                	add	a5,a5,a4
    80001ff0:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001ff2:	713c                	ld	a5,96(a0)
    80001ff4:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001ff6:	60e2                	ld	ra,24(sp)
    80001ff8:	6442                	ld	s0,16(sp)
    80001ffa:	64a2                	ld	s1,8(sp)
    80001ffc:	6105                	addi	sp,sp,32
    80001ffe:	8082                	ret
    return p->trapframe->a1;
    80002000:	713c                	ld	a5,96(a0)
    80002002:	7fa8                	ld	a0,120(a5)
    80002004:	bfcd                	j	80001ff6 <argraw+0x30>
    return p->trapframe->a2;
    80002006:	713c                	ld	a5,96(a0)
    80002008:	63c8                	ld	a0,128(a5)
    8000200a:	b7f5                	j	80001ff6 <argraw+0x30>
    return p->trapframe->a3;
    8000200c:	713c                	ld	a5,96(a0)
    8000200e:	67c8                	ld	a0,136(a5)
    80002010:	b7dd                	j	80001ff6 <argraw+0x30>
    return p->trapframe->a4;
    80002012:	713c                	ld	a5,96(a0)
    80002014:	6bc8                	ld	a0,144(a5)
    80002016:	b7c5                	j	80001ff6 <argraw+0x30>
    return p->trapframe->a5;
    80002018:	713c                	ld	a5,96(a0)
    8000201a:	6fc8                	ld	a0,152(a5)
    8000201c:	bfe9                	j	80001ff6 <argraw+0x30>
  panic("argraw");
    8000201e:	00006517          	auipc	a0,0x6
    80002022:	3b250513          	addi	a0,a0,946 # 800083d0 <states.1739+0x148>
    80002026:	00004097          	auipc	ra,0x4
    8000202a:	1b0080e7          	jalr	432(ra) # 800061d6 <panic>

000000008000202e <fetchaddr>:
{
    8000202e:	1101                	addi	sp,sp,-32
    80002030:	ec06                	sd	ra,24(sp)
    80002032:	e822                	sd	s0,16(sp)
    80002034:	e426                	sd	s1,8(sp)
    80002036:	e04a                	sd	s2,0(sp)
    80002038:	1000                	addi	s0,sp,32
    8000203a:	84aa                	mv	s1,a0
    8000203c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000203e:	fffff097          	auipc	ra,0xfffff
    80002042:	f7a080e7          	jalr	-134(ra) # 80000fb8 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80002046:	693c                	ld	a5,80(a0)
    80002048:	02f4f863          	bgeu	s1,a5,80002078 <fetchaddr+0x4a>
    8000204c:	00848713          	addi	a4,s1,8
    80002050:	02e7e663          	bltu	a5,a4,8000207c <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002054:	46a1                	li	a3,8
    80002056:	8626                	mv	a2,s1
    80002058:	85ca                	mv	a1,s2
    8000205a:	6d28                	ld	a0,88(a0)
    8000205c:	fffff097          	auipc	ra,0xfffff
    80002060:	ca6080e7          	jalr	-858(ra) # 80000d02 <copyin>
    80002064:	00a03533          	snez	a0,a0
    80002068:	40a00533          	neg	a0,a0
}
    8000206c:	60e2                	ld	ra,24(sp)
    8000206e:	6442                	ld	s0,16(sp)
    80002070:	64a2                	ld	s1,8(sp)
    80002072:	6902                	ld	s2,0(sp)
    80002074:	6105                	addi	sp,sp,32
    80002076:	8082                	ret
    return -1;
    80002078:	557d                	li	a0,-1
    8000207a:	bfcd                	j	8000206c <fetchaddr+0x3e>
    8000207c:	557d                	li	a0,-1
    8000207e:	b7fd                	j	8000206c <fetchaddr+0x3e>

0000000080002080 <fetchstr>:
{
    80002080:	7179                	addi	sp,sp,-48
    80002082:	f406                	sd	ra,40(sp)
    80002084:	f022                	sd	s0,32(sp)
    80002086:	ec26                	sd	s1,24(sp)
    80002088:	e84a                	sd	s2,16(sp)
    8000208a:	e44e                	sd	s3,8(sp)
    8000208c:	1800                	addi	s0,sp,48
    8000208e:	892a                	mv	s2,a0
    80002090:	84ae                	mv	s1,a1
    80002092:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002094:	fffff097          	auipc	ra,0xfffff
    80002098:	f24080e7          	jalr	-220(ra) # 80000fb8 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    8000209c:	86ce                	mv	a3,s3
    8000209e:	864a                	mv	a2,s2
    800020a0:	85a6                	mv	a1,s1
    800020a2:	6d28                	ld	a0,88(a0)
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	cea080e7          	jalr	-790(ra) # 80000d8e <copyinstr>
    800020ac:	00054e63          	bltz	a0,800020c8 <fetchstr+0x48>
  return strlen(buf);
    800020b0:	8526                	mv	a0,s1
    800020b2:	ffffe097          	auipc	ra,0xffffe
    800020b6:	342080e7          	jalr	834(ra) # 800003f4 <strlen>
}
    800020ba:	70a2                	ld	ra,40(sp)
    800020bc:	7402                	ld	s0,32(sp)
    800020be:	64e2                	ld	s1,24(sp)
    800020c0:	6942                	ld	s2,16(sp)
    800020c2:	69a2                	ld	s3,8(sp)
    800020c4:	6145                	addi	sp,sp,48
    800020c6:	8082                	ret
    return -1;
    800020c8:	557d                	li	a0,-1
    800020ca:	bfc5                	j	800020ba <fetchstr+0x3a>

00000000800020cc <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    800020cc:	1101                	addi	sp,sp,-32
    800020ce:	ec06                	sd	ra,24(sp)
    800020d0:	e822                	sd	s0,16(sp)
    800020d2:	e426                	sd	s1,8(sp)
    800020d4:	1000                	addi	s0,sp,32
    800020d6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	eee080e7          	jalr	-274(ra) # 80001fc6 <argraw>
    800020e0:	c088                	sw	a0,0(s1)
}
    800020e2:	60e2                	ld	ra,24(sp)
    800020e4:	6442                	ld	s0,16(sp)
    800020e6:	64a2                	ld	s1,8(sp)
    800020e8:	6105                	addi	sp,sp,32
    800020ea:	8082                	ret

00000000800020ec <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    800020ec:	1101                	addi	sp,sp,-32
    800020ee:	ec06                	sd	ra,24(sp)
    800020f0:	e822                	sd	s0,16(sp)
    800020f2:	e426                	sd	s1,8(sp)
    800020f4:	1000                	addi	s0,sp,32
    800020f6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800020f8:	00000097          	auipc	ra,0x0
    800020fc:	ece080e7          	jalr	-306(ra) # 80001fc6 <argraw>
    80002100:	e088                	sd	a0,0(s1)
}
    80002102:	60e2                	ld	ra,24(sp)
    80002104:	6442                	ld	s0,16(sp)
    80002106:	64a2                	ld	s1,8(sp)
    80002108:	6105                	addi	sp,sp,32
    8000210a:	8082                	ret

000000008000210c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000210c:	7179                	addi	sp,sp,-48
    8000210e:	f406                	sd	ra,40(sp)
    80002110:	f022                	sd	s0,32(sp)
    80002112:	ec26                	sd	s1,24(sp)
    80002114:	e84a                	sd	s2,16(sp)
    80002116:	1800                	addi	s0,sp,48
    80002118:	84ae                	mv	s1,a1
    8000211a:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    8000211c:	fd840593          	addi	a1,s0,-40
    80002120:	00000097          	auipc	ra,0x0
    80002124:	fcc080e7          	jalr	-52(ra) # 800020ec <argaddr>
  return fetchstr(addr, buf, max);
    80002128:	864a                	mv	a2,s2
    8000212a:	85a6                	mv	a1,s1
    8000212c:	fd843503          	ld	a0,-40(s0)
    80002130:	00000097          	auipc	ra,0x0
    80002134:	f50080e7          	jalr	-176(ra) # 80002080 <fetchstr>
}
    80002138:	70a2                	ld	ra,40(sp)
    8000213a:	7402                	ld	s0,32(sp)
    8000213c:	64e2                	ld	s1,24(sp)
    8000213e:	6942                	ld	s2,16(sp)
    80002140:	6145                	addi	sp,sp,48
    80002142:	8082                	ret

0000000080002144 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80002144:	1101                	addi	sp,sp,-32
    80002146:	ec06                	sd	ra,24(sp)
    80002148:	e822                	sd	s0,16(sp)
    8000214a:	e426                	sd	s1,8(sp)
    8000214c:	e04a                	sd	s2,0(sp)
    8000214e:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002150:	fffff097          	auipc	ra,0xfffff
    80002154:	e68080e7          	jalr	-408(ra) # 80000fb8 <myproc>
    80002158:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000215a:	06053903          	ld	s2,96(a0)
    8000215e:	0a893783          	ld	a5,168(s2)
    80002162:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002166:	37fd                	addiw	a5,a5,-1
    80002168:	4751                	li	a4,20
    8000216a:	00f76f63          	bltu	a4,a5,80002188 <syscall+0x44>
    8000216e:	00369713          	slli	a4,a3,0x3
    80002172:	00006797          	auipc	a5,0x6
    80002176:	29e78793          	addi	a5,a5,670 # 80008410 <syscalls>
    8000217a:	97ba                	add	a5,a5,a4
    8000217c:	639c                	ld	a5,0(a5)
    8000217e:	c789                	beqz	a5,80002188 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80002180:	9782                	jalr	a5
    80002182:	06a93823          	sd	a0,112(s2)
    80002186:	a839                	j	800021a4 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002188:	16048613          	addi	a2,s1,352
    8000218c:	5c8c                	lw	a1,56(s1)
    8000218e:	00006517          	auipc	a0,0x6
    80002192:	24a50513          	addi	a0,a0,586 # 800083d8 <states.1739+0x150>
    80002196:	00004097          	auipc	ra,0x4
    8000219a:	08a080e7          	jalr	138(ra) # 80006220 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000219e:	70bc                	ld	a5,96(s1)
    800021a0:	577d                	li	a4,-1
    800021a2:	fbb8                	sd	a4,112(a5)
  }
}
    800021a4:	60e2                	ld	ra,24(sp)
    800021a6:	6442                	ld	s0,16(sp)
    800021a8:	64a2                	ld	s1,8(sp)
    800021aa:	6902                	ld	s2,0(sp)
    800021ac:	6105                	addi	sp,sp,32
    800021ae:	8082                	ret

00000000800021b0 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800021b0:	1101                	addi	sp,sp,-32
    800021b2:	ec06                	sd	ra,24(sp)
    800021b4:	e822                	sd	s0,16(sp)
    800021b6:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    800021b8:	fec40593          	addi	a1,s0,-20
    800021bc:	4501                	li	a0,0
    800021be:	00000097          	auipc	ra,0x0
    800021c2:	f0e080e7          	jalr	-242(ra) # 800020cc <argint>
  exit(n);
    800021c6:	fec42503          	lw	a0,-20(s0)
    800021ca:	fffff097          	auipc	ra,0xfffff
    800021ce:	5ca080e7          	jalr	1482(ra) # 80001794 <exit>
  return 0;  // not reached
}
    800021d2:	4501                	li	a0,0
    800021d4:	60e2                	ld	ra,24(sp)
    800021d6:	6442                	ld	s0,16(sp)
    800021d8:	6105                	addi	sp,sp,32
    800021da:	8082                	ret

00000000800021dc <sys_getpid>:

uint64
sys_getpid(void)
{
    800021dc:	1141                	addi	sp,sp,-16
    800021de:	e406                	sd	ra,8(sp)
    800021e0:	e022                	sd	s0,0(sp)
    800021e2:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800021e4:	fffff097          	auipc	ra,0xfffff
    800021e8:	dd4080e7          	jalr	-556(ra) # 80000fb8 <myproc>
}
    800021ec:	5d08                	lw	a0,56(a0)
    800021ee:	60a2                	ld	ra,8(sp)
    800021f0:	6402                	ld	s0,0(sp)
    800021f2:	0141                	addi	sp,sp,16
    800021f4:	8082                	ret

00000000800021f6 <sys_fork>:

uint64
sys_fork(void)
{
    800021f6:	1141                	addi	sp,sp,-16
    800021f8:	e406                	sd	ra,8(sp)
    800021fa:	e022                	sd	s0,0(sp)
    800021fc:	0800                	addi	s0,sp,16
  return fork();
    800021fe:	fffff097          	auipc	ra,0xfffff
    80002202:	174080e7          	jalr	372(ra) # 80001372 <fork>
}
    80002206:	60a2                	ld	ra,8(sp)
    80002208:	6402                	ld	s0,0(sp)
    8000220a:	0141                	addi	sp,sp,16
    8000220c:	8082                	ret

000000008000220e <sys_wait>:

uint64
sys_wait(void)
{
    8000220e:	1101                	addi	sp,sp,-32
    80002210:	ec06                	sd	ra,24(sp)
    80002212:	e822                	sd	s0,16(sp)
    80002214:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002216:	fe840593          	addi	a1,s0,-24
    8000221a:	4501                	li	a0,0
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	ed0080e7          	jalr	-304(ra) # 800020ec <argaddr>
  return wait(p);
    80002224:	fe843503          	ld	a0,-24(s0)
    80002228:	fffff097          	auipc	ra,0xfffff
    8000222c:	712080e7          	jalr	1810(ra) # 8000193a <wait>
}
    80002230:	60e2                	ld	ra,24(sp)
    80002232:	6442                	ld	s0,16(sp)
    80002234:	6105                	addi	sp,sp,32
    80002236:	8082                	ret

0000000080002238 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002238:	7179                	addi	sp,sp,-48
    8000223a:	f406                	sd	ra,40(sp)
    8000223c:	f022                	sd	s0,32(sp)
    8000223e:	ec26                	sd	s1,24(sp)
    80002240:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002242:	fdc40593          	addi	a1,s0,-36
    80002246:	4501                	li	a0,0
    80002248:	00000097          	auipc	ra,0x0
    8000224c:	e84080e7          	jalr	-380(ra) # 800020cc <argint>
  addr = myproc()->sz;
    80002250:	fffff097          	auipc	ra,0xfffff
    80002254:	d68080e7          	jalr	-664(ra) # 80000fb8 <myproc>
    80002258:	6924                	ld	s1,80(a0)
  if(growproc(n) < 0)
    8000225a:	fdc42503          	lw	a0,-36(s0)
    8000225e:	fffff097          	auipc	ra,0xfffff
    80002262:	0b8080e7          	jalr	184(ra) # 80001316 <growproc>
    80002266:	00054863          	bltz	a0,80002276 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    8000226a:	8526                	mv	a0,s1
    8000226c:	70a2                	ld	ra,40(sp)
    8000226e:	7402                	ld	s0,32(sp)
    80002270:	64e2                	ld	s1,24(sp)
    80002272:	6145                	addi	sp,sp,48
    80002274:	8082                	ret
    return -1;
    80002276:	54fd                	li	s1,-1
    80002278:	bfcd                	j	8000226a <sys_sbrk+0x32>

000000008000227a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000227a:	7139                	addi	sp,sp,-64
    8000227c:	fc06                	sd	ra,56(sp)
    8000227e:	f822                	sd	s0,48(sp)
    80002280:	f426                	sd	s1,40(sp)
    80002282:	f04a                	sd	s2,32(sp)
    80002284:	ec4e                	sd	s3,24(sp)
    80002286:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002288:	fcc40593          	addi	a1,s0,-52
    8000228c:	4501                	li	a0,0
    8000228e:	00000097          	auipc	ra,0x0
    80002292:	e3e080e7          	jalr	-450(ra) # 800020cc <argint>
  if(n < 0)
    80002296:	fcc42783          	lw	a5,-52(s0)
    8000229a:	0607cf63          	bltz	a5,80002318 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    8000229e:	0000d517          	auipc	a0,0xd
    800022a2:	8b250513          	addi	a0,a0,-1870 # 8000eb50 <tickslock>
    800022a6:	00004097          	auipc	ra,0x4
    800022aa:	464080e7          	jalr	1124(ra) # 8000670a <acquire>
  ticks0 = ticks;
    800022ae:	00006917          	auipc	s2,0x6
    800022b2:	70a92903          	lw	s2,1802(s2) # 800089b8 <ticks>
  while(ticks - ticks0 < n){
    800022b6:	fcc42783          	lw	a5,-52(s0)
    800022ba:	cf9d                	beqz	a5,800022f8 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800022bc:	0000d997          	auipc	s3,0xd
    800022c0:	89498993          	addi	s3,s3,-1900 # 8000eb50 <tickslock>
    800022c4:	00006497          	auipc	s1,0x6
    800022c8:	6f448493          	addi	s1,s1,1780 # 800089b8 <ticks>
    if(killed(myproc())){
    800022cc:	fffff097          	auipc	ra,0xfffff
    800022d0:	cec080e7          	jalr	-788(ra) # 80000fb8 <myproc>
    800022d4:	fffff097          	auipc	ra,0xfffff
    800022d8:	634080e7          	jalr	1588(ra) # 80001908 <killed>
    800022dc:	e129                	bnez	a0,8000231e <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    800022de:	85ce                	mv	a1,s3
    800022e0:	8526                	mv	a0,s1
    800022e2:	fffff097          	auipc	ra,0xfffff
    800022e6:	37e080e7          	jalr	894(ra) # 80001660 <sleep>
  while(ticks - ticks0 < n){
    800022ea:	409c                	lw	a5,0(s1)
    800022ec:	412787bb          	subw	a5,a5,s2
    800022f0:	fcc42703          	lw	a4,-52(s0)
    800022f4:	fce7ece3          	bltu	a5,a4,800022cc <sys_sleep+0x52>
  }
  release(&tickslock);
    800022f8:	0000d517          	auipc	a0,0xd
    800022fc:	85850513          	addi	a0,a0,-1960 # 8000eb50 <tickslock>
    80002300:	00004097          	auipc	ra,0x4
    80002304:	4da080e7          	jalr	1242(ra) # 800067da <release>
  return 0;
    80002308:	4501                	li	a0,0
}
    8000230a:	70e2                	ld	ra,56(sp)
    8000230c:	7442                	ld	s0,48(sp)
    8000230e:	74a2                	ld	s1,40(sp)
    80002310:	7902                	ld	s2,32(sp)
    80002312:	69e2                	ld	s3,24(sp)
    80002314:	6121                	addi	sp,sp,64
    80002316:	8082                	ret
    n = 0;
    80002318:	fc042623          	sw	zero,-52(s0)
    8000231c:	b749                	j	8000229e <sys_sleep+0x24>
      release(&tickslock);
    8000231e:	0000d517          	auipc	a0,0xd
    80002322:	83250513          	addi	a0,a0,-1998 # 8000eb50 <tickslock>
    80002326:	00004097          	auipc	ra,0x4
    8000232a:	4b4080e7          	jalr	1204(ra) # 800067da <release>
      return -1;
    8000232e:	557d                	li	a0,-1
    80002330:	bfe9                	j	8000230a <sys_sleep+0x90>

0000000080002332 <sys_kill>:

uint64
sys_kill(void)
{
    80002332:	1101                	addi	sp,sp,-32
    80002334:	ec06                	sd	ra,24(sp)
    80002336:	e822                	sd	s0,16(sp)
    80002338:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    8000233a:	fec40593          	addi	a1,s0,-20
    8000233e:	4501                	li	a0,0
    80002340:	00000097          	auipc	ra,0x0
    80002344:	d8c080e7          	jalr	-628(ra) # 800020cc <argint>
  return kill(pid);
    80002348:	fec42503          	lw	a0,-20(s0)
    8000234c:	fffff097          	auipc	ra,0xfffff
    80002350:	51e080e7          	jalr	1310(ra) # 8000186a <kill>
}
    80002354:	60e2                	ld	ra,24(sp)
    80002356:	6442                	ld	s0,16(sp)
    80002358:	6105                	addi	sp,sp,32
    8000235a:	8082                	ret

000000008000235c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000235c:	1101                	addi	sp,sp,-32
    8000235e:	ec06                	sd	ra,24(sp)
    80002360:	e822                	sd	s0,16(sp)
    80002362:	e426                	sd	s1,8(sp)
    80002364:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002366:	0000c517          	auipc	a0,0xc
    8000236a:	7ea50513          	addi	a0,a0,2026 # 8000eb50 <tickslock>
    8000236e:	00004097          	auipc	ra,0x4
    80002372:	39c080e7          	jalr	924(ra) # 8000670a <acquire>
  xticks = ticks;
    80002376:	00006497          	auipc	s1,0x6
    8000237a:	6424a483          	lw	s1,1602(s1) # 800089b8 <ticks>
  release(&tickslock);
    8000237e:	0000c517          	auipc	a0,0xc
    80002382:	7d250513          	addi	a0,a0,2002 # 8000eb50 <tickslock>
    80002386:	00004097          	auipc	ra,0x4
    8000238a:	454080e7          	jalr	1108(ra) # 800067da <release>
  return xticks;
}
    8000238e:	02049513          	slli	a0,s1,0x20
    80002392:	9101                	srli	a0,a0,0x20
    80002394:	60e2                	ld	ra,24(sp)
    80002396:	6442                	ld	s0,16(sp)
    80002398:	64a2                	ld	s1,8(sp)
    8000239a:	6105                	addi	sp,sp,32
    8000239c:	8082                	ret

000000008000239e <hash>:
  struct buf buckets[NBUCKET];
} bcache;

int 
hash(int n)
{
    8000239e:	1141                	addi	sp,sp,-16
    800023a0:	e422                	sd	s0,8(sp)
    800023a2:	0800                	addi	s0,sp,16
  return n % NBUCKET;
}
    800023a4:	47b5                	li	a5,13
    800023a6:	02f5653b          	remw	a0,a0,a5
    800023aa:	6422                	ld	s0,8(sp)
    800023ac:	0141                	addi	sp,sp,16
    800023ae:	8082                	ret

00000000800023b0 <binit>:

void
binit(void)
{
    800023b0:	711d                	addi	sp,sp,-96
    800023b2:	ec86                	sd	ra,88(sp)
    800023b4:	e8a2                	sd	s0,80(sp)
    800023b6:	e4a6                	sd	s1,72(sp)
    800023b8:	e0ca                	sd	s2,64(sp)
    800023ba:	fc4e                	sd	s3,56(sp)
    800023bc:	f852                	sd	s4,48(sp)
    800023be:	f456                	sd	s5,40(sp)
    800023c0:	f05a                	sd	s6,32(sp)
    800023c2:	ec5e                	sd	s7,24(sp)
    800023c4:	e862                	sd	s8,16(sp)
    800023c6:	e466                	sd	s9,8(sp)
    800023c8:	1080                	addi	s0,sp,96
  struct buf *b;

  int i;
  for(i=0;i<NBUCKET;++i){
    800023ca:	0000c917          	auipc	s2,0xc
    800023ce:	7a690913          	addi	s2,s2,1958 # 8000eb70 <bcache>
    800023d2:	00015497          	auipc	s1,0x15
    800023d6:	c7e48493          	addi	s1,s1,-898 # 80017050 <bcache+0x84e0>
    800023da:	00018a17          	auipc	s4,0x18
    800023de:	556a0a13          	addi	s4,s4,1366 # 8001a930 <sb>
    initlock(&bcache.lock[i], "bcache");
    800023e2:	00006997          	auipc	s3,0x6
    800023e6:	0de98993          	addi	s3,s3,222 # 800084c0 <syscalls+0xb0>
    800023ea:	85ce                	mv	a1,s3
    800023ec:	854a                	mv	a0,s2
    800023ee:	00004097          	auipc	ra,0x4
    800023f2:	498080e7          	jalr	1176(ra) # 80006886 <initlock>
    bcache.buckets[i].prev = &bcache.buckets[i];
    800023f6:	e8a4                	sd	s1,80(s1)
    bcache.buckets[i].next = &bcache.buckets[i];
    800023f8:	eca4                	sd	s1,88(s1)
  for(i=0;i<NBUCKET;++i){
    800023fa:	02090913          	addi	s2,s2,32
    800023fe:	46048493          	addi	s1,s1,1120
    80002402:	ff4494e3          	bne	s1,s4,800023ea <binit+0x3a>
  }

  // Create linked list of buffers
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002406:	0000d917          	auipc	s2,0xd
    8000240a:	90a90913          	addi	s2,s2,-1782 # 8000ed10 <bcache+0x1a0>
  return n % NBUCKET;
    8000240e:	4cb5                	li	s9,13
    int id = hash(b->blockno);
    b->prev = &bcache.buckets[id];
    80002410:	46000c13          	li	s8,1120
    80002414:	6a21                	lui	s4,0x8
    80002416:	4e0a0b93          	addi	s7,s4,1248 # 84e0 <_entry-0x7fff7b20>
    8000241a:	0000c997          	auipc	s3,0xc
    8000241e:	75698993          	addi	s3,s3,1878 # 8000eb70 <bcache>
    b->next = bcache.buckets[id].next;
    initsleeplock(&b->lock, "buffer");
    80002422:	00006b17          	auipc	s6,0x6
    80002426:	0a6b0b13          	addi	s6,s6,166 # 800084c8 <syscalls+0xb8>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000242a:	00015a97          	auipc	s5,0x15
    8000242e:	c26a8a93          	addi	s5,s5,-986 # 80017050 <bcache+0x84e0>
  return n % NBUCKET;
    80002432:	00c92483          	lw	s1,12(s2)
    80002436:	0394e4bb          	remw	s1,s1,s9
    b->prev = &bcache.buckets[id];
    8000243a:	038484b3          	mul	s1,s1,s8
    8000243e:	017487b3          	add	a5,s1,s7
    80002442:	97ce                	add	a5,a5,s3
    80002444:	04f93823          	sd	a5,80(s2)
    b->next = bcache.buckets[id].next;
    80002448:	94ce                	add	s1,s1,s3
    8000244a:	94d2                	add	s1,s1,s4
    8000244c:	5384b783          	ld	a5,1336(s1)
    80002450:	04f93c23          	sd	a5,88(s2)
    initsleeplock(&b->lock, "buffer");
    80002454:	85da                	mv	a1,s6
    80002456:	01090513          	addi	a0,s2,16
    8000245a:	00001097          	auipc	ra,0x1
    8000245e:	5c0080e7          	jalr	1472(ra) # 80003a1a <initsleeplock>
    bcache.buckets[id].next->prev = b;
    80002462:	5384b783          	ld	a5,1336(s1)
    80002466:	0527b823          	sd	s2,80(a5)
    bcache.buckets[id].next = b;
    8000246a:	5324bc23          	sd	s2,1336(s1)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000246e:	46090913          	addi	s2,s2,1120
    80002472:	fd5910e3          	bne	s2,s5,80002432 <binit+0x82>
  }
}
    80002476:	60e6                	ld	ra,88(sp)
    80002478:	6446                	ld	s0,80(sp)
    8000247a:	64a6                	ld	s1,72(sp)
    8000247c:	6906                	ld	s2,64(sp)
    8000247e:	79e2                	ld	s3,56(sp)
    80002480:	7a42                	ld	s4,48(sp)
    80002482:	7aa2                	ld	s5,40(sp)
    80002484:	7b02                	ld	s6,32(sp)
    80002486:	6be2                	ld	s7,24(sp)
    80002488:	6c42                	ld	s8,16(sp)
    8000248a:	6ca2                	ld	s9,8(sp)
    8000248c:	6125                	addi	sp,sp,96
    8000248e:	8082                	ret

0000000080002490 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002490:	711d                	addi	sp,sp,-96
    80002492:	ec86                	sd	ra,88(sp)
    80002494:	e8a2                	sd	s0,80(sp)
    80002496:	e4a6                	sd	s1,72(sp)
    80002498:	e0ca                	sd	s2,64(sp)
    8000249a:	fc4e                	sd	s3,56(sp)
    8000249c:	f852                	sd	s4,48(sp)
    8000249e:	f456                	sd	s5,40(sp)
    800024a0:	f05a                	sd	s6,32(sp)
    800024a2:	ec5e                	sd	s7,24(sp)
    800024a4:	e862                	sd	s8,16(sp)
    800024a6:	e466                	sd	s9,8(sp)
    800024a8:	e06a                	sd	s10,0(sp)
    800024aa:	1080                	addi	s0,sp,96
    800024ac:	8b2a                	mv	s6,a0
    800024ae:	8aae                	mv	s5,a1
  return n % NBUCKET;
    800024b0:	49b5                	li	s3,13
    800024b2:	0335e9bb          	remw	s3,a1,s3
  acquire(&bcache.lock[id]);
    800024b6:	00599a13          	slli	s4,s3,0x5
    800024ba:	0000cb97          	auipc	s7,0xc
    800024be:	6b6b8b93          	addi	s7,s7,1718 # 8000eb70 <bcache>
    800024c2:	9a5e                	add	s4,s4,s7
    800024c4:	8552                	mv	a0,s4
    800024c6:	00004097          	auipc	ra,0x4
    800024ca:	244080e7          	jalr	580(ra) # 8000670a <acquire>
  for(b = bcache.buckets[id].next; b != &bcache.buckets[id]; b = b->next){
    800024ce:	46000793          	li	a5,1120
    800024d2:	02f987b3          	mul	a5,s3,a5
    800024d6:	00fb86b3          	add	a3,s7,a5
    800024da:	6721                	lui	a4,0x8
    800024dc:	96ba                	add	a3,a3,a4
    800024de:	5386b483          	ld	s1,1336(a3)
    800024e2:	4e070913          	addi	s2,a4,1248 # 84e0 <_entry-0x7fff7b20>
    800024e6:	97ca                	add	a5,a5,s2
    800024e8:	01778933          	add	s2,a5,s7
    800024ec:	03249563          	bne	s1,s2,80002516 <bread+0x86>
  release(&bcache.lock[id]);
    800024f0:	8552                	mv	a0,s4
    800024f2:	00004097          	auipc	ra,0x4
    800024f6:	2e8080e7          	jalr	744(ra) # 800067da <release>
  for(i = 0; i < NBUCKET; ++i){
    800024fa:	0000cc17          	auipc	s8,0xc
    800024fe:	676c0c13          	addi	s8,s8,1654 # 8000eb70 <bcache>
    80002502:	00015a17          	auipc	s4,0x15
    80002506:	b4ea0a13          	addi	s4,s4,-1202 # 80017050 <bcache+0x84e0>
    8000250a:	4b81                	li	s7,0
    8000250c:	4d35                	li	s10,13
    8000250e:	a0d1                	j	800025d2 <bread+0x142>
  for(b = bcache.buckets[id].next; b != &bcache.buckets[id]; b = b->next){
    80002510:	6ca4                	ld	s1,88(s1)
    80002512:	fd248fe3          	beq	s1,s2,800024f0 <bread+0x60>
    if(b->dev == dev && b->blockno == blockno){
    80002516:	449c                	lw	a5,8(s1)
    80002518:	ff679ce3          	bne	a5,s6,80002510 <bread+0x80>
    8000251c:	44dc                	lw	a5,12(s1)
    8000251e:	ff5799e3          	bne	a5,s5,80002510 <bread+0x80>
      b->refcnt++;
    80002522:	44bc                	lw	a5,72(s1)
    80002524:	2785                	addiw	a5,a5,1
    80002526:	c4bc                	sw	a5,72(s1)
      release(&bcache.lock[id]);
    80002528:	8552                	mv	a0,s4
    8000252a:	00004097          	auipc	ra,0x4
    8000252e:	2b0080e7          	jalr	688(ra) # 800067da <release>
      acquiresleep(&b->lock);
    80002532:	01048513          	addi	a0,s1,16
    80002536:	00001097          	auipc	ra,0x1
    8000253a:	51e080e7          	jalr	1310(ra) # 80003a54 <acquiresleep>
      return b;
    8000253e:	a8a9                	j	80002598 <bread+0x108>
        b->dev = dev;
    80002540:	0164a423          	sw	s6,8(s1)
        b->blockno = blockno;
    80002544:	0154a623          	sw	s5,12(s1)
        b->valid = 0;
    80002548:	0004a023          	sw	zero,0(s1)
        b->refcnt = 1;
    8000254c:	4785                	li	a5,1
    8000254e:	c4bc                	sw	a5,72(s1)
        b->prev->next = b->next;
    80002550:	68bc                	ld	a5,80(s1)
    80002552:	6cb8                	ld	a4,88(s1)
    80002554:	efb8                	sd	a4,88(a5)
        b->next->prev = b->prev;
    80002556:	6cbc                	ld	a5,88(s1)
    80002558:	68b8                	ld	a4,80(s1)
    8000255a:	ebb8                	sd	a4,80(a5)
        b->prev = &bcache.buckets[id];
    8000255c:	0524b823          	sd	s2,80(s1)
    	b->next = bcache.buckets[id].next;
    80002560:	46000793          	li	a5,1120
    80002564:	02f989b3          	mul	s3,s3,a5
    80002568:	0000c797          	auipc	a5,0xc
    8000256c:	60878793          	addi	a5,a5,1544 # 8000eb70 <bcache>
    80002570:	97ce                	add	a5,a5,s3
    80002572:	69a1                	lui	s3,0x8
    80002574:	99be                	add	s3,s3,a5
    80002576:	5389b783          	ld	a5,1336(s3) # 8538 <_entry-0x7fff7ac8>
    8000257a:	ecbc                	sd	a5,88(s1)
  	  	bcache.buckets[id].next->prev = b;
    8000257c:	eba4                	sd	s1,80(a5)
  	 	bcache.buckets[id].next = b;
    8000257e:	5299bc23          	sd	s1,1336(s3)
        release(&bcache.lock[i]);
    80002582:	8566                	mv	a0,s9
    80002584:	00004097          	auipc	ra,0x4
    80002588:	256080e7          	jalr	598(ra) # 800067da <release>
        acquiresleep(&b->lock);
    8000258c:	01048513          	addi	a0,s1,16
    80002590:	00001097          	auipc	ra,0x1
    80002594:	4c4080e7          	jalr	1220(ra) # 80003a54 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002598:	409c                	lw	a5,0(s1)
    8000259a:	c7bd                	beqz	a5,80002608 <bread+0x178>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000259c:	8526                	mv	a0,s1
    8000259e:	60e6                	ld	ra,88(sp)
    800025a0:	6446                	ld	s0,80(sp)
    800025a2:	64a6                	ld	s1,72(sp)
    800025a4:	6906                	ld	s2,64(sp)
    800025a6:	79e2                	ld	s3,56(sp)
    800025a8:	7a42                	ld	s4,48(sp)
    800025aa:	7aa2                	ld	s5,40(sp)
    800025ac:	7b02                	ld	s6,32(sp)
    800025ae:	6be2                	ld	s7,24(sp)
    800025b0:	6c42                	ld	s8,16(sp)
    800025b2:	6ca2                	ld	s9,8(sp)
    800025b4:	6d02                	ld	s10,0(sp)
    800025b6:	6125                	addi	sp,sp,96
    800025b8:	8082                	ret
    release(&bcache.lock[i]);
    800025ba:	8566                	mv	a0,s9
    800025bc:	00004097          	auipc	ra,0x4
    800025c0:	21e080e7          	jalr	542(ra) # 800067da <release>
  for(i = 0; i < NBUCKET; ++i){
    800025c4:	2b85                	addiw	s7,s7,1
    800025c6:	020c0c13          	addi	s8,s8,32
    800025ca:	460a0a13          	addi	s4,s4,1120
    800025ce:	03ab8563          	beq	s7,s10,800025f8 <bread+0x168>
    if(i == id)
    800025d2:	ff7989e3          	beq	s3,s7,800025c4 <bread+0x134>
    acquire(&bcache.lock[i]);
    800025d6:	8ce2                	mv	s9,s8
    800025d8:	8562                	mv	a0,s8
    800025da:	00004097          	auipc	ra,0x4
    800025de:	130080e7          	jalr	304(ra) # 8000670a <acquire>
    for(b = bcache.buckets[i].prev; b != &bcache.buckets[i]; b = b->prev){
    800025e2:	87d2                	mv	a5,s4
    800025e4:	050a3483          	ld	s1,80(s4)
    800025e8:	fd4489e3          	beq	s1,s4,800025ba <bread+0x12a>
      if(b->refcnt == 0) {
    800025ec:	44b8                	lw	a4,72(s1)
    800025ee:	db29                	beqz	a4,80002540 <bread+0xb0>
    for(b = bcache.buckets[i].prev; b != &bcache.buckets[i]; b = b->prev){
    800025f0:	68a4                	ld	s1,80(s1)
    800025f2:	fef49de3          	bne	s1,a5,800025ec <bread+0x15c>
    800025f6:	b7d1                	j	800025ba <bread+0x12a>
  panic("bget: no buffers");
    800025f8:	00006517          	auipc	a0,0x6
    800025fc:	ed850513          	addi	a0,a0,-296 # 800084d0 <syscalls+0xc0>
    80002600:	00004097          	auipc	ra,0x4
    80002604:	bd6080e7          	jalr	-1066(ra) # 800061d6 <panic>
    virtio_disk_rw(b, 0);
    80002608:	4581                	li	a1,0
    8000260a:	8526                	mv	a0,s1
    8000260c:	00003097          	auipc	ra,0x3
    80002610:	02c080e7          	jalr	44(ra) # 80005638 <virtio_disk_rw>
    b->valid = 1;
    80002614:	4785                	li	a5,1
    80002616:	c09c                	sw	a5,0(s1)
  return b;
    80002618:	b751                	j	8000259c <bread+0x10c>

000000008000261a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000261a:	1101                	addi	sp,sp,-32
    8000261c:	ec06                	sd	ra,24(sp)
    8000261e:	e822                	sd	s0,16(sp)
    80002620:	e426                	sd	s1,8(sp)
    80002622:	1000                	addi	s0,sp,32
    80002624:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002626:	0541                	addi	a0,a0,16
    80002628:	00001097          	auipc	ra,0x1
    8000262c:	4c6080e7          	jalr	1222(ra) # 80003aee <holdingsleep>
    80002630:	cd01                	beqz	a0,80002648 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002632:	4585                	li	a1,1
    80002634:	8526                	mv	a0,s1
    80002636:	00003097          	auipc	ra,0x3
    8000263a:	002080e7          	jalr	2(ra) # 80005638 <virtio_disk_rw>
}
    8000263e:	60e2                	ld	ra,24(sp)
    80002640:	6442                	ld	s0,16(sp)
    80002642:	64a2                	ld	s1,8(sp)
    80002644:	6105                	addi	sp,sp,32
    80002646:	8082                	ret
    panic("bwrite");
    80002648:	00006517          	auipc	a0,0x6
    8000264c:	ea050513          	addi	a0,a0,-352 # 800084e8 <syscalls+0xd8>
    80002650:	00004097          	auipc	ra,0x4
    80002654:	b86080e7          	jalr	-1146(ra) # 800061d6 <panic>

0000000080002658 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002658:	7179                	addi	sp,sp,-48
    8000265a:	f406                	sd	ra,40(sp)
    8000265c:	f022                	sd	s0,32(sp)
    8000265e:	ec26                	sd	s1,24(sp)
    80002660:	e84a                	sd	s2,16(sp)
    80002662:	e44e                	sd	s3,8(sp)
    80002664:	1800                	addi	s0,sp,48
    80002666:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002668:	01050913          	addi	s2,a0,16
    8000266c:	854a                	mv	a0,s2
    8000266e:	00001097          	auipc	ra,0x1
    80002672:	480080e7          	jalr	1152(ra) # 80003aee <holdingsleep>
    80002676:	c951                	beqz	a0,8000270a <brelse+0xb2>
    panic("brelse");

  releasesleep(&b->lock);
    80002678:	854a                	mv	a0,s2
    8000267a:	00001097          	auipc	ra,0x1
    8000267e:	430080e7          	jalr	1072(ra) # 80003aaa <releasesleep>
  return n % NBUCKET;
    80002682:	00c4a903          	lw	s2,12(s1)
    80002686:	47b5                	li	a5,13
    80002688:	02f9693b          	remw	s2,s2,a5

  int id = hash(b->blockno);
  
  acquire(&bcache.lock[id]);
    8000268c:	00591993          	slli	s3,s2,0x5
    80002690:	0000c797          	auipc	a5,0xc
    80002694:	4e078793          	addi	a5,a5,1248 # 8000eb70 <bcache>
    80002698:	99be                	add	s3,s3,a5
    8000269a:	854e                	mv	a0,s3
    8000269c:	00004097          	auipc	ra,0x4
    800026a0:	06e080e7          	jalr	110(ra) # 8000670a <acquire>
  b->refcnt--;
    800026a4:	44bc                	lw	a5,72(s1)
    800026a6:	37fd                	addiw	a5,a5,-1
    800026a8:	0007871b          	sext.w	a4,a5
    800026ac:	c4bc                	sw	a5,72(s1)
  if (b->refcnt == 0) {
    800026ae:	e331                	bnez	a4,800026f2 <brelse+0x9a>
    // no one is waiting for it.
    // pop
    b->next->prev = b->prev;
    800026b0:	6cbc                	ld	a5,88(s1)
    800026b2:	68b8                	ld	a4,80(s1)
    800026b4:	ebb8                	sd	a4,80(a5)
    b->prev->next = b->next;
    800026b6:	68bc                	ld	a5,80(s1)
    800026b8:	6cb8                	ld	a4,88(s1)
    800026ba:	efb8                	sd	a4,88(a5)
    
    // push
    b->next = bcache.buckets[id].next;
    800026bc:	0000c697          	auipc	a3,0xc
    800026c0:	4b468693          	addi	a3,a3,1204 # 8000eb70 <bcache>
    800026c4:	46000613          	li	a2,1120
    800026c8:	02c907b3          	mul	a5,s2,a2
    800026cc:	97b6                	add	a5,a5,a3
    800026ce:	6721                	lui	a4,0x8
    800026d0:	97ba                	add	a5,a5,a4
    800026d2:	5387b583          	ld	a1,1336(a5)
    800026d6:	ecac                	sd	a1,88(s1)
    b->prev = &bcache.buckets[id];
    800026d8:	02c90933          	mul	s2,s2,a2
    800026dc:	4e070713          	addi	a4,a4,1248 # 84e0 <_entry-0x7fff7b20>
    800026e0:	993a                	add	s2,s2,a4
    800026e2:	9936                	add	s2,s2,a3
    800026e4:	0524b823          	sd	s2,80(s1)
    bcache.buckets[id].next->prev = b;
    800026e8:	5387b703          	ld	a4,1336(a5)
    800026ec:	eb24                	sd	s1,80(a4)
    bcache.buckets[id].next = b;
    800026ee:	5297bc23          	sd	s1,1336(a5)
  }
  
  release(&bcache.lock[id]);
    800026f2:	854e                	mv	a0,s3
    800026f4:	00004097          	auipc	ra,0x4
    800026f8:	0e6080e7          	jalr	230(ra) # 800067da <release>
}
    800026fc:	70a2                	ld	ra,40(sp)
    800026fe:	7402                	ld	s0,32(sp)
    80002700:	64e2                	ld	s1,24(sp)
    80002702:	6942                	ld	s2,16(sp)
    80002704:	69a2                	ld	s3,8(sp)
    80002706:	6145                	addi	sp,sp,48
    80002708:	8082                	ret
    panic("brelse");
    8000270a:	00006517          	auipc	a0,0x6
    8000270e:	de650513          	addi	a0,a0,-538 # 800084f0 <syscalls+0xe0>
    80002712:	00004097          	auipc	ra,0x4
    80002716:	ac4080e7          	jalr	-1340(ra) # 800061d6 <panic>

000000008000271a <bpin>:

void
bpin(struct buf *b) {
    8000271a:	1101                	addi	sp,sp,-32
    8000271c:	ec06                	sd	ra,24(sp)
    8000271e:	e822                	sd	s0,16(sp)
    80002720:	e426                	sd	s1,8(sp)
    80002722:	e04a                	sd	s2,0(sp)
    80002724:	1000                	addi	s0,sp,32
    80002726:	892a                	mv	s2,a0
  return n % NBUCKET;
    80002728:	4544                	lw	s1,12(a0)
  int id = hash(b->blockno);
  acquire(&bcache.lock[id]);
    8000272a:	47b5                	li	a5,13
    8000272c:	02f4e4bb          	remw	s1,s1,a5
    80002730:	0496                	slli	s1,s1,0x5
    80002732:	0000c797          	auipc	a5,0xc
    80002736:	43e78793          	addi	a5,a5,1086 # 8000eb70 <bcache>
    8000273a:	94be                	add	s1,s1,a5
    8000273c:	8526                	mv	a0,s1
    8000273e:	00004097          	auipc	ra,0x4
    80002742:	fcc080e7          	jalr	-52(ra) # 8000670a <acquire>
  b->refcnt++;
    80002746:	04892783          	lw	a5,72(s2)
    8000274a:	2785                	addiw	a5,a5,1
    8000274c:	04f92423          	sw	a5,72(s2)
  release(&bcache.lock[id]);
    80002750:	8526                	mv	a0,s1
    80002752:	00004097          	auipc	ra,0x4
    80002756:	088080e7          	jalr	136(ra) # 800067da <release>
}
    8000275a:	60e2                	ld	ra,24(sp)
    8000275c:	6442                	ld	s0,16(sp)
    8000275e:	64a2                	ld	s1,8(sp)
    80002760:	6902                	ld	s2,0(sp)
    80002762:	6105                	addi	sp,sp,32
    80002764:	8082                	ret

0000000080002766 <bunpin>:

void
bunpin(struct buf *b) {
    80002766:	1101                	addi	sp,sp,-32
    80002768:	ec06                	sd	ra,24(sp)
    8000276a:	e822                	sd	s0,16(sp)
    8000276c:	e426                	sd	s1,8(sp)
    8000276e:	e04a                	sd	s2,0(sp)
    80002770:	1000                	addi	s0,sp,32
    80002772:	892a                	mv	s2,a0
  return n % NBUCKET;
    80002774:	4544                	lw	s1,12(a0)
  int id = hash(b->blockno);
  acquire(&bcache.lock[id]);
    80002776:	47b5                	li	a5,13
    80002778:	02f4e4bb          	remw	s1,s1,a5
    8000277c:	0496                	slli	s1,s1,0x5
    8000277e:	0000c797          	auipc	a5,0xc
    80002782:	3f278793          	addi	a5,a5,1010 # 8000eb70 <bcache>
    80002786:	94be                	add	s1,s1,a5
    80002788:	8526                	mv	a0,s1
    8000278a:	00004097          	auipc	ra,0x4
    8000278e:	f80080e7          	jalr	-128(ra) # 8000670a <acquire>
  b->refcnt--;
    80002792:	04892783          	lw	a5,72(s2)
    80002796:	37fd                	addiw	a5,a5,-1
    80002798:	04f92423          	sw	a5,72(s2)
  release(&bcache.lock[id]);
    8000279c:	8526                	mv	a0,s1
    8000279e:	00004097          	auipc	ra,0x4
    800027a2:	03c080e7          	jalr	60(ra) # 800067da <release>
}
    800027a6:	60e2                	ld	ra,24(sp)
    800027a8:	6442                	ld	s0,16(sp)
    800027aa:	64a2                	ld	s1,8(sp)
    800027ac:	6902                	ld	s2,0(sp)
    800027ae:	6105                	addi	sp,sp,32
    800027b0:	8082                	ret

00000000800027b2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800027b2:	1101                	addi	sp,sp,-32
    800027b4:	ec06                	sd	ra,24(sp)
    800027b6:	e822                	sd	s0,16(sp)
    800027b8:	e426                	sd	s1,8(sp)
    800027ba:	e04a                	sd	s2,0(sp)
    800027bc:	1000                	addi	s0,sp,32
    800027be:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800027c0:	00d5d59b          	srliw	a1,a1,0xd
    800027c4:	00018797          	auipc	a5,0x18
    800027c8:	1887a783          	lw	a5,392(a5) # 8001a94c <sb+0x1c>
    800027cc:	9dbd                	addw	a1,a1,a5
    800027ce:	00000097          	auipc	ra,0x0
    800027d2:	cc2080e7          	jalr	-830(ra) # 80002490 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800027d6:	0074f713          	andi	a4,s1,7
    800027da:	4785                	li	a5,1
    800027dc:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800027e0:	14ce                	slli	s1,s1,0x33
    800027e2:	90d9                	srli	s1,s1,0x36
    800027e4:	00950733          	add	a4,a0,s1
    800027e8:	06074703          	lbu	a4,96(a4)
    800027ec:	00e7f6b3          	and	a3,a5,a4
    800027f0:	c69d                	beqz	a3,8000281e <bfree+0x6c>
    800027f2:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800027f4:	94aa                	add	s1,s1,a0
    800027f6:	fff7c793          	not	a5,a5
    800027fa:	8ff9                	and	a5,a5,a4
    800027fc:	06f48023          	sb	a5,96(s1)
  log_write(bp);
    80002800:	00001097          	auipc	ra,0x1
    80002804:	134080e7          	jalr	308(ra) # 80003934 <log_write>
  brelse(bp);
    80002808:	854a                	mv	a0,s2
    8000280a:	00000097          	auipc	ra,0x0
    8000280e:	e4e080e7          	jalr	-434(ra) # 80002658 <brelse>
}
    80002812:	60e2                	ld	ra,24(sp)
    80002814:	6442                	ld	s0,16(sp)
    80002816:	64a2                	ld	s1,8(sp)
    80002818:	6902                	ld	s2,0(sp)
    8000281a:	6105                	addi	sp,sp,32
    8000281c:	8082                	ret
    panic("freeing free block");
    8000281e:	00006517          	auipc	a0,0x6
    80002822:	cda50513          	addi	a0,a0,-806 # 800084f8 <syscalls+0xe8>
    80002826:	00004097          	auipc	ra,0x4
    8000282a:	9b0080e7          	jalr	-1616(ra) # 800061d6 <panic>

000000008000282e <balloc>:
{
    8000282e:	711d                	addi	sp,sp,-96
    80002830:	ec86                	sd	ra,88(sp)
    80002832:	e8a2                	sd	s0,80(sp)
    80002834:	e4a6                	sd	s1,72(sp)
    80002836:	e0ca                	sd	s2,64(sp)
    80002838:	fc4e                	sd	s3,56(sp)
    8000283a:	f852                	sd	s4,48(sp)
    8000283c:	f456                	sd	s5,40(sp)
    8000283e:	f05a                	sd	s6,32(sp)
    80002840:	ec5e                	sd	s7,24(sp)
    80002842:	e862                	sd	s8,16(sp)
    80002844:	e466                	sd	s9,8(sp)
    80002846:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002848:	00018797          	auipc	a5,0x18
    8000284c:	0ec7a783          	lw	a5,236(a5) # 8001a934 <sb+0x4>
    80002850:	10078163          	beqz	a5,80002952 <balloc+0x124>
    80002854:	8baa                	mv	s7,a0
    80002856:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002858:	00018b17          	auipc	s6,0x18
    8000285c:	0d8b0b13          	addi	s6,s6,216 # 8001a930 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002860:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80002862:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002864:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002866:	6c89                	lui	s9,0x2
    80002868:	a061                	j	800028f0 <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000286a:	974a                	add	a4,a4,s2
    8000286c:	8fd5                	or	a5,a5,a3
    8000286e:	06f70023          	sb	a5,96(a4)
        log_write(bp);
    80002872:	854a                	mv	a0,s2
    80002874:	00001097          	auipc	ra,0x1
    80002878:	0c0080e7          	jalr	192(ra) # 80003934 <log_write>
        brelse(bp);
    8000287c:	854a                	mv	a0,s2
    8000287e:	00000097          	auipc	ra,0x0
    80002882:	dda080e7          	jalr	-550(ra) # 80002658 <brelse>
  bp = bread(dev, bno);
    80002886:	85a6                	mv	a1,s1
    80002888:	855e                	mv	a0,s7
    8000288a:	00000097          	auipc	ra,0x0
    8000288e:	c06080e7          	jalr	-1018(ra) # 80002490 <bread>
    80002892:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002894:	40000613          	li	a2,1024
    80002898:	4581                	li	a1,0
    8000289a:	06050513          	addi	a0,a0,96
    8000289e:	ffffe097          	auipc	ra,0xffffe
    800028a2:	9d2080e7          	jalr	-1582(ra) # 80000270 <memset>
  log_write(bp);
    800028a6:	854a                	mv	a0,s2
    800028a8:	00001097          	auipc	ra,0x1
    800028ac:	08c080e7          	jalr	140(ra) # 80003934 <log_write>
  brelse(bp);
    800028b0:	854a                	mv	a0,s2
    800028b2:	00000097          	auipc	ra,0x0
    800028b6:	da6080e7          	jalr	-602(ra) # 80002658 <brelse>
}
    800028ba:	8526                	mv	a0,s1
    800028bc:	60e6                	ld	ra,88(sp)
    800028be:	6446                	ld	s0,80(sp)
    800028c0:	64a6                	ld	s1,72(sp)
    800028c2:	6906                	ld	s2,64(sp)
    800028c4:	79e2                	ld	s3,56(sp)
    800028c6:	7a42                	ld	s4,48(sp)
    800028c8:	7aa2                	ld	s5,40(sp)
    800028ca:	7b02                	ld	s6,32(sp)
    800028cc:	6be2                	ld	s7,24(sp)
    800028ce:	6c42                	ld	s8,16(sp)
    800028d0:	6ca2                	ld	s9,8(sp)
    800028d2:	6125                	addi	sp,sp,96
    800028d4:	8082                	ret
    brelse(bp);
    800028d6:	854a                	mv	a0,s2
    800028d8:	00000097          	auipc	ra,0x0
    800028dc:	d80080e7          	jalr	-640(ra) # 80002658 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800028e0:	015c87bb          	addw	a5,s9,s5
    800028e4:	00078a9b          	sext.w	s5,a5
    800028e8:	004b2703          	lw	a4,4(s6)
    800028ec:	06eaf363          	bgeu	s5,a4,80002952 <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    800028f0:	41fad79b          	sraiw	a5,s5,0x1f
    800028f4:	0137d79b          	srliw	a5,a5,0x13
    800028f8:	015787bb          	addw	a5,a5,s5
    800028fc:	40d7d79b          	sraiw	a5,a5,0xd
    80002900:	01cb2583          	lw	a1,28(s6)
    80002904:	9dbd                	addw	a1,a1,a5
    80002906:	855e                	mv	a0,s7
    80002908:	00000097          	auipc	ra,0x0
    8000290c:	b88080e7          	jalr	-1144(ra) # 80002490 <bread>
    80002910:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002912:	004b2503          	lw	a0,4(s6)
    80002916:	000a849b          	sext.w	s1,s5
    8000291a:	8662                	mv	a2,s8
    8000291c:	faa4fde3          	bgeu	s1,a0,800028d6 <balloc+0xa8>
      m = 1 << (bi % 8);
    80002920:	41f6579b          	sraiw	a5,a2,0x1f
    80002924:	01d7d69b          	srliw	a3,a5,0x1d
    80002928:	00c6873b          	addw	a4,a3,a2
    8000292c:	00777793          	andi	a5,a4,7
    80002930:	9f95                	subw	a5,a5,a3
    80002932:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002936:	4037571b          	sraiw	a4,a4,0x3
    8000293a:	00e906b3          	add	a3,s2,a4
    8000293e:	0606c683          	lbu	a3,96(a3)
    80002942:	00d7f5b3          	and	a1,a5,a3
    80002946:	d195                	beqz	a1,8000286a <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002948:	2605                	addiw	a2,a2,1
    8000294a:	2485                	addiw	s1,s1,1
    8000294c:	fd4618e3          	bne	a2,s4,8000291c <balloc+0xee>
    80002950:	b759                	j	800028d6 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    80002952:	00006517          	auipc	a0,0x6
    80002956:	bbe50513          	addi	a0,a0,-1090 # 80008510 <syscalls+0x100>
    8000295a:	00004097          	auipc	ra,0x4
    8000295e:	8c6080e7          	jalr	-1850(ra) # 80006220 <printf>
  return 0;
    80002962:	4481                	li	s1,0
    80002964:	bf99                	j	800028ba <balloc+0x8c>

0000000080002966 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002966:	7179                	addi	sp,sp,-48
    80002968:	f406                	sd	ra,40(sp)
    8000296a:	f022                	sd	s0,32(sp)
    8000296c:	ec26                	sd	s1,24(sp)
    8000296e:	e84a                	sd	s2,16(sp)
    80002970:	e44e                	sd	s3,8(sp)
    80002972:	e052                	sd	s4,0(sp)
    80002974:	1800                	addi	s0,sp,48
    80002976:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002978:	47ad                	li	a5,11
    8000297a:	02b7e763          	bltu	a5,a1,800029a8 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    8000297e:	02059493          	slli	s1,a1,0x20
    80002982:	9081                	srli	s1,s1,0x20
    80002984:	048a                	slli	s1,s1,0x2
    80002986:	94aa                	add	s1,s1,a0
    80002988:	0584a903          	lw	s2,88(s1)
    8000298c:	06091e63          	bnez	s2,80002a08 <bmap+0xa2>
      addr = balloc(ip->dev);
    80002990:	4108                	lw	a0,0(a0)
    80002992:	00000097          	auipc	ra,0x0
    80002996:	e9c080e7          	jalr	-356(ra) # 8000282e <balloc>
    8000299a:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000299e:	06090563          	beqz	s2,80002a08 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    800029a2:	0524ac23          	sw	s2,88(s1)
    800029a6:	a08d                	j	80002a08 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    800029a8:	ff45849b          	addiw	s1,a1,-12
    800029ac:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800029b0:	0ff00793          	li	a5,255
    800029b4:	08e7e563          	bltu	a5,a4,80002a3e <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800029b8:	08852903          	lw	s2,136(a0)
    800029bc:	00091d63          	bnez	s2,800029d6 <bmap+0x70>
      addr = balloc(ip->dev);
    800029c0:	4108                	lw	a0,0(a0)
    800029c2:	00000097          	auipc	ra,0x0
    800029c6:	e6c080e7          	jalr	-404(ra) # 8000282e <balloc>
    800029ca:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800029ce:	02090d63          	beqz	s2,80002a08 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    800029d2:	0929a423          	sw	s2,136(s3)
    }
    bp = bread(ip->dev, addr);
    800029d6:	85ca                	mv	a1,s2
    800029d8:	0009a503          	lw	a0,0(s3)
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	ab4080e7          	jalr	-1356(ra) # 80002490 <bread>
    800029e4:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800029e6:	06050793          	addi	a5,a0,96
    if((addr = a[bn]) == 0){
    800029ea:	02049593          	slli	a1,s1,0x20
    800029ee:	9181                	srli	a1,a1,0x20
    800029f0:	058a                	slli	a1,a1,0x2
    800029f2:	00b784b3          	add	s1,a5,a1
    800029f6:	0004a903          	lw	s2,0(s1)
    800029fa:	02090063          	beqz	s2,80002a1a <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800029fe:	8552                	mv	a0,s4
    80002a00:	00000097          	auipc	ra,0x0
    80002a04:	c58080e7          	jalr	-936(ra) # 80002658 <brelse>
    return addr;
  }
  panic("bmap: out of range");
}
    80002a08:	854a                	mv	a0,s2
    80002a0a:	70a2                	ld	ra,40(sp)
    80002a0c:	7402                	ld	s0,32(sp)
    80002a0e:	64e2                	ld	s1,24(sp)
    80002a10:	6942                	ld	s2,16(sp)
    80002a12:	69a2                	ld	s3,8(sp)
    80002a14:	6a02                	ld	s4,0(sp)
    80002a16:	6145                	addi	sp,sp,48
    80002a18:	8082                	ret
      addr = balloc(ip->dev);
    80002a1a:	0009a503          	lw	a0,0(s3)
    80002a1e:	00000097          	auipc	ra,0x0
    80002a22:	e10080e7          	jalr	-496(ra) # 8000282e <balloc>
    80002a26:	0005091b          	sext.w	s2,a0
      if(addr){
    80002a2a:	fc090ae3          	beqz	s2,800029fe <bmap+0x98>
        a[bn] = addr;
    80002a2e:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002a32:	8552                	mv	a0,s4
    80002a34:	00001097          	auipc	ra,0x1
    80002a38:	f00080e7          	jalr	-256(ra) # 80003934 <log_write>
    80002a3c:	b7c9                	j	800029fe <bmap+0x98>
  panic("bmap: out of range");
    80002a3e:	00006517          	auipc	a0,0x6
    80002a42:	aea50513          	addi	a0,a0,-1302 # 80008528 <syscalls+0x118>
    80002a46:	00003097          	auipc	ra,0x3
    80002a4a:	790080e7          	jalr	1936(ra) # 800061d6 <panic>

0000000080002a4e <iget>:
{
    80002a4e:	7179                	addi	sp,sp,-48
    80002a50:	f406                	sd	ra,40(sp)
    80002a52:	f022                	sd	s0,32(sp)
    80002a54:	ec26                	sd	s1,24(sp)
    80002a56:	e84a                	sd	s2,16(sp)
    80002a58:	e44e                	sd	s3,8(sp)
    80002a5a:	e052                	sd	s4,0(sp)
    80002a5c:	1800                	addi	s0,sp,48
    80002a5e:	89aa                	mv	s3,a0
    80002a60:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002a62:	00018517          	auipc	a0,0x18
    80002a66:	eee50513          	addi	a0,a0,-274 # 8001a950 <itable>
    80002a6a:	00004097          	auipc	ra,0x4
    80002a6e:	ca0080e7          	jalr	-864(ra) # 8000670a <acquire>
  empty = 0;
    80002a72:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a74:	00018497          	auipc	s1,0x18
    80002a78:	efc48493          	addi	s1,s1,-260 # 8001a970 <itable+0x20>
    80002a7c:	0001a697          	auipc	a3,0x1a
    80002a80:	b1468693          	addi	a3,a3,-1260 # 8001c590 <log>
    80002a84:	a039                	j	80002a92 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002a86:	02090b63          	beqz	s2,80002abc <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a8a:	09048493          	addi	s1,s1,144
    80002a8e:	02d48a63          	beq	s1,a3,80002ac2 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002a92:	449c                	lw	a5,8(s1)
    80002a94:	fef059e3          	blez	a5,80002a86 <iget+0x38>
    80002a98:	4098                	lw	a4,0(s1)
    80002a9a:	ff3716e3          	bne	a4,s3,80002a86 <iget+0x38>
    80002a9e:	40d8                	lw	a4,4(s1)
    80002aa0:	ff4713e3          	bne	a4,s4,80002a86 <iget+0x38>
      ip->ref++;
    80002aa4:	2785                	addiw	a5,a5,1
    80002aa6:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002aa8:	00018517          	auipc	a0,0x18
    80002aac:	ea850513          	addi	a0,a0,-344 # 8001a950 <itable>
    80002ab0:	00004097          	auipc	ra,0x4
    80002ab4:	d2a080e7          	jalr	-726(ra) # 800067da <release>
      return ip;
    80002ab8:	8926                	mv	s2,s1
    80002aba:	a03d                	j	80002ae8 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002abc:	f7f9                	bnez	a5,80002a8a <iget+0x3c>
    80002abe:	8926                	mv	s2,s1
    80002ac0:	b7e9                	j	80002a8a <iget+0x3c>
  if(empty == 0)
    80002ac2:	02090c63          	beqz	s2,80002afa <iget+0xac>
  ip->dev = dev;
    80002ac6:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002aca:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002ace:	4785                	li	a5,1
    80002ad0:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002ad4:	04092423          	sw	zero,72(s2)
  release(&itable.lock);
    80002ad8:	00018517          	auipc	a0,0x18
    80002adc:	e7850513          	addi	a0,a0,-392 # 8001a950 <itable>
    80002ae0:	00004097          	auipc	ra,0x4
    80002ae4:	cfa080e7          	jalr	-774(ra) # 800067da <release>
}
    80002ae8:	854a                	mv	a0,s2
    80002aea:	70a2                	ld	ra,40(sp)
    80002aec:	7402                	ld	s0,32(sp)
    80002aee:	64e2                	ld	s1,24(sp)
    80002af0:	6942                	ld	s2,16(sp)
    80002af2:	69a2                	ld	s3,8(sp)
    80002af4:	6a02                	ld	s4,0(sp)
    80002af6:	6145                	addi	sp,sp,48
    80002af8:	8082                	ret
    panic("iget: no inodes");
    80002afa:	00006517          	auipc	a0,0x6
    80002afe:	a4650513          	addi	a0,a0,-1466 # 80008540 <syscalls+0x130>
    80002b02:	00003097          	auipc	ra,0x3
    80002b06:	6d4080e7          	jalr	1748(ra) # 800061d6 <panic>

0000000080002b0a <fsinit>:
fsinit(int dev) {
    80002b0a:	7179                	addi	sp,sp,-48
    80002b0c:	f406                	sd	ra,40(sp)
    80002b0e:	f022                	sd	s0,32(sp)
    80002b10:	ec26                	sd	s1,24(sp)
    80002b12:	e84a                	sd	s2,16(sp)
    80002b14:	e44e                	sd	s3,8(sp)
    80002b16:	1800                	addi	s0,sp,48
    80002b18:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002b1a:	4585                	li	a1,1
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	974080e7          	jalr	-1676(ra) # 80002490 <bread>
    80002b24:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002b26:	00018997          	auipc	s3,0x18
    80002b2a:	e0a98993          	addi	s3,s3,-502 # 8001a930 <sb>
    80002b2e:	02000613          	li	a2,32
    80002b32:	06050593          	addi	a1,a0,96
    80002b36:	854e                	mv	a0,s3
    80002b38:	ffffd097          	auipc	ra,0xffffd
    80002b3c:	798080e7          	jalr	1944(ra) # 800002d0 <memmove>
  brelse(bp);
    80002b40:	8526                	mv	a0,s1
    80002b42:	00000097          	auipc	ra,0x0
    80002b46:	b16080e7          	jalr	-1258(ra) # 80002658 <brelse>
  if(sb.magic != FSMAGIC)
    80002b4a:	0009a703          	lw	a4,0(s3)
    80002b4e:	102037b7          	lui	a5,0x10203
    80002b52:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002b56:	02f71263          	bne	a4,a5,80002b7a <fsinit+0x70>
  initlog(dev, &sb);
    80002b5a:	00018597          	auipc	a1,0x18
    80002b5e:	dd658593          	addi	a1,a1,-554 # 8001a930 <sb>
    80002b62:	854a                	mv	a0,s2
    80002b64:	00001097          	auipc	ra,0x1
    80002b68:	b54080e7          	jalr	-1196(ra) # 800036b8 <initlog>
}
    80002b6c:	70a2                	ld	ra,40(sp)
    80002b6e:	7402                	ld	s0,32(sp)
    80002b70:	64e2                	ld	s1,24(sp)
    80002b72:	6942                	ld	s2,16(sp)
    80002b74:	69a2                	ld	s3,8(sp)
    80002b76:	6145                	addi	sp,sp,48
    80002b78:	8082                	ret
    panic("invalid file system");
    80002b7a:	00006517          	auipc	a0,0x6
    80002b7e:	9d650513          	addi	a0,a0,-1578 # 80008550 <syscalls+0x140>
    80002b82:	00003097          	auipc	ra,0x3
    80002b86:	654080e7          	jalr	1620(ra) # 800061d6 <panic>

0000000080002b8a <iinit>:
{
    80002b8a:	7179                	addi	sp,sp,-48
    80002b8c:	f406                	sd	ra,40(sp)
    80002b8e:	f022                	sd	s0,32(sp)
    80002b90:	ec26                	sd	s1,24(sp)
    80002b92:	e84a                	sd	s2,16(sp)
    80002b94:	e44e                	sd	s3,8(sp)
    80002b96:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002b98:	00006597          	auipc	a1,0x6
    80002b9c:	9d058593          	addi	a1,a1,-1584 # 80008568 <syscalls+0x158>
    80002ba0:	00018517          	auipc	a0,0x18
    80002ba4:	db050513          	addi	a0,a0,-592 # 8001a950 <itable>
    80002ba8:	00004097          	auipc	ra,0x4
    80002bac:	cde080e7          	jalr	-802(ra) # 80006886 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002bb0:	00018497          	auipc	s1,0x18
    80002bb4:	dd048493          	addi	s1,s1,-560 # 8001a980 <itable+0x30>
    80002bb8:	0001a997          	auipc	s3,0x1a
    80002bbc:	9e898993          	addi	s3,s3,-1560 # 8001c5a0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002bc0:	00006917          	auipc	s2,0x6
    80002bc4:	9b090913          	addi	s2,s2,-1616 # 80008570 <syscalls+0x160>
    80002bc8:	85ca                	mv	a1,s2
    80002bca:	8526                	mv	a0,s1
    80002bcc:	00001097          	auipc	ra,0x1
    80002bd0:	e4e080e7          	jalr	-434(ra) # 80003a1a <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002bd4:	09048493          	addi	s1,s1,144
    80002bd8:	ff3498e3          	bne	s1,s3,80002bc8 <iinit+0x3e>
}
    80002bdc:	70a2                	ld	ra,40(sp)
    80002bde:	7402                	ld	s0,32(sp)
    80002be0:	64e2                	ld	s1,24(sp)
    80002be2:	6942                	ld	s2,16(sp)
    80002be4:	69a2                	ld	s3,8(sp)
    80002be6:	6145                	addi	sp,sp,48
    80002be8:	8082                	ret

0000000080002bea <ialloc>:
{
    80002bea:	715d                	addi	sp,sp,-80
    80002bec:	e486                	sd	ra,72(sp)
    80002bee:	e0a2                	sd	s0,64(sp)
    80002bf0:	fc26                	sd	s1,56(sp)
    80002bf2:	f84a                	sd	s2,48(sp)
    80002bf4:	f44e                	sd	s3,40(sp)
    80002bf6:	f052                	sd	s4,32(sp)
    80002bf8:	ec56                	sd	s5,24(sp)
    80002bfa:	e85a                	sd	s6,16(sp)
    80002bfc:	e45e                	sd	s7,8(sp)
    80002bfe:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c00:	00018717          	auipc	a4,0x18
    80002c04:	d3c72703          	lw	a4,-708(a4) # 8001a93c <sb+0xc>
    80002c08:	4785                	li	a5,1
    80002c0a:	04e7fa63          	bgeu	a5,a4,80002c5e <ialloc+0x74>
    80002c0e:	8aaa                	mv	s5,a0
    80002c10:	8bae                	mv	s7,a1
    80002c12:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002c14:	00018a17          	auipc	s4,0x18
    80002c18:	d1ca0a13          	addi	s4,s4,-740 # 8001a930 <sb>
    80002c1c:	00048b1b          	sext.w	s6,s1
    80002c20:	0044d593          	srli	a1,s1,0x4
    80002c24:	018a2783          	lw	a5,24(s4)
    80002c28:	9dbd                	addw	a1,a1,a5
    80002c2a:	8556                	mv	a0,s5
    80002c2c:	00000097          	auipc	ra,0x0
    80002c30:	864080e7          	jalr	-1948(ra) # 80002490 <bread>
    80002c34:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002c36:	06050993          	addi	s3,a0,96
    80002c3a:	00f4f793          	andi	a5,s1,15
    80002c3e:	079a                	slli	a5,a5,0x6
    80002c40:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002c42:	00099783          	lh	a5,0(s3)
    80002c46:	c3a1                	beqz	a5,80002c86 <ialloc+0x9c>
    brelse(bp);
    80002c48:	00000097          	auipc	ra,0x0
    80002c4c:	a10080e7          	jalr	-1520(ra) # 80002658 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c50:	0485                	addi	s1,s1,1
    80002c52:	00ca2703          	lw	a4,12(s4)
    80002c56:	0004879b          	sext.w	a5,s1
    80002c5a:	fce7e1e3          	bltu	a5,a4,80002c1c <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80002c5e:	00006517          	auipc	a0,0x6
    80002c62:	91a50513          	addi	a0,a0,-1766 # 80008578 <syscalls+0x168>
    80002c66:	00003097          	auipc	ra,0x3
    80002c6a:	5ba080e7          	jalr	1466(ra) # 80006220 <printf>
  return 0;
    80002c6e:	4501                	li	a0,0
}
    80002c70:	60a6                	ld	ra,72(sp)
    80002c72:	6406                	ld	s0,64(sp)
    80002c74:	74e2                	ld	s1,56(sp)
    80002c76:	7942                	ld	s2,48(sp)
    80002c78:	79a2                	ld	s3,40(sp)
    80002c7a:	7a02                	ld	s4,32(sp)
    80002c7c:	6ae2                	ld	s5,24(sp)
    80002c7e:	6b42                	ld	s6,16(sp)
    80002c80:	6ba2                	ld	s7,8(sp)
    80002c82:	6161                	addi	sp,sp,80
    80002c84:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002c86:	04000613          	li	a2,64
    80002c8a:	4581                	li	a1,0
    80002c8c:	854e                	mv	a0,s3
    80002c8e:	ffffd097          	auipc	ra,0xffffd
    80002c92:	5e2080e7          	jalr	1506(ra) # 80000270 <memset>
      dip->type = type;
    80002c96:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002c9a:	854a                	mv	a0,s2
    80002c9c:	00001097          	auipc	ra,0x1
    80002ca0:	c98080e7          	jalr	-872(ra) # 80003934 <log_write>
      brelse(bp);
    80002ca4:	854a                	mv	a0,s2
    80002ca6:	00000097          	auipc	ra,0x0
    80002caa:	9b2080e7          	jalr	-1614(ra) # 80002658 <brelse>
      return iget(dev, inum);
    80002cae:	85da                	mv	a1,s6
    80002cb0:	8556                	mv	a0,s5
    80002cb2:	00000097          	auipc	ra,0x0
    80002cb6:	d9c080e7          	jalr	-612(ra) # 80002a4e <iget>
    80002cba:	bf5d                	j	80002c70 <ialloc+0x86>

0000000080002cbc <iupdate>:
{
    80002cbc:	1101                	addi	sp,sp,-32
    80002cbe:	ec06                	sd	ra,24(sp)
    80002cc0:	e822                	sd	s0,16(sp)
    80002cc2:	e426                	sd	s1,8(sp)
    80002cc4:	e04a                	sd	s2,0(sp)
    80002cc6:	1000                	addi	s0,sp,32
    80002cc8:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002cca:	415c                	lw	a5,4(a0)
    80002ccc:	0047d79b          	srliw	a5,a5,0x4
    80002cd0:	00018597          	auipc	a1,0x18
    80002cd4:	c785a583          	lw	a1,-904(a1) # 8001a948 <sb+0x18>
    80002cd8:	9dbd                	addw	a1,a1,a5
    80002cda:	4108                	lw	a0,0(a0)
    80002cdc:	fffff097          	auipc	ra,0xfffff
    80002ce0:	7b4080e7          	jalr	1972(ra) # 80002490 <bread>
    80002ce4:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002ce6:	06050793          	addi	a5,a0,96
    80002cea:	40c8                	lw	a0,4(s1)
    80002cec:	893d                	andi	a0,a0,15
    80002cee:	051a                	slli	a0,a0,0x6
    80002cf0:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002cf2:	04c49703          	lh	a4,76(s1)
    80002cf6:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80002cfa:	04e49703          	lh	a4,78(s1)
    80002cfe:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80002d02:	05049703          	lh	a4,80(s1)
    80002d06:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80002d0a:	05249703          	lh	a4,82(s1)
    80002d0e:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80002d12:	48f8                	lw	a4,84(s1)
    80002d14:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002d16:	03400613          	li	a2,52
    80002d1a:	05848593          	addi	a1,s1,88
    80002d1e:	0531                	addi	a0,a0,12
    80002d20:	ffffd097          	auipc	ra,0xffffd
    80002d24:	5b0080e7          	jalr	1456(ra) # 800002d0 <memmove>
  log_write(bp);
    80002d28:	854a                	mv	a0,s2
    80002d2a:	00001097          	auipc	ra,0x1
    80002d2e:	c0a080e7          	jalr	-1014(ra) # 80003934 <log_write>
  brelse(bp);
    80002d32:	854a                	mv	a0,s2
    80002d34:	00000097          	auipc	ra,0x0
    80002d38:	924080e7          	jalr	-1756(ra) # 80002658 <brelse>
}
    80002d3c:	60e2                	ld	ra,24(sp)
    80002d3e:	6442                	ld	s0,16(sp)
    80002d40:	64a2                	ld	s1,8(sp)
    80002d42:	6902                	ld	s2,0(sp)
    80002d44:	6105                	addi	sp,sp,32
    80002d46:	8082                	ret

0000000080002d48 <idup>:
{
    80002d48:	1101                	addi	sp,sp,-32
    80002d4a:	ec06                	sd	ra,24(sp)
    80002d4c:	e822                	sd	s0,16(sp)
    80002d4e:	e426                	sd	s1,8(sp)
    80002d50:	1000                	addi	s0,sp,32
    80002d52:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002d54:	00018517          	auipc	a0,0x18
    80002d58:	bfc50513          	addi	a0,a0,-1028 # 8001a950 <itable>
    80002d5c:	00004097          	auipc	ra,0x4
    80002d60:	9ae080e7          	jalr	-1618(ra) # 8000670a <acquire>
  ip->ref++;
    80002d64:	449c                	lw	a5,8(s1)
    80002d66:	2785                	addiw	a5,a5,1
    80002d68:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d6a:	00018517          	auipc	a0,0x18
    80002d6e:	be650513          	addi	a0,a0,-1050 # 8001a950 <itable>
    80002d72:	00004097          	auipc	ra,0x4
    80002d76:	a68080e7          	jalr	-1432(ra) # 800067da <release>
}
    80002d7a:	8526                	mv	a0,s1
    80002d7c:	60e2                	ld	ra,24(sp)
    80002d7e:	6442                	ld	s0,16(sp)
    80002d80:	64a2                	ld	s1,8(sp)
    80002d82:	6105                	addi	sp,sp,32
    80002d84:	8082                	ret

0000000080002d86 <ilock>:
{
    80002d86:	1101                	addi	sp,sp,-32
    80002d88:	ec06                	sd	ra,24(sp)
    80002d8a:	e822                	sd	s0,16(sp)
    80002d8c:	e426                	sd	s1,8(sp)
    80002d8e:	e04a                	sd	s2,0(sp)
    80002d90:	1000                	addi	s0,sp,32
  if(ip == 0 || atomic_read4(&ip->ref) < 1)
    80002d92:	c51d                	beqz	a0,80002dc0 <ilock+0x3a>
    80002d94:	84aa                	mv	s1,a0
    80002d96:	0521                	addi	a0,a0,8
    80002d98:	00004097          	auipc	ra,0x4
    80002d9c:	b6e080e7          	jalr	-1170(ra) # 80006906 <atomic_read4>
    80002da0:	02a05063          	blez	a0,80002dc0 <ilock+0x3a>
  acquiresleep(&ip->lock);
    80002da4:	01048513          	addi	a0,s1,16
    80002da8:	00001097          	auipc	ra,0x1
    80002dac:	cac080e7          	jalr	-852(ra) # 80003a54 <acquiresleep>
  if(ip->valid == 0){
    80002db0:	44bc                	lw	a5,72(s1)
    80002db2:	cf99                	beqz	a5,80002dd0 <ilock+0x4a>
}
    80002db4:	60e2                	ld	ra,24(sp)
    80002db6:	6442                	ld	s0,16(sp)
    80002db8:	64a2                	ld	s1,8(sp)
    80002dba:	6902                	ld	s2,0(sp)
    80002dbc:	6105                	addi	sp,sp,32
    80002dbe:	8082                	ret
    panic("ilock");
    80002dc0:	00005517          	auipc	a0,0x5
    80002dc4:	7d050513          	addi	a0,a0,2000 # 80008590 <syscalls+0x180>
    80002dc8:	00003097          	auipc	ra,0x3
    80002dcc:	40e080e7          	jalr	1038(ra) # 800061d6 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002dd0:	40dc                	lw	a5,4(s1)
    80002dd2:	0047d79b          	srliw	a5,a5,0x4
    80002dd6:	00018597          	auipc	a1,0x18
    80002dda:	b725a583          	lw	a1,-1166(a1) # 8001a948 <sb+0x18>
    80002dde:	9dbd                	addw	a1,a1,a5
    80002de0:	4088                	lw	a0,0(s1)
    80002de2:	fffff097          	auipc	ra,0xfffff
    80002de6:	6ae080e7          	jalr	1710(ra) # 80002490 <bread>
    80002dea:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002dec:	06050593          	addi	a1,a0,96
    80002df0:	40dc                	lw	a5,4(s1)
    80002df2:	8bbd                	andi	a5,a5,15
    80002df4:	079a                	slli	a5,a5,0x6
    80002df6:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002df8:	00059783          	lh	a5,0(a1)
    80002dfc:	04f49623          	sh	a5,76(s1)
    ip->major = dip->major;
    80002e00:	00259783          	lh	a5,2(a1)
    80002e04:	04f49723          	sh	a5,78(s1)
    ip->minor = dip->minor;
    80002e08:	00459783          	lh	a5,4(a1)
    80002e0c:	04f49823          	sh	a5,80(s1)
    ip->nlink = dip->nlink;
    80002e10:	00659783          	lh	a5,6(a1)
    80002e14:	04f49923          	sh	a5,82(s1)
    ip->size = dip->size;
    80002e18:	459c                	lw	a5,8(a1)
    80002e1a:	c8fc                	sw	a5,84(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002e1c:	03400613          	li	a2,52
    80002e20:	05b1                	addi	a1,a1,12
    80002e22:	05848513          	addi	a0,s1,88
    80002e26:	ffffd097          	auipc	ra,0xffffd
    80002e2a:	4aa080e7          	jalr	1194(ra) # 800002d0 <memmove>
    brelse(bp);
    80002e2e:	854a                	mv	a0,s2
    80002e30:	00000097          	auipc	ra,0x0
    80002e34:	828080e7          	jalr	-2008(ra) # 80002658 <brelse>
    ip->valid = 1;
    80002e38:	4785                	li	a5,1
    80002e3a:	c4bc                	sw	a5,72(s1)
    if(ip->type == 0)
    80002e3c:	04c49783          	lh	a5,76(s1)
    80002e40:	fbb5                	bnez	a5,80002db4 <ilock+0x2e>
      panic("ilock: no type");
    80002e42:	00005517          	auipc	a0,0x5
    80002e46:	75650513          	addi	a0,a0,1878 # 80008598 <syscalls+0x188>
    80002e4a:	00003097          	auipc	ra,0x3
    80002e4e:	38c080e7          	jalr	908(ra) # 800061d6 <panic>

0000000080002e52 <iunlock>:
{
    80002e52:	1101                	addi	sp,sp,-32
    80002e54:	ec06                	sd	ra,24(sp)
    80002e56:	e822                	sd	s0,16(sp)
    80002e58:	e426                	sd	s1,8(sp)
    80002e5a:	e04a                	sd	s2,0(sp)
    80002e5c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || atomic_read4(&ip->ref) < 1)
    80002e5e:	cd0d                	beqz	a0,80002e98 <iunlock+0x46>
    80002e60:	84aa                	mv	s1,a0
    80002e62:	01050913          	addi	s2,a0,16
    80002e66:	854a                	mv	a0,s2
    80002e68:	00001097          	auipc	ra,0x1
    80002e6c:	c86080e7          	jalr	-890(ra) # 80003aee <holdingsleep>
    80002e70:	c505                	beqz	a0,80002e98 <iunlock+0x46>
    80002e72:	00848513          	addi	a0,s1,8
    80002e76:	00004097          	auipc	ra,0x4
    80002e7a:	a90080e7          	jalr	-1392(ra) # 80006906 <atomic_read4>
    80002e7e:	00a05d63          	blez	a0,80002e98 <iunlock+0x46>
  releasesleep(&ip->lock);
    80002e82:	854a                	mv	a0,s2
    80002e84:	00001097          	auipc	ra,0x1
    80002e88:	c26080e7          	jalr	-986(ra) # 80003aaa <releasesleep>
}
    80002e8c:	60e2                	ld	ra,24(sp)
    80002e8e:	6442                	ld	s0,16(sp)
    80002e90:	64a2                	ld	s1,8(sp)
    80002e92:	6902                	ld	s2,0(sp)
    80002e94:	6105                	addi	sp,sp,32
    80002e96:	8082                	ret
    panic("iunlock");
    80002e98:	00005517          	auipc	a0,0x5
    80002e9c:	71050513          	addi	a0,a0,1808 # 800085a8 <syscalls+0x198>
    80002ea0:	00003097          	auipc	ra,0x3
    80002ea4:	336080e7          	jalr	822(ra) # 800061d6 <panic>

0000000080002ea8 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002ea8:	7179                	addi	sp,sp,-48
    80002eaa:	f406                	sd	ra,40(sp)
    80002eac:	f022                	sd	s0,32(sp)
    80002eae:	ec26                	sd	s1,24(sp)
    80002eb0:	e84a                	sd	s2,16(sp)
    80002eb2:	e44e                	sd	s3,8(sp)
    80002eb4:	e052                	sd	s4,0(sp)
    80002eb6:	1800                	addi	s0,sp,48
    80002eb8:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002eba:	05850493          	addi	s1,a0,88
    80002ebe:	08850913          	addi	s2,a0,136
    80002ec2:	a021                	j	80002eca <itrunc+0x22>
    80002ec4:	0491                	addi	s1,s1,4
    80002ec6:	01248d63          	beq	s1,s2,80002ee0 <itrunc+0x38>
    if(ip->addrs[i]){
    80002eca:	408c                	lw	a1,0(s1)
    80002ecc:	dde5                	beqz	a1,80002ec4 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002ece:	0009a503          	lw	a0,0(s3)
    80002ed2:	00000097          	auipc	ra,0x0
    80002ed6:	8e0080e7          	jalr	-1824(ra) # 800027b2 <bfree>
      ip->addrs[i] = 0;
    80002eda:	0004a023          	sw	zero,0(s1)
    80002ede:	b7dd                	j	80002ec4 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002ee0:	0889a583          	lw	a1,136(s3)
    80002ee4:	e185                	bnez	a1,80002f04 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }
  
  ip->size = 0;
    80002ee6:	0409aa23          	sw	zero,84(s3)
  iupdate(ip);
    80002eea:	854e                	mv	a0,s3
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	dd0080e7          	jalr	-560(ra) # 80002cbc <iupdate>
}
    80002ef4:	70a2                	ld	ra,40(sp)
    80002ef6:	7402                	ld	s0,32(sp)
    80002ef8:	64e2                	ld	s1,24(sp)
    80002efa:	6942                	ld	s2,16(sp)
    80002efc:	69a2                	ld	s3,8(sp)
    80002efe:	6a02                	ld	s4,0(sp)
    80002f00:	6145                	addi	sp,sp,48
    80002f02:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002f04:	0009a503          	lw	a0,0(s3)
    80002f08:	fffff097          	auipc	ra,0xfffff
    80002f0c:	588080e7          	jalr	1416(ra) # 80002490 <bread>
    80002f10:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002f12:	06050493          	addi	s1,a0,96
    80002f16:	46050913          	addi	s2,a0,1120
    80002f1a:	a811                	j	80002f2e <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002f1c:	0009a503          	lw	a0,0(s3)
    80002f20:	00000097          	auipc	ra,0x0
    80002f24:	892080e7          	jalr	-1902(ra) # 800027b2 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002f28:	0491                	addi	s1,s1,4
    80002f2a:	01248563          	beq	s1,s2,80002f34 <itrunc+0x8c>
      if(a[j])
    80002f2e:	408c                	lw	a1,0(s1)
    80002f30:	dde5                	beqz	a1,80002f28 <itrunc+0x80>
    80002f32:	b7ed                	j	80002f1c <itrunc+0x74>
    brelse(bp);
    80002f34:	8552                	mv	a0,s4
    80002f36:	fffff097          	auipc	ra,0xfffff
    80002f3a:	722080e7          	jalr	1826(ra) # 80002658 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002f3e:	0889a583          	lw	a1,136(s3)
    80002f42:	0009a503          	lw	a0,0(s3)
    80002f46:	00000097          	auipc	ra,0x0
    80002f4a:	86c080e7          	jalr	-1940(ra) # 800027b2 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002f4e:	0809a423          	sw	zero,136(s3)
    80002f52:	bf51                	j	80002ee6 <itrunc+0x3e>

0000000080002f54 <iput>:
{
    80002f54:	1101                	addi	sp,sp,-32
    80002f56:	ec06                	sd	ra,24(sp)
    80002f58:	e822                	sd	s0,16(sp)
    80002f5a:	e426                	sd	s1,8(sp)
    80002f5c:	e04a                	sd	s2,0(sp)
    80002f5e:	1000                	addi	s0,sp,32
    80002f60:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f62:	00018517          	auipc	a0,0x18
    80002f66:	9ee50513          	addi	a0,a0,-1554 # 8001a950 <itable>
    80002f6a:	00003097          	auipc	ra,0x3
    80002f6e:	7a0080e7          	jalr	1952(ra) # 8000670a <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f72:	4498                	lw	a4,8(s1)
    80002f74:	4785                	li	a5,1
    80002f76:	02f70363          	beq	a4,a5,80002f9c <iput+0x48>
  ip->ref--;
    80002f7a:	449c                	lw	a5,8(s1)
    80002f7c:	37fd                	addiw	a5,a5,-1
    80002f7e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002f80:	00018517          	auipc	a0,0x18
    80002f84:	9d050513          	addi	a0,a0,-1584 # 8001a950 <itable>
    80002f88:	00004097          	auipc	ra,0x4
    80002f8c:	852080e7          	jalr	-1966(ra) # 800067da <release>
}
    80002f90:	60e2                	ld	ra,24(sp)
    80002f92:	6442                	ld	s0,16(sp)
    80002f94:	64a2                	ld	s1,8(sp)
    80002f96:	6902                	ld	s2,0(sp)
    80002f98:	6105                	addi	sp,sp,32
    80002f9a:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f9c:	44bc                	lw	a5,72(s1)
    80002f9e:	dff1                	beqz	a5,80002f7a <iput+0x26>
    80002fa0:	05249783          	lh	a5,82(s1)
    80002fa4:	fbf9                	bnez	a5,80002f7a <iput+0x26>
    acquiresleep(&ip->lock);
    80002fa6:	01048913          	addi	s2,s1,16
    80002faa:	854a                	mv	a0,s2
    80002fac:	00001097          	auipc	ra,0x1
    80002fb0:	aa8080e7          	jalr	-1368(ra) # 80003a54 <acquiresleep>
    release(&itable.lock);
    80002fb4:	00018517          	auipc	a0,0x18
    80002fb8:	99c50513          	addi	a0,a0,-1636 # 8001a950 <itable>
    80002fbc:	00004097          	auipc	ra,0x4
    80002fc0:	81e080e7          	jalr	-2018(ra) # 800067da <release>
    itrunc(ip);
    80002fc4:	8526                	mv	a0,s1
    80002fc6:	00000097          	auipc	ra,0x0
    80002fca:	ee2080e7          	jalr	-286(ra) # 80002ea8 <itrunc>
    ip->type = 0;
    80002fce:	04049623          	sh	zero,76(s1)
    iupdate(ip);
    80002fd2:	8526                	mv	a0,s1
    80002fd4:	00000097          	auipc	ra,0x0
    80002fd8:	ce8080e7          	jalr	-792(ra) # 80002cbc <iupdate>
    ip->valid = 0;
    80002fdc:	0404a423          	sw	zero,72(s1)
    releasesleep(&ip->lock);
    80002fe0:	854a                	mv	a0,s2
    80002fe2:	00001097          	auipc	ra,0x1
    80002fe6:	ac8080e7          	jalr	-1336(ra) # 80003aaa <releasesleep>
    acquire(&itable.lock);
    80002fea:	00018517          	auipc	a0,0x18
    80002fee:	96650513          	addi	a0,a0,-1690 # 8001a950 <itable>
    80002ff2:	00003097          	auipc	ra,0x3
    80002ff6:	718080e7          	jalr	1816(ra) # 8000670a <acquire>
    80002ffa:	b741                	j	80002f7a <iput+0x26>

0000000080002ffc <iunlockput>:
{
    80002ffc:	1101                	addi	sp,sp,-32
    80002ffe:	ec06                	sd	ra,24(sp)
    80003000:	e822                	sd	s0,16(sp)
    80003002:	e426                	sd	s1,8(sp)
    80003004:	1000                	addi	s0,sp,32
    80003006:	84aa                	mv	s1,a0
  iunlock(ip);
    80003008:	00000097          	auipc	ra,0x0
    8000300c:	e4a080e7          	jalr	-438(ra) # 80002e52 <iunlock>
  iput(ip);
    80003010:	8526                	mv	a0,s1
    80003012:	00000097          	auipc	ra,0x0
    80003016:	f42080e7          	jalr	-190(ra) # 80002f54 <iput>
}
    8000301a:	60e2                	ld	ra,24(sp)
    8000301c:	6442                	ld	s0,16(sp)
    8000301e:	64a2                	ld	s1,8(sp)
    80003020:	6105                	addi	sp,sp,32
    80003022:	8082                	ret

0000000080003024 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003024:	1141                	addi	sp,sp,-16
    80003026:	e422                	sd	s0,8(sp)
    80003028:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    8000302a:	411c                	lw	a5,0(a0)
    8000302c:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    8000302e:	415c                	lw	a5,4(a0)
    80003030:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003032:	04c51783          	lh	a5,76(a0)
    80003036:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    8000303a:	05251783          	lh	a5,82(a0)
    8000303e:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003042:	05456783          	lwu	a5,84(a0)
    80003046:	e99c                	sd	a5,16(a1)
}
    80003048:	6422                	ld	s0,8(sp)
    8000304a:	0141                	addi	sp,sp,16
    8000304c:	8082                	ret

000000008000304e <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000304e:	497c                	lw	a5,84(a0)
    80003050:	0ed7e963          	bltu	a5,a3,80003142 <readi+0xf4>
{
    80003054:	7159                	addi	sp,sp,-112
    80003056:	f486                	sd	ra,104(sp)
    80003058:	f0a2                	sd	s0,96(sp)
    8000305a:	eca6                	sd	s1,88(sp)
    8000305c:	e8ca                	sd	s2,80(sp)
    8000305e:	e4ce                	sd	s3,72(sp)
    80003060:	e0d2                	sd	s4,64(sp)
    80003062:	fc56                	sd	s5,56(sp)
    80003064:	f85a                	sd	s6,48(sp)
    80003066:	f45e                	sd	s7,40(sp)
    80003068:	f062                	sd	s8,32(sp)
    8000306a:	ec66                	sd	s9,24(sp)
    8000306c:	e86a                	sd	s10,16(sp)
    8000306e:	e46e                	sd	s11,8(sp)
    80003070:	1880                	addi	s0,sp,112
    80003072:	8b2a                	mv	s6,a0
    80003074:	8bae                	mv	s7,a1
    80003076:	8a32                	mv	s4,a2
    80003078:	84b6                	mv	s1,a3
    8000307a:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    8000307c:	9f35                	addw	a4,a4,a3
    return 0;
    8000307e:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003080:	0ad76063          	bltu	a4,a3,80003120 <readi+0xd2>
  if(off + n > ip->size)
    80003084:	00e7f463          	bgeu	a5,a4,8000308c <readi+0x3e>
    n = ip->size - off;
    80003088:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000308c:	0a0a8963          	beqz	s5,8000313e <readi+0xf0>
    80003090:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003092:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003096:	5c7d                	li	s8,-1
    80003098:	a82d                	j	800030d2 <readi+0x84>
    8000309a:	020d1d93          	slli	s11,s10,0x20
    8000309e:	020ddd93          	srli	s11,s11,0x20
    800030a2:	06090613          	addi	a2,s2,96
    800030a6:	86ee                	mv	a3,s11
    800030a8:	963a                	add	a2,a2,a4
    800030aa:	85d2                	mv	a1,s4
    800030ac:	855e                	mv	a0,s7
    800030ae:	fffff097          	auipc	ra,0xfffff
    800030b2:	9ba080e7          	jalr	-1606(ra) # 80001a68 <either_copyout>
    800030b6:	05850d63          	beq	a0,s8,80003110 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800030ba:	854a                	mv	a0,s2
    800030bc:	fffff097          	auipc	ra,0xfffff
    800030c0:	59c080e7          	jalr	1436(ra) # 80002658 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030c4:	013d09bb          	addw	s3,s10,s3
    800030c8:	009d04bb          	addw	s1,s10,s1
    800030cc:	9a6e                	add	s4,s4,s11
    800030ce:	0559f763          	bgeu	s3,s5,8000311c <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    800030d2:	00a4d59b          	srliw	a1,s1,0xa
    800030d6:	855a                	mv	a0,s6
    800030d8:	00000097          	auipc	ra,0x0
    800030dc:	88e080e7          	jalr	-1906(ra) # 80002966 <bmap>
    800030e0:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800030e4:	cd85                	beqz	a1,8000311c <readi+0xce>
    bp = bread(ip->dev, addr);
    800030e6:	000b2503          	lw	a0,0(s6)
    800030ea:	fffff097          	auipc	ra,0xfffff
    800030ee:	3a6080e7          	jalr	934(ra) # 80002490 <bread>
    800030f2:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800030f4:	3ff4f713          	andi	a4,s1,1023
    800030f8:	40ec87bb          	subw	a5,s9,a4
    800030fc:	413a86bb          	subw	a3,s5,s3
    80003100:	8d3e                	mv	s10,a5
    80003102:	2781                	sext.w	a5,a5
    80003104:	0006861b          	sext.w	a2,a3
    80003108:	f8f679e3          	bgeu	a2,a5,8000309a <readi+0x4c>
    8000310c:	8d36                	mv	s10,a3
    8000310e:	b771                	j	8000309a <readi+0x4c>
      brelse(bp);
    80003110:	854a                	mv	a0,s2
    80003112:	fffff097          	auipc	ra,0xfffff
    80003116:	546080e7          	jalr	1350(ra) # 80002658 <brelse>
      tot = -1;
    8000311a:	59fd                	li	s3,-1
  }
  return tot;
    8000311c:	0009851b          	sext.w	a0,s3
}
    80003120:	70a6                	ld	ra,104(sp)
    80003122:	7406                	ld	s0,96(sp)
    80003124:	64e6                	ld	s1,88(sp)
    80003126:	6946                	ld	s2,80(sp)
    80003128:	69a6                	ld	s3,72(sp)
    8000312a:	6a06                	ld	s4,64(sp)
    8000312c:	7ae2                	ld	s5,56(sp)
    8000312e:	7b42                	ld	s6,48(sp)
    80003130:	7ba2                	ld	s7,40(sp)
    80003132:	7c02                	ld	s8,32(sp)
    80003134:	6ce2                	ld	s9,24(sp)
    80003136:	6d42                	ld	s10,16(sp)
    80003138:	6da2                	ld	s11,8(sp)
    8000313a:	6165                	addi	sp,sp,112
    8000313c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000313e:	89d6                	mv	s3,s5
    80003140:	bff1                	j	8000311c <readi+0xce>
    return 0;
    80003142:	4501                	li	a0,0
}
    80003144:	8082                	ret

0000000080003146 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003146:	497c                	lw	a5,84(a0)
    80003148:	10d7e863          	bltu	a5,a3,80003258 <writei+0x112>
{
    8000314c:	7159                	addi	sp,sp,-112
    8000314e:	f486                	sd	ra,104(sp)
    80003150:	f0a2                	sd	s0,96(sp)
    80003152:	eca6                	sd	s1,88(sp)
    80003154:	e8ca                	sd	s2,80(sp)
    80003156:	e4ce                	sd	s3,72(sp)
    80003158:	e0d2                	sd	s4,64(sp)
    8000315a:	fc56                	sd	s5,56(sp)
    8000315c:	f85a                	sd	s6,48(sp)
    8000315e:	f45e                	sd	s7,40(sp)
    80003160:	f062                	sd	s8,32(sp)
    80003162:	ec66                	sd	s9,24(sp)
    80003164:	e86a                	sd	s10,16(sp)
    80003166:	e46e                	sd	s11,8(sp)
    80003168:	1880                	addi	s0,sp,112
    8000316a:	8aaa                	mv	s5,a0
    8000316c:	8bae                	mv	s7,a1
    8000316e:	8a32                	mv	s4,a2
    80003170:	8936                	mv	s2,a3
    80003172:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003174:	00e687bb          	addw	a5,a3,a4
    80003178:	0ed7e263          	bltu	a5,a3,8000325c <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    8000317c:	00043737          	lui	a4,0x43
    80003180:	0ef76063          	bltu	a4,a5,80003260 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003184:	0c0b0863          	beqz	s6,80003254 <writei+0x10e>
    80003188:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    8000318a:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000318e:	5c7d                	li	s8,-1
    80003190:	a091                	j	800031d4 <writei+0x8e>
    80003192:	020d1d93          	slli	s11,s10,0x20
    80003196:	020ddd93          	srli	s11,s11,0x20
    8000319a:	06048513          	addi	a0,s1,96
    8000319e:	86ee                	mv	a3,s11
    800031a0:	8652                	mv	a2,s4
    800031a2:	85de                	mv	a1,s7
    800031a4:	953a                	add	a0,a0,a4
    800031a6:	fffff097          	auipc	ra,0xfffff
    800031aa:	918080e7          	jalr	-1768(ra) # 80001abe <either_copyin>
    800031ae:	07850263          	beq	a0,s8,80003212 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    800031b2:	8526                	mv	a0,s1
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	780080e7          	jalr	1920(ra) # 80003934 <log_write>
    brelse(bp);
    800031bc:	8526                	mv	a0,s1
    800031be:	fffff097          	auipc	ra,0xfffff
    800031c2:	49a080e7          	jalr	1178(ra) # 80002658 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031c6:	013d09bb          	addw	s3,s10,s3
    800031ca:	012d093b          	addw	s2,s10,s2
    800031ce:	9a6e                	add	s4,s4,s11
    800031d0:	0569f663          	bgeu	s3,s6,8000321c <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    800031d4:	00a9559b          	srliw	a1,s2,0xa
    800031d8:	8556                	mv	a0,s5
    800031da:	fffff097          	auipc	ra,0xfffff
    800031de:	78c080e7          	jalr	1932(ra) # 80002966 <bmap>
    800031e2:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800031e6:	c99d                	beqz	a1,8000321c <writei+0xd6>
    bp = bread(ip->dev, addr);
    800031e8:	000aa503          	lw	a0,0(s5)
    800031ec:	fffff097          	auipc	ra,0xfffff
    800031f0:	2a4080e7          	jalr	676(ra) # 80002490 <bread>
    800031f4:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800031f6:	3ff97713          	andi	a4,s2,1023
    800031fa:	40ec87bb          	subw	a5,s9,a4
    800031fe:	413b06bb          	subw	a3,s6,s3
    80003202:	8d3e                	mv	s10,a5
    80003204:	2781                	sext.w	a5,a5
    80003206:	0006861b          	sext.w	a2,a3
    8000320a:	f8f674e3          	bgeu	a2,a5,80003192 <writei+0x4c>
    8000320e:	8d36                	mv	s10,a3
    80003210:	b749                	j	80003192 <writei+0x4c>
      brelse(bp);
    80003212:	8526                	mv	a0,s1
    80003214:	fffff097          	auipc	ra,0xfffff
    80003218:	444080e7          	jalr	1092(ra) # 80002658 <brelse>
  }

  if(off > ip->size)
    8000321c:	054aa783          	lw	a5,84(s5)
    80003220:	0127f463          	bgeu	a5,s2,80003228 <writei+0xe2>
    ip->size = off;
    80003224:	052aaa23          	sw	s2,84(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003228:	8556                	mv	a0,s5
    8000322a:	00000097          	auipc	ra,0x0
    8000322e:	a92080e7          	jalr	-1390(ra) # 80002cbc <iupdate>

  return tot;
    80003232:	0009851b          	sext.w	a0,s3
}
    80003236:	70a6                	ld	ra,104(sp)
    80003238:	7406                	ld	s0,96(sp)
    8000323a:	64e6                	ld	s1,88(sp)
    8000323c:	6946                	ld	s2,80(sp)
    8000323e:	69a6                	ld	s3,72(sp)
    80003240:	6a06                	ld	s4,64(sp)
    80003242:	7ae2                	ld	s5,56(sp)
    80003244:	7b42                	ld	s6,48(sp)
    80003246:	7ba2                	ld	s7,40(sp)
    80003248:	7c02                	ld	s8,32(sp)
    8000324a:	6ce2                	ld	s9,24(sp)
    8000324c:	6d42                	ld	s10,16(sp)
    8000324e:	6da2                	ld	s11,8(sp)
    80003250:	6165                	addi	sp,sp,112
    80003252:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003254:	89da                	mv	s3,s6
    80003256:	bfc9                	j	80003228 <writei+0xe2>
    return -1;
    80003258:	557d                	li	a0,-1
}
    8000325a:	8082                	ret
    return -1;
    8000325c:	557d                	li	a0,-1
    8000325e:	bfe1                	j	80003236 <writei+0xf0>
    return -1;
    80003260:	557d                	li	a0,-1
    80003262:	bfd1                	j	80003236 <writei+0xf0>

0000000080003264 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003264:	1141                	addi	sp,sp,-16
    80003266:	e406                	sd	ra,8(sp)
    80003268:	e022                	sd	s0,0(sp)
    8000326a:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000326c:	4639                	li	a2,14
    8000326e:	ffffd097          	auipc	ra,0xffffd
    80003272:	0da080e7          	jalr	218(ra) # 80000348 <strncmp>
}
    80003276:	60a2                	ld	ra,8(sp)
    80003278:	6402                	ld	s0,0(sp)
    8000327a:	0141                	addi	sp,sp,16
    8000327c:	8082                	ret

000000008000327e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000327e:	7139                	addi	sp,sp,-64
    80003280:	fc06                	sd	ra,56(sp)
    80003282:	f822                	sd	s0,48(sp)
    80003284:	f426                	sd	s1,40(sp)
    80003286:	f04a                	sd	s2,32(sp)
    80003288:	ec4e                	sd	s3,24(sp)
    8000328a:	e852                	sd	s4,16(sp)
    8000328c:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000328e:	04c51703          	lh	a4,76(a0)
    80003292:	4785                	li	a5,1
    80003294:	00f71a63          	bne	a4,a5,800032a8 <dirlookup+0x2a>
    80003298:	892a                	mv	s2,a0
    8000329a:	89ae                	mv	s3,a1
    8000329c:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000329e:	497c                	lw	a5,84(a0)
    800032a0:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800032a2:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032a4:	e79d                	bnez	a5,800032d2 <dirlookup+0x54>
    800032a6:	a8a5                	j	8000331e <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800032a8:	00005517          	auipc	a0,0x5
    800032ac:	30850513          	addi	a0,a0,776 # 800085b0 <syscalls+0x1a0>
    800032b0:	00003097          	auipc	ra,0x3
    800032b4:	f26080e7          	jalr	-218(ra) # 800061d6 <panic>
      panic("dirlookup read");
    800032b8:	00005517          	auipc	a0,0x5
    800032bc:	31050513          	addi	a0,a0,784 # 800085c8 <syscalls+0x1b8>
    800032c0:	00003097          	auipc	ra,0x3
    800032c4:	f16080e7          	jalr	-234(ra) # 800061d6 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032c8:	24c1                	addiw	s1,s1,16
    800032ca:	05492783          	lw	a5,84(s2)
    800032ce:	04f4f763          	bgeu	s1,a5,8000331c <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032d2:	4741                	li	a4,16
    800032d4:	86a6                	mv	a3,s1
    800032d6:	fc040613          	addi	a2,s0,-64
    800032da:	4581                	li	a1,0
    800032dc:	854a                	mv	a0,s2
    800032de:	00000097          	auipc	ra,0x0
    800032e2:	d70080e7          	jalr	-656(ra) # 8000304e <readi>
    800032e6:	47c1                	li	a5,16
    800032e8:	fcf518e3          	bne	a0,a5,800032b8 <dirlookup+0x3a>
    if(de.inum == 0)
    800032ec:	fc045783          	lhu	a5,-64(s0)
    800032f0:	dfe1                	beqz	a5,800032c8 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800032f2:	fc240593          	addi	a1,s0,-62
    800032f6:	854e                	mv	a0,s3
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	f6c080e7          	jalr	-148(ra) # 80003264 <namecmp>
    80003300:	f561                	bnez	a0,800032c8 <dirlookup+0x4a>
      if(poff)
    80003302:	000a0463          	beqz	s4,8000330a <dirlookup+0x8c>
        *poff = off;
    80003306:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    8000330a:	fc045583          	lhu	a1,-64(s0)
    8000330e:	00092503          	lw	a0,0(s2)
    80003312:	fffff097          	auipc	ra,0xfffff
    80003316:	73c080e7          	jalr	1852(ra) # 80002a4e <iget>
    8000331a:	a011                	j	8000331e <dirlookup+0xa0>
  return 0;
    8000331c:	4501                	li	a0,0
}
    8000331e:	70e2                	ld	ra,56(sp)
    80003320:	7442                	ld	s0,48(sp)
    80003322:	74a2                	ld	s1,40(sp)
    80003324:	7902                	ld	s2,32(sp)
    80003326:	69e2                	ld	s3,24(sp)
    80003328:	6a42                	ld	s4,16(sp)
    8000332a:	6121                	addi	sp,sp,64
    8000332c:	8082                	ret

000000008000332e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    8000332e:	711d                	addi	sp,sp,-96
    80003330:	ec86                	sd	ra,88(sp)
    80003332:	e8a2                	sd	s0,80(sp)
    80003334:	e4a6                	sd	s1,72(sp)
    80003336:	e0ca                	sd	s2,64(sp)
    80003338:	fc4e                	sd	s3,56(sp)
    8000333a:	f852                	sd	s4,48(sp)
    8000333c:	f456                	sd	s5,40(sp)
    8000333e:	f05a                	sd	s6,32(sp)
    80003340:	ec5e                	sd	s7,24(sp)
    80003342:	e862                	sd	s8,16(sp)
    80003344:	e466                	sd	s9,8(sp)
    80003346:	1080                	addi	s0,sp,96
    80003348:	84aa                	mv	s1,a0
    8000334a:	8b2e                	mv	s6,a1
    8000334c:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000334e:	00054703          	lbu	a4,0(a0)
    80003352:	02f00793          	li	a5,47
    80003356:	02f70363          	beq	a4,a5,8000337c <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000335a:	ffffe097          	auipc	ra,0xffffe
    8000335e:	c5e080e7          	jalr	-930(ra) # 80000fb8 <myproc>
    80003362:	15853503          	ld	a0,344(a0)
    80003366:	00000097          	auipc	ra,0x0
    8000336a:	9e2080e7          	jalr	-1566(ra) # 80002d48 <idup>
    8000336e:	89aa                	mv	s3,a0
  while(*path == '/')
    80003370:	02f00913          	li	s2,47
  len = path - s;
    80003374:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003376:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003378:	4c05                	li	s8,1
    8000337a:	a865                	j	80003432 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    8000337c:	4585                	li	a1,1
    8000337e:	4505                	li	a0,1
    80003380:	fffff097          	auipc	ra,0xfffff
    80003384:	6ce080e7          	jalr	1742(ra) # 80002a4e <iget>
    80003388:	89aa                	mv	s3,a0
    8000338a:	b7dd                	j	80003370 <namex+0x42>
      iunlockput(ip);
    8000338c:	854e                	mv	a0,s3
    8000338e:	00000097          	auipc	ra,0x0
    80003392:	c6e080e7          	jalr	-914(ra) # 80002ffc <iunlockput>
      return 0;
    80003396:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003398:	854e                	mv	a0,s3
    8000339a:	60e6                	ld	ra,88(sp)
    8000339c:	6446                	ld	s0,80(sp)
    8000339e:	64a6                	ld	s1,72(sp)
    800033a0:	6906                	ld	s2,64(sp)
    800033a2:	79e2                	ld	s3,56(sp)
    800033a4:	7a42                	ld	s4,48(sp)
    800033a6:	7aa2                	ld	s5,40(sp)
    800033a8:	7b02                	ld	s6,32(sp)
    800033aa:	6be2                	ld	s7,24(sp)
    800033ac:	6c42                	ld	s8,16(sp)
    800033ae:	6ca2                	ld	s9,8(sp)
    800033b0:	6125                	addi	sp,sp,96
    800033b2:	8082                	ret
      iunlock(ip);
    800033b4:	854e                	mv	a0,s3
    800033b6:	00000097          	auipc	ra,0x0
    800033ba:	a9c080e7          	jalr	-1380(ra) # 80002e52 <iunlock>
      return ip;
    800033be:	bfe9                	j	80003398 <namex+0x6a>
      iunlockput(ip);
    800033c0:	854e                	mv	a0,s3
    800033c2:	00000097          	auipc	ra,0x0
    800033c6:	c3a080e7          	jalr	-966(ra) # 80002ffc <iunlockput>
      return 0;
    800033ca:	89d2                	mv	s3,s4
    800033cc:	b7f1                	j	80003398 <namex+0x6a>
  len = path - s;
    800033ce:	40b48633          	sub	a2,s1,a1
    800033d2:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    800033d6:	094cd463          	bge	s9,s4,8000345e <namex+0x130>
    memmove(name, s, DIRSIZ);
    800033da:	4639                	li	a2,14
    800033dc:	8556                	mv	a0,s5
    800033de:	ffffd097          	auipc	ra,0xffffd
    800033e2:	ef2080e7          	jalr	-270(ra) # 800002d0 <memmove>
  while(*path == '/')
    800033e6:	0004c783          	lbu	a5,0(s1)
    800033ea:	01279763          	bne	a5,s2,800033f8 <namex+0xca>
    path++;
    800033ee:	0485                	addi	s1,s1,1
  while(*path == '/')
    800033f0:	0004c783          	lbu	a5,0(s1)
    800033f4:	ff278de3          	beq	a5,s2,800033ee <namex+0xc0>
    ilock(ip);
    800033f8:	854e                	mv	a0,s3
    800033fa:	00000097          	auipc	ra,0x0
    800033fe:	98c080e7          	jalr	-1652(ra) # 80002d86 <ilock>
    if(ip->type != T_DIR){
    80003402:	04c99783          	lh	a5,76(s3)
    80003406:	f98793e3          	bne	a5,s8,8000338c <namex+0x5e>
    if(nameiparent && *path == '\0'){
    8000340a:	000b0563          	beqz	s6,80003414 <namex+0xe6>
    8000340e:	0004c783          	lbu	a5,0(s1)
    80003412:	d3cd                	beqz	a5,800033b4 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003414:	865e                	mv	a2,s7
    80003416:	85d6                	mv	a1,s5
    80003418:	854e                	mv	a0,s3
    8000341a:	00000097          	auipc	ra,0x0
    8000341e:	e64080e7          	jalr	-412(ra) # 8000327e <dirlookup>
    80003422:	8a2a                	mv	s4,a0
    80003424:	dd51                	beqz	a0,800033c0 <namex+0x92>
    iunlockput(ip);
    80003426:	854e                	mv	a0,s3
    80003428:	00000097          	auipc	ra,0x0
    8000342c:	bd4080e7          	jalr	-1068(ra) # 80002ffc <iunlockput>
    ip = next;
    80003430:	89d2                	mv	s3,s4
  while(*path == '/')
    80003432:	0004c783          	lbu	a5,0(s1)
    80003436:	05279763          	bne	a5,s2,80003484 <namex+0x156>
    path++;
    8000343a:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000343c:	0004c783          	lbu	a5,0(s1)
    80003440:	ff278de3          	beq	a5,s2,8000343a <namex+0x10c>
  if(*path == 0)
    80003444:	c79d                	beqz	a5,80003472 <namex+0x144>
    path++;
    80003446:	85a6                	mv	a1,s1
  len = path - s;
    80003448:	8a5e                	mv	s4,s7
    8000344a:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    8000344c:	01278963          	beq	a5,s2,8000345e <namex+0x130>
    80003450:	dfbd                	beqz	a5,800033ce <namex+0xa0>
    path++;
    80003452:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003454:	0004c783          	lbu	a5,0(s1)
    80003458:	ff279ce3          	bne	a5,s2,80003450 <namex+0x122>
    8000345c:	bf8d                	j	800033ce <namex+0xa0>
    memmove(name, s, len);
    8000345e:	2601                	sext.w	a2,a2
    80003460:	8556                	mv	a0,s5
    80003462:	ffffd097          	auipc	ra,0xffffd
    80003466:	e6e080e7          	jalr	-402(ra) # 800002d0 <memmove>
    name[len] = 0;
    8000346a:	9a56                	add	s4,s4,s5
    8000346c:	000a0023          	sb	zero,0(s4)
    80003470:	bf9d                	j	800033e6 <namex+0xb8>
  if(nameiparent){
    80003472:	f20b03e3          	beqz	s6,80003398 <namex+0x6a>
    iput(ip);
    80003476:	854e                	mv	a0,s3
    80003478:	00000097          	auipc	ra,0x0
    8000347c:	adc080e7          	jalr	-1316(ra) # 80002f54 <iput>
    return 0;
    80003480:	4981                	li	s3,0
    80003482:	bf19                	j	80003398 <namex+0x6a>
  if(*path == 0)
    80003484:	d7fd                	beqz	a5,80003472 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003486:	0004c783          	lbu	a5,0(s1)
    8000348a:	85a6                	mv	a1,s1
    8000348c:	b7d1                	j	80003450 <namex+0x122>

000000008000348e <dirlink>:
{
    8000348e:	7139                	addi	sp,sp,-64
    80003490:	fc06                	sd	ra,56(sp)
    80003492:	f822                	sd	s0,48(sp)
    80003494:	f426                	sd	s1,40(sp)
    80003496:	f04a                	sd	s2,32(sp)
    80003498:	ec4e                	sd	s3,24(sp)
    8000349a:	e852                	sd	s4,16(sp)
    8000349c:	0080                	addi	s0,sp,64
    8000349e:	892a                	mv	s2,a0
    800034a0:	8a2e                	mv	s4,a1
    800034a2:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800034a4:	4601                	li	a2,0
    800034a6:	00000097          	auipc	ra,0x0
    800034aa:	dd8080e7          	jalr	-552(ra) # 8000327e <dirlookup>
    800034ae:	e93d                	bnez	a0,80003524 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034b0:	05492483          	lw	s1,84(s2)
    800034b4:	c49d                	beqz	s1,800034e2 <dirlink+0x54>
    800034b6:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034b8:	4741                	li	a4,16
    800034ba:	86a6                	mv	a3,s1
    800034bc:	fc040613          	addi	a2,s0,-64
    800034c0:	4581                	li	a1,0
    800034c2:	854a                	mv	a0,s2
    800034c4:	00000097          	auipc	ra,0x0
    800034c8:	b8a080e7          	jalr	-1142(ra) # 8000304e <readi>
    800034cc:	47c1                	li	a5,16
    800034ce:	06f51163          	bne	a0,a5,80003530 <dirlink+0xa2>
    if(de.inum == 0)
    800034d2:	fc045783          	lhu	a5,-64(s0)
    800034d6:	c791                	beqz	a5,800034e2 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800034d8:	24c1                	addiw	s1,s1,16
    800034da:	05492783          	lw	a5,84(s2)
    800034de:	fcf4ede3          	bltu	s1,a5,800034b8 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800034e2:	4639                	li	a2,14
    800034e4:	85d2                	mv	a1,s4
    800034e6:	fc240513          	addi	a0,s0,-62
    800034ea:	ffffd097          	auipc	ra,0xffffd
    800034ee:	e9a080e7          	jalr	-358(ra) # 80000384 <strncpy>
  de.inum = inum;
    800034f2:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034f6:	4741                	li	a4,16
    800034f8:	86a6                	mv	a3,s1
    800034fa:	fc040613          	addi	a2,s0,-64
    800034fe:	4581                	li	a1,0
    80003500:	854a                	mv	a0,s2
    80003502:	00000097          	auipc	ra,0x0
    80003506:	c44080e7          	jalr	-956(ra) # 80003146 <writei>
    8000350a:	1541                	addi	a0,a0,-16
    8000350c:	00a03533          	snez	a0,a0
    80003510:	40a00533          	neg	a0,a0
}
    80003514:	70e2                	ld	ra,56(sp)
    80003516:	7442                	ld	s0,48(sp)
    80003518:	74a2                	ld	s1,40(sp)
    8000351a:	7902                	ld	s2,32(sp)
    8000351c:	69e2                	ld	s3,24(sp)
    8000351e:	6a42                	ld	s4,16(sp)
    80003520:	6121                	addi	sp,sp,64
    80003522:	8082                	ret
    iput(ip);
    80003524:	00000097          	auipc	ra,0x0
    80003528:	a30080e7          	jalr	-1488(ra) # 80002f54 <iput>
    return -1;
    8000352c:	557d                	li	a0,-1
    8000352e:	b7dd                	j	80003514 <dirlink+0x86>
      panic("dirlink read");
    80003530:	00005517          	auipc	a0,0x5
    80003534:	0a850513          	addi	a0,a0,168 # 800085d8 <syscalls+0x1c8>
    80003538:	00003097          	auipc	ra,0x3
    8000353c:	c9e080e7          	jalr	-866(ra) # 800061d6 <panic>

0000000080003540 <namei>:

struct inode*
namei(char *path)
{
    80003540:	1101                	addi	sp,sp,-32
    80003542:	ec06                	sd	ra,24(sp)
    80003544:	e822                	sd	s0,16(sp)
    80003546:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003548:	fe040613          	addi	a2,s0,-32
    8000354c:	4581                	li	a1,0
    8000354e:	00000097          	auipc	ra,0x0
    80003552:	de0080e7          	jalr	-544(ra) # 8000332e <namex>
}
    80003556:	60e2                	ld	ra,24(sp)
    80003558:	6442                	ld	s0,16(sp)
    8000355a:	6105                	addi	sp,sp,32
    8000355c:	8082                	ret

000000008000355e <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000355e:	1141                	addi	sp,sp,-16
    80003560:	e406                	sd	ra,8(sp)
    80003562:	e022                	sd	s0,0(sp)
    80003564:	0800                	addi	s0,sp,16
    80003566:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003568:	4585                	li	a1,1
    8000356a:	00000097          	auipc	ra,0x0
    8000356e:	dc4080e7          	jalr	-572(ra) # 8000332e <namex>
}
    80003572:	60a2                	ld	ra,8(sp)
    80003574:	6402                	ld	s0,0(sp)
    80003576:	0141                	addi	sp,sp,16
    80003578:	8082                	ret

000000008000357a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000357a:	1101                	addi	sp,sp,-32
    8000357c:	ec06                	sd	ra,24(sp)
    8000357e:	e822                	sd	s0,16(sp)
    80003580:	e426                	sd	s1,8(sp)
    80003582:	e04a                	sd	s2,0(sp)
    80003584:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003586:	00019917          	auipc	s2,0x19
    8000358a:	00a90913          	addi	s2,s2,10 # 8001c590 <log>
    8000358e:	02092583          	lw	a1,32(s2)
    80003592:	03092503          	lw	a0,48(s2)
    80003596:	fffff097          	auipc	ra,0xfffff
    8000359a:	efa080e7          	jalr	-262(ra) # 80002490 <bread>
    8000359e:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800035a0:	03492683          	lw	a3,52(s2)
    800035a4:	d134                	sw	a3,96(a0)
  for (i = 0; i < log.lh.n; i++) {
    800035a6:	02d05763          	blez	a3,800035d4 <write_head+0x5a>
    800035aa:	00019797          	auipc	a5,0x19
    800035ae:	01e78793          	addi	a5,a5,30 # 8001c5c8 <log+0x38>
    800035b2:	06450713          	addi	a4,a0,100
    800035b6:	36fd                	addiw	a3,a3,-1
    800035b8:	1682                	slli	a3,a3,0x20
    800035ba:	9281                	srli	a3,a3,0x20
    800035bc:	068a                	slli	a3,a3,0x2
    800035be:	00019617          	auipc	a2,0x19
    800035c2:	00e60613          	addi	a2,a2,14 # 8001c5cc <log+0x3c>
    800035c6:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    800035c8:	4390                	lw	a2,0(a5)
    800035ca:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800035cc:	0791                	addi	a5,a5,4
    800035ce:	0711                	addi	a4,a4,4
    800035d0:	fed79ce3          	bne	a5,a3,800035c8 <write_head+0x4e>
  }
  bwrite(buf);
    800035d4:	8526                	mv	a0,s1
    800035d6:	fffff097          	auipc	ra,0xfffff
    800035da:	044080e7          	jalr	68(ra) # 8000261a <bwrite>
  brelse(buf);
    800035de:	8526                	mv	a0,s1
    800035e0:	fffff097          	auipc	ra,0xfffff
    800035e4:	078080e7          	jalr	120(ra) # 80002658 <brelse>
}
    800035e8:	60e2                	ld	ra,24(sp)
    800035ea:	6442                	ld	s0,16(sp)
    800035ec:	64a2                	ld	s1,8(sp)
    800035ee:	6902                	ld	s2,0(sp)
    800035f0:	6105                	addi	sp,sp,32
    800035f2:	8082                	ret

00000000800035f4 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035f4:	00019797          	auipc	a5,0x19
    800035f8:	fd07a783          	lw	a5,-48(a5) # 8001c5c4 <log+0x34>
    800035fc:	0af05d63          	blez	a5,800036b6 <install_trans+0xc2>
{
    80003600:	7139                	addi	sp,sp,-64
    80003602:	fc06                	sd	ra,56(sp)
    80003604:	f822                	sd	s0,48(sp)
    80003606:	f426                	sd	s1,40(sp)
    80003608:	f04a                	sd	s2,32(sp)
    8000360a:	ec4e                	sd	s3,24(sp)
    8000360c:	e852                	sd	s4,16(sp)
    8000360e:	e456                	sd	s5,8(sp)
    80003610:	e05a                	sd	s6,0(sp)
    80003612:	0080                	addi	s0,sp,64
    80003614:	8b2a                	mv	s6,a0
    80003616:	00019a97          	auipc	s5,0x19
    8000361a:	fb2a8a93          	addi	s5,s5,-78 # 8001c5c8 <log+0x38>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000361e:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003620:	00019997          	auipc	s3,0x19
    80003624:	f7098993          	addi	s3,s3,-144 # 8001c590 <log>
    80003628:	a035                	j	80003654 <install_trans+0x60>
      bunpin(dbuf);
    8000362a:	8526                	mv	a0,s1
    8000362c:	fffff097          	auipc	ra,0xfffff
    80003630:	13a080e7          	jalr	314(ra) # 80002766 <bunpin>
    brelse(lbuf);
    80003634:	854a                	mv	a0,s2
    80003636:	fffff097          	auipc	ra,0xfffff
    8000363a:	022080e7          	jalr	34(ra) # 80002658 <brelse>
    brelse(dbuf);
    8000363e:	8526                	mv	a0,s1
    80003640:	fffff097          	auipc	ra,0xfffff
    80003644:	018080e7          	jalr	24(ra) # 80002658 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003648:	2a05                	addiw	s4,s4,1
    8000364a:	0a91                	addi	s5,s5,4
    8000364c:	0349a783          	lw	a5,52(s3)
    80003650:	04fa5963          	bge	s4,a5,800036a2 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003654:	0209a583          	lw	a1,32(s3)
    80003658:	014585bb          	addw	a1,a1,s4
    8000365c:	2585                	addiw	a1,a1,1
    8000365e:	0309a503          	lw	a0,48(s3)
    80003662:	fffff097          	auipc	ra,0xfffff
    80003666:	e2e080e7          	jalr	-466(ra) # 80002490 <bread>
    8000366a:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000366c:	000aa583          	lw	a1,0(s5)
    80003670:	0309a503          	lw	a0,48(s3)
    80003674:	fffff097          	auipc	ra,0xfffff
    80003678:	e1c080e7          	jalr	-484(ra) # 80002490 <bread>
    8000367c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000367e:	40000613          	li	a2,1024
    80003682:	06090593          	addi	a1,s2,96
    80003686:	06050513          	addi	a0,a0,96
    8000368a:	ffffd097          	auipc	ra,0xffffd
    8000368e:	c46080e7          	jalr	-954(ra) # 800002d0 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003692:	8526                	mv	a0,s1
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	f86080e7          	jalr	-122(ra) # 8000261a <bwrite>
    if(recovering == 0)
    8000369c:	f80b1ce3          	bnez	s6,80003634 <install_trans+0x40>
    800036a0:	b769                	j	8000362a <install_trans+0x36>
}
    800036a2:	70e2                	ld	ra,56(sp)
    800036a4:	7442                	ld	s0,48(sp)
    800036a6:	74a2                	ld	s1,40(sp)
    800036a8:	7902                	ld	s2,32(sp)
    800036aa:	69e2                	ld	s3,24(sp)
    800036ac:	6a42                	ld	s4,16(sp)
    800036ae:	6aa2                	ld	s5,8(sp)
    800036b0:	6b02                	ld	s6,0(sp)
    800036b2:	6121                	addi	sp,sp,64
    800036b4:	8082                	ret
    800036b6:	8082                	ret

00000000800036b8 <initlog>:
{
    800036b8:	7179                	addi	sp,sp,-48
    800036ba:	f406                	sd	ra,40(sp)
    800036bc:	f022                	sd	s0,32(sp)
    800036be:	ec26                	sd	s1,24(sp)
    800036c0:	e84a                	sd	s2,16(sp)
    800036c2:	e44e                	sd	s3,8(sp)
    800036c4:	1800                	addi	s0,sp,48
    800036c6:	892a                	mv	s2,a0
    800036c8:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800036ca:	00019497          	auipc	s1,0x19
    800036ce:	ec648493          	addi	s1,s1,-314 # 8001c590 <log>
    800036d2:	00005597          	auipc	a1,0x5
    800036d6:	f1658593          	addi	a1,a1,-234 # 800085e8 <syscalls+0x1d8>
    800036da:	8526                	mv	a0,s1
    800036dc:	00003097          	auipc	ra,0x3
    800036e0:	1aa080e7          	jalr	426(ra) # 80006886 <initlock>
  log.start = sb->logstart;
    800036e4:	0149a583          	lw	a1,20(s3)
    800036e8:	d08c                	sw	a1,32(s1)
  log.size = sb->nlog;
    800036ea:	0109a783          	lw	a5,16(s3)
    800036ee:	d0dc                	sw	a5,36(s1)
  log.dev = dev;
    800036f0:	0324a823          	sw	s2,48(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036f4:	854a                	mv	a0,s2
    800036f6:	fffff097          	auipc	ra,0xfffff
    800036fa:	d9a080e7          	jalr	-614(ra) # 80002490 <bread>
  log.lh.n = lh->n;
    800036fe:	513c                	lw	a5,96(a0)
    80003700:	d8dc                	sw	a5,52(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003702:	02f05563          	blez	a5,8000372c <initlog+0x74>
    80003706:	06450713          	addi	a4,a0,100
    8000370a:	00019697          	auipc	a3,0x19
    8000370e:	ebe68693          	addi	a3,a3,-322 # 8001c5c8 <log+0x38>
    80003712:	37fd                	addiw	a5,a5,-1
    80003714:	1782                	slli	a5,a5,0x20
    80003716:	9381                	srli	a5,a5,0x20
    80003718:	078a                	slli	a5,a5,0x2
    8000371a:	06850613          	addi	a2,a0,104
    8000371e:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003720:	4310                	lw	a2,0(a4)
    80003722:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    80003724:	0711                	addi	a4,a4,4
    80003726:	0691                	addi	a3,a3,4
    80003728:	fef71ce3          	bne	a4,a5,80003720 <initlog+0x68>
  brelse(buf);
    8000372c:	fffff097          	auipc	ra,0xfffff
    80003730:	f2c080e7          	jalr	-212(ra) # 80002658 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003734:	4505                	li	a0,1
    80003736:	00000097          	auipc	ra,0x0
    8000373a:	ebe080e7          	jalr	-322(ra) # 800035f4 <install_trans>
  log.lh.n = 0;
    8000373e:	00019797          	auipc	a5,0x19
    80003742:	e807a323          	sw	zero,-378(a5) # 8001c5c4 <log+0x34>
  write_head(); // clear the log
    80003746:	00000097          	auipc	ra,0x0
    8000374a:	e34080e7          	jalr	-460(ra) # 8000357a <write_head>
}
    8000374e:	70a2                	ld	ra,40(sp)
    80003750:	7402                	ld	s0,32(sp)
    80003752:	64e2                	ld	s1,24(sp)
    80003754:	6942                	ld	s2,16(sp)
    80003756:	69a2                	ld	s3,8(sp)
    80003758:	6145                	addi	sp,sp,48
    8000375a:	8082                	ret

000000008000375c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000375c:	1101                	addi	sp,sp,-32
    8000375e:	ec06                	sd	ra,24(sp)
    80003760:	e822                	sd	s0,16(sp)
    80003762:	e426                	sd	s1,8(sp)
    80003764:	e04a                	sd	s2,0(sp)
    80003766:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003768:	00019517          	auipc	a0,0x19
    8000376c:	e2850513          	addi	a0,a0,-472 # 8001c590 <log>
    80003770:	00003097          	auipc	ra,0x3
    80003774:	f9a080e7          	jalr	-102(ra) # 8000670a <acquire>
  while(1){
    if(log.committing){
    80003778:	00019497          	auipc	s1,0x19
    8000377c:	e1848493          	addi	s1,s1,-488 # 8001c590 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003780:	4979                	li	s2,30
    80003782:	a039                	j	80003790 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003784:	85a6                	mv	a1,s1
    80003786:	8526                	mv	a0,s1
    80003788:	ffffe097          	auipc	ra,0xffffe
    8000378c:	ed8080e7          	jalr	-296(ra) # 80001660 <sleep>
    if(log.committing){
    80003790:	54dc                	lw	a5,44(s1)
    80003792:	fbed                	bnez	a5,80003784 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003794:	549c                	lw	a5,40(s1)
    80003796:	0017871b          	addiw	a4,a5,1
    8000379a:	0007069b          	sext.w	a3,a4
    8000379e:	0027179b          	slliw	a5,a4,0x2
    800037a2:	9fb9                	addw	a5,a5,a4
    800037a4:	0017979b          	slliw	a5,a5,0x1
    800037a8:	58d8                	lw	a4,52(s1)
    800037aa:	9fb9                	addw	a5,a5,a4
    800037ac:	00f95963          	bge	s2,a5,800037be <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800037b0:	85a6                	mv	a1,s1
    800037b2:	8526                	mv	a0,s1
    800037b4:	ffffe097          	auipc	ra,0xffffe
    800037b8:	eac080e7          	jalr	-340(ra) # 80001660 <sleep>
    800037bc:	bfd1                	j	80003790 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800037be:	00019517          	auipc	a0,0x19
    800037c2:	dd250513          	addi	a0,a0,-558 # 8001c590 <log>
    800037c6:	d514                	sw	a3,40(a0)
      release(&log.lock);
    800037c8:	00003097          	auipc	ra,0x3
    800037cc:	012080e7          	jalr	18(ra) # 800067da <release>
      break;
    }
  }
}
    800037d0:	60e2                	ld	ra,24(sp)
    800037d2:	6442                	ld	s0,16(sp)
    800037d4:	64a2                	ld	s1,8(sp)
    800037d6:	6902                	ld	s2,0(sp)
    800037d8:	6105                	addi	sp,sp,32
    800037da:	8082                	ret

00000000800037dc <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800037dc:	7139                	addi	sp,sp,-64
    800037de:	fc06                	sd	ra,56(sp)
    800037e0:	f822                	sd	s0,48(sp)
    800037e2:	f426                	sd	s1,40(sp)
    800037e4:	f04a                	sd	s2,32(sp)
    800037e6:	ec4e                	sd	s3,24(sp)
    800037e8:	e852                	sd	s4,16(sp)
    800037ea:	e456                	sd	s5,8(sp)
    800037ec:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800037ee:	00019497          	auipc	s1,0x19
    800037f2:	da248493          	addi	s1,s1,-606 # 8001c590 <log>
    800037f6:	8526                	mv	a0,s1
    800037f8:	00003097          	auipc	ra,0x3
    800037fc:	f12080e7          	jalr	-238(ra) # 8000670a <acquire>
  log.outstanding -= 1;
    80003800:	549c                	lw	a5,40(s1)
    80003802:	37fd                	addiw	a5,a5,-1
    80003804:	0007891b          	sext.w	s2,a5
    80003808:	d49c                	sw	a5,40(s1)
  if(log.committing)
    8000380a:	54dc                	lw	a5,44(s1)
    8000380c:	efb9                	bnez	a5,8000386a <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    8000380e:	06091663          	bnez	s2,8000387a <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    80003812:	00019497          	auipc	s1,0x19
    80003816:	d7e48493          	addi	s1,s1,-642 # 8001c590 <log>
    8000381a:	4785                	li	a5,1
    8000381c:	d4dc                	sw	a5,44(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    8000381e:	8526                	mv	a0,s1
    80003820:	00003097          	auipc	ra,0x3
    80003824:	fba080e7          	jalr	-70(ra) # 800067da <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003828:	58dc                	lw	a5,52(s1)
    8000382a:	06f04763          	bgtz	a5,80003898 <end_op+0xbc>
    acquire(&log.lock);
    8000382e:	00019497          	auipc	s1,0x19
    80003832:	d6248493          	addi	s1,s1,-670 # 8001c590 <log>
    80003836:	8526                	mv	a0,s1
    80003838:	00003097          	auipc	ra,0x3
    8000383c:	ed2080e7          	jalr	-302(ra) # 8000670a <acquire>
    log.committing = 0;
    80003840:	0204a623          	sw	zero,44(s1)
    wakeup(&log);
    80003844:	8526                	mv	a0,s1
    80003846:	ffffe097          	auipc	ra,0xffffe
    8000384a:	e7e080e7          	jalr	-386(ra) # 800016c4 <wakeup>
    release(&log.lock);
    8000384e:	8526                	mv	a0,s1
    80003850:	00003097          	auipc	ra,0x3
    80003854:	f8a080e7          	jalr	-118(ra) # 800067da <release>
}
    80003858:	70e2                	ld	ra,56(sp)
    8000385a:	7442                	ld	s0,48(sp)
    8000385c:	74a2                	ld	s1,40(sp)
    8000385e:	7902                	ld	s2,32(sp)
    80003860:	69e2                	ld	s3,24(sp)
    80003862:	6a42                	ld	s4,16(sp)
    80003864:	6aa2                	ld	s5,8(sp)
    80003866:	6121                	addi	sp,sp,64
    80003868:	8082                	ret
    panic("log.committing");
    8000386a:	00005517          	auipc	a0,0x5
    8000386e:	d8650513          	addi	a0,a0,-634 # 800085f0 <syscalls+0x1e0>
    80003872:	00003097          	auipc	ra,0x3
    80003876:	964080e7          	jalr	-1692(ra) # 800061d6 <panic>
    wakeup(&log);
    8000387a:	00019497          	auipc	s1,0x19
    8000387e:	d1648493          	addi	s1,s1,-746 # 8001c590 <log>
    80003882:	8526                	mv	a0,s1
    80003884:	ffffe097          	auipc	ra,0xffffe
    80003888:	e40080e7          	jalr	-448(ra) # 800016c4 <wakeup>
  release(&log.lock);
    8000388c:	8526                	mv	a0,s1
    8000388e:	00003097          	auipc	ra,0x3
    80003892:	f4c080e7          	jalr	-180(ra) # 800067da <release>
  if(do_commit){
    80003896:	b7c9                	j	80003858 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003898:	00019a97          	auipc	s5,0x19
    8000389c:	d30a8a93          	addi	s5,s5,-720 # 8001c5c8 <log+0x38>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800038a0:	00019a17          	auipc	s4,0x19
    800038a4:	cf0a0a13          	addi	s4,s4,-784 # 8001c590 <log>
    800038a8:	020a2583          	lw	a1,32(s4)
    800038ac:	012585bb          	addw	a1,a1,s2
    800038b0:	2585                	addiw	a1,a1,1
    800038b2:	030a2503          	lw	a0,48(s4)
    800038b6:	fffff097          	auipc	ra,0xfffff
    800038ba:	bda080e7          	jalr	-1062(ra) # 80002490 <bread>
    800038be:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800038c0:	000aa583          	lw	a1,0(s5)
    800038c4:	030a2503          	lw	a0,48(s4)
    800038c8:	fffff097          	auipc	ra,0xfffff
    800038cc:	bc8080e7          	jalr	-1080(ra) # 80002490 <bread>
    800038d0:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800038d2:	40000613          	li	a2,1024
    800038d6:	06050593          	addi	a1,a0,96
    800038da:	06048513          	addi	a0,s1,96
    800038de:	ffffd097          	auipc	ra,0xffffd
    800038e2:	9f2080e7          	jalr	-1550(ra) # 800002d0 <memmove>
    bwrite(to);  // write the log
    800038e6:	8526                	mv	a0,s1
    800038e8:	fffff097          	auipc	ra,0xfffff
    800038ec:	d32080e7          	jalr	-718(ra) # 8000261a <bwrite>
    brelse(from);
    800038f0:	854e                	mv	a0,s3
    800038f2:	fffff097          	auipc	ra,0xfffff
    800038f6:	d66080e7          	jalr	-666(ra) # 80002658 <brelse>
    brelse(to);
    800038fa:	8526                	mv	a0,s1
    800038fc:	fffff097          	auipc	ra,0xfffff
    80003900:	d5c080e7          	jalr	-676(ra) # 80002658 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003904:	2905                	addiw	s2,s2,1
    80003906:	0a91                	addi	s5,s5,4
    80003908:	034a2783          	lw	a5,52(s4)
    8000390c:	f8f94ee3          	blt	s2,a5,800038a8 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003910:	00000097          	auipc	ra,0x0
    80003914:	c6a080e7          	jalr	-918(ra) # 8000357a <write_head>
    install_trans(0); // Now install writes to home locations
    80003918:	4501                	li	a0,0
    8000391a:	00000097          	auipc	ra,0x0
    8000391e:	cda080e7          	jalr	-806(ra) # 800035f4 <install_trans>
    log.lh.n = 0;
    80003922:	00019797          	auipc	a5,0x19
    80003926:	ca07a123          	sw	zero,-862(a5) # 8001c5c4 <log+0x34>
    write_head();    // Erase the transaction from the log
    8000392a:	00000097          	auipc	ra,0x0
    8000392e:	c50080e7          	jalr	-944(ra) # 8000357a <write_head>
    80003932:	bdf5                	j	8000382e <end_op+0x52>

0000000080003934 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003934:	1101                	addi	sp,sp,-32
    80003936:	ec06                	sd	ra,24(sp)
    80003938:	e822                	sd	s0,16(sp)
    8000393a:	e426                	sd	s1,8(sp)
    8000393c:	e04a                	sd	s2,0(sp)
    8000393e:	1000                	addi	s0,sp,32
    80003940:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003942:	00019917          	auipc	s2,0x19
    80003946:	c4e90913          	addi	s2,s2,-946 # 8001c590 <log>
    8000394a:	854a                	mv	a0,s2
    8000394c:	00003097          	auipc	ra,0x3
    80003950:	dbe080e7          	jalr	-578(ra) # 8000670a <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003954:	03492603          	lw	a2,52(s2)
    80003958:	47f5                	li	a5,29
    8000395a:	06c7c563          	blt	a5,a2,800039c4 <log_write+0x90>
    8000395e:	00019797          	auipc	a5,0x19
    80003962:	c567a783          	lw	a5,-938(a5) # 8001c5b4 <log+0x24>
    80003966:	37fd                	addiw	a5,a5,-1
    80003968:	04f65e63          	bge	a2,a5,800039c4 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000396c:	00019797          	auipc	a5,0x19
    80003970:	c4c7a783          	lw	a5,-948(a5) # 8001c5b8 <log+0x28>
    80003974:	06f05063          	blez	a5,800039d4 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003978:	4781                	li	a5,0
    8000397a:	06c05563          	blez	a2,800039e4 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000397e:	44cc                	lw	a1,12(s1)
    80003980:	00019717          	auipc	a4,0x19
    80003984:	c4870713          	addi	a4,a4,-952 # 8001c5c8 <log+0x38>
  for (i = 0; i < log.lh.n; i++) {
    80003988:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000398a:	4314                	lw	a3,0(a4)
    8000398c:	04b68c63          	beq	a3,a1,800039e4 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003990:	2785                	addiw	a5,a5,1
    80003992:	0711                	addi	a4,a4,4
    80003994:	fef61be3          	bne	a2,a5,8000398a <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003998:	0631                	addi	a2,a2,12
    8000399a:	060a                	slli	a2,a2,0x2
    8000399c:	00019797          	auipc	a5,0x19
    800039a0:	bf478793          	addi	a5,a5,-1036 # 8001c590 <log>
    800039a4:	963e                	add	a2,a2,a5
    800039a6:	44dc                	lw	a5,12(s1)
    800039a8:	c61c                	sw	a5,8(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800039aa:	8526                	mv	a0,s1
    800039ac:	fffff097          	auipc	ra,0xfffff
    800039b0:	d6e080e7          	jalr	-658(ra) # 8000271a <bpin>
    log.lh.n++;
    800039b4:	00019717          	auipc	a4,0x19
    800039b8:	bdc70713          	addi	a4,a4,-1060 # 8001c590 <log>
    800039bc:	5b5c                	lw	a5,52(a4)
    800039be:	2785                	addiw	a5,a5,1
    800039c0:	db5c                	sw	a5,52(a4)
    800039c2:	a835                	j	800039fe <log_write+0xca>
    panic("too big a transaction");
    800039c4:	00005517          	auipc	a0,0x5
    800039c8:	c3c50513          	addi	a0,a0,-964 # 80008600 <syscalls+0x1f0>
    800039cc:	00003097          	auipc	ra,0x3
    800039d0:	80a080e7          	jalr	-2038(ra) # 800061d6 <panic>
    panic("log_write outside of trans");
    800039d4:	00005517          	auipc	a0,0x5
    800039d8:	c4450513          	addi	a0,a0,-956 # 80008618 <syscalls+0x208>
    800039dc:	00002097          	auipc	ra,0x2
    800039e0:	7fa080e7          	jalr	2042(ra) # 800061d6 <panic>
  log.lh.block[i] = b->blockno;
    800039e4:	00c78713          	addi	a4,a5,12
    800039e8:	00271693          	slli	a3,a4,0x2
    800039ec:	00019717          	auipc	a4,0x19
    800039f0:	ba470713          	addi	a4,a4,-1116 # 8001c590 <log>
    800039f4:	9736                	add	a4,a4,a3
    800039f6:	44d4                	lw	a3,12(s1)
    800039f8:	c714                	sw	a3,8(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800039fa:	faf608e3          	beq	a2,a5,800039aa <log_write+0x76>
  }
  release(&log.lock);
    800039fe:	00019517          	auipc	a0,0x19
    80003a02:	b9250513          	addi	a0,a0,-1134 # 8001c590 <log>
    80003a06:	00003097          	auipc	ra,0x3
    80003a0a:	dd4080e7          	jalr	-556(ra) # 800067da <release>
}
    80003a0e:	60e2                	ld	ra,24(sp)
    80003a10:	6442                	ld	s0,16(sp)
    80003a12:	64a2                	ld	s1,8(sp)
    80003a14:	6902                	ld	s2,0(sp)
    80003a16:	6105                	addi	sp,sp,32
    80003a18:	8082                	ret

0000000080003a1a <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003a1a:	1101                	addi	sp,sp,-32
    80003a1c:	ec06                	sd	ra,24(sp)
    80003a1e:	e822                	sd	s0,16(sp)
    80003a20:	e426                	sd	s1,8(sp)
    80003a22:	e04a                	sd	s2,0(sp)
    80003a24:	1000                	addi	s0,sp,32
    80003a26:	84aa                	mv	s1,a0
    80003a28:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003a2a:	00005597          	auipc	a1,0x5
    80003a2e:	c0e58593          	addi	a1,a1,-1010 # 80008638 <syscalls+0x228>
    80003a32:	0521                	addi	a0,a0,8
    80003a34:	00003097          	auipc	ra,0x3
    80003a38:	e52080e7          	jalr	-430(ra) # 80006886 <initlock>
  lk->name = name;
    80003a3c:	0324b423          	sd	s2,40(s1)
  lk->locked = 0;
    80003a40:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a44:	0204a823          	sw	zero,48(s1)
}
    80003a48:	60e2                	ld	ra,24(sp)
    80003a4a:	6442                	ld	s0,16(sp)
    80003a4c:	64a2                	ld	s1,8(sp)
    80003a4e:	6902                	ld	s2,0(sp)
    80003a50:	6105                	addi	sp,sp,32
    80003a52:	8082                	ret

0000000080003a54 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a54:	1101                	addi	sp,sp,-32
    80003a56:	ec06                	sd	ra,24(sp)
    80003a58:	e822                	sd	s0,16(sp)
    80003a5a:	e426                	sd	s1,8(sp)
    80003a5c:	e04a                	sd	s2,0(sp)
    80003a5e:	1000                	addi	s0,sp,32
    80003a60:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a62:	00850913          	addi	s2,a0,8
    80003a66:	854a                	mv	a0,s2
    80003a68:	00003097          	auipc	ra,0x3
    80003a6c:	ca2080e7          	jalr	-862(ra) # 8000670a <acquire>
  while (lk->locked) {
    80003a70:	409c                	lw	a5,0(s1)
    80003a72:	cb89                	beqz	a5,80003a84 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a74:	85ca                	mv	a1,s2
    80003a76:	8526                	mv	a0,s1
    80003a78:	ffffe097          	auipc	ra,0xffffe
    80003a7c:	be8080e7          	jalr	-1048(ra) # 80001660 <sleep>
  while (lk->locked) {
    80003a80:	409c                	lw	a5,0(s1)
    80003a82:	fbed                	bnez	a5,80003a74 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a84:	4785                	li	a5,1
    80003a86:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a88:	ffffd097          	auipc	ra,0xffffd
    80003a8c:	530080e7          	jalr	1328(ra) # 80000fb8 <myproc>
    80003a90:	5d1c                	lw	a5,56(a0)
    80003a92:	d89c                	sw	a5,48(s1)
  release(&lk->lk);
    80003a94:	854a                	mv	a0,s2
    80003a96:	00003097          	auipc	ra,0x3
    80003a9a:	d44080e7          	jalr	-700(ra) # 800067da <release>
}
    80003a9e:	60e2                	ld	ra,24(sp)
    80003aa0:	6442                	ld	s0,16(sp)
    80003aa2:	64a2                	ld	s1,8(sp)
    80003aa4:	6902                	ld	s2,0(sp)
    80003aa6:	6105                	addi	sp,sp,32
    80003aa8:	8082                	ret

0000000080003aaa <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003aaa:	1101                	addi	sp,sp,-32
    80003aac:	ec06                	sd	ra,24(sp)
    80003aae:	e822                	sd	s0,16(sp)
    80003ab0:	e426                	sd	s1,8(sp)
    80003ab2:	e04a                	sd	s2,0(sp)
    80003ab4:	1000                	addi	s0,sp,32
    80003ab6:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003ab8:	00850913          	addi	s2,a0,8
    80003abc:	854a                	mv	a0,s2
    80003abe:	00003097          	auipc	ra,0x3
    80003ac2:	c4c080e7          	jalr	-948(ra) # 8000670a <acquire>
  lk->locked = 0;
    80003ac6:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003aca:	0204a823          	sw	zero,48(s1)
  wakeup(lk);
    80003ace:	8526                	mv	a0,s1
    80003ad0:	ffffe097          	auipc	ra,0xffffe
    80003ad4:	bf4080e7          	jalr	-1036(ra) # 800016c4 <wakeup>
  release(&lk->lk);
    80003ad8:	854a                	mv	a0,s2
    80003ada:	00003097          	auipc	ra,0x3
    80003ade:	d00080e7          	jalr	-768(ra) # 800067da <release>
}
    80003ae2:	60e2                	ld	ra,24(sp)
    80003ae4:	6442                	ld	s0,16(sp)
    80003ae6:	64a2                	ld	s1,8(sp)
    80003ae8:	6902                	ld	s2,0(sp)
    80003aea:	6105                	addi	sp,sp,32
    80003aec:	8082                	ret

0000000080003aee <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003aee:	7179                	addi	sp,sp,-48
    80003af0:	f406                	sd	ra,40(sp)
    80003af2:	f022                	sd	s0,32(sp)
    80003af4:	ec26                	sd	s1,24(sp)
    80003af6:	e84a                	sd	s2,16(sp)
    80003af8:	e44e                	sd	s3,8(sp)
    80003afa:	1800                	addi	s0,sp,48
    80003afc:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003afe:	00850913          	addi	s2,a0,8
    80003b02:	854a                	mv	a0,s2
    80003b04:	00003097          	auipc	ra,0x3
    80003b08:	c06080e7          	jalr	-1018(ra) # 8000670a <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b0c:	409c                	lw	a5,0(s1)
    80003b0e:	ef99                	bnez	a5,80003b2c <holdingsleep+0x3e>
    80003b10:	4481                	li	s1,0
  release(&lk->lk);
    80003b12:	854a                	mv	a0,s2
    80003b14:	00003097          	auipc	ra,0x3
    80003b18:	cc6080e7          	jalr	-826(ra) # 800067da <release>
  return r;
}
    80003b1c:	8526                	mv	a0,s1
    80003b1e:	70a2                	ld	ra,40(sp)
    80003b20:	7402                	ld	s0,32(sp)
    80003b22:	64e2                	ld	s1,24(sp)
    80003b24:	6942                	ld	s2,16(sp)
    80003b26:	69a2                	ld	s3,8(sp)
    80003b28:	6145                	addi	sp,sp,48
    80003b2a:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b2c:	0304a983          	lw	s3,48(s1)
    80003b30:	ffffd097          	auipc	ra,0xffffd
    80003b34:	488080e7          	jalr	1160(ra) # 80000fb8 <myproc>
    80003b38:	5d04                	lw	s1,56(a0)
    80003b3a:	413484b3          	sub	s1,s1,s3
    80003b3e:	0014b493          	seqz	s1,s1
    80003b42:	bfc1                	j	80003b12 <holdingsleep+0x24>

0000000080003b44 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003b44:	1141                	addi	sp,sp,-16
    80003b46:	e406                	sd	ra,8(sp)
    80003b48:	e022                	sd	s0,0(sp)
    80003b4a:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003b4c:	00005597          	auipc	a1,0x5
    80003b50:	afc58593          	addi	a1,a1,-1284 # 80008648 <syscalls+0x238>
    80003b54:	00019517          	auipc	a0,0x19
    80003b58:	b8c50513          	addi	a0,a0,-1140 # 8001c6e0 <ftable>
    80003b5c:	00003097          	auipc	ra,0x3
    80003b60:	d2a080e7          	jalr	-726(ra) # 80006886 <initlock>
}
    80003b64:	60a2                	ld	ra,8(sp)
    80003b66:	6402                	ld	s0,0(sp)
    80003b68:	0141                	addi	sp,sp,16
    80003b6a:	8082                	ret

0000000080003b6c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b6c:	1101                	addi	sp,sp,-32
    80003b6e:	ec06                	sd	ra,24(sp)
    80003b70:	e822                	sd	s0,16(sp)
    80003b72:	e426                	sd	s1,8(sp)
    80003b74:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b76:	00019517          	auipc	a0,0x19
    80003b7a:	b6a50513          	addi	a0,a0,-1174 # 8001c6e0 <ftable>
    80003b7e:	00003097          	auipc	ra,0x3
    80003b82:	b8c080e7          	jalr	-1140(ra) # 8000670a <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b86:	00019497          	auipc	s1,0x19
    80003b8a:	b7a48493          	addi	s1,s1,-1158 # 8001c700 <ftable+0x20>
    80003b8e:	0001a717          	auipc	a4,0x1a
    80003b92:	b1270713          	addi	a4,a4,-1262 # 8001d6a0 <disk>
    if(f->ref == 0){
    80003b96:	40dc                	lw	a5,4(s1)
    80003b98:	cf99                	beqz	a5,80003bb6 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b9a:	02848493          	addi	s1,s1,40
    80003b9e:	fee49ce3          	bne	s1,a4,80003b96 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003ba2:	00019517          	auipc	a0,0x19
    80003ba6:	b3e50513          	addi	a0,a0,-1218 # 8001c6e0 <ftable>
    80003baa:	00003097          	auipc	ra,0x3
    80003bae:	c30080e7          	jalr	-976(ra) # 800067da <release>
  return 0;
    80003bb2:	4481                	li	s1,0
    80003bb4:	a819                	j	80003bca <filealloc+0x5e>
      f->ref = 1;
    80003bb6:	4785                	li	a5,1
    80003bb8:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003bba:	00019517          	auipc	a0,0x19
    80003bbe:	b2650513          	addi	a0,a0,-1242 # 8001c6e0 <ftable>
    80003bc2:	00003097          	auipc	ra,0x3
    80003bc6:	c18080e7          	jalr	-1000(ra) # 800067da <release>
}
    80003bca:	8526                	mv	a0,s1
    80003bcc:	60e2                	ld	ra,24(sp)
    80003bce:	6442                	ld	s0,16(sp)
    80003bd0:	64a2                	ld	s1,8(sp)
    80003bd2:	6105                	addi	sp,sp,32
    80003bd4:	8082                	ret

0000000080003bd6 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003bd6:	1101                	addi	sp,sp,-32
    80003bd8:	ec06                	sd	ra,24(sp)
    80003bda:	e822                	sd	s0,16(sp)
    80003bdc:	e426                	sd	s1,8(sp)
    80003bde:	1000                	addi	s0,sp,32
    80003be0:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003be2:	00019517          	auipc	a0,0x19
    80003be6:	afe50513          	addi	a0,a0,-1282 # 8001c6e0 <ftable>
    80003bea:	00003097          	auipc	ra,0x3
    80003bee:	b20080e7          	jalr	-1248(ra) # 8000670a <acquire>
  if(f->ref < 1)
    80003bf2:	40dc                	lw	a5,4(s1)
    80003bf4:	02f05263          	blez	a5,80003c18 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003bf8:	2785                	addiw	a5,a5,1
    80003bfa:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003bfc:	00019517          	auipc	a0,0x19
    80003c00:	ae450513          	addi	a0,a0,-1308 # 8001c6e0 <ftable>
    80003c04:	00003097          	auipc	ra,0x3
    80003c08:	bd6080e7          	jalr	-1066(ra) # 800067da <release>
  return f;
}
    80003c0c:	8526                	mv	a0,s1
    80003c0e:	60e2                	ld	ra,24(sp)
    80003c10:	6442                	ld	s0,16(sp)
    80003c12:	64a2                	ld	s1,8(sp)
    80003c14:	6105                	addi	sp,sp,32
    80003c16:	8082                	ret
    panic("filedup");
    80003c18:	00005517          	auipc	a0,0x5
    80003c1c:	a3850513          	addi	a0,a0,-1480 # 80008650 <syscalls+0x240>
    80003c20:	00002097          	auipc	ra,0x2
    80003c24:	5b6080e7          	jalr	1462(ra) # 800061d6 <panic>

0000000080003c28 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003c28:	7139                	addi	sp,sp,-64
    80003c2a:	fc06                	sd	ra,56(sp)
    80003c2c:	f822                	sd	s0,48(sp)
    80003c2e:	f426                	sd	s1,40(sp)
    80003c30:	f04a                	sd	s2,32(sp)
    80003c32:	ec4e                	sd	s3,24(sp)
    80003c34:	e852                	sd	s4,16(sp)
    80003c36:	e456                	sd	s5,8(sp)
    80003c38:	0080                	addi	s0,sp,64
    80003c3a:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003c3c:	00019517          	auipc	a0,0x19
    80003c40:	aa450513          	addi	a0,a0,-1372 # 8001c6e0 <ftable>
    80003c44:	00003097          	auipc	ra,0x3
    80003c48:	ac6080e7          	jalr	-1338(ra) # 8000670a <acquire>
  if(f->ref < 1)
    80003c4c:	40dc                	lw	a5,4(s1)
    80003c4e:	06f05163          	blez	a5,80003cb0 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003c52:	37fd                	addiw	a5,a5,-1
    80003c54:	0007871b          	sext.w	a4,a5
    80003c58:	c0dc                	sw	a5,4(s1)
    80003c5a:	06e04363          	bgtz	a4,80003cc0 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c5e:	0004a903          	lw	s2,0(s1)
    80003c62:	0094ca83          	lbu	s5,9(s1)
    80003c66:	0104ba03          	ld	s4,16(s1)
    80003c6a:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c6e:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c72:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c76:	00019517          	auipc	a0,0x19
    80003c7a:	a6a50513          	addi	a0,a0,-1430 # 8001c6e0 <ftable>
    80003c7e:	00003097          	auipc	ra,0x3
    80003c82:	b5c080e7          	jalr	-1188(ra) # 800067da <release>

  if(ff.type == FD_PIPE){
    80003c86:	4785                	li	a5,1
    80003c88:	04f90d63          	beq	s2,a5,80003ce2 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c8c:	3979                	addiw	s2,s2,-2
    80003c8e:	4785                	li	a5,1
    80003c90:	0527e063          	bltu	a5,s2,80003cd0 <fileclose+0xa8>
    begin_op();
    80003c94:	00000097          	auipc	ra,0x0
    80003c98:	ac8080e7          	jalr	-1336(ra) # 8000375c <begin_op>
    iput(ff.ip);
    80003c9c:	854e                	mv	a0,s3
    80003c9e:	fffff097          	auipc	ra,0xfffff
    80003ca2:	2b6080e7          	jalr	694(ra) # 80002f54 <iput>
    end_op();
    80003ca6:	00000097          	auipc	ra,0x0
    80003caa:	b36080e7          	jalr	-1226(ra) # 800037dc <end_op>
    80003cae:	a00d                	j	80003cd0 <fileclose+0xa8>
    panic("fileclose");
    80003cb0:	00005517          	auipc	a0,0x5
    80003cb4:	9a850513          	addi	a0,a0,-1624 # 80008658 <syscalls+0x248>
    80003cb8:	00002097          	auipc	ra,0x2
    80003cbc:	51e080e7          	jalr	1310(ra) # 800061d6 <panic>
    release(&ftable.lock);
    80003cc0:	00019517          	auipc	a0,0x19
    80003cc4:	a2050513          	addi	a0,a0,-1504 # 8001c6e0 <ftable>
    80003cc8:	00003097          	auipc	ra,0x3
    80003ccc:	b12080e7          	jalr	-1262(ra) # 800067da <release>
  }
}
    80003cd0:	70e2                	ld	ra,56(sp)
    80003cd2:	7442                	ld	s0,48(sp)
    80003cd4:	74a2                	ld	s1,40(sp)
    80003cd6:	7902                	ld	s2,32(sp)
    80003cd8:	69e2                	ld	s3,24(sp)
    80003cda:	6a42                	ld	s4,16(sp)
    80003cdc:	6aa2                	ld	s5,8(sp)
    80003cde:	6121                	addi	sp,sp,64
    80003ce0:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003ce2:	85d6                	mv	a1,s5
    80003ce4:	8552                	mv	a0,s4
    80003ce6:	00000097          	auipc	ra,0x0
    80003cea:	34c080e7          	jalr	844(ra) # 80004032 <pipeclose>
    80003cee:	b7cd                	j	80003cd0 <fileclose+0xa8>

0000000080003cf0 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003cf0:	715d                	addi	sp,sp,-80
    80003cf2:	e486                	sd	ra,72(sp)
    80003cf4:	e0a2                	sd	s0,64(sp)
    80003cf6:	fc26                	sd	s1,56(sp)
    80003cf8:	f84a                	sd	s2,48(sp)
    80003cfa:	f44e                	sd	s3,40(sp)
    80003cfc:	0880                	addi	s0,sp,80
    80003cfe:	84aa                	mv	s1,a0
    80003d00:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003d02:	ffffd097          	auipc	ra,0xffffd
    80003d06:	2b6080e7          	jalr	694(ra) # 80000fb8 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003d0a:	409c                	lw	a5,0(s1)
    80003d0c:	37f9                	addiw	a5,a5,-2
    80003d0e:	4705                	li	a4,1
    80003d10:	04f76763          	bltu	a4,a5,80003d5e <filestat+0x6e>
    80003d14:	892a                	mv	s2,a0
    ilock(f->ip);
    80003d16:	6c88                	ld	a0,24(s1)
    80003d18:	fffff097          	auipc	ra,0xfffff
    80003d1c:	06e080e7          	jalr	110(ra) # 80002d86 <ilock>
    stati(f->ip, &st);
    80003d20:	fb840593          	addi	a1,s0,-72
    80003d24:	6c88                	ld	a0,24(s1)
    80003d26:	fffff097          	auipc	ra,0xfffff
    80003d2a:	2fe080e7          	jalr	766(ra) # 80003024 <stati>
    iunlock(f->ip);
    80003d2e:	6c88                	ld	a0,24(s1)
    80003d30:	fffff097          	auipc	ra,0xfffff
    80003d34:	122080e7          	jalr	290(ra) # 80002e52 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d38:	46e1                	li	a3,24
    80003d3a:	fb840613          	addi	a2,s0,-72
    80003d3e:	85ce                	mv	a1,s3
    80003d40:	05893503          	ld	a0,88(s2)
    80003d44:	ffffd097          	auipc	ra,0xffffd
    80003d48:	efe080e7          	jalr	-258(ra) # 80000c42 <copyout>
    80003d4c:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003d50:	60a6                	ld	ra,72(sp)
    80003d52:	6406                	ld	s0,64(sp)
    80003d54:	74e2                	ld	s1,56(sp)
    80003d56:	7942                	ld	s2,48(sp)
    80003d58:	79a2                	ld	s3,40(sp)
    80003d5a:	6161                	addi	sp,sp,80
    80003d5c:	8082                	ret
  return -1;
    80003d5e:	557d                	li	a0,-1
    80003d60:	bfc5                	j	80003d50 <filestat+0x60>

0000000080003d62 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d62:	7179                	addi	sp,sp,-48
    80003d64:	f406                	sd	ra,40(sp)
    80003d66:	f022                	sd	s0,32(sp)
    80003d68:	ec26                	sd	s1,24(sp)
    80003d6a:	e84a                	sd	s2,16(sp)
    80003d6c:	e44e                	sd	s3,8(sp)
    80003d6e:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d70:	00854783          	lbu	a5,8(a0)
    80003d74:	c3d5                	beqz	a5,80003e18 <fileread+0xb6>
    80003d76:	84aa                	mv	s1,a0
    80003d78:	89ae                	mv	s3,a1
    80003d7a:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d7c:	411c                	lw	a5,0(a0)
    80003d7e:	4705                	li	a4,1
    80003d80:	04e78963          	beq	a5,a4,80003dd2 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d84:	470d                	li	a4,3
    80003d86:	04e78d63          	beq	a5,a4,80003de0 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d8a:	4709                	li	a4,2
    80003d8c:	06e79e63          	bne	a5,a4,80003e08 <fileread+0xa6>
    ilock(f->ip);
    80003d90:	6d08                	ld	a0,24(a0)
    80003d92:	fffff097          	auipc	ra,0xfffff
    80003d96:	ff4080e7          	jalr	-12(ra) # 80002d86 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003d9a:	874a                	mv	a4,s2
    80003d9c:	5094                	lw	a3,32(s1)
    80003d9e:	864e                	mv	a2,s3
    80003da0:	4585                	li	a1,1
    80003da2:	6c88                	ld	a0,24(s1)
    80003da4:	fffff097          	auipc	ra,0xfffff
    80003da8:	2aa080e7          	jalr	682(ra) # 8000304e <readi>
    80003dac:	892a                	mv	s2,a0
    80003dae:	00a05563          	blez	a0,80003db8 <fileread+0x56>
      f->off += r;
    80003db2:	509c                	lw	a5,32(s1)
    80003db4:	9fa9                	addw	a5,a5,a0
    80003db6:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003db8:	6c88                	ld	a0,24(s1)
    80003dba:	fffff097          	auipc	ra,0xfffff
    80003dbe:	098080e7          	jalr	152(ra) # 80002e52 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003dc2:	854a                	mv	a0,s2
    80003dc4:	70a2                	ld	ra,40(sp)
    80003dc6:	7402                	ld	s0,32(sp)
    80003dc8:	64e2                	ld	s1,24(sp)
    80003dca:	6942                	ld	s2,16(sp)
    80003dcc:	69a2                	ld	s3,8(sp)
    80003dce:	6145                	addi	sp,sp,48
    80003dd0:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003dd2:	6908                	ld	a0,16(a0)
    80003dd4:	00000097          	auipc	ra,0x0
    80003dd8:	3d8080e7          	jalr	984(ra) # 800041ac <piperead>
    80003ddc:	892a                	mv	s2,a0
    80003dde:	b7d5                	j	80003dc2 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003de0:	02451783          	lh	a5,36(a0)
    80003de4:	03079693          	slli	a3,a5,0x30
    80003de8:	92c1                	srli	a3,a3,0x30
    80003dea:	4725                	li	a4,9
    80003dec:	02d76863          	bltu	a4,a3,80003e1c <fileread+0xba>
    80003df0:	0792                	slli	a5,a5,0x4
    80003df2:	00019717          	auipc	a4,0x19
    80003df6:	84e70713          	addi	a4,a4,-1970 # 8001c640 <devsw>
    80003dfa:	97ba                	add	a5,a5,a4
    80003dfc:	639c                	ld	a5,0(a5)
    80003dfe:	c38d                	beqz	a5,80003e20 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003e00:	4505                	li	a0,1
    80003e02:	9782                	jalr	a5
    80003e04:	892a                	mv	s2,a0
    80003e06:	bf75                	j	80003dc2 <fileread+0x60>
    panic("fileread");
    80003e08:	00005517          	auipc	a0,0x5
    80003e0c:	86050513          	addi	a0,a0,-1952 # 80008668 <syscalls+0x258>
    80003e10:	00002097          	auipc	ra,0x2
    80003e14:	3c6080e7          	jalr	966(ra) # 800061d6 <panic>
    return -1;
    80003e18:	597d                	li	s2,-1
    80003e1a:	b765                	j	80003dc2 <fileread+0x60>
      return -1;
    80003e1c:	597d                	li	s2,-1
    80003e1e:	b755                	j	80003dc2 <fileread+0x60>
    80003e20:	597d                	li	s2,-1
    80003e22:	b745                	j	80003dc2 <fileread+0x60>

0000000080003e24 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003e24:	715d                	addi	sp,sp,-80
    80003e26:	e486                	sd	ra,72(sp)
    80003e28:	e0a2                	sd	s0,64(sp)
    80003e2a:	fc26                	sd	s1,56(sp)
    80003e2c:	f84a                	sd	s2,48(sp)
    80003e2e:	f44e                	sd	s3,40(sp)
    80003e30:	f052                	sd	s4,32(sp)
    80003e32:	ec56                	sd	s5,24(sp)
    80003e34:	e85a                	sd	s6,16(sp)
    80003e36:	e45e                	sd	s7,8(sp)
    80003e38:	e062                	sd	s8,0(sp)
    80003e3a:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003e3c:	00954783          	lbu	a5,9(a0)
    80003e40:	10078663          	beqz	a5,80003f4c <filewrite+0x128>
    80003e44:	892a                	mv	s2,a0
    80003e46:	8aae                	mv	s5,a1
    80003e48:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e4a:	411c                	lw	a5,0(a0)
    80003e4c:	4705                	li	a4,1
    80003e4e:	02e78263          	beq	a5,a4,80003e72 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e52:	470d                	li	a4,3
    80003e54:	02e78663          	beq	a5,a4,80003e80 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e58:	4709                	li	a4,2
    80003e5a:	0ee79163          	bne	a5,a4,80003f3c <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e5e:	0ac05d63          	blez	a2,80003f18 <filewrite+0xf4>
    int i = 0;
    80003e62:	4981                	li	s3,0
    80003e64:	6b05                	lui	s6,0x1
    80003e66:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003e6a:	6b85                	lui	s7,0x1
    80003e6c:	c00b8b9b          	addiw	s7,s7,-1024
    80003e70:	a861                	j	80003f08 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003e72:	6908                	ld	a0,16(a0)
    80003e74:	00000097          	auipc	ra,0x0
    80003e78:	238080e7          	jalr	568(ra) # 800040ac <pipewrite>
    80003e7c:	8a2a                	mv	s4,a0
    80003e7e:	a045                	j	80003f1e <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e80:	02451783          	lh	a5,36(a0)
    80003e84:	03079693          	slli	a3,a5,0x30
    80003e88:	92c1                	srli	a3,a3,0x30
    80003e8a:	4725                	li	a4,9
    80003e8c:	0cd76263          	bltu	a4,a3,80003f50 <filewrite+0x12c>
    80003e90:	0792                	slli	a5,a5,0x4
    80003e92:	00018717          	auipc	a4,0x18
    80003e96:	7ae70713          	addi	a4,a4,1966 # 8001c640 <devsw>
    80003e9a:	97ba                	add	a5,a5,a4
    80003e9c:	679c                	ld	a5,8(a5)
    80003e9e:	cbdd                	beqz	a5,80003f54 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003ea0:	4505                	li	a0,1
    80003ea2:	9782                	jalr	a5
    80003ea4:	8a2a                	mv	s4,a0
    80003ea6:	a8a5                	j	80003f1e <filewrite+0xfa>
    80003ea8:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003eac:	00000097          	auipc	ra,0x0
    80003eb0:	8b0080e7          	jalr	-1872(ra) # 8000375c <begin_op>
      ilock(f->ip);
    80003eb4:	01893503          	ld	a0,24(s2)
    80003eb8:	fffff097          	auipc	ra,0xfffff
    80003ebc:	ece080e7          	jalr	-306(ra) # 80002d86 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003ec0:	8762                	mv	a4,s8
    80003ec2:	02092683          	lw	a3,32(s2)
    80003ec6:	01598633          	add	a2,s3,s5
    80003eca:	4585                	li	a1,1
    80003ecc:	01893503          	ld	a0,24(s2)
    80003ed0:	fffff097          	auipc	ra,0xfffff
    80003ed4:	276080e7          	jalr	630(ra) # 80003146 <writei>
    80003ed8:	84aa                	mv	s1,a0
    80003eda:	00a05763          	blez	a0,80003ee8 <filewrite+0xc4>
        f->off += r;
    80003ede:	02092783          	lw	a5,32(s2)
    80003ee2:	9fa9                	addw	a5,a5,a0
    80003ee4:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003ee8:	01893503          	ld	a0,24(s2)
    80003eec:	fffff097          	auipc	ra,0xfffff
    80003ef0:	f66080e7          	jalr	-154(ra) # 80002e52 <iunlock>
      end_op();
    80003ef4:	00000097          	auipc	ra,0x0
    80003ef8:	8e8080e7          	jalr	-1816(ra) # 800037dc <end_op>

      if(r != n1){
    80003efc:	009c1f63          	bne	s8,s1,80003f1a <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003f00:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003f04:	0149db63          	bge	s3,s4,80003f1a <filewrite+0xf6>
      int n1 = n - i;
    80003f08:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003f0c:	84be                	mv	s1,a5
    80003f0e:	2781                	sext.w	a5,a5
    80003f10:	f8fb5ce3          	bge	s6,a5,80003ea8 <filewrite+0x84>
    80003f14:	84de                	mv	s1,s7
    80003f16:	bf49                	j	80003ea8 <filewrite+0x84>
    int i = 0;
    80003f18:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003f1a:	013a1f63          	bne	s4,s3,80003f38 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003f1e:	8552                	mv	a0,s4
    80003f20:	60a6                	ld	ra,72(sp)
    80003f22:	6406                	ld	s0,64(sp)
    80003f24:	74e2                	ld	s1,56(sp)
    80003f26:	7942                	ld	s2,48(sp)
    80003f28:	79a2                	ld	s3,40(sp)
    80003f2a:	7a02                	ld	s4,32(sp)
    80003f2c:	6ae2                	ld	s5,24(sp)
    80003f2e:	6b42                	ld	s6,16(sp)
    80003f30:	6ba2                	ld	s7,8(sp)
    80003f32:	6c02                	ld	s8,0(sp)
    80003f34:	6161                	addi	sp,sp,80
    80003f36:	8082                	ret
    ret = (i == n ? n : -1);
    80003f38:	5a7d                	li	s4,-1
    80003f3a:	b7d5                	j	80003f1e <filewrite+0xfa>
    panic("filewrite");
    80003f3c:	00004517          	auipc	a0,0x4
    80003f40:	73c50513          	addi	a0,a0,1852 # 80008678 <syscalls+0x268>
    80003f44:	00002097          	auipc	ra,0x2
    80003f48:	292080e7          	jalr	658(ra) # 800061d6 <panic>
    return -1;
    80003f4c:	5a7d                	li	s4,-1
    80003f4e:	bfc1                	j	80003f1e <filewrite+0xfa>
      return -1;
    80003f50:	5a7d                	li	s4,-1
    80003f52:	b7f1                	j	80003f1e <filewrite+0xfa>
    80003f54:	5a7d                	li	s4,-1
    80003f56:	b7e1                	j	80003f1e <filewrite+0xfa>

0000000080003f58 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f58:	7179                	addi	sp,sp,-48
    80003f5a:	f406                	sd	ra,40(sp)
    80003f5c:	f022                	sd	s0,32(sp)
    80003f5e:	ec26                	sd	s1,24(sp)
    80003f60:	e84a                	sd	s2,16(sp)
    80003f62:	e44e                	sd	s3,8(sp)
    80003f64:	e052                	sd	s4,0(sp)
    80003f66:	1800                	addi	s0,sp,48
    80003f68:	84aa                	mv	s1,a0
    80003f6a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f6c:	0005b023          	sd	zero,0(a1)
    80003f70:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f74:	00000097          	auipc	ra,0x0
    80003f78:	bf8080e7          	jalr	-1032(ra) # 80003b6c <filealloc>
    80003f7c:	e088                	sd	a0,0(s1)
    80003f7e:	c551                	beqz	a0,8000400a <pipealloc+0xb2>
    80003f80:	00000097          	auipc	ra,0x0
    80003f84:	bec080e7          	jalr	-1044(ra) # 80003b6c <filealloc>
    80003f88:	00aa3023          	sd	a0,0(s4)
    80003f8c:	c92d                	beqz	a0,80003ffe <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f8e:	ffffc097          	auipc	ra,0xffffc
    80003f92:	1da080e7          	jalr	474(ra) # 80000168 <kalloc>
    80003f96:	892a                	mv	s2,a0
    80003f98:	c125                	beqz	a0,80003ff8 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003f9a:	4985                	li	s3,1
    80003f9c:	23352423          	sw	s3,552(a0)
  pi->writeopen = 1;
    80003fa0:	23352623          	sw	s3,556(a0)
  pi->nwrite = 0;
    80003fa4:	22052223          	sw	zero,548(a0)
  pi->nread = 0;
    80003fa8:	22052023          	sw	zero,544(a0)
  initlock(&pi->lock, "pipe");
    80003fac:	00004597          	auipc	a1,0x4
    80003fb0:	6dc58593          	addi	a1,a1,1756 # 80008688 <syscalls+0x278>
    80003fb4:	00003097          	auipc	ra,0x3
    80003fb8:	8d2080e7          	jalr	-1838(ra) # 80006886 <initlock>
  (*f0)->type = FD_PIPE;
    80003fbc:	609c                	ld	a5,0(s1)
    80003fbe:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003fc2:	609c                	ld	a5,0(s1)
    80003fc4:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003fc8:	609c                	ld	a5,0(s1)
    80003fca:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003fce:	609c                	ld	a5,0(s1)
    80003fd0:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003fd4:	000a3783          	ld	a5,0(s4)
    80003fd8:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003fdc:	000a3783          	ld	a5,0(s4)
    80003fe0:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003fe4:	000a3783          	ld	a5,0(s4)
    80003fe8:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003fec:	000a3783          	ld	a5,0(s4)
    80003ff0:	0127b823          	sd	s2,16(a5)
  return 0;
    80003ff4:	4501                	li	a0,0
    80003ff6:	a025                	j	8000401e <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003ff8:	6088                	ld	a0,0(s1)
    80003ffa:	e501                	bnez	a0,80004002 <pipealloc+0xaa>
    80003ffc:	a039                	j	8000400a <pipealloc+0xb2>
    80003ffe:	6088                	ld	a0,0(s1)
    80004000:	c51d                	beqz	a0,8000402e <pipealloc+0xd6>
    fileclose(*f0);
    80004002:	00000097          	auipc	ra,0x0
    80004006:	c26080e7          	jalr	-986(ra) # 80003c28 <fileclose>
  if(*f1)
    8000400a:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000400e:	557d                	li	a0,-1
  if(*f1)
    80004010:	c799                	beqz	a5,8000401e <pipealloc+0xc6>
    fileclose(*f1);
    80004012:	853e                	mv	a0,a5
    80004014:	00000097          	auipc	ra,0x0
    80004018:	c14080e7          	jalr	-1004(ra) # 80003c28 <fileclose>
  return -1;
    8000401c:	557d                	li	a0,-1
}
    8000401e:	70a2                	ld	ra,40(sp)
    80004020:	7402                	ld	s0,32(sp)
    80004022:	64e2                	ld	s1,24(sp)
    80004024:	6942                	ld	s2,16(sp)
    80004026:	69a2                	ld	s3,8(sp)
    80004028:	6a02                	ld	s4,0(sp)
    8000402a:	6145                	addi	sp,sp,48
    8000402c:	8082                	ret
  return -1;
    8000402e:	557d                	li	a0,-1
    80004030:	b7fd                	j	8000401e <pipealloc+0xc6>

0000000080004032 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004032:	1101                	addi	sp,sp,-32
    80004034:	ec06                	sd	ra,24(sp)
    80004036:	e822                	sd	s0,16(sp)
    80004038:	e426                	sd	s1,8(sp)
    8000403a:	e04a                	sd	s2,0(sp)
    8000403c:	1000                	addi	s0,sp,32
    8000403e:	84aa                	mv	s1,a0
    80004040:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004042:	00002097          	auipc	ra,0x2
    80004046:	6c8080e7          	jalr	1736(ra) # 8000670a <acquire>
  if(writable){
    8000404a:	04090263          	beqz	s2,8000408e <pipeclose+0x5c>
    pi->writeopen = 0;
    8000404e:	2204a623          	sw	zero,556(s1)
    wakeup(&pi->nread);
    80004052:	22048513          	addi	a0,s1,544
    80004056:	ffffd097          	auipc	ra,0xffffd
    8000405a:	66e080e7          	jalr	1646(ra) # 800016c4 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000405e:	2284b783          	ld	a5,552(s1)
    80004062:	ef9d                	bnez	a5,800040a0 <pipeclose+0x6e>
    release(&pi->lock);
    80004064:	8526                	mv	a0,s1
    80004066:	00002097          	auipc	ra,0x2
    8000406a:	774080e7          	jalr	1908(ra) # 800067da <release>
#ifdef LAB_LOCK
    freelock(&pi->lock);
    8000406e:	8526                	mv	a0,s1
    80004070:	00002097          	auipc	ra,0x2
    80004074:	7b2080e7          	jalr	1970(ra) # 80006822 <freelock>
#endif    
    kfree((char*)pi);
    80004078:	8526                	mv	a0,s1
    8000407a:	ffffc097          	auipc	ra,0xffffc
    8000407e:	fa2080e7          	jalr	-94(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004082:	60e2                	ld	ra,24(sp)
    80004084:	6442                	ld	s0,16(sp)
    80004086:	64a2                	ld	s1,8(sp)
    80004088:	6902                	ld	s2,0(sp)
    8000408a:	6105                	addi	sp,sp,32
    8000408c:	8082                	ret
    pi->readopen = 0;
    8000408e:	2204a423          	sw	zero,552(s1)
    wakeup(&pi->nwrite);
    80004092:	22448513          	addi	a0,s1,548
    80004096:	ffffd097          	auipc	ra,0xffffd
    8000409a:	62e080e7          	jalr	1582(ra) # 800016c4 <wakeup>
    8000409e:	b7c1                	j	8000405e <pipeclose+0x2c>
    release(&pi->lock);
    800040a0:	8526                	mv	a0,s1
    800040a2:	00002097          	auipc	ra,0x2
    800040a6:	738080e7          	jalr	1848(ra) # 800067da <release>
}
    800040aa:	bfe1                	j	80004082 <pipeclose+0x50>

00000000800040ac <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800040ac:	7159                	addi	sp,sp,-112
    800040ae:	f486                	sd	ra,104(sp)
    800040b0:	f0a2                	sd	s0,96(sp)
    800040b2:	eca6                	sd	s1,88(sp)
    800040b4:	e8ca                	sd	s2,80(sp)
    800040b6:	e4ce                	sd	s3,72(sp)
    800040b8:	e0d2                	sd	s4,64(sp)
    800040ba:	fc56                	sd	s5,56(sp)
    800040bc:	f85a                	sd	s6,48(sp)
    800040be:	f45e                	sd	s7,40(sp)
    800040c0:	f062                	sd	s8,32(sp)
    800040c2:	ec66                	sd	s9,24(sp)
    800040c4:	1880                	addi	s0,sp,112
    800040c6:	84aa                	mv	s1,a0
    800040c8:	8aae                	mv	s5,a1
    800040ca:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800040cc:	ffffd097          	auipc	ra,0xffffd
    800040d0:	eec080e7          	jalr	-276(ra) # 80000fb8 <myproc>
    800040d4:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800040d6:	8526                	mv	a0,s1
    800040d8:	00002097          	auipc	ra,0x2
    800040dc:	632080e7          	jalr	1586(ra) # 8000670a <acquire>
  while(i < n){
    800040e0:	0d405463          	blez	s4,800041a8 <pipewrite+0xfc>
    800040e4:	8ba6                	mv	s7,s1
  int i = 0;
    800040e6:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040e8:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800040ea:	22048c93          	addi	s9,s1,544
      sleep(&pi->nwrite, &pi->lock);
    800040ee:	22448c13          	addi	s8,s1,548
    800040f2:	a08d                	j	80004154 <pipewrite+0xa8>
      release(&pi->lock);
    800040f4:	8526                	mv	a0,s1
    800040f6:	00002097          	auipc	ra,0x2
    800040fa:	6e4080e7          	jalr	1764(ra) # 800067da <release>
      return -1;
    800040fe:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004100:	854a                	mv	a0,s2
    80004102:	70a6                	ld	ra,104(sp)
    80004104:	7406                	ld	s0,96(sp)
    80004106:	64e6                	ld	s1,88(sp)
    80004108:	6946                	ld	s2,80(sp)
    8000410a:	69a6                	ld	s3,72(sp)
    8000410c:	6a06                	ld	s4,64(sp)
    8000410e:	7ae2                	ld	s5,56(sp)
    80004110:	7b42                	ld	s6,48(sp)
    80004112:	7ba2                	ld	s7,40(sp)
    80004114:	7c02                	ld	s8,32(sp)
    80004116:	6ce2                	ld	s9,24(sp)
    80004118:	6165                	addi	sp,sp,112
    8000411a:	8082                	ret
      wakeup(&pi->nread);
    8000411c:	8566                	mv	a0,s9
    8000411e:	ffffd097          	auipc	ra,0xffffd
    80004122:	5a6080e7          	jalr	1446(ra) # 800016c4 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004126:	85de                	mv	a1,s7
    80004128:	8562                	mv	a0,s8
    8000412a:	ffffd097          	auipc	ra,0xffffd
    8000412e:	536080e7          	jalr	1334(ra) # 80001660 <sleep>
    80004132:	a839                	j	80004150 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004134:	2244a783          	lw	a5,548(s1)
    80004138:	0017871b          	addiw	a4,a5,1
    8000413c:	22e4a223          	sw	a4,548(s1)
    80004140:	1ff7f793          	andi	a5,a5,511
    80004144:	97a6                	add	a5,a5,s1
    80004146:	f9f44703          	lbu	a4,-97(s0)
    8000414a:	02e78023          	sb	a4,32(a5)
      i++;
    8000414e:	2905                	addiw	s2,s2,1
  while(i < n){
    80004150:	05495063          	bge	s2,s4,80004190 <pipewrite+0xe4>
    if(pi->readopen == 0 || killed(pr)){
    80004154:	2284a783          	lw	a5,552(s1)
    80004158:	dfd1                	beqz	a5,800040f4 <pipewrite+0x48>
    8000415a:	854e                	mv	a0,s3
    8000415c:	ffffd097          	auipc	ra,0xffffd
    80004160:	7ac080e7          	jalr	1964(ra) # 80001908 <killed>
    80004164:	f941                	bnez	a0,800040f4 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004166:	2204a783          	lw	a5,544(s1)
    8000416a:	2244a703          	lw	a4,548(s1)
    8000416e:	2007879b          	addiw	a5,a5,512
    80004172:	faf705e3          	beq	a4,a5,8000411c <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004176:	4685                	li	a3,1
    80004178:	01590633          	add	a2,s2,s5
    8000417c:	f9f40593          	addi	a1,s0,-97
    80004180:	0589b503          	ld	a0,88(s3)
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	b7e080e7          	jalr	-1154(ra) # 80000d02 <copyin>
    8000418c:	fb6514e3          	bne	a0,s6,80004134 <pipewrite+0x88>
  wakeup(&pi->nread);
    80004190:	22048513          	addi	a0,s1,544
    80004194:	ffffd097          	auipc	ra,0xffffd
    80004198:	530080e7          	jalr	1328(ra) # 800016c4 <wakeup>
  release(&pi->lock);
    8000419c:	8526                	mv	a0,s1
    8000419e:	00002097          	auipc	ra,0x2
    800041a2:	63c080e7          	jalr	1596(ra) # 800067da <release>
  return i;
    800041a6:	bfa9                	j	80004100 <pipewrite+0x54>
  int i = 0;
    800041a8:	4901                	li	s2,0
    800041aa:	b7dd                	j	80004190 <pipewrite+0xe4>

00000000800041ac <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800041ac:	715d                	addi	sp,sp,-80
    800041ae:	e486                	sd	ra,72(sp)
    800041b0:	e0a2                	sd	s0,64(sp)
    800041b2:	fc26                	sd	s1,56(sp)
    800041b4:	f84a                	sd	s2,48(sp)
    800041b6:	f44e                	sd	s3,40(sp)
    800041b8:	f052                	sd	s4,32(sp)
    800041ba:	ec56                	sd	s5,24(sp)
    800041bc:	e85a                	sd	s6,16(sp)
    800041be:	0880                	addi	s0,sp,80
    800041c0:	84aa                	mv	s1,a0
    800041c2:	892e                	mv	s2,a1
    800041c4:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800041c6:	ffffd097          	auipc	ra,0xffffd
    800041ca:	df2080e7          	jalr	-526(ra) # 80000fb8 <myproc>
    800041ce:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800041d0:	8b26                	mv	s6,s1
    800041d2:	8526                	mv	a0,s1
    800041d4:	00002097          	auipc	ra,0x2
    800041d8:	536080e7          	jalr	1334(ra) # 8000670a <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041dc:	2204a703          	lw	a4,544(s1)
    800041e0:	2244a783          	lw	a5,548(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041e4:	22048993          	addi	s3,s1,544
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041e8:	02f71763          	bne	a4,a5,80004216 <piperead+0x6a>
    800041ec:	22c4a783          	lw	a5,556(s1)
    800041f0:	c39d                	beqz	a5,80004216 <piperead+0x6a>
    if(killed(pr)){
    800041f2:	8552                	mv	a0,s4
    800041f4:	ffffd097          	auipc	ra,0xffffd
    800041f8:	714080e7          	jalr	1812(ra) # 80001908 <killed>
    800041fc:	e941                	bnez	a0,8000428c <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041fe:	85da                	mv	a1,s6
    80004200:	854e                	mv	a0,s3
    80004202:	ffffd097          	auipc	ra,0xffffd
    80004206:	45e080e7          	jalr	1118(ra) # 80001660 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000420a:	2204a703          	lw	a4,544(s1)
    8000420e:	2244a783          	lw	a5,548(s1)
    80004212:	fcf70de3          	beq	a4,a5,800041ec <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004216:	09505263          	blez	s5,8000429a <piperead+0xee>
    8000421a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000421c:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    8000421e:	2204a783          	lw	a5,544(s1)
    80004222:	2244a703          	lw	a4,548(s1)
    80004226:	02f70d63          	beq	a4,a5,80004260 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000422a:	0017871b          	addiw	a4,a5,1
    8000422e:	22e4a023          	sw	a4,544(s1)
    80004232:	1ff7f793          	andi	a5,a5,511
    80004236:	97a6                	add	a5,a5,s1
    80004238:	0207c783          	lbu	a5,32(a5)
    8000423c:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004240:	4685                	li	a3,1
    80004242:	fbf40613          	addi	a2,s0,-65
    80004246:	85ca                	mv	a1,s2
    80004248:	058a3503          	ld	a0,88(s4)
    8000424c:	ffffd097          	auipc	ra,0xffffd
    80004250:	9f6080e7          	jalr	-1546(ra) # 80000c42 <copyout>
    80004254:	01650663          	beq	a0,s6,80004260 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004258:	2985                	addiw	s3,s3,1
    8000425a:	0905                	addi	s2,s2,1
    8000425c:	fd3a91e3          	bne	s5,s3,8000421e <piperead+0x72>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004260:	22448513          	addi	a0,s1,548
    80004264:	ffffd097          	auipc	ra,0xffffd
    80004268:	460080e7          	jalr	1120(ra) # 800016c4 <wakeup>
  release(&pi->lock);
    8000426c:	8526                	mv	a0,s1
    8000426e:	00002097          	auipc	ra,0x2
    80004272:	56c080e7          	jalr	1388(ra) # 800067da <release>
  return i;
}
    80004276:	854e                	mv	a0,s3
    80004278:	60a6                	ld	ra,72(sp)
    8000427a:	6406                	ld	s0,64(sp)
    8000427c:	74e2                	ld	s1,56(sp)
    8000427e:	7942                	ld	s2,48(sp)
    80004280:	79a2                	ld	s3,40(sp)
    80004282:	7a02                	ld	s4,32(sp)
    80004284:	6ae2                	ld	s5,24(sp)
    80004286:	6b42                	ld	s6,16(sp)
    80004288:	6161                	addi	sp,sp,80
    8000428a:	8082                	ret
      release(&pi->lock);
    8000428c:	8526                	mv	a0,s1
    8000428e:	00002097          	auipc	ra,0x2
    80004292:	54c080e7          	jalr	1356(ra) # 800067da <release>
      return -1;
    80004296:	59fd                	li	s3,-1
    80004298:	bff9                	j	80004276 <piperead+0xca>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000429a:	4981                	li	s3,0
    8000429c:	b7d1                	j	80004260 <piperead+0xb4>

000000008000429e <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    8000429e:	1141                	addi	sp,sp,-16
    800042a0:	e422                	sd	s0,8(sp)
    800042a2:	0800                	addi	s0,sp,16
    800042a4:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800042a6:	8905                	andi	a0,a0,1
    800042a8:	c111                	beqz	a0,800042ac <flags2perm+0xe>
      perm = PTE_X;
    800042aa:	4521                	li	a0,8
    if(flags & 0x2)
    800042ac:	8b89                	andi	a5,a5,2
    800042ae:	c399                	beqz	a5,800042b4 <flags2perm+0x16>
      perm |= PTE_W;
    800042b0:	00456513          	ori	a0,a0,4
    return perm;
}
    800042b4:	6422                	ld	s0,8(sp)
    800042b6:	0141                	addi	sp,sp,16
    800042b8:	8082                	ret

00000000800042ba <exec>:

int
exec(char *path, char **argv)
{
    800042ba:	df010113          	addi	sp,sp,-528
    800042be:	20113423          	sd	ra,520(sp)
    800042c2:	20813023          	sd	s0,512(sp)
    800042c6:	ffa6                	sd	s1,504(sp)
    800042c8:	fbca                	sd	s2,496(sp)
    800042ca:	f7ce                	sd	s3,488(sp)
    800042cc:	f3d2                	sd	s4,480(sp)
    800042ce:	efd6                	sd	s5,472(sp)
    800042d0:	ebda                	sd	s6,464(sp)
    800042d2:	e7de                	sd	s7,456(sp)
    800042d4:	e3e2                	sd	s8,448(sp)
    800042d6:	ff66                	sd	s9,440(sp)
    800042d8:	fb6a                	sd	s10,432(sp)
    800042da:	f76e                	sd	s11,424(sp)
    800042dc:	0c00                	addi	s0,sp,528
    800042de:	84aa                	mv	s1,a0
    800042e0:	dea43c23          	sd	a0,-520(s0)
    800042e4:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800042e8:	ffffd097          	auipc	ra,0xffffd
    800042ec:	cd0080e7          	jalr	-816(ra) # 80000fb8 <myproc>
    800042f0:	892a                	mv	s2,a0

  begin_op();
    800042f2:	fffff097          	auipc	ra,0xfffff
    800042f6:	46a080e7          	jalr	1130(ra) # 8000375c <begin_op>

  if((ip = namei(path)) == 0){
    800042fa:	8526                	mv	a0,s1
    800042fc:	fffff097          	auipc	ra,0xfffff
    80004300:	244080e7          	jalr	580(ra) # 80003540 <namei>
    80004304:	c92d                	beqz	a0,80004376 <exec+0xbc>
    80004306:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004308:	fffff097          	auipc	ra,0xfffff
    8000430c:	a7e080e7          	jalr	-1410(ra) # 80002d86 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004310:	04000713          	li	a4,64
    80004314:	4681                	li	a3,0
    80004316:	e5040613          	addi	a2,s0,-432
    8000431a:	4581                	li	a1,0
    8000431c:	8526                	mv	a0,s1
    8000431e:	fffff097          	auipc	ra,0xfffff
    80004322:	d30080e7          	jalr	-720(ra) # 8000304e <readi>
    80004326:	04000793          	li	a5,64
    8000432a:	00f51a63          	bne	a0,a5,8000433e <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    8000432e:	e5042703          	lw	a4,-432(s0)
    80004332:	464c47b7          	lui	a5,0x464c4
    80004336:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000433a:	04f70463          	beq	a4,a5,80004382 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000433e:	8526                	mv	a0,s1
    80004340:	fffff097          	auipc	ra,0xfffff
    80004344:	cbc080e7          	jalr	-836(ra) # 80002ffc <iunlockput>
    end_op();
    80004348:	fffff097          	auipc	ra,0xfffff
    8000434c:	494080e7          	jalr	1172(ra) # 800037dc <end_op>
  }
  return -1;
    80004350:	557d                	li	a0,-1
}
    80004352:	20813083          	ld	ra,520(sp)
    80004356:	20013403          	ld	s0,512(sp)
    8000435a:	74fe                	ld	s1,504(sp)
    8000435c:	795e                	ld	s2,496(sp)
    8000435e:	79be                	ld	s3,488(sp)
    80004360:	7a1e                	ld	s4,480(sp)
    80004362:	6afe                	ld	s5,472(sp)
    80004364:	6b5e                	ld	s6,464(sp)
    80004366:	6bbe                	ld	s7,456(sp)
    80004368:	6c1e                	ld	s8,448(sp)
    8000436a:	7cfa                	ld	s9,440(sp)
    8000436c:	7d5a                	ld	s10,432(sp)
    8000436e:	7dba                	ld	s11,424(sp)
    80004370:	21010113          	addi	sp,sp,528
    80004374:	8082                	ret
    end_op();
    80004376:	fffff097          	auipc	ra,0xfffff
    8000437a:	466080e7          	jalr	1126(ra) # 800037dc <end_op>
    return -1;
    8000437e:	557d                	li	a0,-1
    80004380:	bfc9                	j	80004352 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80004382:	854a                	mv	a0,s2
    80004384:	ffffd097          	auipc	ra,0xffffd
    80004388:	cfc080e7          	jalr	-772(ra) # 80001080 <proc_pagetable>
    8000438c:	8baa                	mv	s7,a0
    8000438e:	d945                	beqz	a0,8000433e <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004390:	e7042983          	lw	s3,-400(s0)
    80004394:	e8845783          	lhu	a5,-376(s0)
    80004398:	c7ad                	beqz	a5,80004402 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000439a:	4a01                	li	s4,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000439c:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    8000439e:	6c85                	lui	s9,0x1
    800043a0:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800043a4:	def43823          	sd	a5,-528(s0)
    800043a8:	ac0d                	j	800045da <exec+0x320>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800043aa:	00004517          	auipc	a0,0x4
    800043ae:	2e650513          	addi	a0,a0,742 # 80008690 <syscalls+0x280>
    800043b2:	00002097          	auipc	ra,0x2
    800043b6:	e24080e7          	jalr	-476(ra) # 800061d6 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800043ba:	8756                	mv	a4,s5
    800043bc:	012d86bb          	addw	a3,s11,s2
    800043c0:	4581                	li	a1,0
    800043c2:	8526                	mv	a0,s1
    800043c4:	fffff097          	auipc	ra,0xfffff
    800043c8:	c8a080e7          	jalr	-886(ra) # 8000304e <readi>
    800043cc:	2501                	sext.w	a0,a0
    800043ce:	1aaa9a63          	bne	s5,a0,80004582 <exec+0x2c8>
  for(i = 0; i < sz; i += PGSIZE){
    800043d2:	6785                	lui	a5,0x1
    800043d4:	0127893b          	addw	s2,a5,s2
    800043d8:	77fd                	lui	a5,0xfffff
    800043da:	01478a3b          	addw	s4,a5,s4
    800043de:	1f897563          	bgeu	s2,s8,800045c8 <exec+0x30e>
    pa = walkaddr(pagetable, va + i);
    800043e2:	02091593          	slli	a1,s2,0x20
    800043e6:	9181                	srli	a1,a1,0x20
    800043e8:	95ea                	add	a1,a1,s10
    800043ea:	855e                	mv	a0,s7
    800043ec:	ffffc097          	auipc	ra,0xffffc
    800043f0:	226080e7          	jalr	550(ra) # 80000612 <walkaddr>
    800043f4:	862a                	mv	a2,a0
    if(pa == 0)
    800043f6:	d955                	beqz	a0,800043aa <exec+0xf0>
      n = PGSIZE;
    800043f8:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    800043fa:	fd9a70e3          	bgeu	s4,s9,800043ba <exec+0x100>
      n = sz - i;
    800043fe:	8ad2                	mv	s5,s4
    80004400:	bf6d                	j	800043ba <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004402:	4a01                	li	s4,0
  iunlockput(ip);
    80004404:	8526                	mv	a0,s1
    80004406:	fffff097          	auipc	ra,0xfffff
    8000440a:	bf6080e7          	jalr	-1034(ra) # 80002ffc <iunlockput>
  end_op();
    8000440e:	fffff097          	auipc	ra,0xfffff
    80004412:	3ce080e7          	jalr	974(ra) # 800037dc <end_op>
  p = myproc();
    80004416:	ffffd097          	auipc	ra,0xffffd
    8000441a:	ba2080e7          	jalr	-1118(ra) # 80000fb8 <myproc>
    8000441e:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004420:	05053d03          	ld	s10,80(a0)
  sz = PGROUNDUP(sz);
    80004424:	6785                	lui	a5,0x1
    80004426:	17fd                	addi	a5,a5,-1
    80004428:	9a3e                	add	s4,s4,a5
    8000442a:	757d                	lui	a0,0xfffff
    8000442c:	00aa77b3          	and	a5,s4,a0
    80004430:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004434:	4691                	li	a3,4
    80004436:	6609                	lui	a2,0x2
    80004438:	963e                	add	a2,a2,a5
    8000443a:	85be                	mv	a1,a5
    8000443c:	855e                	mv	a0,s7
    8000443e:	ffffc097          	auipc	ra,0xffffc
    80004442:	5ac080e7          	jalr	1452(ra) # 800009ea <uvmalloc>
    80004446:	8b2a                	mv	s6,a0
  ip = 0;
    80004448:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    8000444a:	12050c63          	beqz	a0,80004582 <exec+0x2c8>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000444e:	75f9                	lui	a1,0xffffe
    80004450:	95aa                	add	a1,a1,a0
    80004452:	855e                	mv	a0,s7
    80004454:	ffffc097          	auipc	ra,0xffffc
    80004458:	7bc080e7          	jalr	1980(ra) # 80000c10 <uvmclear>
  stackbase = sp - PGSIZE;
    8000445c:	7c7d                	lui	s8,0xfffff
    8000445e:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    80004460:	e0043783          	ld	a5,-512(s0)
    80004464:	6388                	ld	a0,0(a5)
    80004466:	c535                	beqz	a0,800044d2 <exec+0x218>
    80004468:	e9040993          	addi	s3,s0,-368
    8000446c:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004470:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    80004472:	ffffc097          	auipc	ra,0xffffc
    80004476:	f82080e7          	jalr	-126(ra) # 800003f4 <strlen>
    8000447a:	2505                	addiw	a0,a0,1
    8000447c:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004480:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004484:	13896663          	bltu	s2,s8,800045b0 <exec+0x2f6>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004488:	e0043d83          	ld	s11,-512(s0)
    8000448c:	000dba03          	ld	s4,0(s11)
    80004490:	8552                	mv	a0,s4
    80004492:	ffffc097          	auipc	ra,0xffffc
    80004496:	f62080e7          	jalr	-158(ra) # 800003f4 <strlen>
    8000449a:	0015069b          	addiw	a3,a0,1
    8000449e:	8652                	mv	a2,s4
    800044a0:	85ca                	mv	a1,s2
    800044a2:	855e                	mv	a0,s7
    800044a4:	ffffc097          	auipc	ra,0xffffc
    800044a8:	79e080e7          	jalr	1950(ra) # 80000c42 <copyout>
    800044ac:	10054663          	bltz	a0,800045b8 <exec+0x2fe>
    ustack[argc] = sp;
    800044b0:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800044b4:	0485                	addi	s1,s1,1
    800044b6:	008d8793          	addi	a5,s11,8
    800044ba:	e0f43023          	sd	a5,-512(s0)
    800044be:	008db503          	ld	a0,8(s11)
    800044c2:	c911                	beqz	a0,800044d6 <exec+0x21c>
    if(argc >= MAXARG)
    800044c4:	09a1                	addi	s3,s3,8
    800044c6:	fb3c96e3          	bne	s9,s3,80004472 <exec+0x1b8>
  sz = sz1;
    800044ca:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800044ce:	4481                	li	s1,0
    800044d0:	a84d                	j	80004582 <exec+0x2c8>
  sp = sz;
    800044d2:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800044d4:	4481                	li	s1,0
  ustack[argc] = 0;
    800044d6:	00349793          	slli	a5,s1,0x3
    800044da:	f9040713          	addi	a4,s0,-112
    800044de:	97ba                	add	a5,a5,a4
    800044e0:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    800044e4:	00148693          	addi	a3,s1,1
    800044e8:	068e                	slli	a3,a3,0x3
    800044ea:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800044ee:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800044f2:	01897663          	bgeu	s2,s8,800044fe <exec+0x244>
  sz = sz1;
    800044f6:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800044fa:	4481                	li	s1,0
    800044fc:	a059                	j	80004582 <exec+0x2c8>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800044fe:	e9040613          	addi	a2,s0,-368
    80004502:	85ca                	mv	a1,s2
    80004504:	855e                	mv	a0,s7
    80004506:	ffffc097          	auipc	ra,0xffffc
    8000450a:	73c080e7          	jalr	1852(ra) # 80000c42 <copyout>
    8000450e:	0a054963          	bltz	a0,800045c0 <exec+0x306>
  p->trapframe->a1 = sp;
    80004512:	060ab783          	ld	a5,96(s5)
    80004516:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000451a:	df843783          	ld	a5,-520(s0)
    8000451e:	0007c703          	lbu	a4,0(a5)
    80004522:	cf11                	beqz	a4,8000453e <exec+0x284>
    80004524:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004526:	02f00693          	li	a3,47
    8000452a:	a039                	j	80004538 <exec+0x27e>
      last = s+1;
    8000452c:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004530:	0785                	addi	a5,a5,1
    80004532:	fff7c703          	lbu	a4,-1(a5)
    80004536:	c701                	beqz	a4,8000453e <exec+0x284>
    if(*s == '/')
    80004538:	fed71ce3          	bne	a4,a3,80004530 <exec+0x276>
    8000453c:	bfc5                	j	8000452c <exec+0x272>
  safestrcpy(p->name, last, sizeof(p->name));
    8000453e:	4641                	li	a2,16
    80004540:	df843583          	ld	a1,-520(s0)
    80004544:	160a8513          	addi	a0,s5,352
    80004548:	ffffc097          	auipc	ra,0xffffc
    8000454c:	e7a080e7          	jalr	-390(ra) # 800003c2 <safestrcpy>
  oldpagetable = p->pagetable;
    80004550:	058ab503          	ld	a0,88(s5)
  p->pagetable = pagetable;
    80004554:	057abc23          	sd	s7,88(s5)
  p->sz = sz;
    80004558:	056ab823          	sd	s6,80(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000455c:	060ab783          	ld	a5,96(s5)
    80004560:	e6843703          	ld	a4,-408(s0)
    80004564:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004566:	060ab783          	ld	a5,96(s5)
    8000456a:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000456e:	85ea                	mv	a1,s10
    80004570:	ffffd097          	auipc	ra,0xffffd
    80004574:	bac080e7          	jalr	-1108(ra) # 8000111c <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004578:	0004851b          	sext.w	a0,s1
    8000457c:	bbd9                	j	80004352 <exec+0x98>
    8000457e:	e1443423          	sd	s4,-504(s0)
    proc_freepagetable(pagetable, sz);
    80004582:	e0843583          	ld	a1,-504(s0)
    80004586:	855e                	mv	a0,s7
    80004588:	ffffd097          	auipc	ra,0xffffd
    8000458c:	b94080e7          	jalr	-1132(ra) # 8000111c <proc_freepagetable>
  if(ip){
    80004590:	da0497e3          	bnez	s1,8000433e <exec+0x84>
  return -1;
    80004594:	557d                	li	a0,-1
    80004596:	bb75                	j	80004352 <exec+0x98>
    80004598:	e1443423          	sd	s4,-504(s0)
    8000459c:	b7dd                	j	80004582 <exec+0x2c8>
    8000459e:	e1443423          	sd	s4,-504(s0)
    800045a2:	b7c5                	j	80004582 <exec+0x2c8>
    800045a4:	e1443423          	sd	s4,-504(s0)
    800045a8:	bfe9                	j	80004582 <exec+0x2c8>
    800045aa:	e1443423          	sd	s4,-504(s0)
    800045ae:	bfd1                	j	80004582 <exec+0x2c8>
  sz = sz1;
    800045b0:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045b4:	4481                	li	s1,0
    800045b6:	b7f1                	j	80004582 <exec+0x2c8>
  sz = sz1;
    800045b8:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045bc:	4481                	li	s1,0
    800045be:	b7d1                	j	80004582 <exec+0x2c8>
  sz = sz1;
    800045c0:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800045c4:	4481                	li	s1,0
    800045c6:	bf75                	j	80004582 <exec+0x2c8>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800045c8:	e0843a03          	ld	s4,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800045cc:	2b05                	addiw	s6,s6,1
    800045ce:	0389899b          	addiw	s3,s3,56
    800045d2:	e8845783          	lhu	a5,-376(s0)
    800045d6:	e2fb57e3          	bge	s6,a5,80004404 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800045da:	2981                	sext.w	s3,s3
    800045dc:	03800713          	li	a4,56
    800045e0:	86ce                	mv	a3,s3
    800045e2:	e1840613          	addi	a2,s0,-488
    800045e6:	4581                	li	a1,0
    800045e8:	8526                	mv	a0,s1
    800045ea:	fffff097          	auipc	ra,0xfffff
    800045ee:	a64080e7          	jalr	-1436(ra) # 8000304e <readi>
    800045f2:	03800793          	li	a5,56
    800045f6:	f8f514e3          	bne	a0,a5,8000457e <exec+0x2c4>
    if(ph.type != ELF_PROG_LOAD)
    800045fa:	e1842783          	lw	a5,-488(s0)
    800045fe:	4705                	li	a4,1
    80004600:	fce796e3          	bne	a5,a4,800045cc <exec+0x312>
    if(ph.memsz < ph.filesz)
    80004604:	e4043903          	ld	s2,-448(s0)
    80004608:	e3843783          	ld	a5,-456(s0)
    8000460c:	f8f966e3          	bltu	s2,a5,80004598 <exec+0x2de>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004610:	e2843783          	ld	a5,-472(s0)
    80004614:	993e                	add	s2,s2,a5
    80004616:	f8f964e3          	bltu	s2,a5,8000459e <exec+0x2e4>
    if(ph.vaddr % PGSIZE != 0)
    8000461a:	df043703          	ld	a4,-528(s0)
    8000461e:	8ff9                	and	a5,a5,a4
    80004620:	f3d1                	bnez	a5,800045a4 <exec+0x2ea>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004622:	e1c42503          	lw	a0,-484(s0)
    80004626:	00000097          	auipc	ra,0x0
    8000462a:	c78080e7          	jalr	-904(ra) # 8000429e <flags2perm>
    8000462e:	86aa                	mv	a3,a0
    80004630:	864a                	mv	a2,s2
    80004632:	85d2                	mv	a1,s4
    80004634:	855e                	mv	a0,s7
    80004636:	ffffc097          	auipc	ra,0xffffc
    8000463a:	3b4080e7          	jalr	948(ra) # 800009ea <uvmalloc>
    8000463e:	e0a43423          	sd	a0,-504(s0)
    80004642:	d525                	beqz	a0,800045aa <exec+0x2f0>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004644:	e2843d03          	ld	s10,-472(s0)
    80004648:	e2042d83          	lw	s11,-480(s0)
    8000464c:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004650:	f60c0ce3          	beqz	s8,800045c8 <exec+0x30e>
    80004654:	8a62                	mv	s4,s8
    80004656:	4901                	li	s2,0
    80004658:	b369                	j	800043e2 <exec+0x128>

000000008000465a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000465a:	7179                	addi	sp,sp,-48
    8000465c:	f406                	sd	ra,40(sp)
    8000465e:	f022                	sd	s0,32(sp)
    80004660:	ec26                	sd	s1,24(sp)
    80004662:	e84a                	sd	s2,16(sp)
    80004664:	1800                	addi	s0,sp,48
    80004666:	892e                	mv	s2,a1
    80004668:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000466a:	fdc40593          	addi	a1,s0,-36
    8000466e:	ffffe097          	auipc	ra,0xffffe
    80004672:	a5e080e7          	jalr	-1442(ra) # 800020cc <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004676:	fdc42703          	lw	a4,-36(s0)
    8000467a:	47bd                	li	a5,15
    8000467c:	02e7eb63          	bltu	a5,a4,800046b2 <argfd+0x58>
    80004680:	ffffd097          	auipc	ra,0xffffd
    80004684:	938080e7          	jalr	-1736(ra) # 80000fb8 <myproc>
    80004688:	fdc42703          	lw	a4,-36(s0)
    8000468c:	01a70793          	addi	a5,a4,26
    80004690:	078e                	slli	a5,a5,0x3
    80004692:	953e                	add	a0,a0,a5
    80004694:	651c                	ld	a5,8(a0)
    80004696:	c385                	beqz	a5,800046b6 <argfd+0x5c>
    return -1;
  if(pfd)
    80004698:	00090463          	beqz	s2,800046a0 <argfd+0x46>
    *pfd = fd;
    8000469c:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800046a0:	4501                	li	a0,0
  if(pf)
    800046a2:	c091                	beqz	s1,800046a6 <argfd+0x4c>
    *pf = f;
    800046a4:	e09c                	sd	a5,0(s1)
}
    800046a6:	70a2                	ld	ra,40(sp)
    800046a8:	7402                	ld	s0,32(sp)
    800046aa:	64e2                	ld	s1,24(sp)
    800046ac:	6942                	ld	s2,16(sp)
    800046ae:	6145                	addi	sp,sp,48
    800046b0:	8082                	ret
    return -1;
    800046b2:	557d                	li	a0,-1
    800046b4:	bfcd                	j	800046a6 <argfd+0x4c>
    800046b6:	557d                	li	a0,-1
    800046b8:	b7fd                	j	800046a6 <argfd+0x4c>

00000000800046ba <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800046ba:	1101                	addi	sp,sp,-32
    800046bc:	ec06                	sd	ra,24(sp)
    800046be:	e822                	sd	s0,16(sp)
    800046c0:	e426                	sd	s1,8(sp)
    800046c2:	1000                	addi	s0,sp,32
    800046c4:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800046c6:	ffffd097          	auipc	ra,0xffffd
    800046ca:	8f2080e7          	jalr	-1806(ra) # 80000fb8 <myproc>
    800046ce:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800046d0:	0d850793          	addi	a5,a0,216 # fffffffffffff0d8 <end+0xffffffff7ffd76b0>
    800046d4:	4501                	li	a0,0
    800046d6:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800046d8:	6398                	ld	a4,0(a5)
    800046da:	cb19                	beqz	a4,800046f0 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800046dc:	2505                	addiw	a0,a0,1
    800046de:	07a1                	addi	a5,a5,8
    800046e0:	fed51ce3          	bne	a0,a3,800046d8 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800046e4:	557d                	li	a0,-1
}
    800046e6:	60e2                	ld	ra,24(sp)
    800046e8:	6442                	ld	s0,16(sp)
    800046ea:	64a2                	ld	s1,8(sp)
    800046ec:	6105                	addi	sp,sp,32
    800046ee:	8082                	ret
      p->ofile[fd] = f;
    800046f0:	01a50793          	addi	a5,a0,26
    800046f4:	078e                	slli	a5,a5,0x3
    800046f6:	963e                	add	a2,a2,a5
    800046f8:	e604                	sd	s1,8(a2)
      return fd;
    800046fa:	b7f5                	j	800046e6 <fdalloc+0x2c>

00000000800046fc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800046fc:	715d                	addi	sp,sp,-80
    800046fe:	e486                	sd	ra,72(sp)
    80004700:	e0a2                	sd	s0,64(sp)
    80004702:	fc26                	sd	s1,56(sp)
    80004704:	f84a                	sd	s2,48(sp)
    80004706:	f44e                	sd	s3,40(sp)
    80004708:	f052                	sd	s4,32(sp)
    8000470a:	ec56                	sd	s5,24(sp)
    8000470c:	e85a                	sd	s6,16(sp)
    8000470e:	0880                	addi	s0,sp,80
    80004710:	8b2e                	mv	s6,a1
    80004712:	89b2                	mv	s3,a2
    80004714:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004716:	fb040593          	addi	a1,s0,-80
    8000471a:	fffff097          	auipc	ra,0xfffff
    8000471e:	e44080e7          	jalr	-444(ra) # 8000355e <nameiparent>
    80004722:	84aa                	mv	s1,a0
    80004724:	16050063          	beqz	a0,80004884 <create+0x188>
    return 0;

  ilock(dp);
    80004728:	ffffe097          	auipc	ra,0xffffe
    8000472c:	65e080e7          	jalr	1630(ra) # 80002d86 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004730:	4601                	li	a2,0
    80004732:	fb040593          	addi	a1,s0,-80
    80004736:	8526                	mv	a0,s1
    80004738:	fffff097          	auipc	ra,0xfffff
    8000473c:	b46080e7          	jalr	-1210(ra) # 8000327e <dirlookup>
    80004740:	8aaa                	mv	s5,a0
    80004742:	c931                	beqz	a0,80004796 <create+0x9a>
    iunlockput(dp);
    80004744:	8526                	mv	a0,s1
    80004746:	fffff097          	auipc	ra,0xfffff
    8000474a:	8b6080e7          	jalr	-1866(ra) # 80002ffc <iunlockput>
    ilock(ip);
    8000474e:	8556                	mv	a0,s5
    80004750:	ffffe097          	auipc	ra,0xffffe
    80004754:	636080e7          	jalr	1590(ra) # 80002d86 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004758:	000b059b          	sext.w	a1,s6
    8000475c:	4789                	li	a5,2
    8000475e:	02f59563          	bne	a1,a5,80004788 <create+0x8c>
    80004762:	04cad783          	lhu	a5,76(s5)
    80004766:	37f9                	addiw	a5,a5,-2
    80004768:	17c2                	slli	a5,a5,0x30
    8000476a:	93c1                	srli	a5,a5,0x30
    8000476c:	4705                	li	a4,1
    8000476e:	00f76d63          	bltu	a4,a5,80004788 <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004772:	8556                	mv	a0,s5
    80004774:	60a6                	ld	ra,72(sp)
    80004776:	6406                	ld	s0,64(sp)
    80004778:	74e2                	ld	s1,56(sp)
    8000477a:	7942                	ld	s2,48(sp)
    8000477c:	79a2                	ld	s3,40(sp)
    8000477e:	7a02                	ld	s4,32(sp)
    80004780:	6ae2                	ld	s5,24(sp)
    80004782:	6b42                	ld	s6,16(sp)
    80004784:	6161                	addi	sp,sp,80
    80004786:	8082                	ret
    iunlockput(ip);
    80004788:	8556                	mv	a0,s5
    8000478a:	fffff097          	auipc	ra,0xfffff
    8000478e:	872080e7          	jalr	-1934(ra) # 80002ffc <iunlockput>
    return 0;
    80004792:	4a81                	li	s5,0
    80004794:	bff9                	j	80004772 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    80004796:	85da                	mv	a1,s6
    80004798:	4088                	lw	a0,0(s1)
    8000479a:	ffffe097          	auipc	ra,0xffffe
    8000479e:	450080e7          	jalr	1104(ra) # 80002bea <ialloc>
    800047a2:	8a2a                	mv	s4,a0
    800047a4:	c921                	beqz	a0,800047f4 <create+0xf8>
  ilock(ip);
    800047a6:	ffffe097          	auipc	ra,0xffffe
    800047aa:	5e0080e7          	jalr	1504(ra) # 80002d86 <ilock>
  ip->major = major;
    800047ae:	053a1723          	sh	s3,78(s4)
  ip->minor = minor;
    800047b2:	052a1823          	sh	s2,80(s4)
  ip->nlink = 1;
    800047b6:	4785                	li	a5,1
    800047b8:	04fa1923          	sh	a5,82(s4)
  iupdate(ip);
    800047bc:	8552                	mv	a0,s4
    800047be:	ffffe097          	auipc	ra,0xffffe
    800047c2:	4fe080e7          	jalr	1278(ra) # 80002cbc <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800047c6:	000b059b          	sext.w	a1,s6
    800047ca:	4785                	li	a5,1
    800047cc:	02f58b63          	beq	a1,a5,80004802 <create+0x106>
  if(dirlink(dp, name, ip->inum) < 0)
    800047d0:	004a2603          	lw	a2,4(s4)
    800047d4:	fb040593          	addi	a1,s0,-80
    800047d8:	8526                	mv	a0,s1
    800047da:	fffff097          	auipc	ra,0xfffff
    800047de:	cb4080e7          	jalr	-844(ra) # 8000348e <dirlink>
    800047e2:	06054f63          	bltz	a0,80004860 <create+0x164>
  iunlockput(dp);
    800047e6:	8526                	mv	a0,s1
    800047e8:	fffff097          	auipc	ra,0xfffff
    800047ec:	814080e7          	jalr	-2028(ra) # 80002ffc <iunlockput>
  return ip;
    800047f0:	8ad2                	mv	s5,s4
    800047f2:	b741                	j	80004772 <create+0x76>
    iunlockput(dp);
    800047f4:	8526                	mv	a0,s1
    800047f6:	fffff097          	auipc	ra,0xfffff
    800047fa:	806080e7          	jalr	-2042(ra) # 80002ffc <iunlockput>
    return 0;
    800047fe:	8ad2                	mv	s5,s4
    80004800:	bf8d                	j	80004772 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004802:	004a2603          	lw	a2,4(s4)
    80004806:	00004597          	auipc	a1,0x4
    8000480a:	eaa58593          	addi	a1,a1,-342 # 800086b0 <syscalls+0x2a0>
    8000480e:	8552                	mv	a0,s4
    80004810:	fffff097          	auipc	ra,0xfffff
    80004814:	c7e080e7          	jalr	-898(ra) # 8000348e <dirlink>
    80004818:	04054463          	bltz	a0,80004860 <create+0x164>
    8000481c:	40d0                	lw	a2,4(s1)
    8000481e:	00004597          	auipc	a1,0x4
    80004822:	e9a58593          	addi	a1,a1,-358 # 800086b8 <syscalls+0x2a8>
    80004826:	8552                	mv	a0,s4
    80004828:	fffff097          	auipc	ra,0xfffff
    8000482c:	c66080e7          	jalr	-922(ra) # 8000348e <dirlink>
    80004830:	02054863          	bltz	a0,80004860 <create+0x164>
  if(dirlink(dp, name, ip->inum) < 0)
    80004834:	004a2603          	lw	a2,4(s4)
    80004838:	fb040593          	addi	a1,s0,-80
    8000483c:	8526                	mv	a0,s1
    8000483e:	fffff097          	auipc	ra,0xfffff
    80004842:	c50080e7          	jalr	-944(ra) # 8000348e <dirlink>
    80004846:	00054d63          	bltz	a0,80004860 <create+0x164>
    dp->nlink++;  // for ".."
    8000484a:	0524d783          	lhu	a5,82(s1)
    8000484e:	2785                	addiw	a5,a5,1
    80004850:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    80004854:	8526                	mv	a0,s1
    80004856:	ffffe097          	auipc	ra,0xffffe
    8000485a:	466080e7          	jalr	1126(ra) # 80002cbc <iupdate>
    8000485e:	b761                	j	800047e6 <create+0xea>
  ip->nlink = 0;
    80004860:	040a1923          	sh	zero,82(s4)
  iupdate(ip);
    80004864:	8552                	mv	a0,s4
    80004866:	ffffe097          	auipc	ra,0xffffe
    8000486a:	456080e7          	jalr	1110(ra) # 80002cbc <iupdate>
  iunlockput(ip);
    8000486e:	8552                	mv	a0,s4
    80004870:	ffffe097          	auipc	ra,0xffffe
    80004874:	78c080e7          	jalr	1932(ra) # 80002ffc <iunlockput>
  iunlockput(dp);
    80004878:	8526                	mv	a0,s1
    8000487a:	ffffe097          	auipc	ra,0xffffe
    8000487e:	782080e7          	jalr	1922(ra) # 80002ffc <iunlockput>
  return 0;
    80004882:	bdc5                	j	80004772 <create+0x76>
    return 0;
    80004884:	8aaa                	mv	s5,a0
    80004886:	b5f5                	j	80004772 <create+0x76>

0000000080004888 <sys_dup>:
{
    80004888:	7179                	addi	sp,sp,-48
    8000488a:	f406                	sd	ra,40(sp)
    8000488c:	f022                	sd	s0,32(sp)
    8000488e:	ec26                	sd	s1,24(sp)
    80004890:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004892:	fd840613          	addi	a2,s0,-40
    80004896:	4581                	li	a1,0
    80004898:	4501                	li	a0,0
    8000489a:	00000097          	auipc	ra,0x0
    8000489e:	dc0080e7          	jalr	-576(ra) # 8000465a <argfd>
    return -1;
    800048a2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800048a4:	02054363          	bltz	a0,800048ca <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800048a8:	fd843503          	ld	a0,-40(s0)
    800048ac:	00000097          	auipc	ra,0x0
    800048b0:	e0e080e7          	jalr	-498(ra) # 800046ba <fdalloc>
    800048b4:	84aa                	mv	s1,a0
    return -1;
    800048b6:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800048b8:	00054963          	bltz	a0,800048ca <sys_dup+0x42>
  filedup(f);
    800048bc:	fd843503          	ld	a0,-40(s0)
    800048c0:	fffff097          	auipc	ra,0xfffff
    800048c4:	316080e7          	jalr	790(ra) # 80003bd6 <filedup>
  return fd;
    800048c8:	87a6                	mv	a5,s1
}
    800048ca:	853e                	mv	a0,a5
    800048cc:	70a2                	ld	ra,40(sp)
    800048ce:	7402                	ld	s0,32(sp)
    800048d0:	64e2                	ld	s1,24(sp)
    800048d2:	6145                	addi	sp,sp,48
    800048d4:	8082                	ret

00000000800048d6 <sys_read>:
{
    800048d6:	7179                	addi	sp,sp,-48
    800048d8:	f406                	sd	ra,40(sp)
    800048da:	f022                	sd	s0,32(sp)
    800048dc:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800048de:	fd840593          	addi	a1,s0,-40
    800048e2:	4505                	li	a0,1
    800048e4:	ffffe097          	auipc	ra,0xffffe
    800048e8:	808080e7          	jalr	-2040(ra) # 800020ec <argaddr>
  argint(2, &n);
    800048ec:	fe440593          	addi	a1,s0,-28
    800048f0:	4509                	li	a0,2
    800048f2:	ffffd097          	auipc	ra,0xffffd
    800048f6:	7da080e7          	jalr	2010(ra) # 800020cc <argint>
  if(argfd(0, 0, &f) < 0)
    800048fa:	fe840613          	addi	a2,s0,-24
    800048fe:	4581                	li	a1,0
    80004900:	4501                	li	a0,0
    80004902:	00000097          	auipc	ra,0x0
    80004906:	d58080e7          	jalr	-680(ra) # 8000465a <argfd>
    8000490a:	87aa                	mv	a5,a0
    return -1;
    8000490c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000490e:	0007cc63          	bltz	a5,80004926 <sys_read+0x50>
  return fileread(f, p, n);
    80004912:	fe442603          	lw	a2,-28(s0)
    80004916:	fd843583          	ld	a1,-40(s0)
    8000491a:	fe843503          	ld	a0,-24(s0)
    8000491e:	fffff097          	auipc	ra,0xfffff
    80004922:	444080e7          	jalr	1092(ra) # 80003d62 <fileread>
}
    80004926:	70a2                	ld	ra,40(sp)
    80004928:	7402                	ld	s0,32(sp)
    8000492a:	6145                	addi	sp,sp,48
    8000492c:	8082                	ret

000000008000492e <sys_write>:
{
    8000492e:	7179                	addi	sp,sp,-48
    80004930:	f406                	sd	ra,40(sp)
    80004932:	f022                	sd	s0,32(sp)
    80004934:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004936:	fd840593          	addi	a1,s0,-40
    8000493a:	4505                	li	a0,1
    8000493c:	ffffd097          	auipc	ra,0xffffd
    80004940:	7b0080e7          	jalr	1968(ra) # 800020ec <argaddr>
  argint(2, &n);
    80004944:	fe440593          	addi	a1,s0,-28
    80004948:	4509                	li	a0,2
    8000494a:	ffffd097          	auipc	ra,0xffffd
    8000494e:	782080e7          	jalr	1922(ra) # 800020cc <argint>
  if(argfd(0, 0, &f) < 0)
    80004952:	fe840613          	addi	a2,s0,-24
    80004956:	4581                	li	a1,0
    80004958:	4501                	li	a0,0
    8000495a:	00000097          	auipc	ra,0x0
    8000495e:	d00080e7          	jalr	-768(ra) # 8000465a <argfd>
    80004962:	87aa                	mv	a5,a0
    return -1;
    80004964:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004966:	0007cc63          	bltz	a5,8000497e <sys_write+0x50>
  return filewrite(f, p, n);
    8000496a:	fe442603          	lw	a2,-28(s0)
    8000496e:	fd843583          	ld	a1,-40(s0)
    80004972:	fe843503          	ld	a0,-24(s0)
    80004976:	fffff097          	auipc	ra,0xfffff
    8000497a:	4ae080e7          	jalr	1198(ra) # 80003e24 <filewrite>
}
    8000497e:	70a2                	ld	ra,40(sp)
    80004980:	7402                	ld	s0,32(sp)
    80004982:	6145                	addi	sp,sp,48
    80004984:	8082                	ret

0000000080004986 <sys_close>:
{
    80004986:	1101                	addi	sp,sp,-32
    80004988:	ec06                	sd	ra,24(sp)
    8000498a:	e822                	sd	s0,16(sp)
    8000498c:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000498e:	fe040613          	addi	a2,s0,-32
    80004992:	fec40593          	addi	a1,s0,-20
    80004996:	4501                	li	a0,0
    80004998:	00000097          	auipc	ra,0x0
    8000499c:	cc2080e7          	jalr	-830(ra) # 8000465a <argfd>
    return -1;
    800049a0:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800049a2:	02054463          	bltz	a0,800049ca <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800049a6:	ffffc097          	auipc	ra,0xffffc
    800049aa:	612080e7          	jalr	1554(ra) # 80000fb8 <myproc>
    800049ae:	fec42783          	lw	a5,-20(s0)
    800049b2:	07e9                	addi	a5,a5,26
    800049b4:	078e                	slli	a5,a5,0x3
    800049b6:	97aa                	add	a5,a5,a0
    800049b8:	0007b423          	sd	zero,8(a5)
  fileclose(f);
    800049bc:	fe043503          	ld	a0,-32(s0)
    800049c0:	fffff097          	auipc	ra,0xfffff
    800049c4:	268080e7          	jalr	616(ra) # 80003c28 <fileclose>
  return 0;
    800049c8:	4781                	li	a5,0
}
    800049ca:	853e                	mv	a0,a5
    800049cc:	60e2                	ld	ra,24(sp)
    800049ce:	6442                	ld	s0,16(sp)
    800049d0:	6105                	addi	sp,sp,32
    800049d2:	8082                	ret

00000000800049d4 <sys_fstat>:
{
    800049d4:	1101                	addi	sp,sp,-32
    800049d6:	ec06                	sd	ra,24(sp)
    800049d8:	e822                	sd	s0,16(sp)
    800049da:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800049dc:	fe040593          	addi	a1,s0,-32
    800049e0:	4505                	li	a0,1
    800049e2:	ffffd097          	auipc	ra,0xffffd
    800049e6:	70a080e7          	jalr	1802(ra) # 800020ec <argaddr>
  if(argfd(0, 0, &f) < 0)
    800049ea:	fe840613          	addi	a2,s0,-24
    800049ee:	4581                	li	a1,0
    800049f0:	4501                	li	a0,0
    800049f2:	00000097          	auipc	ra,0x0
    800049f6:	c68080e7          	jalr	-920(ra) # 8000465a <argfd>
    800049fa:	87aa                	mv	a5,a0
    return -1;
    800049fc:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800049fe:	0007ca63          	bltz	a5,80004a12 <sys_fstat+0x3e>
  return filestat(f, st);
    80004a02:	fe043583          	ld	a1,-32(s0)
    80004a06:	fe843503          	ld	a0,-24(s0)
    80004a0a:	fffff097          	auipc	ra,0xfffff
    80004a0e:	2e6080e7          	jalr	742(ra) # 80003cf0 <filestat>
}
    80004a12:	60e2                	ld	ra,24(sp)
    80004a14:	6442                	ld	s0,16(sp)
    80004a16:	6105                	addi	sp,sp,32
    80004a18:	8082                	ret

0000000080004a1a <sys_link>:
{
    80004a1a:	7169                	addi	sp,sp,-304
    80004a1c:	f606                	sd	ra,296(sp)
    80004a1e:	f222                	sd	s0,288(sp)
    80004a20:	ee26                	sd	s1,280(sp)
    80004a22:	ea4a                	sd	s2,272(sp)
    80004a24:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a26:	08000613          	li	a2,128
    80004a2a:	ed040593          	addi	a1,s0,-304
    80004a2e:	4501                	li	a0,0
    80004a30:	ffffd097          	auipc	ra,0xffffd
    80004a34:	6dc080e7          	jalr	1756(ra) # 8000210c <argstr>
    return -1;
    80004a38:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a3a:	10054e63          	bltz	a0,80004b56 <sys_link+0x13c>
    80004a3e:	08000613          	li	a2,128
    80004a42:	f5040593          	addi	a1,s0,-176
    80004a46:	4505                	li	a0,1
    80004a48:	ffffd097          	auipc	ra,0xffffd
    80004a4c:	6c4080e7          	jalr	1732(ra) # 8000210c <argstr>
    return -1;
    80004a50:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a52:	10054263          	bltz	a0,80004b56 <sys_link+0x13c>
  begin_op();
    80004a56:	fffff097          	auipc	ra,0xfffff
    80004a5a:	d06080e7          	jalr	-762(ra) # 8000375c <begin_op>
  if((ip = namei(old)) == 0){
    80004a5e:	ed040513          	addi	a0,s0,-304
    80004a62:	fffff097          	auipc	ra,0xfffff
    80004a66:	ade080e7          	jalr	-1314(ra) # 80003540 <namei>
    80004a6a:	84aa                	mv	s1,a0
    80004a6c:	c551                	beqz	a0,80004af8 <sys_link+0xde>
  ilock(ip);
    80004a6e:	ffffe097          	auipc	ra,0xffffe
    80004a72:	318080e7          	jalr	792(ra) # 80002d86 <ilock>
  if(ip->type == T_DIR){
    80004a76:	04c49703          	lh	a4,76(s1)
    80004a7a:	4785                	li	a5,1
    80004a7c:	08f70463          	beq	a4,a5,80004b04 <sys_link+0xea>
  ip->nlink++;
    80004a80:	0524d783          	lhu	a5,82(s1)
    80004a84:	2785                	addiw	a5,a5,1
    80004a86:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80004a8a:	8526                	mv	a0,s1
    80004a8c:	ffffe097          	auipc	ra,0xffffe
    80004a90:	230080e7          	jalr	560(ra) # 80002cbc <iupdate>
  iunlock(ip);
    80004a94:	8526                	mv	a0,s1
    80004a96:	ffffe097          	auipc	ra,0xffffe
    80004a9a:	3bc080e7          	jalr	956(ra) # 80002e52 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004a9e:	fd040593          	addi	a1,s0,-48
    80004aa2:	f5040513          	addi	a0,s0,-176
    80004aa6:	fffff097          	auipc	ra,0xfffff
    80004aaa:	ab8080e7          	jalr	-1352(ra) # 8000355e <nameiparent>
    80004aae:	892a                	mv	s2,a0
    80004ab0:	c935                	beqz	a0,80004b24 <sys_link+0x10a>
  ilock(dp);
    80004ab2:	ffffe097          	auipc	ra,0xffffe
    80004ab6:	2d4080e7          	jalr	724(ra) # 80002d86 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004aba:	00092703          	lw	a4,0(s2)
    80004abe:	409c                	lw	a5,0(s1)
    80004ac0:	04f71d63          	bne	a4,a5,80004b1a <sys_link+0x100>
    80004ac4:	40d0                	lw	a2,4(s1)
    80004ac6:	fd040593          	addi	a1,s0,-48
    80004aca:	854a                	mv	a0,s2
    80004acc:	fffff097          	auipc	ra,0xfffff
    80004ad0:	9c2080e7          	jalr	-1598(ra) # 8000348e <dirlink>
    80004ad4:	04054363          	bltz	a0,80004b1a <sys_link+0x100>
  iunlockput(dp);
    80004ad8:	854a                	mv	a0,s2
    80004ada:	ffffe097          	auipc	ra,0xffffe
    80004ade:	522080e7          	jalr	1314(ra) # 80002ffc <iunlockput>
  iput(ip);
    80004ae2:	8526                	mv	a0,s1
    80004ae4:	ffffe097          	auipc	ra,0xffffe
    80004ae8:	470080e7          	jalr	1136(ra) # 80002f54 <iput>
  end_op();
    80004aec:	fffff097          	auipc	ra,0xfffff
    80004af0:	cf0080e7          	jalr	-784(ra) # 800037dc <end_op>
  return 0;
    80004af4:	4781                	li	a5,0
    80004af6:	a085                	j	80004b56 <sys_link+0x13c>
    end_op();
    80004af8:	fffff097          	auipc	ra,0xfffff
    80004afc:	ce4080e7          	jalr	-796(ra) # 800037dc <end_op>
    return -1;
    80004b00:	57fd                	li	a5,-1
    80004b02:	a891                	j	80004b56 <sys_link+0x13c>
    iunlockput(ip);
    80004b04:	8526                	mv	a0,s1
    80004b06:	ffffe097          	auipc	ra,0xffffe
    80004b0a:	4f6080e7          	jalr	1270(ra) # 80002ffc <iunlockput>
    end_op();
    80004b0e:	fffff097          	auipc	ra,0xfffff
    80004b12:	cce080e7          	jalr	-818(ra) # 800037dc <end_op>
    return -1;
    80004b16:	57fd                	li	a5,-1
    80004b18:	a83d                	j	80004b56 <sys_link+0x13c>
    iunlockput(dp);
    80004b1a:	854a                	mv	a0,s2
    80004b1c:	ffffe097          	auipc	ra,0xffffe
    80004b20:	4e0080e7          	jalr	1248(ra) # 80002ffc <iunlockput>
  ilock(ip);
    80004b24:	8526                	mv	a0,s1
    80004b26:	ffffe097          	auipc	ra,0xffffe
    80004b2a:	260080e7          	jalr	608(ra) # 80002d86 <ilock>
  ip->nlink--;
    80004b2e:	0524d783          	lhu	a5,82(s1)
    80004b32:	37fd                	addiw	a5,a5,-1
    80004b34:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80004b38:	8526                	mv	a0,s1
    80004b3a:	ffffe097          	auipc	ra,0xffffe
    80004b3e:	182080e7          	jalr	386(ra) # 80002cbc <iupdate>
  iunlockput(ip);
    80004b42:	8526                	mv	a0,s1
    80004b44:	ffffe097          	auipc	ra,0xffffe
    80004b48:	4b8080e7          	jalr	1208(ra) # 80002ffc <iunlockput>
  end_op();
    80004b4c:	fffff097          	auipc	ra,0xfffff
    80004b50:	c90080e7          	jalr	-880(ra) # 800037dc <end_op>
  return -1;
    80004b54:	57fd                	li	a5,-1
}
    80004b56:	853e                	mv	a0,a5
    80004b58:	70b2                	ld	ra,296(sp)
    80004b5a:	7412                	ld	s0,288(sp)
    80004b5c:	64f2                	ld	s1,280(sp)
    80004b5e:	6952                	ld	s2,272(sp)
    80004b60:	6155                	addi	sp,sp,304
    80004b62:	8082                	ret

0000000080004b64 <sys_unlink>:
{
    80004b64:	7151                	addi	sp,sp,-240
    80004b66:	f586                	sd	ra,232(sp)
    80004b68:	f1a2                	sd	s0,224(sp)
    80004b6a:	eda6                	sd	s1,216(sp)
    80004b6c:	e9ca                	sd	s2,208(sp)
    80004b6e:	e5ce                	sd	s3,200(sp)
    80004b70:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004b72:	08000613          	li	a2,128
    80004b76:	f3040593          	addi	a1,s0,-208
    80004b7a:	4501                	li	a0,0
    80004b7c:	ffffd097          	auipc	ra,0xffffd
    80004b80:	590080e7          	jalr	1424(ra) # 8000210c <argstr>
    80004b84:	18054163          	bltz	a0,80004d06 <sys_unlink+0x1a2>
  begin_op();
    80004b88:	fffff097          	auipc	ra,0xfffff
    80004b8c:	bd4080e7          	jalr	-1068(ra) # 8000375c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004b90:	fb040593          	addi	a1,s0,-80
    80004b94:	f3040513          	addi	a0,s0,-208
    80004b98:	fffff097          	auipc	ra,0xfffff
    80004b9c:	9c6080e7          	jalr	-1594(ra) # 8000355e <nameiparent>
    80004ba0:	84aa                	mv	s1,a0
    80004ba2:	c979                	beqz	a0,80004c78 <sys_unlink+0x114>
  ilock(dp);
    80004ba4:	ffffe097          	auipc	ra,0xffffe
    80004ba8:	1e2080e7          	jalr	482(ra) # 80002d86 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004bac:	00004597          	auipc	a1,0x4
    80004bb0:	b0458593          	addi	a1,a1,-1276 # 800086b0 <syscalls+0x2a0>
    80004bb4:	fb040513          	addi	a0,s0,-80
    80004bb8:	ffffe097          	auipc	ra,0xffffe
    80004bbc:	6ac080e7          	jalr	1708(ra) # 80003264 <namecmp>
    80004bc0:	14050a63          	beqz	a0,80004d14 <sys_unlink+0x1b0>
    80004bc4:	00004597          	auipc	a1,0x4
    80004bc8:	af458593          	addi	a1,a1,-1292 # 800086b8 <syscalls+0x2a8>
    80004bcc:	fb040513          	addi	a0,s0,-80
    80004bd0:	ffffe097          	auipc	ra,0xffffe
    80004bd4:	694080e7          	jalr	1684(ra) # 80003264 <namecmp>
    80004bd8:	12050e63          	beqz	a0,80004d14 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004bdc:	f2c40613          	addi	a2,s0,-212
    80004be0:	fb040593          	addi	a1,s0,-80
    80004be4:	8526                	mv	a0,s1
    80004be6:	ffffe097          	auipc	ra,0xffffe
    80004bea:	698080e7          	jalr	1688(ra) # 8000327e <dirlookup>
    80004bee:	892a                	mv	s2,a0
    80004bf0:	12050263          	beqz	a0,80004d14 <sys_unlink+0x1b0>
  ilock(ip);
    80004bf4:	ffffe097          	auipc	ra,0xffffe
    80004bf8:	192080e7          	jalr	402(ra) # 80002d86 <ilock>
  if(ip->nlink < 1)
    80004bfc:	05291783          	lh	a5,82(s2)
    80004c00:	08f05263          	blez	a5,80004c84 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004c04:	04c91703          	lh	a4,76(s2)
    80004c08:	4785                	li	a5,1
    80004c0a:	08f70563          	beq	a4,a5,80004c94 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004c0e:	4641                	li	a2,16
    80004c10:	4581                	li	a1,0
    80004c12:	fc040513          	addi	a0,s0,-64
    80004c16:	ffffb097          	auipc	ra,0xffffb
    80004c1a:	65a080e7          	jalr	1626(ra) # 80000270 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c1e:	4741                	li	a4,16
    80004c20:	f2c42683          	lw	a3,-212(s0)
    80004c24:	fc040613          	addi	a2,s0,-64
    80004c28:	4581                	li	a1,0
    80004c2a:	8526                	mv	a0,s1
    80004c2c:	ffffe097          	auipc	ra,0xffffe
    80004c30:	51a080e7          	jalr	1306(ra) # 80003146 <writei>
    80004c34:	47c1                	li	a5,16
    80004c36:	0af51563          	bne	a0,a5,80004ce0 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004c3a:	04c91703          	lh	a4,76(s2)
    80004c3e:	4785                	li	a5,1
    80004c40:	0af70863          	beq	a4,a5,80004cf0 <sys_unlink+0x18c>
  iunlockput(dp);
    80004c44:	8526                	mv	a0,s1
    80004c46:	ffffe097          	auipc	ra,0xffffe
    80004c4a:	3b6080e7          	jalr	950(ra) # 80002ffc <iunlockput>
  ip->nlink--;
    80004c4e:	05295783          	lhu	a5,82(s2)
    80004c52:	37fd                	addiw	a5,a5,-1
    80004c54:	04f91923          	sh	a5,82(s2)
  iupdate(ip);
    80004c58:	854a                	mv	a0,s2
    80004c5a:	ffffe097          	auipc	ra,0xffffe
    80004c5e:	062080e7          	jalr	98(ra) # 80002cbc <iupdate>
  iunlockput(ip);
    80004c62:	854a                	mv	a0,s2
    80004c64:	ffffe097          	auipc	ra,0xffffe
    80004c68:	398080e7          	jalr	920(ra) # 80002ffc <iunlockput>
  end_op();
    80004c6c:	fffff097          	auipc	ra,0xfffff
    80004c70:	b70080e7          	jalr	-1168(ra) # 800037dc <end_op>
  return 0;
    80004c74:	4501                	li	a0,0
    80004c76:	a84d                	j	80004d28 <sys_unlink+0x1c4>
    end_op();
    80004c78:	fffff097          	auipc	ra,0xfffff
    80004c7c:	b64080e7          	jalr	-1180(ra) # 800037dc <end_op>
    return -1;
    80004c80:	557d                	li	a0,-1
    80004c82:	a05d                	j	80004d28 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004c84:	00004517          	auipc	a0,0x4
    80004c88:	a3c50513          	addi	a0,a0,-1476 # 800086c0 <syscalls+0x2b0>
    80004c8c:	00001097          	auipc	ra,0x1
    80004c90:	54a080e7          	jalr	1354(ra) # 800061d6 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c94:	05492703          	lw	a4,84(s2)
    80004c98:	02000793          	li	a5,32
    80004c9c:	f6e7f9e3          	bgeu	a5,a4,80004c0e <sys_unlink+0xaa>
    80004ca0:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004ca4:	4741                	li	a4,16
    80004ca6:	86ce                	mv	a3,s3
    80004ca8:	f1840613          	addi	a2,s0,-232
    80004cac:	4581                	li	a1,0
    80004cae:	854a                	mv	a0,s2
    80004cb0:	ffffe097          	auipc	ra,0xffffe
    80004cb4:	39e080e7          	jalr	926(ra) # 8000304e <readi>
    80004cb8:	47c1                	li	a5,16
    80004cba:	00f51b63          	bne	a0,a5,80004cd0 <sys_unlink+0x16c>
    if(de.inum != 0)
    80004cbe:	f1845783          	lhu	a5,-232(s0)
    80004cc2:	e7a1                	bnez	a5,80004d0a <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004cc4:	29c1                	addiw	s3,s3,16
    80004cc6:	05492783          	lw	a5,84(s2)
    80004cca:	fcf9ede3          	bltu	s3,a5,80004ca4 <sys_unlink+0x140>
    80004cce:	b781                	j	80004c0e <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004cd0:	00004517          	auipc	a0,0x4
    80004cd4:	a0850513          	addi	a0,a0,-1528 # 800086d8 <syscalls+0x2c8>
    80004cd8:	00001097          	auipc	ra,0x1
    80004cdc:	4fe080e7          	jalr	1278(ra) # 800061d6 <panic>
    panic("unlink: writei");
    80004ce0:	00004517          	auipc	a0,0x4
    80004ce4:	a1050513          	addi	a0,a0,-1520 # 800086f0 <syscalls+0x2e0>
    80004ce8:	00001097          	auipc	ra,0x1
    80004cec:	4ee080e7          	jalr	1262(ra) # 800061d6 <panic>
    dp->nlink--;
    80004cf0:	0524d783          	lhu	a5,82(s1)
    80004cf4:	37fd                	addiw	a5,a5,-1
    80004cf6:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    80004cfa:	8526                	mv	a0,s1
    80004cfc:	ffffe097          	auipc	ra,0xffffe
    80004d00:	fc0080e7          	jalr	-64(ra) # 80002cbc <iupdate>
    80004d04:	b781                	j	80004c44 <sys_unlink+0xe0>
    return -1;
    80004d06:	557d                	li	a0,-1
    80004d08:	a005                	j	80004d28 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004d0a:	854a                	mv	a0,s2
    80004d0c:	ffffe097          	auipc	ra,0xffffe
    80004d10:	2f0080e7          	jalr	752(ra) # 80002ffc <iunlockput>
  iunlockput(dp);
    80004d14:	8526                	mv	a0,s1
    80004d16:	ffffe097          	auipc	ra,0xffffe
    80004d1a:	2e6080e7          	jalr	742(ra) # 80002ffc <iunlockput>
  end_op();
    80004d1e:	fffff097          	auipc	ra,0xfffff
    80004d22:	abe080e7          	jalr	-1346(ra) # 800037dc <end_op>
  return -1;
    80004d26:	557d                	li	a0,-1
}
    80004d28:	70ae                	ld	ra,232(sp)
    80004d2a:	740e                	ld	s0,224(sp)
    80004d2c:	64ee                	ld	s1,216(sp)
    80004d2e:	694e                	ld	s2,208(sp)
    80004d30:	69ae                	ld	s3,200(sp)
    80004d32:	616d                	addi	sp,sp,240
    80004d34:	8082                	ret

0000000080004d36 <sys_open>:

uint64
sys_open(void)
{
    80004d36:	7131                	addi	sp,sp,-192
    80004d38:	fd06                	sd	ra,184(sp)
    80004d3a:	f922                	sd	s0,176(sp)
    80004d3c:	f526                	sd	s1,168(sp)
    80004d3e:	f14a                	sd	s2,160(sp)
    80004d40:	ed4e                	sd	s3,152(sp)
    80004d42:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004d44:	f4c40593          	addi	a1,s0,-180
    80004d48:	4505                	li	a0,1
    80004d4a:	ffffd097          	auipc	ra,0xffffd
    80004d4e:	382080e7          	jalr	898(ra) # 800020cc <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d52:	08000613          	li	a2,128
    80004d56:	f5040593          	addi	a1,s0,-176
    80004d5a:	4501                	li	a0,0
    80004d5c:	ffffd097          	auipc	ra,0xffffd
    80004d60:	3b0080e7          	jalr	944(ra) # 8000210c <argstr>
    80004d64:	87aa                	mv	a5,a0
    return -1;
    80004d66:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004d68:	0a07c963          	bltz	a5,80004e1a <sys_open+0xe4>

  begin_op();
    80004d6c:	fffff097          	auipc	ra,0xfffff
    80004d70:	9f0080e7          	jalr	-1552(ra) # 8000375c <begin_op>

  if(omode & O_CREATE){
    80004d74:	f4c42783          	lw	a5,-180(s0)
    80004d78:	2007f793          	andi	a5,a5,512
    80004d7c:	cfc5                	beqz	a5,80004e34 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004d7e:	4681                	li	a3,0
    80004d80:	4601                	li	a2,0
    80004d82:	4589                	li	a1,2
    80004d84:	f5040513          	addi	a0,s0,-176
    80004d88:	00000097          	auipc	ra,0x0
    80004d8c:	974080e7          	jalr	-1676(ra) # 800046fc <create>
    80004d90:	84aa                	mv	s1,a0
    if(ip == 0){
    80004d92:	c959                	beqz	a0,80004e28 <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004d94:	04c49703          	lh	a4,76(s1)
    80004d98:	478d                	li	a5,3
    80004d9a:	00f71763          	bne	a4,a5,80004da8 <sys_open+0x72>
    80004d9e:	04e4d703          	lhu	a4,78(s1)
    80004da2:	47a5                	li	a5,9
    80004da4:	0ce7ed63          	bltu	a5,a4,80004e7e <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004da8:	fffff097          	auipc	ra,0xfffff
    80004dac:	dc4080e7          	jalr	-572(ra) # 80003b6c <filealloc>
    80004db0:	89aa                	mv	s3,a0
    80004db2:	10050363          	beqz	a0,80004eb8 <sys_open+0x182>
    80004db6:	00000097          	auipc	ra,0x0
    80004dba:	904080e7          	jalr	-1788(ra) # 800046ba <fdalloc>
    80004dbe:	892a                	mv	s2,a0
    80004dc0:	0e054763          	bltz	a0,80004eae <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004dc4:	04c49703          	lh	a4,76(s1)
    80004dc8:	478d                	li	a5,3
    80004dca:	0cf70563          	beq	a4,a5,80004e94 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004dce:	4789                	li	a5,2
    80004dd0:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004dd4:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004dd8:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004ddc:	f4c42783          	lw	a5,-180(s0)
    80004de0:	0017c713          	xori	a4,a5,1
    80004de4:	8b05                	andi	a4,a4,1
    80004de6:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004dea:	0037f713          	andi	a4,a5,3
    80004dee:	00e03733          	snez	a4,a4
    80004df2:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004df6:	4007f793          	andi	a5,a5,1024
    80004dfa:	c791                	beqz	a5,80004e06 <sys_open+0xd0>
    80004dfc:	04c49703          	lh	a4,76(s1)
    80004e00:	4789                	li	a5,2
    80004e02:	0af70063          	beq	a4,a5,80004ea2 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004e06:	8526                	mv	a0,s1
    80004e08:	ffffe097          	auipc	ra,0xffffe
    80004e0c:	04a080e7          	jalr	74(ra) # 80002e52 <iunlock>
  end_op();
    80004e10:	fffff097          	auipc	ra,0xfffff
    80004e14:	9cc080e7          	jalr	-1588(ra) # 800037dc <end_op>

  return fd;
    80004e18:	854a                	mv	a0,s2
}
    80004e1a:	70ea                	ld	ra,184(sp)
    80004e1c:	744a                	ld	s0,176(sp)
    80004e1e:	74aa                	ld	s1,168(sp)
    80004e20:	790a                	ld	s2,160(sp)
    80004e22:	69ea                	ld	s3,152(sp)
    80004e24:	6129                	addi	sp,sp,192
    80004e26:	8082                	ret
      end_op();
    80004e28:	fffff097          	auipc	ra,0xfffff
    80004e2c:	9b4080e7          	jalr	-1612(ra) # 800037dc <end_op>
      return -1;
    80004e30:	557d                	li	a0,-1
    80004e32:	b7e5                	j	80004e1a <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004e34:	f5040513          	addi	a0,s0,-176
    80004e38:	ffffe097          	auipc	ra,0xffffe
    80004e3c:	708080e7          	jalr	1800(ra) # 80003540 <namei>
    80004e40:	84aa                	mv	s1,a0
    80004e42:	c905                	beqz	a0,80004e72 <sys_open+0x13c>
    ilock(ip);
    80004e44:	ffffe097          	auipc	ra,0xffffe
    80004e48:	f42080e7          	jalr	-190(ra) # 80002d86 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004e4c:	04c49703          	lh	a4,76(s1)
    80004e50:	4785                	li	a5,1
    80004e52:	f4f711e3          	bne	a4,a5,80004d94 <sys_open+0x5e>
    80004e56:	f4c42783          	lw	a5,-180(s0)
    80004e5a:	d7b9                	beqz	a5,80004da8 <sys_open+0x72>
      iunlockput(ip);
    80004e5c:	8526                	mv	a0,s1
    80004e5e:	ffffe097          	auipc	ra,0xffffe
    80004e62:	19e080e7          	jalr	414(ra) # 80002ffc <iunlockput>
      end_op();
    80004e66:	fffff097          	auipc	ra,0xfffff
    80004e6a:	976080e7          	jalr	-1674(ra) # 800037dc <end_op>
      return -1;
    80004e6e:	557d                	li	a0,-1
    80004e70:	b76d                	j	80004e1a <sys_open+0xe4>
      end_op();
    80004e72:	fffff097          	auipc	ra,0xfffff
    80004e76:	96a080e7          	jalr	-1686(ra) # 800037dc <end_op>
      return -1;
    80004e7a:	557d                	li	a0,-1
    80004e7c:	bf79                	j	80004e1a <sys_open+0xe4>
    iunlockput(ip);
    80004e7e:	8526                	mv	a0,s1
    80004e80:	ffffe097          	auipc	ra,0xffffe
    80004e84:	17c080e7          	jalr	380(ra) # 80002ffc <iunlockput>
    end_op();
    80004e88:	fffff097          	auipc	ra,0xfffff
    80004e8c:	954080e7          	jalr	-1708(ra) # 800037dc <end_op>
    return -1;
    80004e90:	557d                	li	a0,-1
    80004e92:	b761                	j	80004e1a <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004e94:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004e98:	04e49783          	lh	a5,78(s1)
    80004e9c:	02f99223          	sh	a5,36(s3)
    80004ea0:	bf25                	j	80004dd8 <sys_open+0xa2>
    itrunc(ip);
    80004ea2:	8526                	mv	a0,s1
    80004ea4:	ffffe097          	auipc	ra,0xffffe
    80004ea8:	004080e7          	jalr	4(ra) # 80002ea8 <itrunc>
    80004eac:	bfa9                	j	80004e06 <sys_open+0xd0>
      fileclose(f);
    80004eae:	854e                	mv	a0,s3
    80004eb0:	fffff097          	auipc	ra,0xfffff
    80004eb4:	d78080e7          	jalr	-648(ra) # 80003c28 <fileclose>
    iunlockput(ip);
    80004eb8:	8526                	mv	a0,s1
    80004eba:	ffffe097          	auipc	ra,0xffffe
    80004ebe:	142080e7          	jalr	322(ra) # 80002ffc <iunlockput>
    end_op();
    80004ec2:	fffff097          	auipc	ra,0xfffff
    80004ec6:	91a080e7          	jalr	-1766(ra) # 800037dc <end_op>
    return -1;
    80004eca:	557d                	li	a0,-1
    80004ecc:	b7b9                	j	80004e1a <sys_open+0xe4>

0000000080004ece <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004ece:	7175                	addi	sp,sp,-144
    80004ed0:	e506                	sd	ra,136(sp)
    80004ed2:	e122                	sd	s0,128(sp)
    80004ed4:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004ed6:	fffff097          	auipc	ra,0xfffff
    80004eda:	886080e7          	jalr	-1914(ra) # 8000375c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004ede:	08000613          	li	a2,128
    80004ee2:	f7040593          	addi	a1,s0,-144
    80004ee6:	4501                	li	a0,0
    80004ee8:	ffffd097          	auipc	ra,0xffffd
    80004eec:	224080e7          	jalr	548(ra) # 8000210c <argstr>
    80004ef0:	02054963          	bltz	a0,80004f22 <sys_mkdir+0x54>
    80004ef4:	4681                	li	a3,0
    80004ef6:	4601                	li	a2,0
    80004ef8:	4585                	li	a1,1
    80004efa:	f7040513          	addi	a0,s0,-144
    80004efe:	fffff097          	auipc	ra,0xfffff
    80004f02:	7fe080e7          	jalr	2046(ra) # 800046fc <create>
    80004f06:	cd11                	beqz	a0,80004f22 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f08:	ffffe097          	auipc	ra,0xffffe
    80004f0c:	0f4080e7          	jalr	244(ra) # 80002ffc <iunlockput>
  end_op();
    80004f10:	fffff097          	auipc	ra,0xfffff
    80004f14:	8cc080e7          	jalr	-1844(ra) # 800037dc <end_op>
  return 0;
    80004f18:	4501                	li	a0,0
}
    80004f1a:	60aa                	ld	ra,136(sp)
    80004f1c:	640a                	ld	s0,128(sp)
    80004f1e:	6149                	addi	sp,sp,144
    80004f20:	8082                	ret
    end_op();
    80004f22:	fffff097          	auipc	ra,0xfffff
    80004f26:	8ba080e7          	jalr	-1862(ra) # 800037dc <end_op>
    return -1;
    80004f2a:	557d                	li	a0,-1
    80004f2c:	b7fd                	j	80004f1a <sys_mkdir+0x4c>

0000000080004f2e <sys_mknod>:

uint64
sys_mknod(void)
{
    80004f2e:	7135                	addi	sp,sp,-160
    80004f30:	ed06                	sd	ra,152(sp)
    80004f32:	e922                	sd	s0,144(sp)
    80004f34:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004f36:	fffff097          	auipc	ra,0xfffff
    80004f3a:	826080e7          	jalr	-2010(ra) # 8000375c <begin_op>
  argint(1, &major);
    80004f3e:	f6c40593          	addi	a1,s0,-148
    80004f42:	4505                	li	a0,1
    80004f44:	ffffd097          	auipc	ra,0xffffd
    80004f48:	188080e7          	jalr	392(ra) # 800020cc <argint>
  argint(2, &minor);
    80004f4c:	f6840593          	addi	a1,s0,-152
    80004f50:	4509                	li	a0,2
    80004f52:	ffffd097          	auipc	ra,0xffffd
    80004f56:	17a080e7          	jalr	378(ra) # 800020cc <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f5a:	08000613          	li	a2,128
    80004f5e:	f7040593          	addi	a1,s0,-144
    80004f62:	4501                	li	a0,0
    80004f64:	ffffd097          	auipc	ra,0xffffd
    80004f68:	1a8080e7          	jalr	424(ra) # 8000210c <argstr>
    80004f6c:	02054b63          	bltz	a0,80004fa2 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004f70:	f6841683          	lh	a3,-152(s0)
    80004f74:	f6c41603          	lh	a2,-148(s0)
    80004f78:	458d                	li	a1,3
    80004f7a:	f7040513          	addi	a0,s0,-144
    80004f7e:	fffff097          	auipc	ra,0xfffff
    80004f82:	77e080e7          	jalr	1918(ra) # 800046fc <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f86:	cd11                	beqz	a0,80004fa2 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f88:	ffffe097          	auipc	ra,0xffffe
    80004f8c:	074080e7          	jalr	116(ra) # 80002ffc <iunlockput>
  end_op();
    80004f90:	fffff097          	auipc	ra,0xfffff
    80004f94:	84c080e7          	jalr	-1972(ra) # 800037dc <end_op>
  return 0;
    80004f98:	4501                	li	a0,0
}
    80004f9a:	60ea                	ld	ra,152(sp)
    80004f9c:	644a                	ld	s0,144(sp)
    80004f9e:	610d                	addi	sp,sp,160
    80004fa0:	8082                	ret
    end_op();
    80004fa2:	fffff097          	auipc	ra,0xfffff
    80004fa6:	83a080e7          	jalr	-1990(ra) # 800037dc <end_op>
    return -1;
    80004faa:	557d                	li	a0,-1
    80004fac:	b7fd                	j	80004f9a <sys_mknod+0x6c>

0000000080004fae <sys_chdir>:

uint64
sys_chdir(void)
{
    80004fae:	7135                	addi	sp,sp,-160
    80004fb0:	ed06                	sd	ra,152(sp)
    80004fb2:	e922                	sd	s0,144(sp)
    80004fb4:	e526                	sd	s1,136(sp)
    80004fb6:	e14a                	sd	s2,128(sp)
    80004fb8:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004fba:	ffffc097          	auipc	ra,0xffffc
    80004fbe:	ffe080e7          	jalr	-2(ra) # 80000fb8 <myproc>
    80004fc2:	892a                	mv	s2,a0
  
  begin_op();
    80004fc4:	ffffe097          	auipc	ra,0xffffe
    80004fc8:	798080e7          	jalr	1944(ra) # 8000375c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004fcc:	08000613          	li	a2,128
    80004fd0:	f6040593          	addi	a1,s0,-160
    80004fd4:	4501                	li	a0,0
    80004fd6:	ffffd097          	auipc	ra,0xffffd
    80004fda:	136080e7          	jalr	310(ra) # 8000210c <argstr>
    80004fde:	04054b63          	bltz	a0,80005034 <sys_chdir+0x86>
    80004fe2:	f6040513          	addi	a0,s0,-160
    80004fe6:	ffffe097          	auipc	ra,0xffffe
    80004fea:	55a080e7          	jalr	1370(ra) # 80003540 <namei>
    80004fee:	84aa                	mv	s1,a0
    80004ff0:	c131                	beqz	a0,80005034 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004ff2:	ffffe097          	auipc	ra,0xffffe
    80004ff6:	d94080e7          	jalr	-620(ra) # 80002d86 <ilock>
  if(ip->type != T_DIR){
    80004ffa:	04c49703          	lh	a4,76(s1)
    80004ffe:	4785                	li	a5,1
    80005000:	04f71063          	bne	a4,a5,80005040 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005004:	8526                	mv	a0,s1
    80005006:	ffffe097          	auipc	ra,0xffffe
    8000500a:	e4c080e7          	jalr	-436(ra) # 80002e52 <iunlock>
  iput(p->cwd);
    8000500e:	15893503          	ld	a0,344(s2)
    80005012:	ffffe097          	auipc	ra,0xffffe
    80005016:	f42080e7          	jalr	-190(ra) # 80002f54 <iput>
  end_op();
    8000501a:	ffffe097          	auipc	ra,0xffffe
    8000501e:	7c2080e7          	jalr	1986(ra) # 800037dc <end_op>
  p->cwd = ip;
    80005022:	14993c23          	sd	s1,344(s2)
  return 0;
    80005026:	4501                	li	a0,0
}
    80005028:	60ea                	ld	ra,152(sp)
    8000502a:	644a                	ld	s0,144(sp)
    8000502c:	64aa                	ld	s1,136(sp)
    8000502e:	690a                	ld	s2,128(sp)
    80005030:	610d                	addi	sp,sp,160
    80005032:	8082                	ret
    end_op();
    80005034:	ffffe097          	auipc	ra,0xffffe
    80005038:	7a8080e7          	jalr	1960(ra) # 800037dc <end_op>
    return -1;
    8000503c:	557d                	li	a0,-1
    8000503e:	b7ed                	j	80005028 <sys_chdir+0x7a>
    iunlockput(ip);
    80005040:	8526                	mv	a0,s1
    80005042:	ffffe097          	auipc	ra,0xffffe
    80005046:	fba080e7          	jalr	-70(ra) # 80002ffc <iunlockput>
    end_op();
    8000504a:	ffffe097          	auipc	ra,0xffffe
    8000504e:	792080e7          	jalr	1938(ra) # 800037dc <end_op>
    return -1;
    80005052:	557d                	li	a0,-1
    80005054:	bfd1                	j	80005028 <sys_chdir+0x7a>

0000000080005056 <sys_exec>:

uint64
sys_exec(void)
{
    80005056:	7145                	addi	sp,sp,-464
    80005058:	e786                	sd	ra,456(sp)
    8000505a:	e3a2                	sd	s0,448(sp)
    8000505c:	ff26                	sd	s1,440(sp)
    8000505e:	fb4a                	sd	s2,432(sp)
    80005060:	f74e                	sd	s3,424(sp)
    80005062:	f352                	sd	s4,416(sp)
    80005064:	ef56                	sd	s5,408(sp)
    80005066:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005068:	e3840593          	addi	a1,s0,-456
    8000506c:	4505                	li	a0,1
    8000506e:	ffffd097          	auipc	ra,0xffffd
    80005072:	07e080e7          	jalr	126(ra) # 800020ec <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005076:	08000613          	li	a2,128
    8000507a:	f4040593          	addi	a1,s0,-192
    8000507e:	4501                	li	a0,0
    80005080:	ffffd097          	auipc	ra,0xffffd
    80005084:	08c080e7          	jalr	140(ra) # 8000210c <argstr>
    80005088:	87aa                	mv	a5,a0
    return -1;
    8000508a:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    8000508c:	0c07c263          	bltz	a5,80005150 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005090:	10000613          	li	a2,256
    80005094:	4581                	li	a1,0
    80005096:	e4040513          	addi	a0,s0,-448
    8000509a:	ffffb097          	auipc	ra,0xffffb
    8000509e:	1d6080e7          	jalr	470(ra) # 80000270 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800050a2:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800050a6:	89a6                	mv	s3,s1
    800050a8:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800050aa:	02000a13          	li	s4,32
    800050ae:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800050b2:	00391513          	slli	a0,s2,0x3
    800050b6:	e3040593          	addi	a1,s0,-464
    800050ba:	e3843783          	ld	a5,-456(s0)
    800050be:	953e                	add	a0,a0,a5
    800050c0:	ffffd097          	auipc	ra,0xffffd
    800050c4:	f6e080e7          	jalr	-146(ra) # 8000202e <fetchaddr>
    800050c8:	02054a63          	bltz	a0,800050fc <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    800050cc:	e3043783          	ld	a5,-464(s0)
    800050d0:	c3b9                	beqz	a5,80005116 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800050d2:	ffffb097          	auipc	ra,0xffffb
    800050d6:	096080e7          	jalr	150(ra) # 80000168 <kalloc>
    800050da:	85aa                	mv	a1,a0
    800050dc:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800050e0:	cd11                	beqz	a0,800050fc <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800050e2:	6605                	lui	a2,0x1
    800050e4:	e3043503          	ld	a0,-464(s0)
    800050e8:	ffffd097          	auipc	ra,0xffffd
    800050ec:	f98080e7          	jalr	-104(ra) # 80002080 <fetchstr>
    800050f0:	00054663          	bltz	a0,800050fc <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    800050f4:	0905                	addi	s2,s2,1
    800050f6:	09a1                	addi	s3,s3,8
    800050f8:	fb491be3          	bne	s2,s4,800050ae <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050fc:	10048913          	addi	s2,s1,256
    80005100:	6088                	ld	a0,0(s1)
    80005102:	c531                	beqz	a0,8000514e <sys_exec+0xf8>
    kfree(argv[i]);
    80005104:	ffffb097          	auipc	ra,0xffffb
    80005108:	f18080e7          	jalr	-232(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000510c:	04a1                	addi	s1,s1,8
    8000510e:	ff2499e3          	bne	s1,s2,80005100 <sys_exec+0xaa>
  return -1;
    80005112:	557d                	li	a0,-1
    80005114:	a835                	j	80005150 <sys_exec+0xfa>
      argv[i] = 0;
    80005116:	0a8e                	slli	s5,s5,0x3
    80005118:	fc040793          	addi	a5,s0,-64
    8000511c:	9abe                	add	s5,s5,a5
    8000511e:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005122:	e4040593          	addi	a1,s0,-448
    80005126:	f4040513          	addi	a0,s0,-192
    8000512a:	fffff097          	auipc	ra,0xfffff
    8000512e:	190080e7          	jalr	400(ra) # 800042ba <exec>
    80005132:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005134:	10048993          	addi	s3,s1,256
    80005138:	6088                	ld	a0,0(s1)
    8000513a:	c901                	beqz	a0,8000514a <sys_exec+0xf4>
    kfree(argv[i]);
    8000513c:	ffffb097          	auipc	ra,0xffffb
    80005140:	ee0080e7          	jalr	-288(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005144:	04a1                	addi	s1,s1,8
    80005146:	ff3499e3          	bne	s1,s3,80005138 <sys_exec+0xe2>
  return ret;
    8000514a:	854a                	mv	a0,s2
    8000514c:	a011                	j	80005150 <sys_exec+0xfa>
  return -1;
    8000514e:	557d                	li	a0,-1
}
    80005150:	60be                	ld	ra,456(sp)
    80005152:	641e                	ld	s0,448(sp)
    80005154:	74fa                	ld	s1,440(sp)
    80005156:	795a                	ld	s2,432(sp)
    80005158:	79ba                	ld	s3,424(sp)
    8000515a:	7a1a                	ld	s4,416(sp)
    8000515c:	6afa                	ld	s5,408(sp)
    8000515e:	6179                	addi	sp,sp,464
    80005160:	8082                	ret

0000000080005162 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005162:	7139                	addi	sp,sp,-64
    80005164:	fc06                	sd	ra,56(sp)
    80005166:	f822                	sd	s0,48(sp)
    80005168:	f426                	sd	s1,40(sp)
    8000516a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000516c:	ffffc097          	auipc	ra,0xffffc
    80005170:	e4c080e7          	jalr	-436(ra) # 80000fb8 <myproc>
    80005174:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005176:	fd840593          	addi	a1,s0,-40
    8000517a:	4501                	li	a0,0
    8000517c:	ffffd097          	auipc	ra,0xffffd
    80005180:	f70080e7          	jalr	-144(ra) # 800020ec <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80005184:	fc840593          	addi	a1,s0,-56
    80005188:	fd040513          	addi	a0,s0,-48
    8000518c:	fffff097          	auipc	ra,0xfffff
    80005190:	dcc080e7          	jalr	-564(ra) # 80003f58 <pipealloc>
    return -1;
    80005194:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005196:	0c054463          	bltz	a0,8000525e <sys_pipe+0xfc>
  fd0 = -1;
    8000519a:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000519e:	fd043503          	ld	a0,-48(s0)
    800051a2:	fffff097          	auipc	ra,0xfffff
    800051a6:	518080e7          	jalr	1304(ra) # 800046ba <fdalloc>
    800051aa:	fca42223          	sw	a0,-60(s0)
    800051ae:	08054b63          	bltz	a0,80005244 <sys_pipe+0xe2>
    800051b2:	fc843503          	ld	a0,-56(s0)
    800051b6:	fffff097          	auipc	ra,0xfffff
    800051ba:	504080e7          	jalr	1284(ra) # 800046ba <fdalloc>
    800051be:	fca42023          	sw	a0,-64(s0)
    800051c2:	06054863          	bltz	a0,80005232 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051c6:	4691                	li	a3,4
    800051c8:	fc440613          	addi	a2,s0,-60
    800051cc:	fd843583          	ld	a1,-40(s0)
    800051d0:	6ca8                	ld	a0,88(s1)
    800051d2:	ffffc097          	auipc	ra,0xffffc
    800051d6:	a70080e7          	jalr	-1424(ra) # 80000c42 <copyout>
    800051da:	02054063          	bltz	a0,800051fa <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800051de:	4691                	li	a3,4
    800051e0:	fc040613          	addi	a2,s0,-64
    800051e4:	fd843583          	ld	a1,-40(s0)
    800051e8:	0591                	addi	a1,a1,4
    800051ea:	6ca8                	ld	a0,88(s1)
    800051ec:	ffffc097          	auipc	ra,0xffffc
    800051f0:	a56080e7          	jalr	-1450(ra) # 80000c42 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800051f4:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051f6:	06055463          	bgez	a0,8000525e <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    800051fa:	fc442783          	lw	a5,-60(s0)
    800051fe:	07e9                	addi	a5,a5,26
    80005200:	078e                	slli	a5,a5,0x3
    80005202:	97a6                	add	a5,a5,s1
    80005204:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80005208:	fc042503          	lw	a0,-64(s0)
    8000520c:	0569                	addi	a0,a0,26
    8000520e:	050e                	slli	a0,a0,0x3
    80005210:	94aa                	add	s1,s1,a0
    80005212:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80005216:	fd043503          	ld	a0,-48(s0)
    8000521a:	fffff097          	auipc	ra,0xfffff
    8000521e:	a0e080e7          	jalr	-1522(ra) # 80003c28 <fileclose>
    fileclose(wf);
    80005222:	fc843503          	ld	a0,-56(s0)
    80005226:	fffff097          	auipc	ra,0xfffff
    8000522a:	a02080e7          	jalr	-1534(ra) # 80003c28 <fileclose>
    return -1;
    8000522e:	57fd                	li	a5,-1
    80005230:	a03d                	j	8000525e <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005232:	fc442783          	lw	a5,-60(s0)
    80005236:	0007c763          	bltz	a5,80005244 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    8000523a:	07e9                	addi	a5,a5,26
    8000523c:	078e                	slli	a5,a5,0x3
    8000523e:	94be                	add	s1,s1,a5
    80005240:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80005244:	fd043503          	ld	a0,-48(s0)
    80005248:	fffff097          	auipc	ra,0xfffff
    8000524c:	9e0080e7          	jalr	-1568(ra) # 80003c28 <fileclose>
    fileclose(wf);
    80005250:	fc843503          	ld	a0,-56(s0)
    80005254:	fffff097          	auipc	ra,0xfffff
    80005258:	9d4080e7          	jalr	-1580(ra) # 80003c28 <fileclose>
    return -1;
    8000525c:	57fd                	li	a5,-1
}
    8000525e:	853e                	mv	a0,a5
    80005260:	70e2                	ld	ra,56(sp)
    80005262:	7442                	ld	s0,48(sp)
    80005264:	74a2                	ld	s1,40(sp)
    80005266:	6121                	addi	sp,sp,64
    80005268:	8082                	ret
    8000526a:	0000                	unimp
    8000526c:	0000                	unimp
	...

0000000080005270 <kernelvec>:
    80005270:	7111                	addi	sp,sp,-256
    80005272:	e006                	sd	ra,0(sp)
    80005274:	e40a                	sd	sp,8(sp)
    80005276:	e80e                	sd	gp,16(sp)
    80005278:	ec12                	sd	tp,24(sp)
    8000527a:	f016                	sd	t0,32(sp)
    8000527c:	f41a                	sd	t1,40(sp)
    8000527e:	f81e                	sd	t2,48(sp)
    80005280:	fc22                	sd	s0,56(sp)
    80005282:	e0a6                	sd	s1,64(sp)
    80005284:	e4aa                	sd	a0,72(sp)
    80005286:	e8ae                	sd	a1,80(sp)
    80005288:	ecb2                	sd	a2,88(sp)
    8000528a:	f0b6                	sd	a3,96(sp)
    8000528c:	f4ba                	sd	a4,104(sp)
    8000528e:	f8be                	sd	a5,112(sp)
    80005290:	fcc2                	sd	a6,120(sp)
    80005292:	e146                	sd	a7,128(sp)
    80005294:	e54a                	sd	s2,136(sp)
    80005296:	e94e                	sd	s3,144(sp)
    80005298:	ed52                	sd	s4,152(sp)
    8000529a:	f156                	sd	s5,160(sp)
    8000529c:	f55a                	sd	s6,168(sp)
    8000529e:	f95e                	sd	s7,176(sp)
    800052a0:	fd62                	sd	s8,184(sp)
    800052a2:	e1e6                	sd	s9,192(sp)
    800052a4:	e5ea                	sd	s10,200(sp)
    800052a6:	e9ee                	sd	s11,208(sp)
    800052a8:	edf2                	sd	t3,216(sp)
    800052aa:	f1f6                	sd	t4,224(sp)
    800052ac:	f5fa                	sd	t5,232(sp)
    800052ae:	f9fe                	sd	t6,240(sp)
    800052b0:	c4bfc0ef          	jal	ra,80001efa <kerneltrap>
    800052b4:	6082                	ld	ra,0(sp)
    800052b6:	6122                	ld	sp,8(sp)
    800052b8:	61c2                	ld	gp,16(sp)
    800052ba:	7282                	ld	t0,32(sp)
    800052bc:	7322                	ld	t1,40(sp)
    800052be:	73c2                	ld	t2,48(sp)
    800052c0:	7462                	ld	s0,56(sp)
    800052c2:	6486                	ld	s1,64(sp)
    800052c4:	6526                	ld	a0,72(sp)
    800052c6:	65c6                	ld	a1,80(sp)
    800052c8:	6666                	ld	a2,88(sp)
    800052ca:	7686                	ld	a3,96(sp)
    800052cc:	7726                	ld	a4,104(sp)
    800052ce:	77c6                	ld	a5,112(sp)
    800052d0:	7866                	ld	a6,120(sp)
    800052d2:	688a                	ld	a7,128(sp)
    800052d4:	692a                	ld	s2,136(sp)
    800052d6:	69ca                	ld	s3,144(sp)
    800052d8:	6a6a                	ld	s4,152(sp)
    800052da:	7a8a                	ld	s5,160(sp)
    800052dc:	7b2a                	ld	s6,168(sp)
    800052de:	7bca                	ld	s7,176(sp)
    800052e0:	7c6a                	ld	s8,184(sp)
    800052e2:	6c8e                	ld	s9,192(sp)
    800052e4:	6d2e                	ld	s10,200(sp)
    800052e6:	6dce                	ld	s11,208(sp)
    800052e8:	6e6e                	ld	t3,216(sp)
    800052ea:	7e8e                	ld	t4,224(sp)
    800052ec:	7f2e                	ld	t5,232(sp)
    800052ee:	7fce                	ld	t6,240(sp)
    800052f0:	6111                	addi	sp,sp,256
    800052f2:	10200073          	sret
    800052f6:	00000013          	nop
    800052fa:	00000013          	nop
    800052fe:	0001                	nop

0000000080005300 <timervec>:
    80005300:	34051573          	csrrw	a0,mscratch,a0
    80005304:	e10c                	sd	a1,0(a0)
    80005306:	e510                	sd	a2,8(a0)
    80005308:	e914                	sd	a3,16(a0)
    8000530a:	6d0c                	ld	a1,24(a0)
    8000530c:	7110                	ld	a2,32(a0)
    8000530e:	6194                	ld	a3,0(a1)
    80005310:	96b2                	add	a3,a3,a2
    80005312:	e194                	sd	a3,0(a1)
    80005314:	4589                	li	a1,2
    80005316:	14459073          	csrw	sip,a1
    8000531a:	6914                	ld	a3,16(a0)
    8000531c:	6510                	ld	a2,8(a0)
    8000531e:	610c                	ld	a1,0(a0)
    80005320:	34051573          	csrrw	a0,mscratch,a0
    80005324:	30200073          	mret
	...

000000008000532a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000532a:	1141                	addi	sp,sp,-16
    8000532c:	e422                	sd	s0,8(sp)
    8000532e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005330:	0c0007b7          	lui	a5,0xc000
    80005334:	4705                	li	a4,1
    80005336:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005338:	c3d8                	sw	a4,4(a5)
}
    8000533a:	6422                	ld	s0,8(sp)
    8000533c:	0141                	addi	sp,sp,16
    8000533e:	8082                	ret

0000000080005340 <plicinithart>:

void
plicinithart(void)
{
    80005340:	1141                	addi	sp,sp,-16
    80005342:	e406                	sd	ra,8(sp)
    80005344:	e022                	sd	s0,0(sp)
    80005346:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005348:	ffffc097          	auipc	ra,0xffffc
    8000534c:	c44080e7          	jalr	-956(ra) # 80000f8c <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005350:	0085171b          	slliw	a4,a0,0x8
    80005354:	0c0027b7          	lui	a5,0xc002
    80005358:	97ba                	add	a5,a5,a4
    8000535a:	40200713          	li	a4,1026
    8000535e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005362:	00d5151b          	slliw	a0,a0,0xd
    80005366:	0c2017b7          	lui	a5,0xc201
    8000536a:	953e                	add	a0,a0,a5
    8000536c:	00052023          	sw	zero,0(a0)
}
    80005370:	60a2                	ld	ra,8(sp)
    80005372:	6402                	ld	s0,0(sp)
    80005374:	0141                	addi	sp,sp,16
    80005376:	8082                	ret

0000000080005378 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005378:	1141                	addi	sp,sp,-16
    8000537a:	e406                	sd	ra,8(sp)
    8000537c:	e022                	sd	s0,0(sp)
    8000537e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005380:	ffffc097          	auipc	ra,0xffffc
    80005384:	c0c080e7          	jalr	-1012(ra) # 80000f8c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005388:	00d5179b          	slliw	a5,a0,0xd
    8000538c:	0c201537          	lui	a0,0xc201
    80005390:	953e                	add	a0,a0,a5
  return irq;
}
    80005392:	4148                	lw	a0,4(a0)
    80005394:	60a2                	ld	ra,8(sp)
    80005396:	6402                	ld	s0,0(sp)
    80005398:	0141                	addi	sp,sp,16
    8000539a:	8082                	ret

000000008000539c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000539c:	1101                	addi	sp,sp,-32
    8000539e:	ec06                	sd	ra,24(sp)
    800053a0:	e822                	sd	s0,16(sp)
    800053a2:	e426                	sd	s1,8(sp)
    800053a4:	1000                	addi	s0,sp,32
    800053a6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800053a8:	ffffc097          	auipc	ra,0xffffc
    800053ac:	be4080e7          	jalr	-1052(ra) # 80000f8c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800053b0:	00d5151b          	slliw	a0,a0,0xd
    800053b4:	0c2017b7          	lui	a5,0xc201
    800053b8:	97aa                	add	a5,a5,a0
    800053ba:	c3c4                	sw	s1,4(a5)
}
    800053bc:	60e2                	ld	ra,24(sp)
    800053be:	6442                	ld	s0,16(sp)
    800053c0:	64a2                	ld	s1,8(sp)
    800053c2:	6105                	addi	sp,sp,32
    800053c4:	8082                	ret

00000000800053c6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800053c6:	1141                	addi	sp,sp,-16
    800053c8:	e406                	sd	ra,8(sp)
    800053ca:	e022                	sd	s0,0(sp)
    800053cc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800053ce:	479d                	li	a5,7
    800053d0:	04a7cc63          	blt	a5,a0,80005428 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    800053d4:	00018797          	auipc	a5,0x18
    800053d8:	2cc78793          	addi	a5,a5,716 # 8001d6a0 <disk>
    800053dc:	97aa                	add	a5,a5,a0
    800053de:	0187c783          	lbu	a5,24(a5)
    800053e2:	ebb9                	bnez	a5,80005438 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800053e4:	00451613          	slli	a2,a0,0x4
    800053e8:	00018797          	auipc	a5,0x18
    800053ec:	2b878793          	addi	a5,a5,696 # 8001d6a0 <disk>
    800053f0:	6394                	ld	a3,0(a5)
    800053f2:	96b2                	add	a3,a3,a2
    800053f4:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800053f8:	6398                	ld	a4,0(a5)
    800053fa:	9732                	add	a4,a4,a2
    800053fc:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005400:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005404:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005408:	953e                	add	a0,a0,a5
    8000540a:	4785                	li	a5,1
    8000540c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005410:	00018517          	auipc	a0,0x18
    80005414:	2a850513          	addi	a0,a0,680 # 8001d6b8 <disk+0x18>
    80005418:	ffffc097          	auipc	ra,0xffffc
    8000541c:	2ac080e7          	jalr	684(ra) # 800016c4 <wakeup>
}
    80005420:	60a2                	ld	ra,8(sp)
    80005422:	6402                	ld	s0,0(sp)
    80005424:	0141                	addi	sp,sp,16
    80005426:	8082                	ret
    panic("free_desc 1");
    80005428:	00003517          	auipc	a0,0x3
    8000542c:	2d850513          	addi	a0,a0,728 # 80008700 <syscalls+0x2f0>
    80005430:	00001097          	auipc	ra,0x1
    80005434:	da6080e7          	jalr	-602(ra) # 800061d6 <panic>
    panic("free_desc 2");
    80005438:	00003517          	auipc	a0,0x3
    8000543c:	2d850513          	addi	a0,a0,728 # 80008710 <syscalls+0x300>
    80005440:	00001097          	auipc	ra,0x1
    80005444:	d96080e7          	jalr	-618(ra) # 800061d6 <panic>

0000000080005448 <virtio_disk_init>:
{
    80005448:	1101                	addi	sp,sp,-32
    8000544a:	ec06                	sd	ra,24(sp)
    8000544c:	e822                	sd	s0,16(sp)
    8000544e:	e426                	sd	s1,8(sp)
    80005450:	e04a                	sd	s2,0(sp)
    80005452:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005454:	00003597          	auipc	a1,0x3
    80005458:	2cc58593          	addi	a1,a1,716 # 80008720 <syscalls+0x310>
    8000545c:	00018517          	auipc	a0,0x18
    80005460:	36c50513          	addi	a0,a0,876 # 8001d7c8 <disk+0x128>
    80005464:	00001097          	auipc	ra,0x1
    80005468:	422080e7          	jalr	1058(ra) # 80006886 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000546c:	100017b7          	lui	a5,0x10001
    80005470:	4398                	lw	a4,0(a5)
    80005472:	2701                	sext.w	a4,a4
    80005474:	747277b7          	lui	a5,0x74727
    80005478:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000547c:	14f71e63          	bne	a4,a5,800055d8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005480:	100017b7          	lui	a5,0x10001
    80005484:	43dc                	lw	a5,4(a5)
    80005486:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005488:	4709                	li	a4,2
    8000548a:	14e79763          	bne	a5,a4,800055d8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000548e:	100017b7          	lui	a5,0x10001
    80005492:	479c                	lw	a5,8(a5)
    80005494:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005496:	14e79163          	bne	a5,a4,800055d8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000549a:	100017b7          	lui	a5,0x10001
    8000549e:	47d8                	lw	a4,12(a5)
    800054a0:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800054a2:	554d47b7          	lui	a5,0x554d4
    800054a6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800054aa:	12f71763          	bne	a4,a5,800055d8 <virtio_disk_init+0x190>
  *R(VIRTIO_MMIO_STATUS) = status;
    800054ae:	100017b7          	lui	a5,0x10001
    800054b2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800054b6:	4705                	li	a4,1
    800054b8:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054ba:	470d                	li	a4,3
    800054bc:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800054be:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800054c0:	c7ffe737          	lui	a4,0xc7ffe
    800054c4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd6d37>
    800054c8:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800054ca:	2701                	sext.w	a4,a4
    800054cc:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054ce:	472d                	li	a4,11
    800054d0:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    800054d2:	0707a903          	lw	s2,112(a5)
    800054d6:	2901                	sext.w	s2,s2
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800054d8:	00897793          	andi	a5,s2,8
    800054dc:	10078663          	beqz	a5,800055e8 <virtio_disk_init+0x1a0>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800054e0:	100017b7          	lui	a5,0x10001
    800054e4:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800054e8:	43fc                	lw	a5,68(a5)
    800054ea:	2781                	sext.w	a5,a5
    800054ec:	10079663          	bnez	a5,800055f8 <virtio_disk_init+0x1b0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800054f0:	100017b7          	lui	a5,0x10001
    800054f4:	5bdc                	lw	a5,52(a5)
    800054f6:	2781                	sext.w	a5,a5
  if(max == 0)
    800054f8:	10078863          	beqz	a5,80005608 <virtio_disk_init+0x1c0>
  if(max < NUM)
    800054fc:	471d                	li	a4,7
    800054fe:	10f77d63          	bgeu	a4,a5,80005618 <virtio_disk_init+0x1d0>
  disk.desc = kalloc();
    80005502:	ffffb097          	auipc	ra,0xffffb
    80005506:	c66080e7          	jalr	-922(ra) # 80000168 <kalloc>
    8000550a:	00018497          	auipc	s1,0x18
    8000550e:	19648493          	addi	s1,s1,406 # 8001d6a0 <disk>
    80005512:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005514:	ffffb097          	auipc	ra,0xffffb
    80005518:	c54080e7          	jalr	-940(ra) # 80000168 <kalloc>
    8000551c:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000551e:	ffffb097          	auipc	ra,0xffffb
    80005522:	c4a080e7          	jalr	-950(ra) # 80000168 <kalloc>
    80005526:	87aa                	mv	a5,a0
    80005528:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    8000552a:	6088                	ld	a0,0(s1)
    8000552c:	cd75                	beqz	a0,80005628 <virtio_disk_init+0x1e0>
    8000552e:	00018717          	auipc	a4,0x18
    80005532:	17a73703          	ld	a4,378(a4) # 8001d6a8 <disk+0x8>
    80005536:	cb6d                	beqz	a4,80005628 <virtio_disk_init+0x1e0>
    80005538:	cbe5                	beqz	a5,80005628 <virtio_disk_init+0x1e0>
  memset(disk.desc, 0, PGSIZE);
    8000553a:	6605                	lui	a2,0x1
    8000553c:	4581                	li	a1,0
    8000553e:	ffffb097          	auipc	ra,0xffffb
    80005542:	d32080e7          	jalr	-718(ra) # 80000270 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005546:	00018497          	auipc	s1,0x18
    8000554a:	15a48493          	addi	s1,s1,346 # 8001d6a0 <disk>
    8000554e:	6605                	lui	a2,0x1
    80005550:	4581                	li	a1,0
    80005552:	6488                	ld	a0,8(s1)
    80005554:	ffffb097          	auipc	ra,0xffffb
    80005558:	d1c080e7          	jalr	-740(ra) # 80000270 <memset>
  memset(disk.used, 0, PGSIZE);
    8000555c:	6605                	lui	a2,0x1
    8000555e:	4581                	li	a1,0
    80005560:	6888                	ld	a0,16(s1)
    80005562:	ffffb097          	auipc	ra,0xffffb
    80005566:	d0e080e7          	jalr	-754(ra) # 80000270 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000556a:	100017b7          	lui	a5,0x10001
    8000556e:	4721                	li	a4,8
    80005570:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80005572:	4098                	lw	a4,0(s1)
    80005574:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005578:	40d8                	lw	a4,4(s1)
    8000557a:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000557e:	6498                	ld	a4,8(s1)
    80005580:	0007069b          	sext.w	a3,a4
    80005584:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005588:	9701                	srai	a4,a4,0x20
    8000558a:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000558e:	6898                	ld	a4,16(s1)
    80005590:	0007069b          	sext.w	a3,a4
    80005594:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005598:	9701                	srai	a4,a4,0x20
    8000559a:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000559e:	4685                	li	a3,1
    800055a0:	c3f4                	sw	a3,68(a5)
    disk.free[i] = 1;
    800055a2:	4705                	li	a4,1
    800055a4:	00d48c23          	sb	a3,24(s1)
    800055a8:	00e48ca3          	sb	a4,25(s1)
    800055ac:	00e48d23          	sb	a4,26(s1)
    800055b0:	00e48da3          	sb	a4,27(s1)
    800055b4:	00e48e23          	sb	a4,28(s1)
    800055b8:	00e48ea3          	sb	a4,29(s1)
    800055bc:	00e48f23          	sb	a4,30(s1)
    800055c0:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800055c4:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800055c8:	0727a823          	sw	s2,112(a5)
}
    800055cc:	60e2                	ld	ra,24(sp)
    800055ce:	6442                	ld	s0,16(sp)
    800055d0:	64a2                	ld	s1,8(sp)
    800055d2:	6902                	ld	s2,0(sp)
    800055d4:	6105                	addi	sp,sp,32
    800055d6:	8082                	ret
    panic("could not find virtio disk");
    800055d8:	00003517          	auipc	a0,0x3
    800055dc:	15850513          	addi	a0,a0,344 # 80008730 <syscalls+0x320>
    800055e0:	00001097          	auipc	ra,0x1
    800055e4:	bf6080e7          	jalr	-1034(ra) # 800061d6 <panic>
    panic("virtio disk FEATURES_OK unset");
    800055e8:	00003517          	auipc	a0,0x3
    800055ec:	16850513          	addi	a0,a0,360 # 80008750 <syscalls+0x340>
    800055f0:	00001097          	auipc	ra,0x1
    800055f4:	be6080e7          	jalr	-1050(ra) # 800061d6 <panic>
    panic("virtio disk should not be ready");
    800055f8:	00003517          	auipc	a0,0x3
    800055fc:	17850513          	addi	a0,a0,376 # 80008770 <syscalls+0x360>
    80005600:	00001097          	auipc	ra,0x1
    80005604:	bd6080e7          	jalr	-1066(ra) # 800061d6 <panic>
    panic("virtio disk has no queue 0");
    80005608:	00003517          	auipc	a0,0x3
    8000560c:	18850513          	addi	a0,a0,392 # 80008790 <syscalls+0x380>
    80005610:	00001097          	auipc	ra,0x1
    80005614:	bc6080e7          	jalr	-1082(ra) # 800061d6 <panic>
    panic("virtio disk max queue too short");
    80005618:	00003517          	auipc	a0,0x3
    8000561c:	19850513          	addi	a0,a0,408 # 800087b0 <syscalls+0x3a0>
    80005620:	00001097          	auipc	ra,0x1
    80005624:	bb6080e7          	jalr	-1098(ra) # 800061d6 <panic>
    panic("virtio disk kalloc");
    80005628:	00003517          	auipc	a0,0x3
    8000562c:	1a850513          	addi	a0,a0,424 # 800087d0 <syscalls+0x3c0>
    80005630:	00001097          	auipc	ra,0x1
    80005634:	ba6080e7          	jalr	-1114(ra) # 800061d6 <panic>

0000000080005638 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005638:	7159                	addi	sp,sp,-112
    8000563a:	f486                	sd	ra,104(sp)
    8000563c:	f0a2                	sd	s0,96(sp)
    8000563e:	eca6                	sd	s1,88(sp)
    80005640:	e8ca                	sd	s2,80(sp)
    80005642:	e4ce                	sd	s3,72(sp)
    80005644:	e0d2                	sd	s4,64(sp)
    80005646:	fc56                	sd	s5,56(sp)
    80005648:	f85a                	sd	s6,48(sp)
    8000564a:	f45e                	sd	s7,40(sp)
    8000564c:	f062                	sd	s8,32(sp)
    8000564e:	ec66                	sd	s9,24(sp)
    80005650:	e86a                	sd	s10,16(sp)
    80005652:	1880                	addi	s0,sp,112
    80005654:	892a                	mv	s2,a0
    80005656:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005658:	00c52c83          	lw	s9,12(a0)
    8000565c:	001c9c9b          	slliw	s9,s9,0x1
    80005660:	1c82                	slli	s9,s9,0x20
    80005662:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005666:	00018517          	auipc	a0,0x18
    8000566a:	16250513          	addi	a0,a0,354 # 8001d7c8 <disk+0x128>
    8000566e:	00001097          	auipc	ra,0x1
    80005672:	09c080e7          	jalr	156(ra) # 8000670a <acquire>
  for(int i = 0; i < 3; i++){
    80005676:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005678:	4ba1                	li	s7,8
      disk.free[i] = 0;
    8000567a:	00018b17          	auipc	s6,0x18
    8000567e:	026b0b13          	addi	s6,s6,38 # 8001d6a0 <disk>
  for(int i = 0; i < 3; i++){
    80005682:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005684:	8a4e                	mv	s4,s3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005686:	00018c17          	auipc	s8,0x18
    8000568a:	142c0c13          	addi	s8,s8,322 # 8001d7c8 <disk+0x128>
    8000568e:	a8b5                	j	8000570a <virtio_disk_rw+0xd2>
      disk.free[i] = 0;
    80005690:	00fb06b3          	add	a3,s6,a5
    80005694:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005698:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    8000569a:	0207c563          	bltz	a5,800056c4 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    8000569e:	2485                	addiw	s1,s1,1
    800056a0:	0711                	addi	a4,a4,4
    800056a2:	1f548a63          	beq	s1,s5,80005896 <virtio_disk_rw+0x25e>
    idx[i] = alloc_desc();
    800056a6:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    800056a8:	00018697          	auipc	a3,0x18
    800056ac:	ff868693          	addi	a3,a3,-8 # 8001d6a0 <disk>
    800056b0:	87d2                	mv	a5,s4
    if(disk.free[i]){
    800056b2:	0186c583          	lbu	a1,24(a3)
    800056b6:	fde9                	bnez	a1,80005690 <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    800056b8:	2785                	addiw	a5,a5,1
    800056ba:	0685                	addi	a3,a3,1
    800056bc:	ff779be3          	bne	a5,s7,800056b2 <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    800056c0:	57fd                	li	a5,-1
    800056c2:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    800056c4:	02905a63          	blez	s1,800056f8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056c8:	f9042503          	lw	a0,-112(s0)
    800056cc:	00000097          	auipc	ra,0x0
    800056d0:	cfa080e7          	jalr	-774(ra) # 800053c6 <free_desc>
      for(int j = 0; j < i; j++)
    800056d4:	4785                	li	a5,1
    800056d6:	0297d163          	bge	a5,s1,800056f8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056da:	f9442503          	lw	a0,-108(s0)
    800056de:	00000097          	auipc	ra,0x0
    800056e2:	ce8080e7          	jalr	-792(ra) # 800053c6 <free_desc>
      for(int j = 0; j < i; j++)
    800056e6:	4789                	li	a5,2
    800056e8:	0097d863          	bge	a5,s1,800056f8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056ec:	f9842503          	lw	a0,-104(s0)
    800056f0:	00000097          	auipc	ra,0x0
    800056f4:	cd6080e7          	jalr	-810(ra) # 800053c6 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    800056f8:	85e2                	mv	a1,s8
    800056fa:	00018517          	auipc	a0,0x18
    800056fe:	fbe50513          	addi	a0,a0,-66 # 8001d6b8 <disk+0x18>
    80005702:	ffffc097          	auipc	ra,0xffffc
    80005706:	f5e080e7          	jalr	-162(ra) # 80001660 <sleep>
  for(int i = 0; i < 3; i++){
    8000570a:	f9040713          	addi	a4,s0,-112
    8000570e:	84ce                	mv	s1,s3
    80005710:	bf59                	j	800056a6 <virtio_disk_rw+0x6e>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005712:	00a60793          	addi	a5,a2,10 # 100a <_entry-0x7fffeff6>
    80005716:	00479693          	slli	a3,a5,0x4
    8000571a:	00018797          	auipc	a5,0x18
    8000571e:	f8678793          	addi	a5,a5,-122 # 8001d6a0 <disk>
    80005722:	97b6                	add	a5,a5,a3
    80005724:	4685                	li	a3,1
    80005726:	c794                	sw	a3,8(a5)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005728:	00018597          	auipc	a1,0x18
    8000572c:	f7858593          	addi	a1,a1,-136 # 8001d6a0 <disk>
    80005730:	00a60793          	addi	a5,a2,10
    80005734:	0792                	slli	a5,a5,0x4
    80005736:	97ae                	add	a5,a5,a1
    80005738:	0007a623          	sw	zero,12(a5)
  buf0->sector = sector;
    8000573c:	0197b823          	sd	s9,16(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005740:	f6070693          	addi	a3,a4,-160
    80005744:	619c                	ld	a5,0(a1)
    80005746:	97b6                	add	a5,a5,a3
    80005748:	e388                	sd	a0,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000574a:	6188                	ld	a0,0(a1)
    8000574c:	96aa                	add	a3,a3,a0
    8000574e:	47c1                	li	a5,16
    80005750:	c69c                	sw	a5,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005752:	4785                	li	a5,1
    80005754:	00f69623          	sh	a5,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80005758:	f9442783          	lw	a5,-108(s0)
    8000575c:	00f69723          	sh	a5,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005760:	0792                	slli	a5,a5,0x4
    80005762:	953e                	add	a0,a0,a5
    80005764:	06090693          	addi	a3,s2,96
    80005768:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    8000576a:	6188                	ld	a0,0(a1)
    8000576c:	97aa                	add	a5,a5,a0
    8000576e:	40000693          	li	a3,1024
    80005772:	c794                	sw	a3,8(a5)
  if(write)
    80005774:	100d0d63          	beqz	s10,8000588e <virtio_disk_rw+0x256>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005778:	00079623          	sh	zero,12(a5)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000577c:	00c7d683          	lhu	a3,12(a5)
    80005780:	0016e693          	ori	a3,a3,1
    80005784:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[1]].next = idx[2];
    80005788:	f9842583          	lw	a1,-104(s0)
    8000578c:	00b79723          	sh	a1,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005790:	00018697          	auipc	a3,0x18
    80005794:	f1068693          	addi	a3,a3,-240 # 8001d6a0 <disk>
    80005798:	00260793          	addi	a5,a2,2
    8000579c:	0792                	slli	a5,a5,0x4
    8000579e:	97b6                	add	a5,a5,a3
    800057a0:	587d                	li	a6,-1
    800057a2:	01078823          	sb	a6,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800057a6:	0592                	slli	a1,a1,0x4
    800057a8:	952e                	add	a0,a0,a1
    800057aa:	f9070713          	addi	a4,a4,-112
    800057ae:	9736                	add	a4,a4,a3
    800057b0:	e118                	sd	a4,0(a0)
  disk.desc[idx[2]].len = 1;
    800057b2:	6298                	ld	a4,0(a3)
    800057b4:	972e                	add	a4,a4,a1
    800057b6:	4585                	li	a1,1
    800057b8:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800057ba:	4509                	li	a0,2
    800057bc:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[2]].next = 0;
    800057c0:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800057c4:	00b92223          	sw	a1,4(s2)
  disk.info[idx[0]].b = b;
    800057c8:	0127b423          	sd	s2,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800057cc:	6698                	ld	a4,8(a3)
    800057ce:	00275783          	lhu	a5,2(a4)
    800057d2:	8b9d                	andi	a5,a5,7
    800057d4:	0786                	slli	a5,a5,0x1
    800057d6:	97ba                	add	a5,a5,a4
    800057d8:	00c79223          	sh	a2,4(a5)

  __sync_synchronize();
    800057dc:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800057e0:	6698                	ld	a4,8(a3)
    800057e2:	00275783          	lhu	a5,2(a4)
    800057e6:	2785                	addiw	a5,a5,1
    800057e8:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800057ec:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800057f0:	100017b7          	lui	a5,0x10001
    800057f4:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800057f8:	00492703          	lw	a4,4(s2)
    800057fc:	4785                	li	a5,1
    800057fe:	02f71163          	bne	a4,a5,80005820 <virtio_disk_rw+0x1e8>
    sleep(b, &disk.vdisk_lock);
    80005802:	00018997          	auipc	s3,0x18
    80005806:	fc698993          	addi	s3,s3,-58 # 8001d7c8 <disk+0x128>
  while(b->disk == 1) {
    8000580a:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000580c:	85ce                	mv	a1,s3
    8000580e:	854a                	mv	a0,s2
    80005810:	ffffc097          	auipc	ra,0xffffc
    80005814:	e50080e7          	jalr	-432(ra) # 80001660 <sleep>
  while(b->disk == 1) {
    80005818:	00492783          	lw	a5,4(s2)
    8000581c:	fe9788e3          	beq	a5,s1,8000580c <virtio_disk_rw+0x1d4>
  }

  disk.info[idx[0]].b = 0;
    80005820:	f9042903          	lw	s2,-112(s0)
    80005824:	00290793          	addi	a5,s2,2
    80005828:	00479713          	slli	a4,a5,0x4
    8000582c:	00018797          	auipc	a5,0x18
    80005830:	e7478793          	addi	a5,a5,-396 # 8001d6a0 <disk>
    80005834:	97ba                	add	a5,a5,a4
    80005836:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000583a:	00018997          	auipc	s3,0x18
    8000583e:	e6698993          	addi	s3,s3,-410 # 8001d6a0 <disk>
    80005842:	00491713          	slli	a4,s2,0x4
    80005846:	0009b783          	ld	a5,0(s3)
    8000584a:	97ba                	add	a5,a5,a4
    8000584c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005850:	854a                	mv	a0,s2
    80005852:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005856:	00000097          	auipc	ra,0x0
    8000585a:	b70080e7          	jalr	-1168(ra) # 800053c6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000585e:	8885                	andi	s1,s1,1
    80005860:	f0ed                	bnez	s1,80005842 <virtio_disk_rw+0x20a>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005862:	00018517          	auipc	a0,0x18
    80005866:	f6650513          	addi	a0,a0,-154 # 8001d7c8 <disk+0x128>
    8000586a:	00001097          	auipc	ra,0x1
    8000586e:	f70080e7          	jalr	-144(ra) # 800067da <release>
}
    80005872:	70a6                	ld	ra,104(sp)
    80005874:	7406                	ld	s0,96(sp)
    80005876:	64e6                	ld	s1,88(sp)
    80005878:	6946                	ld	s2,80(sp)
    8000587a:	69a6                	ld	s3,72(sp)
    8000587c:	6a06                	ld	s4,64(sp)
    8000587e:	7ae2                	ld	s5,56(sp)
    80005880:	7b42                	ld	s6,48(sp)
    80005882:	7ba2                	ld	s7,40(sp)
    80005884:	7c02                	ld	s8,32(sp)
    80005886:	6ce2                	ld	s9,24(sp)
    80005888:	6d42                	ld	s10,16(sp)
    8000588a:	6165                	addi	sp,sp,112
    8000588c:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000588e:	4689                	li	a3,2
    80005890:	00d79623          	sh	a3,12(a5)
    80005894:	b5e5                	j	8000577c <virtio_disk_rw+0x144>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005896:	f9042603          	lw	a2,-112(s0)
    8000589a:	00a60713          	addi	a4,a2,10
    8000589e:	0712                	slli	a4,a4,0x4
    800058a0:	00018517          	auipc	a0,0x18
    800058a4:	e0850513          	addi	a0,a0,-504 # 8001d6a8 <disk+0x8>
    800058a8:	953a                	add	a0,a0,a4
  if(write)
    800058aa:	e60d14e3          	bnez	s10,80005712 <virtio_disk_rw+0xda>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    800058ae:	00a60793          	addi	a5,a2,10
    800058b2:	00479693          	slli	a3,a5,0x4
    800058b6:	00018797          	auipc	a5,0x18
    800058ba:	dea78793          	addi	a5,a5,-534 # 8001d6a0 <disk>
    800058be:	97b6                	add	a5,a5,a3
    800058c0:	0007a423          	sw	zero,8(a5)
    800058c4:	b595                	j	80005728 <virtio_disk_rw+0xf0>

00000000800058c6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800058c6:	1101                	addi	sp,sp,-32
    800058c8:	ec06                	sd	ra,24(sp)
    800058ca:	e822                	sd	s0,16(sp)
    800058cc:	e426                	sd	s1,8(sp)
    800058ce:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800058d0:	00018497          	auipc	s1,0x18
    800058d4:	dd048493          	addi	s1,s1,-560 # 8001d6a0 <disk>
    800058d8:	00018517          	auipc	a0,0x18
    800058dc:	ef050513          	addi	a0,a0,-272 # 8001d7c8 <disk+0x128>
    800058e0:	00001097          	auipc	ra,0x1
    800058e4:	e2a080e7          	jalr	-470(ra) # 8000670a <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800058e8:	10001737          	lui	a4,0x10001
    800058ec:	533c                	lw	a5,96(a4)
    800058ee:	8b8d                	andi	a5,a5,3
    800058f0:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800058f2:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800058f6:	689c                	ld	a5,16(s1)
    800058f8:	0204d703          	lhu	a4,32(s1)
    800058fc:	0027d783          	lhu	a5,2(a5)
    80005900:	04f70863          	beq	a4,a5,80005950 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005904:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005908:	6898                	ld	a4,16(s1)
    8000590a:	0204d783          	lhu	a5,32(s1)
    8000590e:	8b9d                	andi	a5,a5,7
    80005910:	078e                	slli	a5,a5,0x3
    80005912:	97ba                	add	a5,a5,a4
    80005914:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005916:	00278713          	addi	a4,a5,2
    8000591a:	0712                	slli	a4,a4,0x4
    8000591c:	9726                	add	a4,a4,s1
    8000591e:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005922:	e721                	bnez	a4,8000596a <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005924:	0789                	addi	a5,a5,2
    80005926:	0792                	slli	a5,a5,0x4
    80005928:	97a6                	add	a5,a5,s1
    8000592a:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000592c:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005930:	ffffc097          	auipc	ra,0xffffc
    80005934:	d94080e7          	jalr	-620(ra) # 800016c4 <wakeup>

    disk.used_idx += 1;
    80005938:	0204d783          	lhu	a5,32(s1)
    8000593c:	2785                	addiw	a5,a5,1
    8000593e:	17c2                	slli	a5,a5,0x30
    80005940:	93c1                	srli	a5,a5,0x30
    80005942:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005946:	6898                	ld	a4,16(s1)
    80005948:	00275703          	lhu	a4,2(a4)
    8000594c:	faf71ce3          	bne	a4,a5,80005904 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005950:	00018517          	auipc	a0,0x18
    80005954:	e7850513          	addi	a0,a0,-392 # 8001d7c8 <disk+0x128>
    80005958:	00001097          	auipc	ra,0x1
    8000595c:	e82080e7          	jalr	-382(ra) # 800067da <release>
}
    80005960:	60e2                	ld	ra,24(sp)
    80005962:	6442                	ld	s0,16(sp)
    80005964:	64a2                	ld	s1,8(sp)
    80005966:	6105                	addi	sp,sp,32
    80005968:	8082                	ret
      panic("virtio_disk_intr status");
    8000596a:	00003517          	auipc	a0,0x3
    8000596e:	e7e50513          	addi	a0,a0,-386 # 800087e8 <syscalls+0x3d8>
    80005972:	00001097          	auipc	ra,0x1
    80005976:	864080e7          	jalr	-1948(ra) # 800061d6 <panic>

000000008000597a <statswrite>:
int statscopyin(char*, int);
int statslock(char*, int);
  
int
statswrite(int user_src, uint64 src, int n)
{
    8000597a:	1141                	addi	sp,sp,-16
    8000597c:	e422                	sd	s0,8(sp)
    8000597e:	0800                	addi	s0,sp,16
  return -1;
}
    80005980:	557d                	li	a0,-1
    80005982:	6422                	ld	s0,8(sp)
    80005984:	0141                	addi	sp,sp,16
    80005986:	8082                	ret

0000000080005988 <statsread>:

int
statsread(int user_dst, uint64 dst, int n)
{
    80005988:	7179                	addi	sp,sp,-48
    8000598a:	f406                	sd	ra,40(sp)
    8000598c:	f022                	sd	s0,32(sp)
    8000598e:	ec26                	sd	s1,24(sp)
    80005990:	e84a                	sd	s2,16(sp)
    80005992:	e44e                	sd	s3,8(sp)
    80005994:	e052                	sd	s4,0(sp)
    80005996:	1800                	addi	s0,sp,48
    80005998:	892a                	mv	s2,a0
    8000599a:	89ae                	mv	s3,a1
    8000599c:	84b2                	mv	s1,a2
  int m;

  acquire(&stats.lock);
    8000599e:	00018517          	auipc	a0,0x18
    800059a2:	e4a50513          	addi	a0,a0,-438 # 8001d7e8 <stats>
    800059a6:	00001097          	auipc	ra,0x1
    800059aa:	d64080e7          	jalr	-668(ra) # 8000670a <acquire>

  if(stats.sz == 0) {
    800059ae:	00019797          	auipc	a5,0x19
    800059b2:	e5a7a783          	lw	a5,-422(a5) # 8001e808 <stats+0x1020>
    800059b6:	cbb5                	beqz	a5,80005a2a <statsread+0xa2>
#endif
#ifdef LAB_LOCK
    stats.sz = statslock(stats.buf, BUFSZ);
#endif
  }
  m = stats.sz - stats.off;
    800059b8:	00019797          	auipc	a5,0x19
    800059bc:	e3078793          	addi	a5,a5,-464 # 8001e7e8 <stats+0x1000>
    800059c0:	53d8                	lw	a4,36(a5)
    800059c2:	539c                	lw	a5,32(a5)
    800059c4:	9f99                	subw	a5,a5,a4
    800059c6:	0007869b          	sext.w	a3,a5

  if (m > 0) {
    800059ca:	06d05e63          	blez	a3,80005a46 <statsread+0xbe>
    if(m > n)
    800059ce:	8a3e                	mv	s4,a5
    800059d0:	00d4d363          	bge	s1,a3,800059d6 <statsread+0x4e>
    800059d4:	8a26                	mv	s4,s1
    800059d6:	000a049b          	sext.w	s1,s4
      m  = n;
    if(either_copyout(user_dst, dst, stats.buf+stats.off, m) != -1) {
    800059da:	86a6                	mv	a3,s1
    800059dc:	00018617          	auipc	a2,0x18
    800059e0:	e2c60613          	addi	a2,a2,-468 # 8001d808 <stats+0x20>
    800059e4:	963a                	add	a2,a2,a4
    800059e6:	85ce                	mv	a1,s3
    800059e8:	854a                	mv	a0,s2
    800059ea:	ffffc097          	auipc	ra,0xffffc
    800059ee:	07e080e7          	jalr	126(ra) # 80001a68 <either_copyout>
    800059f2:	57fd                	li	a5,-1
    800059f4:	00f50a63          	beq	a0,a5,80005a08 <statsread+0x80>
      stats.off += m;
    800059f8:	00019717          	auipc	a4,0x19
    800059fc:	df070713          	addi	a4,a4,-528 # 8001e7e8 <stats+0x1000>
    80005a00:	535c                	lw	a5,36(a4)
    80005a02:	014787bb          	addw	a5,a5,s4
    80005a06:	d35c                	sw	a5,36(a4)
  } else {
    m = -1;
    stats.sz = 0;
    stats.off = 0;
  }
  release(&stats.lock);
    80005a08:	00018517          	auipc	a0,0x18
    80005a0c:	de050513          	addi	a0,a0,-544 # 8001d7e8 <stats>
    80005a10:	00001097          	auipc	ra,0x1
    80005a14:	dca080e7          	jalr	-566(ra) # 800067da <release>
  return m;
}
    80005a18:	8526                	mv	a0,s1
    80005a1a:	70a2                	ld	ra,40(sp)
    80005a1c:	7402                	ld	s0,32(sp)
    80005a1e:	64e2                	ld	s1,24(sp)
    80005a20:	6942                	ld	s2,16(sp)
    80005a22:	69a2                	ld	s3,8(sp)
    80005a24:	6a02                	ld	s4,0(sp)
    80005a26:	6145                	addi	sp,sp,48
    80005a28:	8082                	ret
    stats.sz = statslock(stats.buf, BUFSZ);
    80005a2a:	6585                	lui	a1,0x1
    80005a2c:	00018517          	auipc	a0,0x18
    80005a30:	ddc50513          	addi	a0,a0,-548 # 8001d808 <stats+0x20>
    80005a34:	00001097          	auipc	ra,0x1
    80005a38:	f18080e7          	jalr	-232(ra) # 8000694c <statslock>
    80005a3c:	00019797          	auipc	a5,0x19
    80005a40:	dca7a623          	sw	a0,-564(a5) # 8001e808 <stats+0x1020>
    80005a44:	bf95                	j	800059b8 <statsread+0x30>
    stats.sz = 0;
    80005a46:	00019797          	auipc	a5,0x19
    80005a4a:	da278793          	addi	a5,a5,-606 # 8001e7e8 <stats+0x1000>
    80005a4e:	0207a023          	sw	zero,32(a5)
    stats.off = 0;
    80005a52:	0207a223          	sw	zero,36(a5)
    m = -1;
    80005a56:	54fd                	li	s1,-1
    80005a58:	bf45                	j	80005a08 <statsread+0x80>

0000000080005a5a <statsinit>:

void
statsinit(void)
{
    80005a5a:	1141                	addi	sp,sp,-16
    80005a5c:	e406                	sd	ra,8(sp)
    80005a5e:	e022                	sd	s0,0(sp)
    80005a60:	0800                	addi	s0,sp,16
  initlock(&stats.lock, "stats");
    80005a62:	00003597          	auipc	a1,0x3
    80005a66:	d9e58593          	addi	a1,a1,-610 # 80008800 <syscalls+0x3f0>
    80005a6a:	00018517          	auipc	a0,0x18
    80005a6e:	d7e50513          	addi	a0,a0,-642 # 8001d7e8 <stats>
    80005a72:	00001097          	auipc	ra,0x1
    80005a76:	e14080e7          	jalr	-492(ra) # 80006886 <initlock>

  devsw[STATS].read = statsread;
    80005a7a:	00017797          	auipc	a5,0x17
    80005a7e:	bc678793          	addi	a5,a5,-1082 # 8001c640 <devsw>
    80005a82:	00000717          	auipc	a4,0x0
    80005a86:	f0670713          	addi	a4,a4,-250 # 80005988 <statsread>
    80005a8a:	f398                	sd	a4,32(a5)
  devsw[STATS].write = statswrite;
    80005a8c:	00000717          	auipc	a4,0x0
    80005a90:	eee70713          	addi	a4,a4,-274 # 8000597a <statswrite>
    80005a94:	f798                	sd	a4,40(a5)
}
    80005a96:	60a2                	ld	ra,8(sp)
    80005a98:	6402                	ld	s0,0(sp)
    80005a9a:	0141                	addi	sp,sp,16
    80005a9c:	8082                	ret

0000000080005a9e <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    80005a9e:	1101                	addi	sp,sp,-32
    80005aa0:	ec22                	sd	s0,24(sp)
    80005aa2:	1000                	addi	s0,sp,32
    80005aa4:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    80005aa6:	c299                	beqz	a3,80005aac <sprintint+0xe>
    80005aa8:	0805c163          	bltz	a1,80005b2a <sprintint+0x8c>
    x = -xx;
  else
    x = xx;
    80005aac:	2581                	sext.w	a1,a1
    80005aae:	4301                	li	t1,0

  i = 0;
    80005ab0:	fe040713          	addi	a4,s0,-32
    80005ab4:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    80005ab6:	2601                	sext.w	a2,a2
    80005ab8:	00003697          	auipc	a3,0x3
    80005abc:	d6868693          	addi	a3,a3,-664 # 80008820 <digits>
    80005ac0:	88aa                	mv	a7,a0
    80005ac2:	2505                	addiw	a0,a0,1
    80005ac4:	02c5f7bb          	remuw	a5,a1,a2
    80005ac8:	1782                	slli	a5,a5,0x20
    80005aca:	9381                	srli	a5,a5,0x20
    80005acc:	97b6                	add	a5,a5,a3
    80005ace:	0007c783          	lbu	a5,0(a5)
    80005ad2:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    80005ad6:	0005879b          	sext.w	a5,a1
    80005ada:	02c5d5bb          	divuw	a1,a1,a2
    80005ade:	0705                	addi	a4,a4,1
    80005ae0:	fec7f0e3          	bgeu	a5,a2,80005ac0 <sprintint+0x22>

  if(sign)
    80005ae4:	00030b63          	beqz	t1,80005afa <sprintint+0x5c>
    buf[i++] = '-';
    80005ae8:	ff040793          	addi	a5,s0,-16
    80005aec:	97aa                	add	a5,a5,a0
    80005aee:	02d00713          	li	a4,45
    80005af2:	fee78823          	sb	a4,-16(a5)
    80005af6:	0028851b          	addiw	a0,a7,2

  n = 0;
  while(--i >= 0)
    80005afa:	02a05c63          	blez	a0,80005b32 <sprintint+0x94>
    80005afe:	fe040793          	addi	a5,s0,-32
    80005b02:	00a78733          	add	a4,a5,a0
    80005b06:	87c2                	mv	a5,a6
    80005b08:	0805                	addi	a6,a6,1
    80005b0a:	fff5061b          	addiw	a2,a0,-1
    80005b0e:	1602                	slli	a2,a2,0x20
    80005b10:	9201                	srli	a2,a2,0x20
    80005b12:	9642                	add	a2,a2,a6
  *s = c;
    80005b14:	fff74683          	lbu	a3,-1(a4)
    80005b18:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    80005b1c:	177d                	addi	a4,a4,-1
    80005b1e:	0785                	addi	a5,a5,1
    80005b20:	fec79ae3          	bne	a5,a2,80005b14 <sprintint+0x76>
    n += sputc(s+n, buf[i]);
  return n;
}
    80005b24:	6462                	ld	s0,24(sp)
    80005b26:	6105                	addi	sp,sp,32
    80005b28:	8082                	ret
    x = -xx;
    80005b2a:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    80005b2e:	4305                	li	t1,1
    x = -xx;
    80005b30:	b741                	j	80005ab0 <sprintint+0x12>
  while(--i >= 0)
    80005b32:	4501                	li	a0,0
    80005b34:	bfc5                	j	80005b24 <sprintint+0x86>

0000000080005b36 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    80005b36:	7171                	addi	sp,sp,-176
    80005b38:	fc86                	sd	ra,120(sp)
    80005b3a:	f8a2                	sd	s0,112(sp)
    80005b3c:	f4a6                	sd	s1,104(sp)
    80005b3e:	f0ca                	sd	s2,96(sp)
    80005b40:	ecce                	sd	s3,88(sp)
    80005b42:	e8d2                	sd	s4,80(sp)
    80005b44:	e4d6                	sd	s5,72(sp)
    80005b46:	e0da                	sd	s6,64(sp)
    80005b48:	fc5e                	sd	s7,56(sp)
    80005b4a:	f862                	sd	s8,48(sp)
    80005b4c:	f466                	sd	s9,40(sp)
    80005b4e:	f06a                	sd	s10,32(sp)
    80005b50:	ec6e                	sd	s11,24(sp)
    80005b52:	0100                	addi	s0,sp,128
    80005b54:	e414                	sd	a3,8(s0)
    80005b56:	e818                	sd	a4,16(s0)
    80005b58:	ec1c                	sd	a5,24(s0)
    80005b5a:	03043023          	sd	a6,32(s0)
    80005b5e:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    80005b62:	ca0d                	beqz	a2,80005b94 <snprintf+0x5e>
    80005b64:	8baa                	mv	s7,a0
    80005b66:	89ae                	mv	s3,a1
    80005b68:	8a32                	mv	s4,a2
    panic("null fmt");

  va_start(ap, fmt);
    80005b6a:	00840793          	addi	a5,s0,8
    80005b6e:	f8f43423          	sd	a5,-120(s0)
  int off = 0;
    80005b72:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80005b74:	4901                	li	s2,0
    80005b76:	02b05763          	blez	a1,80005ba4 <snprintf+0x6e>
    if(c != '%'){
    80005b7a:	02500a93          	li	s5,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    80005b7e:	07300b13          	li	s6,115
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
      break;
    case 's':
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s && off < sz; s++)
    80005b82:	02800d93          	li	s11,40
  *s = c;
    80005b86:	02500d13          	li	s10,37
    switch(c){
    80005b8a:	07800c93          	li	s9,120
    80005b8e:	06400c13          	li	s8,100
    80005b92:	a01d                	j	80005bb8 <snprintf+0x82>
    panic("null fmt");
    80005b94:	00003517          	auipc	a0,0x3
    80005b98:	c7c50513          	addi	a0,a0,-900 # 80008810 <syscalls+0x400>
    80005b9c:	00000097          	auipc	ra,0x0
    80005ba0:	63a080e7          	jalr	1594(ra) # 800061d6 <panic>
  int off = 0;
    80005ba4:	4481                	li	s1,0
    80005ba6:	a86d                	j	80005c60 <snprintf+0x12a>
  *s = c;
    80005ba8:	009b8733          	add	a4,s7,s1
    80005bac:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80005bb0:	2485                	addiw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80005bb2:	2905                	addiw	s2,s2,1
    80005bb4:	0b34d663          	bge	s1,s3,80005c60 <snprintf+0x12a>
    80005bb8:	012a07b3          	add	a5,s4,s2
    80005bbc:	0007c783          	lbu	a5,0(a5)
    80005bc0:	0007871b          	sext.w	a4,a5
    80005bc4:	cfd1                	beqz	a5,80005c60 <snprintf+0x12a>
    if(c != '%'){
    80005bc6:	ff5711e3          	bne	a4,s5,80005ba8 <snprintf+0x72>
    c = fmt[++i] & 0xff;
    80005bca:	2905                	addiw	s2,s2,1
    80005bcc:	012a07b3          	add	a5,s4,s2
    80005bd0:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    80005bd4:	c7d1                	beqz	a5,80005c60 <snprintf+0x12a>
    switch(c){
    80005bd6:	05678c63          	beq	a5,s6,80005c2e <snprintf+0xf8>
    80005bda:	02fb6763          	bltu	s6,a5,80005c08 <snprintf+0xd2>
    80005bde:	0b578763          	beq	a5,s5,80005c8c <snprintf+0x156>
    80005be2:	0b879b63          	bne	a5,s8,80005c98 <snprintf+0x162>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    80005be6:	f8843783          	ld	a5,-120(s0)
    80005bea:	00878713          	addi	a4,a5,8
    80005bee:	f8e43423          	sd	a4,-120(s0)
    80005bf2:	4685                	li	a3,1
    80005bf4:	4629                	li	a2,10
    80005bf6:	438c                	lw	a1,0(a5)
    80005bf8:	009b8533          	add	a0,s7,s1
    80005bfc:	00000097          	auipc	ra,0x0
    80005c00:	ea2080e7          	jalr	-350(ra) # 80005a9e <sprintint>
    80005c04:	9ca9                	addw	s1,s1,a0
      break;
    80005c06:	b775                	j	80005bb2 <snprintf+0x7c>
    switch(c){
    80005c08:	09979863          	bne	a5,s9,80005c98 <snprintf+0x162>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    80005c0c:	f8843783          	ld	a5,-120(s0)
    80005c10:	00878713          	addi	a4,a5,8
    80005c14:	f8e43423          	sd	a4,-120(s0)
    80005c18:	4685                	li	a3,1
    80005c1a:	4641                	li	a2,16
    80005c1c:	438c                	lw	a1,0(a5)
    80005c1e:	009b8533          	add	a0,s7,s1
    80005c22:	00000097          	auipc	ra,0x0
    80005c26:	e7c080e7          	jalr	-388(ra) # 80005a9e <sprintint>
    80005c2a:	9ca9                	addw	s1,s1,a0
      break;
    80005c2c:	b759                	j	80005bb2 <snprintf+0x7c>
      if((s = va_arg(ap, char*)) == 0)
    80005c2e:	f8843783          	ld	a5,-120(s0)
    80005c32:	00878713          	addi	a4,a5,8
    80005c36:	f8e43423          	sd	a4,-120(s0)
    80005c3a:	639c                	ld	a5,0(a5)
    80005c3c:	c3b1                	beqz	a5,80005c80 <snprintf+0x14a>
      for(; *s && off < sz; s++)
    80005c3e:	0007c703          	lbu	a4,0(a5)
    80005c42:	db25                	beqz	a4,80005bb2 <snprintf+0x7c>
    80005c44:	0134de63          	bge	s1,s3,80005c60 <snprintf+0x12a>
    80005c48:	009b86b3          	add	a3,s7,s1
  *s = c;
    80005c4c:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    80005c50:	2485                	addiw	s1,s1,1
      for(; *s && off < sz; s++)
    80005c52:	0785                	addi	a5,a5,1
    80005c54:	0007c703          	lbu	a4,0(a5)
    80005c58:	df29                	beqz	a4,80005bb2 <snprintf+0x7c>
    80005c5a:	0685                	addi	a3,a3,1
    80005c5c:	fe9998e3          	bne	s3,s1,80005c4c <snprintf+0x116>
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
}
    80005c60:	8526                	mv	a0,s1
    80005c62:	70e6                	ld	ra,120(sp)
    80005c64:	7446                	ld	s0,112(sp)
    80005c66:	74a6                	ld	s1,104(sp)
    80005c68:	7906                	ld	s2,96(sp)
    80005c6a:	69e6                	ld	s3,88(sp)
    80005c6c:	6a46                	ld	s4,80(sp)
    80005c6e:	6aa6                	ld	s5,72(sp)
    80005c70:	6b06                	ld	s6,64(sp)
    80005c72:	7be2                	ld	s7,56(sp)
    80005c74:	7c42                	ld	s8,48(sp)
    80005c76:	7ca2                	ld	s9,40(sp)
    80005c78:	7d02                	ld	s10,32(sp)
    80005c7a:	6de2                	ld	s11,24(sp)
    80005c7c:	614d                	addi	sp,sp,176
    80005c7e:	8082                	ret
        s = "(null)";
    80005c80:	00003797          	auipc	a5,0x3
    80005c84:	b8878793          	addi	a5,a5,-1144 # 80008808 <syscalls+0x3f8>
      for(; *s && off < sz; s++)
    80005c88:	876e                	mv	a4,s11
    80005c8a:	bf6d                	j	80005c44 <snprintf+0x10e>
  *s = c;
    80005c8c:	009b87b3          	add	a5,s7,s1
    80005c90:	01a78023          	sb	s10,0(a5)
      off += sputc(buf+off, '%');
    80005c94:	2485                	addiw	s1,s1,1
      break;
    80005c96:	bf31                	j	80005bb2 <snprintf+0x7c>
  *s = c;
    80005c98:	009b8733          	add	a4,s7,s1
    80005c9c:	01a70023          	sb	s10,0(a4)
      off += sputc(buf+off, c);
    80005ca0:	0014871b          	addiw	a4,s1,1
  *s = c;
    80005ca4:	975e                	add	a4,a4,s7
    80005ca6:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80005caa:	2489                	addiw	s1,s1,2
      break;
    80005cac:	b719                	j	80005bb2 <snprintf+0x7c>

0000000080005cae <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005cae:	1141                	addi	sp,sp,-16
    80005cb0:	e422                	sd	s0,8(sp)
    80005cb2:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005cb4:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005cb8:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005cbc:	0037979b          	slliw	a5,a5,0x3
    80005cc0:	02004737          	lui	a4,0x2004
    80005cc4:	97ba                	add	a5,a5,a4
    80005cc6:	0200c737          	lui	a4,0x200c
    80005cca:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005cce:	000f4637          	lui	a2,0xf4
    80005cd2:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005cd6:	95b2                	add	a1,a1,a2
    80005cd8:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005cda:	00269713          	slli	a4,a3,0x2
    80005cde:	9736                	add	a4,a4,a3
    80005ce0:	00371693          	slli	a3,a4,0x3
    80005ce4:	00019717          	auipc	a4,0x19
    80005ce8:	b2c70713          	addi	a4,a4,-1236 # 8001e810 <timer_scratch>
    80005cec:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005cee:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005cf0:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005cf2:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005cf6:	fffff797          	auipc	a5,0xfffff
    80005cfa:	60a78793          	addi	a5,a5,1546 # 80005300 <timervec>
    80005cfe:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005d02:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005d06:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005d0a:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005d0e:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005d12:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005d16:	30479073          	csrw	mie,a5
}
    80005d1a:	6422                	ld	s0,8(sp)
    80005d1c:	0141                	addi	sp,sp,16
    80005d1e:	8082                	ret

0000000080005d20 <start>:
{
    80005d20:	1141                	addi	sp,sp,-16
    80005d22:	e406                	sd	ra,8(sp)
    80005d24:	e022                	sd	s0,0(sp)
    80005d26:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005d28:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005d2c:	7779                	lui	a4,0xffffe
    80005d2e:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd6dd7>
    80005d32:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005d34:	6705                	lui	a4,0x1
    80005d36:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005d3a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005d3c:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005d40:	ffffa797          	auipc	a5,0xffffa
    80005d44:	6de78793          	addi	a5,a5,1758 # 8000041e <main>
    80005d48:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005d4c:	4781                	li	a5,0
    80005d4e:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005d52:	67c1                	lui	a5,0x10
    80005d54:	17fd                	addi	a5,a5,-1
    80005d56:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005d5a:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005d5e:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005d62:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005d66:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005d6a:	57fd                	li	a5,-1
    80005d6c:	83a9                	srli	a5,a5,0xa
    80005d6e:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005d72:	47bd                	li	a5,15
    80005d74:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005d78:	00000097          	auipc	ra,0x0
    80005d7c:	f36080e7          	jalr	-202(ra) # 80005cae <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005d80:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005d84:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005d86:	823e                	mv	tp,a5
  asm volatile("mret");
    80005d88:	30200073          	mret
}
    80005d8c:	60a2                	ld	ra,8(sp)
    80005d8e:	6402                	ld	s0,0(sp)
    80005d90:	0141                	addi	sp,sp,16
    80005d92:	8082                	ret

0000000080005d94 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005d94:	715d                	addi	sp,sp,-80
    80005d96:	e486                	sd	ra,72(sp)
    80005d98:	e0a2                	sd	s0,64(sp)
    80005d9a:	fc26                	sd	s1,56(sp)
    80005d9c:	f84a                	sd	s2,48(sp)
    80005d9e:	f44e                	sd	s3,40(sp)
    80005da0:	f052                	sd	s4,32(sp)
    80005da2:	ec56                	sd	s5,24(sp)
    80005da4:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005da6:	04c05663          	blez	a2,80005df2 <consolewrite+0x5e>
    80005daa:	8a2a                	mv	s4,a0
    80005dac:	84ae                	mv	s1,a1
    80005dae:	89b2                	mv	s3,a2
    80005db0:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005db2:	5afd                	li	s5,-1
    80005db4:	4685                	li	a3,1
    80005db6:	8626                	mv	a2,s1
    80005db8:	85d2                	mv	a1,s4
    80005dba:	fbf40513          	addi	a0,s0,-65
    80005dbe:	ffffc097          	auipc	ra,0xffffc
    80005dc2:	d00080e7          	jalr	-768(ra) # 80001abe <either_copyin>
    80005dc6:	01550c63          	beq	a0,s5,80005dde <consolewrite+0x4a>
      break;
    uartputc(c);
    80005dca:	fbf44503          	lbu	a0,-65(s0)
    80005dce:	00000097          	auipc	ra,0x0
    80005dd2:	794080e7          	jalr	1940(ra) # 80006562 <uartputc>
  for(i = 0; i < n; i++){
    80005dd6:	2905                	addiw	s2,s2,1
    80005dd8:	0485                	addi	s1,s1,1
    80005dda:	fd299de3          	bne	s3,s2,80005db4 <consolewrite+0x20>
  }

  return i;
}
    80005dde:	854a                	mv	a0,s2
    80005de0:	60a6                	ld	ra,72(sp)
    80005de2:	6406                	ld	s0,64(sp)
    80005de4:	74e2                	ld	s1,56(sp)
    80005de6:	7942                	ld	s2,48(sp)
    80005de8:	79a2                	ld	s3,40(sp)
    80005dea:	7a02                	ld	s4,32(sp)
    80005dec:	6ae2                	ld	s5,24(sp)
    80005dee:	6161                	addi	sp,sp,80
    80005df0:	8082                	ret
  for(i = 0; i < n; i++){
    80005df2:	4901                	li	s2,0
    80005df4:	b7ed                	j	80005dde <consolewrite+0x4a>

0000000080005df6 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005df6:	7119                	addi	sp,sp,-128
    80005df8:	fc86                	sd	ra,120(sp)
    80005dfa:	f8a2                	sd	s0,112(sp)
    80005dfc:	f4a6                	sd	s1,104(sp)
    80005dfe:	f0ca                	sd	s2,96(sp)
    80005e00:	ecce                	sd	s3,88(sp)
    80005e02:	e8d2                	sd	s4,80(sp)
    80005e04:	e4d6                	sd	s5,72(sp)
    80005e06:	e0da                	sd	s6,64(sp)
    80005e08:	fc5e                	sd	s7,56(sp)
    80005e0a:	f862                	sd	s8,48(sp)
    80005e0c:	f466                	sd	s9,40(sp)
    80005e0e:	f06a                	sd	s10,32(sp)
    80005e10:	ec6e                	sd	s11,24(sp)
    80005e12:	0100                	addi	s0,sp,128
    80005e14:	8b2a                	mv	s6,a0
    80005e16:	8aae                	mv	s5,a1
    80005e18:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005e1a:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005e1e:	00021517          	auipc	a0,0x21
    80005e22:	b3250513          	addi	a0,a0,-1230 # 80026950 <cons>
    80005e26:	00001097          	auipc	ra,0x1
    80005e2a:	8e4080e7          	jalr	-1820(ra) # 8000670a <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005e2e:	00021497          	auipc	s1,0x21
    80005e32:	b2248493          	addi	s1,s1,-1246 # 80026950 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005e36:	89a6                	mv	s3,s1
    80005e38:	00021917          	auipc	s2,0x21
    80005e3c:	bb890913          	addi	s2,s2,-1096 # 800269f0 <cons+0xa0>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    80005e40:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005e42:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005e44:	4da9                	li	s11,10
  while(n > 0){
    80005e46:	07405b63          	blez	s4,80005ebc <consoleread+0xc6>
    while(cons.r == cons.w){
    80005e4a:	0a04a783          	lw	a5,160(s1)
    80005e4e:	0a44a703          	lw	a4,164(s1)
    80005e52:	02f71763          	bne	a4,a5,80005e80 <consoleread+0x8a>
      if(killed(myproc())){
    80005e56:	ffffb097          	auipc	ra,0xffffb
    80005e5a:	162080e7          	jalr	354(ra) # 80000fb8 <myproc>
    80005e5e:	ffffc097          	auipc	ra,0xffffc
    80005e62:	aaa080e7          	jalr	-1366(ra) # 80001908 <killed>
    80005e66:	e535                	bnez	a0,80005ed2 <consoleread+0xdc>
      sleep(&cons.r, &cons.lock);
    80005e68:	85ce                	mv	a1,s3
    80005e6a:	854a                	mv	a0,s2
    80005e6c:	ffffb097          	auipc	ra,0xffffb
    80005e70:	7f4080e7          	jalr	2036(ra) # 80001660 <sleep>
    while(cons.r == cons.w){
    80005e74:	0a04a783          	lw	a5,160(s1)
    80005e78:	0a44a703          	lw	a4,164(s1)
    80005e7c:	fcf70de3          	beq	a4,a5,80005e56 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005e80:	0017871b          	addiw	a4,a5,1
    80005e84:	0ae4a023          	sw	a4,160(s1)
    80005e88:	07f7f713          	andi	a4,a5,127
    80005e8c:	9726                	add	a4,a4,s1
    80005e8e:	02074703          	lbu	a4,32(a4)
    80005e92:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005e96:	079c0663          	beq	s8,s9,80005f02 <consoleread+0x10c>
    cbuf = c;
    80005e9a:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005e9e:	4685                	li	a3,1
    80005ea0:	f8f40613          	addi	a2,s0,-113
    80005ea4:	85d6                	mv	a1,s5
    80005ea6:	855a                	mv	a0,s6
    80005ea8:	ffffc097          	auipc	ra,0xffffc
    80005eac:	bc0080e7          	jalr	-1088(ra) # 80001a68 <either_copyout>
    80005eb0:	01a50663          	beq	a0,s10,80005ebc <consoleread+0xc6>
    dst++;
    80005eb4:	0a85                	addi	s5,s5,1
    --n;
    80005eb6:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005eb8:	f9bc17e3          	bne	s8,s11,80005e46 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005ebc:	00021517          	auipc	a0,0x21
    80005ec0:	a9450513          	addi	a0,a0,-1388 # 80026950 <cons>
    80005ec4:	00001097          	auipc	ra,0x1
    80005ec8:	916080e7          	jalr	-1770(ra) # 800067da <release>

  return target - n;
    80005ecc:	414b853b          	subw	a0,s7,s4
    80005ed0:	a811                	j	80005ee4 <consoleread+0xee>
        release(&cons.lock);
    80005ed2:	00021517          	auipc	a0,0x21
    80005ed6:	a7e50513          	addi	a0,a0,-1410 # 80026950 <cons>
    80005eda:	00001097          	auipc	ra,0x1
    80005ede:	900080e7          	jalr	-1792(ra) # 800067da <release>
        return -1;
    80005ee2:	557d                	li	a0,-1
}
    80005ee4:	70e6                	ld	ra,120(sp)
    80005ee6:	7446                	ld	s0,112(sp)
    80005ee8:	74a6                	ld	s1,104(sp)
    80005eea:	7906                	ld	s2,96(sp)
    80005eec:	69e6                	ld	s3,88(sp)
    80005eee:	6a46                	ld	s4,80(sp)
    80005ef0:	6aa6                	ld	s5,72(sp)
    80005ef2:	6b06                	ld	s6,64(sp)
    80005ef4:	7be2                	ld	s7,56(sp)
    80005ef6:	7c42                	ld	s8,48(sp)
    80005ef8:	7ca2                	ld	s9,40(sp)
    80005efa:	7d02                	ld	s10,32(sp)
    80005efc:	6de2                	ld	s11,24(sp)
    80005efe:	6109                	addi	sp,sp,128
    80005f00:	8082                	ret
      if(n < target){
    80005f02:	000a071b          	sext.w	a4,s4
    80005f06:	fb777be3          	bgeu	a4,s7,80005ebc <consoleread+0xc6>
        cons.r--;
    80005f0a:	00021717          	auipc	a4,0x21
    80005f0e:	aef72323          	sw	a5,-1306(a4) # 800269f0 <cons+0xa0>
    80005f12:	b76d                	j	80005ebc <consoleread+0xc6>

0000000080005f14 <consputc>:
{
    80005f14:	1141                	addi	sp,sp,-16
    80005f16:	e406                	sd	ra,8(sp)
    80005f18:	e022                	sd	s0,0(sp)
    80005f1a:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005f1c:	10000793          	li	a5,256
    80005f20:	00f50a63          	beq	a0,a5,80005f34 <consputc+0x20>
    uartputc_sync(c);
    80005f24:	00000097          	auipc	ra,0x0
    80005f28:	564080e7          	jalr	1380(ra) # 80006488 <uartputc_sync>
}
    80005f2c:	60a2                	ld	ra,8(sp)
    80005f2e:	6402                	ld	s0,0(sp)
    80005f30:	0141                	addi	sp,sp,16
    80005f32:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005f34:	4521                	li	a0,8
    80005f36:	00000097          	auipc	ra,0x0
    80005f3a:	552080e7          	jalr	1362(ra) # 80006488 <uartputc_sync>
    80005f3e:	02000513          	li	a0,32
    80005f42:	00000097          	auipc	ra,0x0
    80005f46:	546080e7          	jalr	1350(ra) # 80006488 <uartputc_sync>
    80005f4a:	4521                	li	a0,8
    80005f4c:	00000097          	auipc	ra,0x0
    80005f50:	53c080e7          	jalr	1340(ra) # 80006488 <uartputc_sync>
    80005f54:	bfe1                	j	80005f2c <consputc+0x18>

0000000080005f56 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005f56:	1101                	addi	sp,sp,-32
    80005f58:	ec06                	sd	ra,24(sp)
    80005f5a:	e822                	sd	s0,16(sp)
    80005f5c:	e426                	sd	s1,8(sp)
    80005f5e:	e04a                	sd	s2,0(sp)
    80005f60:	1000                	addi	s0,sp,32
    80005f62:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005f64:	00021517          	auipc	a0,0x21
    80005f68:	9ec50513          	addi	a0,a0,-1556 # 80026950 <cons>
    80005f6c:	00000097          	auipc	ra,0x0
    80005f70:	79e080e7          	jalr	1950(ra) # 8000670a <acquire>

  switch(c){
    80005f74:	47d5                	li	a5,21
    80005f76:	0af48663          	beq	s1,a5,80006022 <consoleintr+0xcc>
    80005f7a:	0297ca63          	blt	a5,s1,80005fae <consoleintr+0x58>
    80005f7e:	47a1                	li	a5,8
    80005f80:	0ef48763          	beq	s1,a5,8000606e <consoleintr+0x118>
    80005f84:	47c1                	li	a5,16
    80005f86:	10f49a63          	bne	s1,a5,8000609a <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005f8a:	ffffc097          	auipc	ra,0xffffc
    80005f8e:	b8a080e7          	jalr	-1142(ra) # 80001b14 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005f92:	00021517          	auipc	a0,0x21
    80005f96:	9be50513          	addi	a0,a0,-1602 # 80026950 <cons>
    80005f9a:	00001097          	auipc	ra,0x1
    80005f9e:	840080e7          	jalr	-1984(ra) # 800067da <release>
}
    80005fa2:	60e2                	ld	ra,24(sp)
    80005fa4:	6442                	ld	s0,16(sp)
    80005fa6:	64a2                	ld	s1,8(sp)
    80005fa8:	6902                	ld	s2,0(sp)
    80005faa:	6105                	addi	sp,sp,32
    80005fac:	8082                	ret
  switch(c){
    80005fae:	07f00793          	li	a5,127
    80005fb2:	0af48e63          	beq	s1,a5,8000606e <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005fb6:	00021717          	auipc	a4,0x21
    80005fba:	99a70713          	addi	a4,a4,-1638 # 80026950 <cons>
    80005fbe:	0a872783          	lw	a5,168(a4)
    80005fc2:	0a072703          	lw	a4,160(a4)
    80005fc6:	9f99                	subw	a5,a5,a4
    80005fc8:	07f00713          	li	a4,127
    80005fcc:	fcf763e3          	bltu	a4,a5,80005f92 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005fd0:	47b5                	li	a5,13
    80005fd2:	0cf48763          	beq	s1,a5,800060a0 <consoleintr+0x14a>
      consputc(c);
    80005fd6:	8526                	mv	a0,s1
    80005fd8:	00000097          	auipc	ra,0x0
    80005fdc:	f3c080e7          	jalr	-196(ra) # 80005f14 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005fe0:	00021797          	auipc	a5,0x21
    80005fe4:	97078793          	addi	a5,a5,-1680 # 80026950 <cons>
    80005fe8:	0a87a683          	lw	a3,168(a5)
    80005fec:	0016871b          	addiw	a4,a3,1
    80005ff0:	0007061b          	sext.w	a2,a4
    80005ff4:	0ae7a423          	sw	a4,168(a5)
    80005ff8:	07f6f693          	andi	a3,a3,127
    80005ffc:	97b6                	add	a5,a5,a3
    80005ffe:	02978023          	sb	s1,32(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80006002:	47a9                	li	a5,10
    80006004:	0cf48563          	beq	s1,a5,800060ce <consoleintr+0x178>
    80006008:	4791                	li	a5,4
    8000600a:	0cf48263          	beq	s1,a5,800060ce <consoleintr+0x178>
    8000600e:	00021797          	auipc	a5,0x21
    80006012:	9e27a783          	lw	a5,-1566(a5) # 800269f0 <cons+0xa0>
    80006016:	9f1d                	subw	a4,a4,a5
    80006018:	08000793          	li	a5,128
    8000601c:	f6f71be3          	bne	a4,a5,80005f92 <consoleintr+0x3c>
    80006020:	a07d                	j	800060ce <consoleintr+0x178>
    while(cons.e != cons.w &&
    80006022:	00021717          	auipc	a4,0x21
    80006026:	92e70713          	addi	a4,a4,-1746 # 80026950 <cons>
    8000602a:	0a872783          	lw	a5,168(a4)
    8000602e:	0a472703          	lw	a4,164(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80006032:	00021497          	auipc	s1,0x21
    80006036:	91e48493          	addi	s1,s1,-1762 # 80026950 <cons>
    while(cons.e != cons.w &&
    8000603a:	4929                	li	s2,10
    8000603c:	f4f70be3          	beq	a4,a5,80005f92 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80006040:	37fd                	addiw	a5,a5,-1
    80006042:	07f7f713          	andi	a4,a5,127
    80006046:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80006048:	02074703          	lbu	a4,32(a4)
    8000604c:	f52703e3          	beq	a4,s2,80005f92 <consoleintr+0x3c>
      cons.e--;
    80006050:	0af4a423          	sw	a5,168(s1)
      consputc(BACKSPACE);
    80006054:	10000513          	li	a0,256
    80006058:	00000097          	auipc	ra,0x0
    8000605c:	ebc080e7          	jalr	-324(ra) # 80005f14 <consputc>
    while(cons.e != cons.w &&
    80006060:	0a84a783          	lw	a5,168(s1)
    80006064:	0a44a703          	lw	a4,164(s1)
    80006068:	fcf71ce3          	bne	a4,a5,80006040 <consoleintr+0xea>
    8000606c:	b71d                	j	80005f92 <consoleintr+0x3c>
    if(cons.e != cons.w){
    8000606e:	00021717          	auipc	a4,0x21
    80006072:	8e270713          	addi	a4,a4,-1822 # 80026950 <cons>
    80006076:	0a872783          	lw	a5,168(a4)
    8000607a:	0a472703          	lw	a4,164(a4)
    8000607e:	f0f70ae3          	beq	a4,a5,80005f92 <consoleintr+0x3c>
      cons.e--;
    80006082:	37fd                	addiw	a5,a5,-1
    80006084:	00021717          	auipc	a4,0x21
    80006088:	96f72a23          	sw	a5,-1676(a4) # 800269f8 <cons+0xa8>
      consputc(BACKSPACE);
    8000608c:	10000513          	li	a0,256
    80006090:	00000097          	auipc	ra,0x0
    80006094:	e84080e7          	jalr	-380(ra) # 80005f14 <consputc>
    80006098:	bded                	j	80005f92 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000609a:	ee048ce3          	beqz	s1,80005f92 <consoleintr+0x3c>
    8000609e:	bf21                	j	80005fb6 <consoleintr+0x60>
      consputc(c);
    800060a0:	4529                	li	a0,10
    800060a2:	00000097          	auipc	ra,0x0
    800060a6:	e72080e7          	jalr	-398(ra) # 80005f14 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800060aa:	00021797          	auipc	a5,0x21
    800060ae:	8a678793          	addi	a5,a5,-1882 # 80026950 <cons>
    800060b2:	0a87a703          	lw	a4,168(a5)
    800060b6:	0017069b          	addiw	a3,a4,1
    800060ba:	0006861b          	sext.w	a2,a3
    800060be:	0ad7a423          	sw	a3,168(a5)
    800060c2:	07f77713          	andi	a4,a4,127
    800060c6:	97ba                	add	a5,a5,a4
    800060c8:	4729                	li	a4,10
    800060ca:	02e78023          	sb	a4,32(a5)
        cons.w = cons.e;
    800060ce:	00021797          	auipc	a5,0x21
    800060d2:	92c7a323          	sw	a2,-1754(a5) # 800269f4 <cons+0xa4>
        wakeup(&cons.r);
    800060d6:	00021517          	auipc	a0,0x21
    800060da:	91a50513          	addi	a0,a0,-1766 # 800269f0 <cons+0xa0>
    800060de:	ffffb097          	auipc	ra,0xffffb
    800060e2:	5e6080e7          	jalr	1510(ra) # 800016c4 <wakeup>
    800060e6:	b575                	j	80005f92 <consoleintr+0x3c>

00000000800060e8 <consoleinit>:

void
consoleinit(void)
{
    800060e8:	1141                	addi	sp,sp,-16
    800060ea:	e406                	sd	ra,8(sp)
    800060ec:	e022                	sd	s0,0(sp)
    800060ee:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    800060f0:	00002597          	auipc	a1,0x2
    800060f4:	74858593          	addi	a1,a1,1864 # 80008838 <digits+0x18>
    800060f8:	00021517          	auipc	a0,0x21
    800060fc:	85850513          	addi	a0,a0,-1960 # 80026950 <cons>
    80006100:	00000097          	auipc	ra,0x0
    80006104:	786080e7          	jalr	1926(ra) # 80006886 <initlock>

  uartinit();
    80006108:	00000097          	auipc	ra,0x0
    8000610c:	330080e7          	jalr	816(ra) # 80006438 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80006110:	00016797          	auipc	a5,0x16
    80006114:	53078793          	addi	a5,a5,1328 # 8001c640 <devsw>
    80006118:	00000717          	auipc	a4,0x0
    8000611c:	cde70713          	addi	a4,a4,-802 # 80005df6 <consoleread>
    80006120:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80006122:	00000717          	auipc	a4,0x0
    80006126:	c7270713          	addi	a4,a4,-910 # 80005d94 <consolewrite>
    8000612a:	ef98                	sd	a4,24(a5)
}
    8000612c:	60a2                	ld	ra,8(sp)
    8000612e:	6402                	ld	s0,0(sp)
    80006130:	0141                	addi	sp,sp,16
    80006132:	8082                	ret

0000000080006134 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80006134:	7179                	addi	sp,sp,-48
    80006136:	f406                	sd	ra,40(sp)
    80006138:	f022                	sd	s0,32(sp)
    8000613a:	ec26                	sd	s1,24(sp)
    8000613c:	e84a                	sd	s2,16(sp)
    8000613e:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80006140:	c219                	beqz	a2,80006146 <printint+0x12>
    80006142:	08054663          	bltz	a0,800061ce <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80006146:	2501                	sext.w	a0,a0
    80006148:	4881                	li	a7,0
    8000614a:	fd040693          	addi	a3,s0,-48

  i = 0;
    8000614e:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80006150:	2581                	sext.w	a1,a1
    80006152:	00002617          	auipc	a2,0x2
    80006156:	6fe60613          	addi	a2,a2,1790 # 80008850 <digits>
    8000615a:	883a                	mv	a6,a4
    8000615c:	2705                	addiw	a4,a4,1
    8000615e:	02b577bb          	remuw	a5,a0,a1
    80006162:	1782                	slli	a5,a5,0x20
    80006164:	9381                	srli	a5,a5,0x20
    80006166:	97b2                	add	a5,a5,a2
    80006168:	0007c783          	lbu	a5,0(a5)
    8000616c:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80006170:	0005079b          	sext.w	a5,a0
    80006174:	02b5553b          	divuw	a0,a0,a1
    80006178:	0685                	addi	a3,a3,1
    8000617a:	feb7f0e3          	bgeu	a5,a1,8000615a <printint+0x26>

  if(sign)
    8000617e:	00088b63          	beqz	a7,80006194 <printint+0x60>
    buf[i++] = '-';
    80006182:	fe040793          	addi	a5,s0,-32
    80006186:	973e                	add	a4,a4,a5
    80006188:	02d00793          	li	a5,45
    8000618c:	fef70823          	sb	a5,-16(a4)
    80006190:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80006194:	02e05763          	blez	a4,800061c2 <printint+0x8e>
    80006198:	fd040793          	addi	a5,s0,-48
    8000619c:	00e784b3          	add	s1,a5,a4
    800061a0:	fff78913          	addi	s2,a5,-1
    800061a4:	993a                	add	s2,s2,a4
    800061a6:	377d                	addiw	a4,a4,-1
    800061a8:	1702                	slli	a4,a4,0x20
    800061aa:	9301                	srli	a4,a4,0x20
    800061ac:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800061b0:	fff4c503          	lbu	a0,-1(s1)
    800061b4:	00000097          	auipc	ra,0x0
    800061b8:	d60080e7          	jalr	-672(ra) # 80005f14 <consputc>
  while(--i >= 0)
    800061bc:	14fd                	addi	s1,s1,-1
    800061be:	ff2499e3          	bne	s1,s2,800061b0 <printint+0x7c>
}
    800061c2:	70a2                	ld	ra,40(sp)
    800061c4:	7402                	ld	s0,32(sp)
    800061c6:	64e2                	ld	s1,24(sp)
    800061c8:	6942                	ld	s2,16(sp)
    800061ca:	6145                	addi	sp,sp,48
    800061cc:	8082                	ret
    x = -xx;
    800061ce:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    800061d2:	4885                	li	a7,1
    x = -xx;
    800061d4:	bf9d                	j	8000614a <printint+0x16>

00000000800061d6 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    800061d6:	1101                	addi	sp,sp,-32
    800061d8:	ec06                	sd	ra,24(sp)
    800061da:	e822                	sd	s0,16(sp)
    800061dc:	e426                	sd	s1,8(sp)
    800061de:	1000                	addi	s0,sp,32
    800061e0:	84aa                	mv	s1,a0
  pr.locking = 0;
    800061e2:	00021797          	auipc	a5,0x21
    800061e6:	8207af23          	sw	zero,-1986(a5) # 80026a20 <pr+0x20>
  printf("panic: ");
    800061ea:	00002517          	auipc	a0,0x2
    800061ee:	65650513          	addi	a0,a0,1622 # 80008840 <digits+0x20>
    800061f2:	00000097          	auipc	ra,0x0
    800061f6:	02e080e7          	jalr	46(ra) # 80006220 <printf>
  printf(s);
    800061fa:	8526                	mv	a0,s1
    800061fc:	00000097          	auipc	ra,0x0
    80006200:	024080e7          	jalr	36(ra) # 80006220 <printf>
  printf("\n");
    80006204:	00002517          	auipc	a0,0x2
    80006208:	6d450513          	addi	a0,a0,1748 # 800088d8 <digits+0x88>
    8000620c:	00000097          	auipc	ra,0x0
    80006210:	014080e7          	jalr	20(ra) # 80006220 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80006214:	4785                	li	a5,1
    80006216:	00002717          	auipc	a4,0x2
    8000621a:	7af72323          	sw	a5,1958(a4) # 800089bc <panicked>
  for(;;)
    8000621e:	a001                	j	8000621e <panic+0x48>

0000000080006220 <printf>:
{
    80006220:	7131                	addi	sp,sp,-192
    80006222:	fc86                	sd	ra,120(sp)
    80006224:	f8a2                	sd	s0,112(sp)
    80006226:	f4a6                	sd	s1,104(sp)
    80006228:	f0ca                	sd	s2,96(sp)
    8000622a:	ecce                	sd	s3,88(sp)
    8000622c:	e8d2                	sd	s4,80(sp)
    8000622e:	e4d6                	sd	s5,72(sp)
    80006230:	e0da                	sd	s6,64(sp)
    80006232:	fc5e                	sd	s7,56(sp)
    80006234:	f862                	sd	s8,48(sp)
    80006236:	f466                	sd	s9,40(sp)
    80006238:	f06a                	sd	s10,32(sp)
    8000623a:	ec6e                	sd	s11,24(sp)
    8000623c:	0100                	addi	s0,sp,128
    8000623e:	8a2a                	mv	s4,a0
    80006240:	e40c                	sd	a1,8(s0)
    80006242:	e810                	sd	a2,16(s0)
    80006244:	ec14                	sd	a3,24(s0)
    80006246:	f018                	sd	a4,32(s0)
    80006248:	f41c                	sd	a5,40(s0)
    8000624a:	03043823          	sd	a6,48(s0)
    8000624e:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80006252:	00020d97          	auipc	s11,0x20
    80006256:	7cedad83          	lw	s11,1998(s11) # 80026a20 <pr+0x20>
  if(locking)
    8000625a:	020d9b63          	bnez	s11,80006290 <printf+0x70>
  if (fmt == 0)
    8000625e:	040a0263          	beqz	s4,800062a2 <printf+0x82>
  va_start(ap, fmt);
    80006262:	00840793          	addi	a5,s0,8
    80006266:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000626a:	000a4503          	lbu	a0,0(s4)
    8000626e:	16050263          	beqz	a0,800063d2 <printf+0x1b2>
    80006272:	4481                	li	s1,0
    if(c != '%'){
    80006274:	02500a93          	li	s5,37
    switch(c){
    80006278:	07000b13          	li	s6,112
  consputc('x');
    8000627c:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000627e:	00002b97          	auipc	s7,0x2
    80006282:	5d2b8b93          	addi	s7,s7,1490 # 80008850 <digits>
    switch(c){
    80006286:	07300c93          	li	s9,115
    8000628a:	06400c13          	li	s8,100
    8000628e:	a82d                	j	800062c8 <printf+0xa8>
    acquire(&pr.lock);
    80006290:	00020517          	auipc	a0,0x20
    80006294:	77050513          	addi	a0,a0,1904 # 80026a00 <pr>
    80006298:	00000097          	auipc	ra,0x0
    8000629c:	472080e7          	jalr	1138(ra) # 8000670a <acquire>
    800062a0:	bf7d                	j	8000625e <printf+0x3e>
    panic("null fmt");
    800062a2:	00002517          	auipc	a0,0x2
    800062a6:	56e50513          	addi	a0,a0,1390 # 80008810 <syscalls+0x400>
    800062aa:	00000097          	auipc	ra,0x0
    800062ae:	f2c080e7          	jalr	-212(ra) # 800061d6 <panic>
      consputc(c);
    800062b2:	00000097          	auipc	ra,0x0
    800062b6:	c62080e7          	jalr	-926(ra) # 80005f14 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800062ba:	2485                	addiw	s1,s1,1
    800062bc:	009a07b3          	add	a5,s4,s1
    800062c0:	0007c503          	lbu	a0,0(a5)
    800062c4:	10050763          	beqz	a0,800063d2 <printf+0x1b2>
    if(c != '%'){
    800062c8:	ff5515e3          	bne	a0,s5,800062b2 <printf+0x92>
    c = fmt[++i] & 0xff;
    800062cc:	2485                	addiw	s1,s1,1
    800062ce:	009a07b3          	add	a5,s4,s1
    800062d2:	0007c783          	lbu	a5,0(a5)
    800062d6:	0007891b          	sext.w	s2,a5
    if(c == 0)
    800062da:	cfe5                	beqz	a5,800063d2 <printf+0x1b2>
    switch(c){
    800062dc:	05678a63          	beq	a5,s6,80006330 <printf+0x110>
    800062e0:	02fb7663          	bgeu	s6,a5,8000630c <printf+0xec>
    800062e4:	09978963          	beq	a5,s9,80006376 <printf+0x156>
    800062e8:	07800713          	li	a4,120
    800062ec:	0ce79863          	bne	a5,a4,800063bc <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    800062f0:	f8843783          	ld	a5,-120(s0)
    800062f4:	00878713          	addi	a4,a5,8
    800062f8:	f8e43423          	sd	a4,-120(s0)
    800062fc:	4605                	li	a2,1
    800062fe:	85ea                	mv	a1,s10
    80006300:	4388                	lw	a0,0(a5)
    80006302:	00000097          	auipc	ra,0x0
    80006306:	e32080e7          	jalr	-462(ra) # 80006134 <printint>
      break;
    8000630a:	bf45                	j	800062ba <printf+0x9a>
    switch(c){
    8000630c:	0b578263          	beq	a5,s5,800063b0 <printf+0x190>
    80006310:	0b879663          	bne	a5,s8,800063bc <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80006314:	f8843783          	ld	a5,-120(s0)
    80006318:	00878713          	addi	a4,a5,8
    8000631c:	f8e43423          	sd	a4,-120(s0)
    80006320:	4605                	li	a2,1
    80006322:	45a9                	li	a1,10
    80006324:	4388                	lw	a0,0(a5)
    80006326:	00000097          	auipc	ra,0x0
    8000632a:	e0e080e7          	jalr	-498(ra) # 80006134 <printint>
      break;
    8000632e:	b771                	j	800062ba <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80006330:	f8843783          	ld	a5,-120(s0)
    80006334:	00878713          	addi	a4,a5,8
    80006338:	f8e43423          	sd	a4,-120(s0)
    8000633c:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80006340:	03000513          	li	a0,48
    80006344:	00000097          	auipc	ra,0x0
    80006348:	bd0080e7          	jalr	-1072(ra) # 80005f14 <consputc>
  consputc('x');
    8000634c:	07800513          	li	a0,120
    80006350:	00000097          	auipc	ra,0x0
    80006354:	bc4080e7          	jalr	-1084(ra) # 80005f14 <consputc>
    80006358:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000635a:	03c9d793          	srli	a5,s3,0x3c
    8000635e:	97de                	add	a5,a5,s7
    80006360:	0007c503          	lbu	a0,0(a5)
    80006364:	00000097          	auipc	ra,0x0
    80006368:	bb0080e7          	jalr	-1104(ra) # 80005f14 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    8000636c:	0992                	slli	s3,s3,0x4
    8000636e:	397d                	addiw	s2,s2,-1
    80006370:	fe0915e3          	bnez	s2,8000635a <printf+0x13a>
    80006374:	b799                	j	800062ba <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80006376:	f8843783          	ld	a5,-120(s0)
    8000637a:	00878713          	addi	a4,a5,8
    8000637e:	f8e43423          	sd	a4,-120(s0)
    80006382:	0007b903          	ld	s2,0(a5)
    80006386:	00090e63          	beqz	s2,800063a2 <printf+0x182>
      for(; *s; s++)
    8000638a:	00094503          	lbu	a0,0(s2)
    8000638e:	d515                	beqz	a0,800062ba <printf+0x9a>
        consputc(*s);
    80006390:	00000097          	auipc	ra,0x0
    80006394:	b84080e7          	jalr	-1148(ra) # 80005f14 <consputc>
      for(; *s; s++)
    80006398:	0905                	addi	s2,s2,1
    8000639a:	00094503          	lbu	a0,0(s2)
    8000639e:	f96d                	bnez	a0,80006390 <printf+0x170>
    800063a0:	bf29                	j	800062ba <printf+0x9a>
        s = "(null)";
    800063a2:	00002917          	auipc	s2,0x2
    800063a6:	46690913          	addi	s2,s2,1126 # 80008808 <syscalls+0x3f8>
      for(; *s; s++)
    800063aa:	02800513          	li	a0,40
    800063ae:	b7cd                	j	80006390 <printf+0x170>
      consputc('%');
    800063b0:	8556                	mv	a0,s5
    800063b2:	00000097          	auipc	ra,0x0
    800063b6:	b62080e7          	jalr	-1182(ra) # 80005f14 <consputc>
      break;
    800063ba:	b701                	j	800062ba <printf+0x9a>
      consputc('%');
    800063bc:	8556                	mv	a0,s5
    800063be:	00000097          	auipc	ra,0x0
    800063c2:	b56080e7          	jalr	-1194(ra) # 80005f14 <consputc>
      consputc(c);
    800063c6:	854a                	mv	a0,s2
    800063c8:	00000097          	auipc	ra,0x0
    800063cc:	b4c080e7          	jalr	-1204(ra) # 80005f14 <consputc>
      break;
    800063d0:	b5ed                	j	800062ba <printf+0x9a>
  if(locking)
    800063d2:	020d9163          	bnez	s11,800063f4 <printf+0x1d4>
}
    800063d6:	70e6                	ld	ra,120(sp)
    800063d8:	7446                	ld	s0,112(sp)
    800063da:	74a6                	ld	s1,104(sp)
    800063dc:	7906                	ld	s2,96(sp)
    800063de:	69e6                	ld	s3,88(sp)
    800063e0:	6a46                	ld	s4,80(sp)
    800063e2:	6aa6                	ld	s5,72(sp)
    800063e4:	6b06                	ld	s6,64(sp)
    800063e6:	7be2                	ld	s7,56(sp)
    800063e8:	7c42                	ld	s8,48(sp)
    800063ea:	7ca2                	ld	s9,40(sp)
    800063ec:	7d02                	ld	s10,32(sp)
    800063ee:	6de2                	ld	s11,24(sp)
    800063f0:	6129                	addi	sp,sp,192
    800063f2:	8082                	ret
    release(&pr.lock);
    800063f4:	00020517          	auipc	a0,0x20
    800063f8:	60c50513          	addi	a0,a0,1548 # 80026a00 <pr>
    800063fc:	00000097          	auipc	ra,0x0
    80006400:	3de080e7          	jalr	990(ra) # 800067da <release>
}
    80006404:	bfc9                	j	800063d6 <printf+0x1b6>

0000000080006406 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006406:	1101                	addi	sp,sp,-32
    80006408:	ec06                	sd	ra,24(sp)
    8000640a:	e822                	sd	s0,16(sp)
    8000640c:	e426                	sd	s1,8(sp)
    8000640e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80006410:	00020497          	auipc	s1,0x20
    80006414:	5f048493          	addi	s1,s1,1520 # 80026a00 <pr>
    80006418:	00002597          	auipc	a1,0x2
    8000641c:	43058593          	addi	a1,a1,1072 # 80008848 <digits+0x28>
    80006420:	8526                	mv	a0,s1
    80006422:	00000097          	auipc	ra,0x0
    80006426:	464080e7          	jalr	1124(ra) # 80006886 <initlock>
  pr.locking = 1;
    8000642a:	4785                	li	a5,1
    8000642c:	d09c                	sw	a5,32(s1)
}
    8000642e:	60e2                	ld	ra,24(sp)
    80006430:	6442                	ld	s0,16(sp)
    80006432:	64a2                	ld	s1,8(sp)
    80006434:	6105                	addi	sp,sp,32
    80006436:	8082                	ret

0000000080006438 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006438:	1141                	addi	sp,sp,-16
    8000643a:	e406                	sd	ra,8(sp)
    8000643c:	e022                	sd	s0,0(sp)
    8000643e:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80006440:	100007b7          	lui	a5,0x10000
    80006444:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80006448:	f8000713          	li	a4,-128
    8000644c:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80006450:	470d                	li	a4,3
    80006452:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80006456:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    8000645a:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    8000645e:	469d                	li	a3,7
    80006460:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80006464:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80006468:	00002597          	auipc	a1,0x2
    8000646c:	40058593          	addi	a1,a1,1024 # 80008868 <digits+0x18>
    80006470:	00020517          	auipc	a0,0x20
    80006474:	5b850513          	addi	a0,a0,1464 # 80026a28 <uart_tx_lock>
    80006478:	00000097          	auipc	ra,0x0
    8000647c:	40e080e7          	jalr	1038(ra) # 80006886 <initlock>
}
    80006480:	60a2                	ld	ra,8(sp)
    80006482:	6402                	ld	s0,0(sp)
    80006484:	0141                	addi	sp,sp,16
    80006486:	8082                	ret

0000000080006488 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80006488:	1101                	addi	sp,sp,-32
    8000648a:	ec06                	sd	ra,24(sp)
    8000648c:	e822                	sd	s0,16(sp)
    8000648e:	e426                	sd	s1,8(sp)
    80006490:	1000                	addi	s0,sp,32
    80006492:	84aa                	mv	s1,a0
  push_off();
    80006494:	00000097          	auipc	ra,0x0
    80006498:	22a080e7          	jalr	554(ra) # 800066be <push_off>

  if(panicked){
    8000649c:	00002797          	auipc	a5,0x2
    800064a0:	5207a783          	lw	a5,1312(a5) # 800089bc <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800064a4:	10000737          	lui	a4,0x10000
  if(panicked){
    800064a8:	c391                	beqz	a5,800064ac <uartputc_sync+0x24>
    for(;;)
    800064aa:	a001                	j	800064aa <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800064ac:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800064b0:	0ff7f793          	andi	a5,a5,255
    800064b4:	0207f793          	andi	a5,a5,32
    800064b8:	dbf5                	beqz	a5,800064ac <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800064ba:	0ff4f793          	andi	a5,s1,255
    800064be:	10000737          	lui	a4,0x10000
    800064c2:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    800064c6:	00000097          	auipc	ra,0x0
    800064ca:	2b4080e7          	jalr	692(ra) # 8000677a <pop_off>
}
    800064ce:	60e2                	ld	ra,24(sp)
    800064d0:	6442                	ld	s0,16(sp)
    800064d2:	64a2                	ld	s1,8(sp)
    800064d4:	6105                	addi	sp,sp,32
    800064d6:	8082                	ret

00000000800064d8 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800064d8:	00002717          	auipc	a4,0x2
    800064dc:	4e873703          	ld	a4,1256(a4) # 800089c0 <uart_tx_r>
    800064e0:	00002797          	auipc	a5,0x2
    800064e4:	4e87b783          	ld	a5,1256(a5) # 800089c8 <uart_tx_w>
    800064e8:	06e78c63          	beq	a5,a4,80006560 <uartstart+0x88>
{
    800064ec:	7139                	addi	sp,sp,-64
    800064ee:	fc06                	sd	ra,56(sp)
    800064f0:	f822                	sd	s0,48(sp)
    800064f2:	f426                	sd	s1,40(sp)
    800064f4:	f04a                	sd	s2,32(sp)
    800064f6:	ec4e                	sd	s3,24(sp)
    800064f8:	e852                	sd	s4,16(sp)
    800064fa:	e456                	sd	s5,8(sp)
    800064fc:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800064fe:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006502:	00020a17          	auipc	s4,0x20
    80006506:	526a0a13          	addi	s4,s4,1318 # 80026a28 <uart_tx_lock>
    uart_tx_r += 1;
    8000650a:	00002497          	auipc	s1,0x2
    8000650e:	4b648493          	addi	s1,s1,1206 # 800089c0 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006512:	00002997          	auipc	s3,0x2
    80006516:	4b698993          	addi	s3,s3,1206 # 800089c8 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000651a:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    8000651e:	0ff7f793          	andi	a5,a5,255
    80006522:	0207f793          	andi	a5,a5,32
    80006526:	c785                	beqz	a5,8000654e <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006528:	01f77793          	andi	a5,a4,31
    8000652c:	97d2                	add	a5,a5,s4
    8000652e:	0207ca83          	lbu	s5,32(a5)
    uart_tx_r += 1;
    80006532:	0705                	addi	a4,a4,1
    80006534:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80006536:	8526                	mv	a0,s1
    80006538:	ffffb097          	auipc	ra,0xffffb
    8000653c:	18c080e7          	jalr	396(ra) # 800016c4 <wakeup>
    
    WriteReg(THR, c);
    80006540:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80006544:	6098                	ld	a4,0(s1)
    80006546:	0009b783          	ld	a5,0(s3)
    8000654a:	fce798e3          	bne	a5,a4,8000651a <uartstart+0x42>
  }
}
    8000654e:	70e2                	ld	ra,56(sp)
    80006550:	7442                	ld	s0,48(sp)
    80006552:	74a2                	ld	s1,40(sp)
    80006554:	7902                	ld	s2,32(sp)
    80006556:	69e2                	ld	s3,24(sp)
    80006558:	6a42                	ld	s4,16(sp)
    8000655a:	6aa2                	ld	s5,8(sp)
    8000655c:	6121                	addi	sp,sp,64
    8000655e:	8082                	ret
    80006560:	8082                	ret

0000000080006562 <uartputc>:
{
    80006562:	7179                	addi	sp,sp,-48
    80006564:	f406                	sd	ra,40(sp)
    80006566:	f022                	sd	s0,32(sp)
    80006568:	ec26                	sd	s1,24(sp)
    8000656a:	e84a                	sd	s2,16(sp)
    8000656c:	e44e                	sd	s3,8(sp)
    8000656e:	e052                	sd	s4,0(sp)
    80006570:	1800                	addi	s0,sp,48
    80006572:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    80006574:	00020517          	auipc	a0,0x20
    80006578:	4b450513          	addi	a0,a0,1204 # 80026a28 <uart_tx_lock>
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	18e080e7          	jalr	398(ra) # 8000670a <acquire>
  if(panicked){
    80006584:	00002797          	auipc	a5,0x2
    80006588:	4387a783          	lw	a5,1080(a5) # 800089bc <panicked>
    8000658c:	e7c9                	bnez	a5,80006616 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000658e:	00002797          	auipc	a5,0x2
    80006592:	43a7b783          	ld	a5,1082(a5) # 800089c8 <uart_tx_w>
    80006596:	00002717          	auipc	a4,0x2
    8000659a:	42a73703          	ld	a4,1066(a4) # 800089c0 <uart_tx_r>
    8000659e:	02070713          	addi	a4,a4,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800065a2:	00020a17          	auipc	s4,0x20
    800065a6:	486a0a13          	addi	s4,s4,1158 # 80026a28 <uart_tx_lock>
    800065aa:	00002497          	auipc	s1,0x2
    800065ae:	41648493          	addi	s1,s1,1046 # 800089c0 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800065b2:	00002917          	auipc	s2,0x2
    800065b6:	41690913          	addi	s2,s2,1046 # 800089c8 <uart_tx_w>
    800065ba:	00f71f63          	bne	a4,a5,800065d8 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    800065be:	85d2                	mv	a1,s4
    800065c0:	8526                	mv	a0,s1
    800065c2:	ffffb097          	auipc	ra,0xffffb
    800065c6:	09e080e7          	jalr	158(ra) # 80001660 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800065ca:	00093783          	ld	a5,0(s2)
    800065ce:	6098                	ld	a4,0(s1)
    800065d0:	02070713          	addi	a4,a4,32
    800065d4:	fef705e3          	beq	a4,a5,800065be <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800065d8:	00020497          	auipc	s1,0x20
    800065dc:	45048493          	addi	s1,s1,1104 # 80026a28 <uart_tx_lock>
    800065e0:	01f7f713          	andi	a4,a5,31
    800065e4:	9726                	add	a4,a4,s1
    800065e6:	03370023          	sb	s3,32(a4)
  uart_tx_w += 1;
    800065ea:	0785                	addi	a5,a5,1
    800065ec:	00002717          	auipc	a4,0x2
    800065f0:	3cf73e23          	sd	a5,988(a4) # 800089c8 <uart_tx_w>
  uartstart();
    800065f4:	00000097          	auipc	ra,0x0
    800065f8:	ee4080e7          	jalr	-284(ra) # 800064d8 <uartstart>
  release(&uart_tx_lock);
    800065fc:	8526                	mv	a0,s1
    800065fe:	00000097          	auipc	ra,0x0
    80006602:	1dc080e7          	jalr	476(ra) # 800067da <release>
}
    80006606:	70a2                	ld	ra,40(sp)
    80006608:	7402                	ld	s0,32(sp)
    8000660a:	64e2                	ld	s1,24(sp)
    8000660c:	6942                	ld	s2,16(sp)
    8000660e:	69a2                	ld	s3,8(sp)
    80006610:	6a02                	ld	s4,0(sp)
    80006612:	6145                	addi	sp,sp,48
    80006614:	8082                	ret
    for(;;)
    80006616:	a001                	j	80006616 <uartputc+0xb4>

0000000080006618 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006618:	1141                	addi	sp,sp,-16
    8000661a:	e422                	sd	s0,8(sp)
    8000661c:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000661e:	100007b7          	lui	a5,0x10000
    80006622:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006626:	8b85                	andi	a5,a5,1
    80006628:	cb91                	beqz	a5,8000663c <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000662a:	100007b7          	lui	a5,0x10000
    8000662e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80006632:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80006636:	6422                	ld	s0,8(sp)
    80006638:	0141                	addi	sp,sp,16
    8000663a:	8082                	ret
    return -1;
    8000663c:	557d                	li	a0,-1
    8000663e:	bfe5                	j	80006636 <uartgetc+0x1e>

0000000080006640 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80006640:	1101                	addi	sp,sp,-32
    80006642:	ec06                	sd	ra,24(sp)
    80006644:	e822                	sd	s0,16(sp)
    80006646:	e426                	sd	s1,8(sp)
    80006648:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000664a:	54fd                	li	s1,-1
    int c = uartgetc();
    8000664c:	00000097          	auipc	ra,0x0
    80006650:	fcc080e7          	jalr	-52(ra) # 80006618 <uartgetc>
    if(c == -1)
    80006654:	00950763          	beq	a0,s1,80006662 <uartintr+0x22>
      break;
    consoleintr(c);
    80006658:	00000097          	auipc	ra,0x0
    8000665c:	8fe080e7          	jalr	-1794(ra) # 80005f56 <consoleintr>
  while(1){
    80006660:	b7f5                	j	8000664c <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80006662:	00020497          	auipc	s1,0x20
    80006666:	3c648493          	addi	s1,s1,966 # 80026a28 <uart_tx_lock>
    8000666a:	8526                	mv	a0,s1
    8000666c:	00000097          	auipc	ra,0x0
    80006670:	09e080e7          	jalr	158(ra) # 8000670a <acquire>
  uartstart();
    80006674:	00000097          	auipc	ra,0x0
    80006678:	e64080e7          	jalr	-412(ra) # 800064d8 <uartstart>
  release(&uart_tx_lock);
    8000667c:	8526                	mv	a0,s1
    8000667e:	00000097          	auipc	ra,0x0
    80006682:	15c080e7          	jalr	348(ra) # 800067da <release>
}
    80006686:	60e2                	ld	ra,24(sp)
    80006688:	6442                	ld	s0,16(sp)
    8000668a:	64a2                	ld	s1,8(sp)
    8000668c:	6105                	addi	sp,sp,32
    8000668e:	8082                	ret

0000000080006690 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006690:	411c                	lw	a5,0(a0)
    80006692:	e399                	bnez	a5,80006698 <holding+0x8>
    80006694:	4501                	li	a0,0
  return r;
}
    80006696:	8082                	ret
{
    80006698:	1101                	addi	sp,sp,-32
    8000669a:	ec06                	sd	ra,24(sp)
    8000669c:	e822                	sd	s0,16(sp)
    8000669e:	e426                	sd	s1,8(sp)
    800066a0:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800066a2:	6904                	ld	s1,16(a0)
    800066a4:	ffffb097          	auipc	ra,0xffffb
    800066a8:	8f8080e7          	jalr	-1800(ra) # 80000f9c <mycpu>
    800066ac:	40a48533          	sub	a0,s1,a0
    800066b0:	00153513          	seqz	a0,a0
}
    800066b4:	60e2                	ld	ra,24(sp)
    800066b6:	6442                	ld	s0,16(sp)
    800066b8:	64a2                	ld	s1,8(sp)
    800066ba:	6105                	addi	sp,sp,32
    800066bc:	8082                	ret

00000000800066be <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800066be:	1101                	addi	sp,sp,-32
    800066c0:	ec06                	sd	ra,24(sp)
    800066c2:	e822                	sd	s0,16(sp)
    800066c4:	e426                	sd	s1,8(sp)
    800066c6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800066c8:	100024f3          	csrr	s1,sstatus
    800066cc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800066d0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800066d2:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800066d6:	ffffb097          	auipc	ra,0xffffb
    800066da:	8c6080e7          	jalr	-1850(ra) # 80000f9c <mycpu>
    800066de:	5d3c                	lw	a5,120(a0)
    800066e0:	cf89                	beqz	a5,800066fa <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800066e2:	ffffb097          	auipc	ra,0xffffb
    800066e6:	8ba080e7          	jalr	-1862(ra) # 80000f9c <mycpu>
    800066ea:	5d3c                	lw	a5,120(a0)
    800066ec:	2785                	addiw	a5,a5,1
    800066ee:	dd3c                	sw	a5,120(a0)
}
    800066f0:	60e2                	ld	ra,24(sp)
    800066f2:	6442                	ld	s0,16(sp)
    800066f4:	64a2                	ld	s1,8(sp)
    800066f6:	6105                	addi	sp,sp,32
    800066f8:	8082                	ret
    mycpu()->intena = old;
    800066fa:	ffffb097          	auipc	ra,0xffffb
    800066fe:	8a2080e7          	jalr	-1886(ra) # 80000f9c <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006702:	8085                	srli	s1,s1,0x1
    80006704:	8885                	andi	s1,s1,1
    80006706:	dd64                	sw	s1,124(a0)
    80006708:	bfe9                	j	800066e2 <push_off+0x24>

000000008000670a <acquire>:
{
    8000670a:	1101                	addi	sp,sp,-32
    8000670c:	ec06                	sd	ra,24(sp)
    8000670e:	e822                	sd	s0,16(sp)
    80006710:	e426                	sd	s1,8(sp)
    80006712:	1000                	addi	s0,sp,32
    80006714:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006716:	00000097          	auipc	ra,0x0
    8000671a:	fa8080e7          	jalr	-88(ra) # 800066be <push_off>
  if(holding(lk))
    8000671e:	8526                	mv	a0,s1
    80006720:	00000097          	auipc	ra,0x0
    80006724:	f70080e7          	jalr	-144(ra) # 80006690 <holding>
    80006728:	e911                	bnez	a0,8000673c <acquire+0x32>
    __sync_fetch_and_add(&(lk->n), 1);
    8000672a:	4785                	li	a5,1
    8000672c:	01c48713          	addi	a4,s1,28
    80006730:	0f50000f          	fence	iorw,ow
    80006734:	04f7202f          	amoadd.w.aq	zero,a5,(a4)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80006738:	4705                	li	a4,1
    8000673a:	a839                	j	80006758 <acquire+0x4e>
    panic("acquire");
    8000673c:	00002517          	auipc	a0,0x2
    80006740:	13450513          	addi	a0,a0,308 # 80008870 <digits+0x20>
    80006744:	00000097          	auipc	ra,0x0
    80006748:	a92080e7          	jalr	-1390(ra) # 800061d6 <panic>
    __sync_fetch_and_add(&(lk->nts), 1);
    8000674c:	01848793          	addi	a5,s1,24
    80006750:	0f50000f          	fence	iorw,ow
    80006754:	04e7a02f          	amoadd.w.aq	zero,a4,(a5)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80006758:	87ba                	mv	a5,a4
    8000675a:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000675e:	2781                	sext.w	a5,a5
    80006760:	f7f5                	bnez	a5,8000674c <acquire+0x42>
  __sync_synchronize();
    80006762:	0ff0000f          	fence
  lk->cpu = mycpu();
    80006766:	ffffb097          	auipc	ra,0xffffb
    8000676a:	836080e7          	jalr	-1994(ra) # 80000f9c <mycpu>
    8000676e:	e888                	sd	a0,16(s1)
}
    80006770:	60e2                	ld	ra,24(sp)
    80006772:	6442                	ld	s0,16(sp)
    80006774:	64a2                	ld	s1,8(sp)
    80006776:	6105                	addi	sp,sp,32
    80006778:	8082                	ret

000000008000677a <pop_off>:

void
pop_off(void)
{
    8000677a:	1141                	addi	sp,sp,-16
    8000677c:	e406                	sd	ra,8(sp)
    8000677e:	e022                	sd	s0,0(sp)
    80006780:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006782:	ffffb097          	auipc	ra,0xffffb
    80006786:	81a080e7          	jalr	-2022(ra) # 80000f9c <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000678a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000678e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006790:	e78d                	bnez	a5,800067ba <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006792:	5d3c                	lw	a5,120(a0)
    80006794:	02f05b63          	blez	a5,800067ca <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006798:	37fd                	addiw	a5,a5,-1
    8000679a:	0007871b          	sext.w	a4,a5
    8000679e:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800067a0:	eb09                	bnez	a4,800067b2 <pop_off+0x38>
    800067a2:	5d7c                	lw	a5,124(a0)
    800067a4:	c799                	beqz	a5,800067b2 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800067a6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800067aa:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800067ae:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800067b2:	60a2                	ld	ra,8(sp)
    800067b4:	6402                	ld	s0,0(sp)
    800067b6:	0141                	addi	sp,sp,16
    800067b8:	8082                	ret
    panic("pop_off - interruptible");
    800067ba:	00002517          	auipc	a0,0x2
    800067be:	0be50513          	addi	a0,a0,190 # 80008878 <digits+0x28>
    800067c2:	00000097          	auipc	ra,0x0
    800067c6:	a14080e7          	jalr	-1516(ra) # 800061d6 <panic>
    panic("pop_off");
    800067ca:	00002517          	auipc	a0,0x2
    800067ce:	0c650513          	addi	a0,a0,198 # 80008890 <digits+0x40>
    800067d2:	00000097          	auipc	ra,0x0
    800067d6:	a04080e7          	jalr	-1532(ra) # 800061d6 <panic>

00000000800067da <release>:
{
    800067da:	1101                	addi	sp,sp,-32
    800067dc:	ec06                	sd	ra,24(sp)
    800067de:	e822                	sd	s0,16(sp)
    800067e0:	e426                	sd	s1,8(sp)
    800067e2:	1000                	addi	s0,sp,32
    800067e4:	84aa                	mv	s1,a0
  if(!holding(lk))
    800067e6:	00000097          	auipc	ra,0x0
    800067ea:	eaa080e7          	jalr	-342(ra) # 80006690 <holding>
    800067ee:	c115                	beqz	a0,80006812 <release+0x38>
  lk->cpu = 0;
    800067f0:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800067f4:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800067f8:	0f50000f          	fence	iorw,ow
    800067fc:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006800:	00000097          	auipc	ra,0x0
    80006804:	f7a080e7          	jalr	-134(ra) # 8000677a <pop_off>
}
    80006808:	60e2                	ld	ra,24(sp)
    8000680a:	6442                	ld	s0,16(sp)
    8000680c:	64a2                	ld	s1,8(sp)
    8000680e:	6105                	addi	sp,sp,32
    80006810:	8082                	ret
    panic("release");
    80006812:	00002517          	auipc	a0,0x2
    80006816:	08650513          	addi	a0,a0,134 # 80008898 <digits+0x48>
    8000681a:	00000097          	auipc	ra,0x0
    8000681e:	9bc080e7          	jalr	-1604(ra) # 800061d6 <panic>

0000000080006822 <freelock>:
{
    80006822:	1101                	addi	sp,sp,-32
    80006824:	ec06                	sd	ra,24(sp)
    80006826:	e822                	sd	s0,16(sp)
    80006828:	e426                	sd	s1,8(sp)
    8000682a:	1000                	addi	s0,sp,32
    8000682c:	84aa                	mv	s1,a0
  acquire(&lock_locks);
    8000682e:	00020517          	auipc	a0,0x20
    80006832:	23a50513          	addi	a0,a0,570 # 80026a68 <lock_locks>
    80006836:	00000097          	auipc	ra,0x0
    8000683a:	ed4080e7          	jalr	-300(ra) # 8000670a <acquire>
  for (i = 0; i < NLOCK; i++) {
    8000683e:	00020717          	auipc	a4,0x20
    80006842:	24a70713          	addi	a4,a4,586 # 80026a88 <locks>
    80006846:	4781                	li	a5,0
    80006848:	1f400613          	li	a2,500
    if(locks[i] == lk) {
    8000684c:	6314                	ld	a3,0(a4)
    8000684e:	00968763          	beq	a3,s1,8000685c <freelock+0x3a>
  for (i = 0; i < NLOCK; i++) {
    80006852:	2785                	addiw	a5,a5,1
    80006854:	0721                	addi	a4,a4,8
    80006856:	fec79be3          	bne	a5,a2,8000684c <freelock+0x2a>
    8000685a:	a809                	j	8000686c <freelock+0x4a>
      locks[i] = 0;
    8000685c:	078e                	slli	a5,a5,0x3
    8000685e:	00020717          	auipc	a4,0x20
    80006862:	22a70713          	addi	a4,a4,554 # 80026a88 <locks>
    80006866:	97ba                	add	a5,a5,a4
    80006868:	0007b023          	sd	zero,0(a5)
  release(&lock_locks);
    8000686c:	00020517          	auipc	a0,0x20
    80006870:	1fc50513          	addi	a0,a0,508 # 80026a68 <lock_locks>
    80006874:	00000097          	auipc	ra,0x0
    80006878:	f66080e7          	jalr	-154(ra) # 800067da <release>
}
    8000687c:	60e2                	ld	ra,24(sp)
    8000687e:	6442                	ld	s0,16(sp)
    80006880:	64a2                	ld	s1,8(sp)
    80006882:	6105                	addi	sp,sp,32
    80006884:	8082                	ret

0000000080006886 <initlock>:
{
    80006886:	1101                	addi	sp,sp,-32
    80006888:	ec06                	sd	ra,24(sp)
    8000688a:	e822                	sd	s0,16(sp)
    8000688c:	e426                	sd	s1,8(sp)
    8000688e:	1000                	addi	s0,sp,32
    80006890:	84aa                	mv	s1,a0
  lk->name = name;
    80006892:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006894:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006898:	00053823          	sd	zero,16(a0)
  lk->nts = 0;
    8000689c:	00052c23          	sw	zero,24(a0)
  lk->n = 0;
    800068a0:	00052e23          	sw	zero,28(a0)
  acquire(&lock_locks);
    800068a4:	00020517          	auipc	a0,0x20
    800068a8:	1c450513          	addi	a0,a0,452 # 80026a68 <lock_locks>
    800068ac:	00000097          	auipc	ra,0x0
    800068b0:	e5e080e7          	jalr	-418(ra) # 8000670a <acquire>
  for (i = 0; i < NLOCK; i++) {
    800068b4:	00020717          	auipc	a4,0x20
    800068b8:	1d470713          	addi	a4,a4,468 # 80026a88 <locks>
    800068bc:	4781                	li	a5,0
    800068be:	1f400693          	li	a3,500
    if(locks[i] == 0) {
    800068c2:	6310                	ld	a2,0(a4)
    800068c4:	ce09                	beqz	a2,800068de <initlock+0x58>
  for (i = 0; i < NLOCK; i++) {
    800068c6:	2785                	addiw	a5,a5,1
    800068c8:	0721                	addi	a4,a4,8
    800068ca:	fed79ce3          	bne	a5,a3,800068c2 <initlock+0x3c>
  panic("findslot");
    800068ce:	00002517          	auipc	a0,0x2
    800068d2:	fd250513          	addi	a0,a0,-46 # 800088a0 <digits+0x50>
    800068d6:	00000097          	auipc	ra,0x0
    800068da:	900080e7          	jalr	-1792(ra) # 800061d6 <panic>
      locks[i] = lk;
    800068de:	078e                	slli	a5,a5,0x3
    800068e0:	00020717          	auipc	a4,0x20
    800068e4:	1a870713          	addi	a4,a4,424 # 80026a88 <locks>
    800068e8:	97ba                	add	a5,a5,a4
    800068ea:	e384                	sd	s1,0(a5)
      release(&lock_locks);
    800068ec:	00020517          	auipc	a0,0x20
    800068f0:	17c50513          	addi	a0,a0,380 # 80026a68 <lock_locks>
    800068f4:	00000097          	auipc	ra,0x0
    800068f8:	ee6080e7          	jalr	-282(ra) # 800067da <release>
}
    800068fc:	60e2                	ld	ra,24(sp)
    800068fe:	6442                	ld	s0,16(sp)
    80006900:	64a2                	ld	s1,8(sp)
    80006902:	6105                	addi	sp,sp,32
    80006904:	8082                	ret

0000000080006906 <atomic_read4>:

// Read a shared 32-bit value without holding a lock
int
atomic_read4(int *addr) {
    80006906:	1141                	addi	sp,sp,-16
    80006908:	e422                	sd	s0,8(sp)
    8000690a:	0800                	addi	s0,sp,16
  uint32 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    8000690c:	0ff0000f          	fence
    80006910:	4108                	lw	a0,0(a0)
    80006912:	0ff0000f          	fence
  return val;
}
    80006916:	2501                	sext.w	a0,a0
    80006918:	6422                	ld	s0,8(sp)
    8000691a:	0141                	addi	sp,sp,16
    8000691c:	8082                	ret

000000008000691e <snprint_lock>:
#ifdef LAB_LOCK
int
snprint_lock(char *buf, int sz, struct spinlock *lk)
{
  int n = 0;
  if(lk->n > 0) {
    8000691e:	4e5c                	lw	a5,28(a2)
    80006920:	00f04463          	bgtz	a5,80006928 <snprint_lock+0xa>
  int n = 0;
    80006924:	4501                	li	a0,0
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
                 lk->name, lk->nts, lk->n);
  }
  return n;
}
    80006926:	8082                	ret
{
    80006928:	1141                	addi	sp,sp,-16
    8000692a:	e406                	sd	ra,8(sp)
    8000692c:	e022                	sd	s0,0(sp)
    8000692e:	0800                	addi	s0,sp,16
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
    80006930:	4e18                	lw	a4,24(a2)
    80006932:	6614                	ld	a3,8(a2)
    80006934:	00002617          	auipc	a2,0x2
    80006938:	f7c60613          	addi	a2,a2,-132 # 800088b0 <digits+0x60>
    8000693c:	fffff097          	auipc	ra,0xfffff
    80006940:	1fa080e7          	jalr	506(ra) # 80005b36 <snprintf>
}
    80006944:	60a2                	ld	ra,8(sp)
    80006946:	6402                	ld	s0,0(sp)
    80006948:	0141                	addi	sp,sp,16
    8000694a:	8082                	ret

000000008000694c <statslock>:

int
statslock(char *buf, int sz) {
    8000694c:	7159                	addi	sp,sp,-112
    8000694e:	f486                	sd	ra,104(sp)
    80006950:	f0a2                	sd	s0,96(sp)
    80006952:	eca6                	sd	s1,88(sp)
    80006954:	e8ca                	sd	s2,80(sp)
    80006956:	e4ce                	sd	s3,72(sp)
    80006958:	e0d2                	sd	s4,64(sp)
    8000695a:	fc56                	sd	s5,56(sp)
    8000695c:	f85a                	sd	s6,48(sp)
    8000695e:	f45e                	sd	s7,40(sp)
    80006960:	f062                	sd	s8,32(sp)
    80006962:	ec66                	sd	s9,24(sp)
    80006964:	e86a                	sd	s10,16(sp)
    80006966:	e46e                	sd	s11,8(sp)
    80006968:	1880                	addi	s0,sp,112
    8000696a:	8aaa                	mv	s5,a0
    8000696c:	8b2e                	mv	s6,a1
  int n;
  int tot = 0;

  acquire(&lock_locks);
    8000696e:	00020517          	auipc	a0,0x20
    80006972:	0fa50513          	addi	a0,a0,250 # 80026a68 <lock_locks>
    80006976:	00000097          	auipc	ra,0x0
    8000697a:	d94080e7          	jalr	-620(ra) # 8000670a <acquire>
  n = snprintf(buf, sz, "--- lock kmem/bcache stats\n");
    8000697e:	00002617          	auipc	a2,0x2
    80006982:	f6260613          	addi	a2,a2,-158 # 800088e0 <digits+0x90>
    80006986:	85da                	mv	a1,s6
    80006988:	8556                	mv	a0,s5
    8000698a:	fffff097          	auipc	ra,0xfffff
    8000698e:	1ac080e7          	jalr	428(ra) # 80005b36 <snprintf>
    80006992:	892a                	mv	s2,a0
  for(int i = 0; i < NLOCK; i++) {
    80006994:	00020c97          	auipc	s9,0x20
    80006998:	0f4c8c93          	addi	s9,s9,244 # 80026a88 <locks>
    8000699c:	00021c17          	auipc	s8,0x21
    800069a0:	08cc0c13          	addi	s8,s8,140 # 80027a28 <end>
  n = snprintf(buf, sz, "--- lock kmem/bcache stats\n");
    800069a4:	84e6                	mv	s1,s9
  int tot = 0;
    800069a6:	4a01                	li	s4,0
    if(locks[i] == 0)
      break;
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    800069a8:	00002b97          	auipc	s7,0x2
    800069ac:	b18b8b93          	addi	s7,s7,-1256 # 800084c0 <syscalls+0xb0>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    800069b0:	00001d17          	auipc	s10,0x1
    800069b4:	668d0d13          	addi	s10,s10,1640 # 80008018 <etext+0x18>
    800069b8:	a01d                	j	800069de <statslock+0x92>
      tot += locks[i]->nts;
    800069ba:	0009b603          	ld	a2,0(s3)
    800069be:	4e1c                	lw	a5,24(a2)
    800069c0:	01478a3b          	addw	s4,a5,s4
      n += snprint_lock(buf +n, sz-n, locks[i]);
    800069c4:	412b05bb          	subw	a1,s6,s2
    800069c8:	012a8533          	add	a0,s5,s2
    800069cc:	00000097          	auipc	ra,0x0
    800069d0:	f52080e7          	jalr	-174(ra) # 8000691e <snprint_lock>
    800069d4:	0125093b          	addw	s2,a0,s2
  for(int i = 0; i < NLOCK; i++) {
    800069d8:	04a1                	addi	s1,s1,8
    800069da:	05848763          	beq	s1,s8,80006a28 <statslock+0xdc>
    if(locks[i] == 0)
    800069de:	89a6                	mv	s3,s1
    800069e0:	609c                	ld	a5,0(s1)
    800069e2:	c3b9                	beqz	a5,80006a28 <statslock+0xdc>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    800069e4:	0087bd83          	ld	s11,8(a5)
    800069e8:	855e                	mv	a0,s7
    800069ea:	ffffa097          	auipc	ra,0xffffa
    800069ee:	a0a080e7          	jalr	-1526(ra) # 800003f4 <strlen>
    800069f2:	0005061b          	sext.w	a2,a0
    800069f6:	85de                	mv	a1,s7
    800069f8:	856e                	mv	a0,s11
    800069fa:	ffffa097          	auipc	ra,0xffffa
    800069fe:	94e080e7          	jalr	-1714(ra) # 80000348 <strncmp>
    80006a02:	dd45                	beqz	a0,800069ba <statslock+0x6e>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    80006a04:	609c                	ld	a5,0(s1)
    80006a06:	0087bd83          	ld	s11,8(a5)
    80006a0a:	856a                	mv	a0,s10
    80006a0c:	ffffa097          	auipc	ra,0xffffa
    80006a10:	9e8080e7          	jalr	-1560(ra) # 800003f4 <strlen>
    80006a14:	0005061b          	sext.w	a2,a0
    80006a18:	85ea                	mv	a1,s10
    80006a1a:	856e                	mv	a0,s11
    80006a1c:	ffffa097          	auipc	ra,0xffffa
    80006a20:	92c080e7          	jalr	-1748(ra) # 80000348 <strncmp>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80006a24:	f955                	bnez	a0,800069d8 <statslock+0x8c>
    80006a26:	bf51                	j	800069ba <statslock+0x6e>
    }
  }
  
  n += snprintf(buf+n, sz-n, "--- top 5 contended locks:\n");
    80006a28:	00002617          	auipc	a2,0x2
    80006a2c:	ed860613          	addi	a2,a2,-296 # 80008900 <digits+0xb0>
    80006a30:	412b05bb          	subw	a1,s6,s2
    80006a34:	012a8533          	add	a0,s5,s2
    80006a38:	fffff097          	auipc	ra,0xfffff
    80006a3c:	0fe080e7          	jalr	254(ra) # 80005b36 <snprintf>
    80006a40:	012509bb          	addw	s3,a0,s2
    80006a44:	4b95                	li	s7,5
  int last = 100000000;
    80006a46:	05f5e537          	lui	a0,0x5f5e
    80006a4a:	10050513          	addi	a0,a0,256 # 5f5e100 <_entry-0x7a0a1f00>
  // stupid way to compute top 5 contended locks
  for(int t = 0; t < 5; t++) {
    int top = 0;
    for(int i = 0; i < NLOCK; i++) {
    80006a4e:	4c01                	li	s8,0
      if(locks[i] == 0)
        break;
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80006a50:	00020497          	auipc	s1,0x20
    80006a54:	03848493          	addi	s1,s1,56 # 80026a88 <locks>
    for(int i = 0; i < NLOCK; i++) {
    80006a58:	1f400913          	li	s2,500
    80006a5c:	a881                	j	80006aac <statslock+0x160>
    80006a5e:	2705                	addiw	a4,a4,1
    80006a60:	06a1                	addi	a3,a3,8
    80006a62:	03270063          	beq	a4,s2,80006a82 <statslock+0x136>
      if(locks[i] == 0)
    80006a66:	629c                	ld	a5,0(a3)
    80006a68:	cf89                	beqz	a5,80006a82 <statslock+0x136>
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    80006a6a:	4f90                	lw	a2,24(a5)
    80006a6c:	00359793          	slli	a5,a1,0x3
    80006a70:	97a6                	add	a5,a5,s1
    80006a72:	639c                	ld	a5,0(a5)
    80006a74:	4f9c                	lw	a5,24(a5)
    80006a76:	fec7d4e3          	bge	a5,a2,80006a5e <statslock+0x112>
    80006a7a:	fea652e3          	bge	a2,a0,80006a5e <statslock+0x112>
    80006a7e:	85ba                	mv	a1,a4
    80006a80:	bff9                	j	80006a5e <statslock+0x112>
        top = i;
      }
    }
    n += snprint_lock(buf+n, sz-n, locks[top]);
    80006a82:	058e                	slli	a1,a1,0x3
    80006a84:	00b48d33          	add	s10,s1,a1
    80006a88:	000d3603          	ld	a2,0(s10)
    80006a8c:	413b05bb          	subw	a1,s6,s3
    80006a90:	013a8533          	add	a0,s5,s3
    80006a94:	00000097          	auipc	ra,0x0
    80006a98:	e8a080e7          	jalr	-374(ra) # 8000691e <snprint_lock>
    80006a9c:	013509bb          	addw	s3,a0,s3
    last = locks[top]->nts;
    80006aa0:	000d3783          	ld	a5,0(s10)
    80006aa4:	4f88                	lw	a0,24(a5)
  for(int t = 0; t < 5; t++) {
    80006aa6:	3bfd                	addiw	s7,s7,-1
    80006aa8:	000b8663          	beqz	s7,80006ab4 <statslock+0x168>
  int tot = 0;
    80006aac:	86e6                	mv	a3,s9
    for(int i = 0; i < NLOCK; i++) {
    80006aae:	8762                	mv	a4,s8
    int top = 0;
    80006ab0:	85e2                	mv	a1,s8
    80006ab2:	bf55                	j	80006a66 <statslock+0x11a>
  }
  n += snprintf(buf+n, sz-n, "tot= %d\n", tot);
    80006ab4:	86d2                	mv	a3,s4
    80006ab6:	00002617          	auipc	a2,0x2
    80006aba:	e6a60613          	addi	a2,a2,-406 # 80008920 <digits+0xd0>
    80006abe:	413b05bb          	subw	a1,s6,s3
    80006ac2:	013a8533          	add	a0,s5,s3
    80006ac6:	fffff097          	auipc	ra,0xfffff
    80006aca:	070080e7          	jalr	112(ra) # 80005b36 <snprintf>
    80006ace:	013509bb          	addw	s3,a0,s3
  release(&lock_locks);  
    80006ad2:	00020517          	auipc	a0,0x20
    80006ad6:	f9650513          	addi	a0,a0,-106 # 80026a68 <lock_locks>
    80006ada:	00000097          	auipc	ra,0x0
    80006ade:	d00080e7          	jalr	-768(ra) # 800067da <release>
  return n;
}
    80006ae2:	854e                	mv	a0,s3
    80006ae4:	70a6                	ld	ra,104(sp)
    80006ae6:	7406                	ld	s0,96(sp)
    80006ae8:	64e6                	ld	s1,88(sp)
    80006aea:	6946                	ld	s2,80(sp)
    80006aec:	69a6                	ld	s3,72(sp)
    80006aee:	6a06                	ld	s4,64(sp)
    80006af0:	7ae2                	ld	s5,56(sp)
    80006af2:	7b42                	ld	s6,48(sp)
    80006af4:	7ba2                	ld	s7,40(sp)
    80006af6:	7c02                	ld	s8,32(sp)
    80006af8:	6ce2                	ld	s9,24(sp)
    80006afa:	6d42                	ld	s10,16(sp)
    80006afc:	6da2                	ld	s11,8(sp)
    80006afe:	6165                	addi	sp,sp,112
    80006b00:	8082                	ret
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
