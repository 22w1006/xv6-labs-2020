
user/_bcachetest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <createfile>:
  exit(0);
}

void
createfile(char *file, int nblock)
{
   0:	bd010113          	addi	sp,sp,-1072
   4:	42113423          	sd	ra,1064(sp)
   8:	42813023          	sd	s0,1056(sp)
   c:	40913c23          	sd	s1,1048(sp)
  10:	41213823          	sd	s2,1040(sp)
  14:	41313423          	sd	s3,1032(sp)
  18:	41413023          	sd	s4,1024(sp)
  1c:	43010413          	addi	s0,sp,1072
  20:	8a2a                	mv	s4,a0
  22:	89ae                	mv	s3,a1
  int fd;
  char buf[BSIZE];
  int i;
  
  fd = open(file, O_CREATE | O_RDWR);
  24:	20200593          	li	a1,514
  28:	00001097          	auipc	ra,0x1
  2c:	808080e7          	jalr	-2040(ra) # 830 <open>
  if(fd < 0){
  30:	04054a63          	bltz	a0,84 <createfile+0x84>
  34:	892a                	mv	s2,a0
    printf("createfile %s failed\n", file);
    exit(-1);
  }
  for(i = 0; i < nblock; i++) {
  36:	4481                	li	s1,0
  38:	03305263          	blez	s3,5c <createfile+0x5c>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)) {
  3c:	40000613          	li	a2,1024
  40:	bd040593          	addi	a1,s0,-1072
  44:	854a                	mv	a0,s2
  46:	00000097          	auipc	ra,0x0
  4a:	7ca080e7          	jalr	1994(ra) # 810 <write>
  4e:	40000793          	li	a5,1024
  52:	04f51763          	bne	a0,a5,a0 <createfile+0xa0>
  for(i = 0; i < nblock; i++) {
  56:	2485                	addiw	s1,s1,1
  58:	fe9992e3          	bne	s3,s1,3c <createfile+0x3c>
      printf("write %s failed\n", file);
      exit(-1);
    }
  }
  close(fd);
  5c:	854a                	mv	a0,s2
  5e:	00000097          	auipc	ra,0x0
  62:	7ba080e7          	jalr	1978(ra) # 818 <close>
}
  66:	42813083          	ld	ra,1064(sp)
  6a:	42013403          	ld	s0,1056(sp)
  6e:	41813483          	ld	s1,1048(sp)
  72:	41013903          	ld	s2,1040(sp)
  76:	40813983          	ld	s3,1032(sp)
  7a:	40013a03          	ld	s4,1024(sp)
  7e:	43010113          	addi	sp,sp,1072
  82:	8082                	ret
    printf("createfile %s failed\n", file);
  84:	85d2                	mv	a1,s4
  86:	00001517          	auipc	a0,0x1
  8a:	d0a50513          	addi	a0,a0,-758 # d90 <statistics+0x86>
  8e:	00001097          	auipc	ra,0x1
  92:	ada080e7          	jalr	-1318(ra) # b68 <printf>
    exit(-1);
  96:	557d                	li	a0,-1
  98:	00000097          	auipc	ra,0x0
  9c:	758080e7          	jalr	1880(ra) # 7f0 <exit>
      printf("write %s failed\n", file);
  a0:	85d2                	mv	a1,s4
  a2:	00001517          	auipc	a0,0x1
  a6:	d0650513          	addi	a0,a0,-762 # da8 <statistics+0x9e>
  aa:	00001097          	auipc	ra,0x1
  ae:	abe080e7          	jalr	-1346(ra) # b68 <printf>
      exit(-1);
  b2:	557d                	li	a0,-1
  b4:	00000097          	auipc	ra,0x0
  b8:	73c080e7          	jalr	1852(ra) # 7f0 <exit>

00000000000000bc <readfile>:

void
readfile(char *file, int nbytes, int inc)
{
  bc:	bc010113          	addi	sp,sp,-1088
  c0:	42113c23          	sd	ra,1080(sp)
  c4:	42813823          	sd	s0,1072(sp)
  c8:	42913423          	sd	s1,1064(sp)
  cc:	43213023          	sd	s2,1056(sp)
  d0:	41313c23          	sd	s3,1048(sp)
  d4:	41413823          	sd	s4,1040(sp)
  d8:	41513423          	sd	s5,1032(sp)
  dc:	44010413          	addi	s0,sp,1088
  char buf[BSIZE];
  int fd;
  int i;

  if(inc > BSIZE) {
  e0:	40000793          	li	a5,1024
  e4:	06c7c463          	blt	a5,a2,14c <readfile+0x90>
  e8:	8aaa                	mv	s5,a0
  ea:	8a2e                	mv	s4,a1
  ec:	84b2                	mv	s1,a2
    printf("readfile: inc too large\n");
    exit(-1);
  }
  if ((fd = open(file, O_RDONLY)) < 0) {
  ee:	4581                	li	a1,0
  f0:	00000097          	auipc	ra,0x0
  f4:	740080e7          	jalr	1856(ra) # 830 <open>
  f8:	89aa                	mv	s3,a0
  fa:	06054663          	bltz	a0,166 <readfile+0xaa>
    printf("readfile open %s failed\n", file);
    exit(-1);
  }
  for (i = 0; i < nbytes; i += inc) {
  fe:	4901                	li	s2,0
 100:	03405063          	blez	s4,120 <readfile+0x64>
    if(read(fd, buf, inc) != inc) {
 104:	8626                	mv	a2,s1
 106:	bc040593          	addi	a1,s0,-1088
 10a:	854e                	mv	a0,s3
 10c:	00000097          	auipc	ra,0x0
 110:	6fc080e7          	jalr	1788(ra) # 808 <read>
 114:	06951763          	bne	a0,s1,182 <readfile+0xc6>
  for (i = 0; i < nbytes; i += inc) {
 118:	0124893b          	addw	s2,s1,s2
 11c:	ff4944e3          	blt	s2,s4,104 <readfile+0x48>
      printf("read %s failed for block %d (%d)\n", file, i, nbytes);
      exit(-1);
    }
  }
  close(fd);
 120:	854e                	mv	a0,s3
 122:	00000097          	auipc	ra,0x0
 126:	6f6080e7          	jalr	1782(ra) # 818 <close>
}
 12a:	43813083          	ld	ra,1080(sp)
 12e:	43013403          	ld	s0,1072(sp)
 132:	42813483          	ld	s1,1064(sp)
 136:	42013903          	ld	s2,1056(sp)
 13a:	41813983          	ld	s3,1048(sp)
 13e:	41013a03          	ld	s4,1040(sp)
 142:	40813a83          	ld	s5,1032(sp)
 146:	44010113          	addi	sp,sp,1088
 14a:	8082                	ret
    printf("readfile: inc too large\n");
 14c:	00001517          	auipc	a0,0x1
 150:	c7450513          	addi	a0,a0,-908 # dc0 <statistics+0xb6>
 154:	00001097          	auipc	ra,0x1
 158:	a14080e7          	jalr	-1516(ra) # b68 <printf>
    exit(-1);
 15c:	557d                	li	a0,-1
 15e:	00000097          	auipc	ra,0x0
 162:	692080e7          	jalr	1682(ra) # 7f0 <exit>
    printf("readfile open %s failed\n", file);
 166:	85d6                	mv	a1,s5
 168:	00001517          	auipc	a0,0x1
 16c:	c7850513          	addi	a0,a0,-904 # de0 <statistics+0xd6>
 170:	00001097          	auipc	ra,0x1
 174:	9f8080e7          	jalr	-1544(ra) # b68 <printf>
    exit(-1);
 178:	557d                	li	a0,-1
 17a:	00000097          	auipc	ra,0x0
 17e:	676080e7          	jalr	1654(ra) # 7f0 <exit>
      printf("read %s failed for block %d (%d)\n", file, i, nbytes);
 182:	86d2                	mv	a3,s4
 184:	864a                	mv	a2,s2
 186:	85d6                	mv	a1,s5
 188:	00001517          	auipc	a0,0x1
 18c:	c7850513          	addi	a0,a0,-904 # e00 <statistics+0xf6>
 190:	00001097          	auipc	ra,0x1
 194:	9d8080e7          	jalr	-1576(ra) # b68 <printf>
      exit(-1);
 198:	557d                	li	a0,-1
 19a:	00000097          	auipc	ra,0x0
 19e:	656080e7          	jalr	1622(ra) # 7f0 <exit>

00000000000001a2 <ntas>:

int ntas(int print)
{
 1a2:	1101                	addi	sp,sp,-32
 1a4:	ec06                	sd	ra,24(sp)
 1a6:	e822                	sd	s0,16(sp)
 1a8:	e426                	sd	s1,8(sp)
 1aa:	e04a                	sd	s2,0(sp)
 1ac:	1000                	addi	s0,sp,32
 1ae:	892a                	mv	s2,a0
  int n;
  char *c;

  if (statistics(buf, SZ) <= 0) {
 1b0:	6585                	lui	a1,0x1
 1b2:	00001517          	auipc	a0,0x1
 1b6:	e5e50513          	addi	a0,a0,-418 # 1010 <buf>
 1ba:	00001097          	auipc	ra,0x1
 1be:	b50080e7          	jalr	-1200(ra) # d0a <statistics>
 1c2:	02a05b63          	blez	a0,1f8 <ntas+0x56>
    fprintf(2, "ntas: no stats\n");
  }
  c = strchr(buf, '=');
 1c6:	03d00593          	li	a1,61
 1ca:	00001517          	auipc	a0,0x1
 1ce:	e4650513          	addi	a0,a0,-442 # 1010 <buf>
 1d2:	00000097          	auipc	ra,0x0
 1d6:	440080e7          	jalr	1088(ra) # 612 <strchr>
  n = atoi(c+2);
 1da:	0509                	addi	a0,a0,2
 1dc:	00000097          	auipc	ra,0x0
 1e0:	514080e7          	jalr	1300(ra) # 6f0 <atoi>
 1e4:	84aa                	mv	s1,a0
  if(print)
 1e6:	02091363          	bnez	s2,20c <ntas+0x6a>
    printf("%s", buf);
  return n;
}
 1ea:	8526                	mv	a0,s1
 1ec:	60e2                	ld	ra,24(sp)
 1ee:	6442                	ld	s0,16(sp)
 1f0:	64a2                	ld	s1,8(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    fprintf(2, "ntas: no stats\n");
 1f8:	00001597          	auipc	a1,0x1
 1fc:	c3058593          	addi	a1,a1,-976 # e28 <statistics+0x11e>
 200:	4509                	li	a0,2
 202:	00001097          	auipc	ra,0x1
 206:	938080e7          	jalr	-1736(ra) # b3a <fprintf>
 20a:	bf75                	j	1c6 <ntas+0x24>
    printf("%s", buf);
 20c:	00001597          	auipc	a1,0x1
 210:	e0458593          	addi	a1,a1,-508 # 1010 <buf>
 214:	00001517          	auipc	a0,0x1
 218:	c2450513          	addi	a0,a0,-988 # e38 <statistics+0x12e>
 21c:	00001097          	auipc	ra,0x1
 220:	94c080e7          	jalr	-1716(ra) # b68 <printf>
 224:	b7d9                	j	1ea <ntas+0x48>

0000000000000226 <test0>:

// Test reading small files concurrently
void
test0()
{
 226:	7139                	addi	sp,sp,-64
 228:	fc06                	sd	ra,56(sp)
 22a:	f822                	sd	s0,48(sp)
 22c:	f426                	sd	s1,40(sp)
 22e:	f04a                	sd	s2,32(sp)
 230:	ec4e                	sd	s3,24(sp)
 232:	0080                	addi	s0,sp,64
  char file[2];
  char dir[2];
  enum { N = 10, NCHILD = 3 };
  int m, n;

  dir[0] = '0';
 234:	03000793          	li	a5,48
 238:	fcf40023          	sb	a5,-64(s0)
  dir[1] = '\0';
 23c:	fc0400a3          	sb	zero,-63(s0)
  file[0] = 'F';
 240:	04600793          	li	a5,70
 244:	fcf40423          	sb	a5,-56(s0)
  file[1] = '\0';
 248:	fc0404a3          	sb	zero,-55(s0)

  printf("start test0\n");
 24c:	00001517          	auipc	a0,0x1
 250:	bf450513          	addi	a0,a0,-1036 # e40 <statistics+0x136>
 254:	00001097          	auipc	ra,0x1
 258:	914080e7          	jalr	-1772(ra) # b68 <printf>
 25c:	03000493          	li	s1,48
      printf("chdir failed\n");
      exit(1);
    }
    unlink(file);
    createfile(file, N);
    if (chdir("..") < 0) {
 260:	00001997          	auipc	s3,0x1
 264:	c0098993          	addi	s3,s3,-1024 # e60 <statistics+0x156>
  for(int i = 0; i < NCHILD; i++){
 268:	03300913          	li	s2,51
    dir[0] = '0' + i;
 26c:	fc940023          	sb	s1,-64(s0)
    mkdir(dir);
 270:	fc040513          	addi	a0,s0,-64
 274:	00000097          	auipc	ra,0x0
 278:	5e4080e7          	jalr	1508(ra) # 858 <mkdir>
    if (chdir(dir) < 0) {
 27c:	fc040513          	addi	a0,s0,-64
 280:	00000097          	auipc	ra,0x0
 284:	5e0080e7          	jalr	1504(ra) # 860 <chdir>
 288:	0c054463          	bltz	a0,350 <test0+0x12a>
    unlink(file);
 28c:	fc840513          	addi	a0,s0,-56
 290:	00000097          	auipc	ra,0x0
 294:	5b0080e7          	jalr	1456(ra) # 840 <unlink>
    createfile(file, N);
 298:	45a9                	li	a1,10
 29a:	fc840513          	addi	a0,s0,-56
 29e:	00000097          	auipc	ra,0x0
 2a2:	d62080e7          	jalr	-670(ra) # 0 <createfile>
    if (chdir("..") < 0) {
 2a6:	854e                	mv	a0,s3
 2a8:	00000097          	auipc	ra,0x0
 2ac:	5b8080e7          	jalr	1464(ra) # 860 <chdir>
 2b0:	0a054d63          	bltz	a0,36a <test0+0x144>
  for(int i = 0; i < NCHILD; i++){
 2b4:	2485                	addiw	s1,s1,1
 2b6:	0ff4f493          	andi	s1,s1,255
 2ba:	fb2499e3          	bne	s1,s2,26c <test0+0x46>
      printf("chdir failed\n");
      exit(1);
    }
  }
  m = ntas(0);
 2be:	4501                	li	a0,0
 2c0:	00000097          	auipc	ra,0x0
 2c4:	ee2080e7          	jalr	-286(ra) # 1a2 <ntas>
 2c8:	892a                	mv	s2,a0
 2ca:	03000493          	li	s1,48
  for(int i = 0; i < NCHILD; i++){
 2ce:	03300993          	li	s3,51
    dir[0] = '0' + i;
 2d2:	fc940023          	sb	s1,-64(s0)
    int pid = fork();
 2d6:	00000097          	auipc	ra,0x0
 2da:	512080e7          	jalr	1298(ra) # 7e8 <fork>
    if(pid < 0){
 2de:	0a054363          	bltz	a0,384 <test0+0x15e>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
 2e2:	cd55                	beqz	a0,39e <test0+0x178>
  for(int i = 0; i < NCHILD; i++){
 2e4:	2485                	addiw	s1,s1,1
 2e6:	0ff4f493          	andi	s1,s1,255
 2ea:	ff3494e3          	bne	s1,s3,2d2 <test0+0xac>
      exit(0);
    }
  }

  for(int i = 0; i < NCHILD; i++){
    wait(0);
 2ee:	4501                	li	a0,0
 2f0:	00000097          	auipc	ra,0x0
 2f4:	508080e7          	jalr	1288(ra) # 7f8 <wait>
 2f8:	4501                	li	a0,0
 2fa:	00000097          	auipc	ra,0x0
 2fe:	4fe080e7          	jalr	1278(ra) # 7f8 <wait>
 302:	4501                	li	a0,0
 304:	00000097          	auipc	ra,0x0
 308:	4f4080e7          	jalr	1268(ra) # 7f8 <wait>
  }
  printf("test0 results:\n");
 30c:	00001517          	auipc	a0,0x1
 310:	b6c50513          	addi	a0,a0,-1172 # e78 <statistics+0x16e>
 314:	00001097          	auipc	ra,0x1
 318:	854080e7          	jalr	-1964(ra) # b68 <printf>
  n = ntas(1);
 31c:	4505                	li	a0,1
 31e:	00000097          	auipc	ra,0x0
 322:	e84080e7          	jalr	-380(ra) # 1a2 <ntas>
  if (n-m < 500)
 326:	4125053b          	subw	a0,a0,s2
 32a:	1f300793          	li	a5,499
 32e:	0aa7cc63          	blt	a5,a0,3e6 <test0+0x1c0>
    printf("test0: OK\n");
 332:	00001517          	auipc	a0,0x1
 336:	b5650513          	addi	a0,a0,-1194 # e88 <statistics+0x17e>
 33a:	00001097          	auipc	ra,0x1
 33e:	82e080e7          	jalr	-2002(ra) # b68 <printf>
  else
    printf("test0: FAIL\n");
}
 342:	70e2                	ld	ra,56(sp)
 344:	7442                	ld	s0,48(sp)
 346:	74a2                	ld	s1,40(sp)
 348:	7902                	ld	s2,32(sp)
 34a:	69e2                	ld	s3,24(sp)
 34c:	6121                	addi	sp,sp,64
 34e:	8082                	ret
      printf("chdir failed\n");
 350:	00001517          	auipc	a0,0x1
 354:	b0050513          	addi	a0,a0,-1280 # e50 <statistics+0x146>
 358:	00001097          	auipc	ra,0x1
 35c:	810080e7          	jalr	-2032(ra) # b68 <printf>
      exit(1);
 360:	4505                	li	a0,1
 362:	00000097          	auipc	ra,0x0
 366:	48e080e7          	jalr	1166(ra) # 7f0 <exit>
      printf("chdir failed\n");
 36a:	00001517          	auipc	a0,0x1
 36e:	ae650513          	addi	a0,a0,-1306 # e50 <statistics+0x146>
 372:	00000097          	auipc	ra,0x0
 376:	7f6080e7          	jalr	2038(ra) # b68 <printf>
      exit(1);
 37a:	4505                	li	a0,1
 37c:	00000097          	auipc	ra,0x0
 380:	474080e7          	jalr	1140(ra) # 7f0 <exit>
      printf("fork failed");
 384:	00001517          	auipc	a0,0x1
 388:	ae450513          	addi	a0,a0,-1308 # e68 <statistics+0x15e>
 38c:	00000097          	auipc	ra,0x0
 390:	7dc080e7          	jalr	2012(ra) # b68 <printf>
      exit(-1);
 394:	557d                	li	a0,-1
 396:	00000097          	auipc	ra,0x0
 39a:	45a080e7          	jalr	1114(ra) # 7f0 <exit>
      if (chdir(dir) < 0) {
 39e:	fc040513          	addi	a0,s0,-64
 3a2:	00000097          	auipc	ra,0x0
 3a6:	4be080e7          	jalr	1214(ra) # 860 <chdir>
 3aa:	02054163          	bltz	a0,3cc <test0+0x1a6>
      readfile(file, N*BSIZE, 1);
 3ae:	4605                	li	a2,1
 3b0:	658d                	lui	a1,0x3
 3b2:	80058593          	addi	a1,a1,-2048 # 2800 <base+0x7f0>
 3b6:	fc840513          	addi	a0,s0,-56
 3ba:	00000097          	auipc	ra,0x0
 3be:	d02080e7          	jalr	-766(ra) # bc <readfile>
      exit(0);
 3c2:	4501                	li	a0,0
 3c4:	00000097          	auipc	ra,0x0
 3c8:	42c080e7          	jalr	1068(ra) # 7f0 <exit>
        printf("chdir failed\n");
 3cc:	00001517          	auipc	a0,0x1
 3d0:	a8450513          	addi	a0,a0,-1404 # e50 <statistics+0x146>
 3d4:	00000097          	auipc	ra,0x0
 3d8:	794080e7          	jalr	1940(ra) # b68 <printf>
        exit(1);
 3dc:	4505                	li	a0,1
 3de:	00000097          	auipc	ra,0x0
 3e2:	412080e7          	jalr	1042(ra) # 7f0 <exit>
    printf("test0: FAIL\n");
 3e6:	00001517          	auipc	a0,0x1
 3ea:	ab250513          	addi	a0,a0,-1358 # e98 <statistics+0x18e>
 3ee:	00000097          	auipc	ra,0x0
 3f2:	77a080e7          	jalr	1914(ra) # b68 <printf>
}
 3f6:	b7b1                	j	342 <test0+0x11c>

00000000000003f8 <test1>:

// Test bcache evictions by reading a large file concurrently
void test1()
{
 3f8:	7179                	addi	sp,sp,-48
 3fa:	f406                	sd	ra,40(sp)
 3fc:	f022                	sd	s0,32(sp)
 3fe:	ec26                	sd	s1,24(sp)
 400:	e84a                	sd	s2,16(sp)
 402:	1800                	addi	s0,sp,48
  char file[3];
  enum { N = 200, BIG=100, NCHILD=2 };
  
  printf("start test1\n");
 404:	00001517          	auipc	a0,0x1
 408:	aa450513          	addi	a0,a0,-1372 # ea8 <statistics+0x19e>
 40c:	00000097          	auipc	ra,0x0
 410:	75c080e7          	jalr	1884(ra) # b68 <printf>
  file[0] = 'B';
 414:	04200793          	li	a5,66
 418:	fcf40c23          	sb	a5,-40(s0)
  file[2] = '\0';
 41c:	fc040d23          	sb	zero,-38(s0)
 420:	4485                	li	s1,1
  for(int i = 0; i < NCHILD; i++){
    file[1] = '0' + i;
    unlink(file);
    if (i == 0) {
 422:	4905                	li	s2,1
 424:	a811                	j	438 <test1+0x40>
      createfile(file, BIG);
 426:	06400593          	li	a1,100
 42a:	fd840513          	addi	a0,s0,-40
 42e:	00000097          	auipc	ra,0x0
 432:	bd2080e7          	jalr	-1070(ra) # 0 <createfile>
  for(int i = 0; i < NCHILD; i++){
 436:	2485                	addiw	s1,s1,1
    file[1] = '0' + i;
 438:	02f4879b          	addiw	a5,s1,47
 43c:	fcf40ca3          	sb	a5,-39(s0)
    unlink(file);
 440:	fd840513          	addi	a0,s0,-40
 444:	00000097          	auipc	ra,0x0
 448:	3fc080e7          	jalr	1020(ra) # 840 <unlink>
    if (i == 0) {
 44c:	fd248de3          	beq	s1,s2,426 <test1+0x2e>
    } else {
      createfile(file, 1);
 450:	85ca                	mv	a1,s2
 452:	fd840513          	addi	a0,s0,-40
 456:	00000097          	auipc	ra,0x0
 45a:	baa080e7          	jalr	-1110(ra) # 0 <createfile>
  for(int i = 0; i < NCHILD; i++){
 45e:	0004879b          	sext.w	a5,s1
 462:	fcf95ae3          	bge	s2,a5,436 <test1+0x3e>
    }
  }
  for(int i = 0; i < NCHILD; i++){
    file[1] = '0' + i;
 466:	03000793          	li	a5,48
 46a:	fcf40ca3          	sb	a5,-39(s0)
    int pid = fork();
 46e:	00000097          	auipc	ra,0x0
 472:	37a080e7          	jalr	890(ra) # 7e8 <fork>
    if(pid < 0){
 476:	04054663          	bltz	a0,4c2 <test1+0xca>
      printf("fork failed");
      exit(-1);
    }
    if(pid == 0){
 47a:	c12d                	beqz	a0,4dc <test1+0xe4>
    file[1] = '0' + i;
 47c:	03100793          	li	a5,49
 480:	fcf40ca3          	sb	a5,-39(s0)
    int pid = fork();
 484:	00000097          	auipc	ra,0x0
 488:	364080e7          	jalr	868(ra) # 7e8 <fork>
    if(pid < 0){
 48c:	02054b63          	bltz	a0,4c2 <test1+0xca>
    if(pid == 0){
 490:	cd35                	beqz	a0,50c <test1+0x114>
      exit(0);
    }
  }

  for(int i = 0; i < NCHILD; i++){
    wait(0);
 492:	4501                	li	a0,0
 494:	00000097          	auipc	ra,0x0
 498:	364080e7          	jalr	868(ra) # 7f8 <wait>
 49c:	4501                	li	a0,0
 49e:	00000097          	auipc	ra,0x0
 4a2:	35a080e7          	jalr	858(ra) # 7f8 <wait>
  }
  printf("test1 OK\n");
 4a6:	00001517          	auipc	a0,0x1
 4aa:	a1250513          	addi	a0,a0,-1518 # eb8 <statistics+0x1ae>
 4ae:	00000097          	auipc	ra,0x0
 4b2:	6ba080e7          	jalr	1722(ra) # b68 <printf>
}
 4b6:	70a2                	ld	ra,40(sp)
 4b8:	7402                	ld	s0,32(sp)
 4ba:	64e2                	ld	s1,24(sp)
 4bc:	6942                	ld	s2,16(sp)
 4be:	6145                	addi	sp,sp,48
 4c0:	8082                	ret
      printf("fork failed");
 4c2:	00001517          	auipc	a0,0x1
 4c6:	9a650513          	addi	a0,a0,-1626 # e68 <statistics+0x15e>
 4ca:	00000097          	auipc	ra,0x0
 4ce:	69e080e7          	jalr	1694(ra) # b68 <printf>
      exit(-1);
 4d2:	557d                	li	a0,-1
 4d4:	00000097          	auipc	ra,0x0
 4d8:	31c080e7          	jalr	796(ra) # 7f0 <exit>
    if(pid == 0){
 4dc:	0c800493          	li	s1,200
          readfile(file, BIG*BSIZE, BSIZE);
 4e0:	40000613          	li	a2,1024
 4e4:	65e5                	lui	a1,0x19
 4e6:	fd840513          	addi	a0,s0,-40
 4ea:	00000097          	auipc	ra,0x0
 4ee:	bd2080e7          	jalr	-1070(ra) # bc <readfile>
        for (i = 0; i < N; i++) {
 4f2:	34fd                	addiw	s1,s1,-1
 4f4:	f4f5                	bnez	s1,4e0 <test1+0xe8>
        unlink(file);
 4f6:	fd840513          	addi	a0,s0,-40
 4fa:	00000097          	auipc	ra,0x0
 4fe:	346080e7          	jalr	838(ra) # 840 <unlink>
        exit(0);
 502:	4501                	li	a0,0
 504:	00000097          	auipc	ra,0x0
 508:	2ec080e7          	jalr	748(ra) # 7f0 <exit>
 50c:	6485                	lui	s1,0x1
 50e:	fa048493          	addi	s1,s1,-96 # fa0 <digits+0xd0>
          readfile(file, 1, BSIZE);
 512:	40000613          	li	a2,1024
 516:	4585                	li	a1,1
 518:	fd840513          	addi	a0,s0,-40
 51c:	00000097          	auipc	ra,0x0
 520:	ba0080e7          	jalr	-1120(ra) # bc <readfile>
        for (i = 0; i < N*20; i++) {
 524:	34fd                	addiw	s1,s1,-1
 526:	f4f5                	bnez	s1,512 <test1+0x11a>
        unlink(file);
 528:	fd840513          	addi	a0,s0,-40
 52c:	00000097          	auipc	ra,0x0
 530:	314080e7          	jalr	788(ra) # 840 <unlink>
      exit(0);
 534:	4501                	li	a0,0
 536:	00000097          	auipc	ra,0x0
 53a:	2ba080e7          	jalr	698(ra) # 7f0 <exit>

000000000000053e <main>:
{
 53e:	1141                	addi	sp,sp,-16
 540:	e406                	sd	ra,8(sp)
 542:	e022                	sd	s0,0(sp)
 544:	0800                	addi	s0,sp,16
  test0();
 546:	00000097          	auipc	ra,0x0
 54a:	ce0080e7          	jalr	-800(ra) # 226 <test0>
  test1();
 54e:	00000097          	auipc	ra,0x0
 552:	eaa080e7          	jalr	-342(ra) # 3f8 <test1>
  exit(0);
 556:	4501                	li	a0,0
 558:	00000097          	auipc	ra,0x0
 55c:	298080e7          	jalr	664(ra) # 7f0 <exit>

0000000000000560 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 560:	1141                	addi	sp,sp,-16
 562:	e406                	sd	ra,8(sp)
 564:	e022                	sd	s0,0(sp)
 566:	0800                	addi	s0,sp,16
  extern int main();
  main();
 568:	00000097          	auipc	ra,0x0
 56c:	fd6080e7          	jalr	-42(ra) # 53e <main>
  exit(0);
 570:	4501                	li	a0,0
 572:	00000097          	auipc	ra,0x0
 576:	27e080e7          	jalr	638(ra) # 7f0 <exit>

000000000000057a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 57a:	1141                	addi	sp,sp,-16
 57c:	e422                	sd	s0,8(sp)
 57e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 580:	87aa                	mv	a5,a0
 582:	0585                	addi	a1,a1,1
 584:	0785                	addi	a5,a5,1
 586:	fff5c703          	lbu	a4,-1(a1) # 18fff <base+0x16fef>
 58a:	fee78fa3          	sb	a4,-1(a5)
 58e:	fb75                	bnez	a4,582 <strcpy+0x8>
    ;
  return os;
}
 590:	6422                	ld	s0,8(sp)
 592:	0141                	addi	sp,sp,16
 594:	8082                	ret

0000000000000596 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 596:	1141                	addi	sp,sp,-16
 598:	e422                	sd	s0,8(sp)
 59a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 59c:	00054783          	lbu	a5,0(a0)
 5a0:	cb91                	beqz	a5,5b4 <strcmp+0x1e>
 5a2:	0005c703          	lbu	a4,0(a1)
 5a6:	00f71763          	bne	a4,a5,5b4 <strcmp+0x1e>
    p++, q++;
 5aa:	0505                	addi	a0,a0,1
 5ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 5ae:	00054783          	lbu	a5,0(a0)
 5b2:	fbe5                	bnez	a5,5a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 5b4:	0005c503          	lbu	a0,0(a1)
}
 5b8:	40a7853b          	subw	a0,a5,a0
 5bc:	6422                	ld	s0,8(sp)
 5be:	0141                	addi	sp,sp,16
 5c0:	8082                	ret

00000000000005c2 <strlen>:

uint
strlen(const char *s)
{
 5c2:	1141                	addi	sp,sp,-16
 5c4:	e422                	sd	s0,8(sp)
 5c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 5c8:	00054783          	lbu	a5,0(a0)
 5cc:	cf91                	beqz	a5,5e8 <strlen+0x26>
 5ce:	0505                	addi	a0,a0,1
 5d0:	87aa                	mv	a5,a0
 5d2:	4685                	li	a3,1
 5d4:	9e89                	subw	a3,a3,a0
 5d6:	00f6853b          	addw	a0,a3,a5
 5da:	0785                	addi	a5,a5,1
 5dc:	fff7c703          	lbu	a4,-1(a5)
 5e0:	fb7d                	bnez	a4,5d6 <strlen+0x14>
    ;
  return n;
}
 5e2:	6422                	ld	s0,8(sp)
 5e4:	0141                	addi	sp,sp,16
 5e6:	8082                	ret
  for(n = 0; s[n]; n++)
 5e8:	4501                	li	a0,0
 5ea:	bfe5                	j	5e2 <strlen+0x20>

00000000000005ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 5f2:	ce09                	beqz	a2,60c <memset+0x20>
 5f4:	87aa                	mv	a5,a0
 5f6:	fff6071b          	addiw	a4,a2,-1
 5fa:	1702                	slli	a4,a4,0x20
 5fc:	9301                	srli	a4,a4,0x20
 5fe:	0705                	addi	a4,a4,1
 600:	972a                	add	a4,a4,a0
    cdst[i] = c;
 602:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 606:	0785                	addi	a5,a5,1
 608:	fee79de3          	bne	a5,a4,602 <memset+0x16>
  }
  return dst;
}
 60c:	6422                	ld	s0,8(sp)
 60e:	0141                	addi	sp,sp,16
 610:	8082                	ret

0000000000000612 <strchr>:

char*
strchr(const char *s, char c)
{
 612:	1141                	addi	sp,sp,-16
 614:	e422                	sd	s0,8(sp)
 616:	0800                	addi	s0,sp,16
  for(; *s; s++)
 618:	00054783          	lbu	a5,0(a0)
 61c:	cb99                	beqz	a5,632 <strchr+0x20>
    if(*s == c)
 61e:	00f58763          	beq	a1,a5,62c <strchr+0x1a>
  for(; *s; s++)
 622:	0505                	addi	a0,a0,1
 624:	00054783          	lbu	a5,0(a0)
 628:	fbfd                	bnez	a5,61e <strchr+0xc>
      return (char*)s;
  return 0;
 62a:	4501                	li	a0,0
}
 62c:	6422                	ld	s0,8(sp)
 62e:	0141                	addi	sp,sp,16
 630:	8082                	ret
  return 0;
 632:	4501                	li	a0,0
 634:	bfe5                	j	62c <strchr+0x1a>

0000000000000636 <gets>:

char*
gets(char *buf, int max)
{
 636:	711d                	addi	sp,sp,-96
 638:	ec86                	sd	ra,88(sp)
 63a:	e8a2                	sd	s0,80(sp)
 63c:	e4a6                	sd	s1,72(sp)
 63e:	e0ca                	sd	s2,64(sp)
 640:	fc4e                	sd	s3,56(sp)
 642:	f852                	sd	s4,48(sp)
 644:	f456                	sd	s5,40(sp)
 646:	f05a                	sd	s6,32(sp)
 648:	ec5e                	sd	s7,24(sp)
 64a:	1080                	addi	s0,sp,96
 64c:	8baa                	mv	s7,a0
 64e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 650:	892a                	mv	s2,a0
 652:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 654:	4aa9                	li	s5,10
 656:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 658:	89a6                	mv	s3,s1
 65a:	2485                	addiw	s1,s1,1
 65c:	0344d863          	bge	s1,s4,68c <gets+0x56>
    cc = read(0, &c, 1);
 660:	4605                	li	a2,1
 662:	faf40593          	addi	a1,s0,-81
 666:	4501                	li	a0,0
 668:	00000097          	auipc	ra,0x0
 66c:	1a0080e7          	jalr	416(ra) # 808 <read>
    if(cc < 1)
 670:	00a05e63          	blez	a0,68c <gets+0x56>
    buf[i++] = c;
 674:	faf44783          	lbu	a5,-81(s0)
 678:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 67c:	01578763          	beq	a5,s5,68a <gets+0x54>
 680:	0905                	addi	s2,s2,1
 682:	fd679be3          	bne	a5,s6,658 <gets+0x22>
  for(i=0; i+1 < max; ){
 686:	89a6                	mv	s3,s1
 688:	a011                	j	68c <gets+0x56>
 68a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 68c:	99de                	add	s3,s3,s7
 68e:	00098023          	sb	zero,0(s3)
  return buf;
}
 692:	855e                	mv	a0,s7
 694:	60e6                	ld	ra,88(sp)
 696:	6446                	ld	s0,80(sp)
 698:	64a6                	ld	s1,72(sp)
 69a:	6906                	ld	s2,64(sp)
 69c:	79e2                	ld	s3,56(sp)
 69e:	7a42                	ld	s4,48(sp)
 6a0:	7aa2                	ld	s5,40(sp)
 6a2:	7b02                	ld	s6,32(sp)
 6a4:	6be2                	ld	s7,24(sp)
 6a6:	6125                	addi	sp,sp,96
 6a8:	8082                	ret

00000000000006aa <stat>:

int
stat(const char *n, struct stat *st)
{
 6aa:	1101                	addi	sp,sp,-32
 6ac:	ec06                	sd	ra,24(sp)
 6ae:	e822                	sd	s0,16(sp)
 6b0:	e426                	sd	s1,8(sp)
 6b2:	e04a                	sd	s2,0(sp)
 6b4:	1000                	addi	s0,sp,32
 6b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6b8:	4581                	li	a1,0
 6ba:	00000097          	auipc	ra,0x0
 6be:	176080e7          	jalr	374(ra) # 830 <open>
  if(fd < 0)
 6c2:	02054563          	bltz	a0,6ec <stat+0x42>
 6c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 6c8:	85ca                	mv	a1,s2
 6ca:	00000097          	auipc	ra,0x0
 6ce:	17e080e7          	jalr	382(ra) # 848 <fstat>
 6d2:	892a                	mv	s2,a0
  close(fd);
 6d4:	8526                	mv	a0,s1
 6d6:	00000097          	auipc	ra,0x0
 6da:	142080e7          	jalr	322(ra) # 818 <close>
  return r;
}
 6de:	854a                	mv	a0,s2
 6e0:	60e2                	ld	ra,24(sp)
 6e2:	6442                	ld	s0,16(sp)
 6e4:	64a2                	ld	s1,8(sp)
 6e6:	6902                	ld	s2,0(sp)
 6e8:	6105                	addi	sp,sp,32
 6ea:	8082                	ret
    return -1;
 6ec:	597d                	li	s2,-1
 6ee:	bfc5                	j	6de <stat+0x34>

00000000000006f0 <atoi>:

int
atoi(const char *s)
{
 6f0:	1141                	addi	sp,sp,-16
 6f2:	e422                	sd	s0,8(sp)
 6f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6f6:	00054603          	lbu	a2,0(a0)
 6fa:	fd06079b          	addiw	a5,a2,-48
 6fe:	0ff7f793          	andi	a5,a5,255
 702:	4725                	li	a4,9
 704:	02f76963          	bltu	a4,a5,736 <atoi+0x46>
 708:	86aa                	mv	a3,a0
  n = 0;
 70a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 70c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 70e:	0685                	addi	a3,a3,1
 710:	0025179b          	slliw	a5,a0,0x2
 714:	9fa9                	addw	a5,a5,a0
 716:	0017979b          	slliw	a5,a5,0x1
 71a:	9fb1                	addw	a5,a5,a2
 71c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 720:	0006c603          	lbu	a2,0(a3)
 724:	fd06071b          	addiw	a4,a2,-48
 728:	0ff77713          	andi	a4,a4,255
 72c:	fee5f1e3          	bgeu	a1,a4,70e <atoi+0x1e>
  return n;
}
 730:	6422                	ld	s0,8(sp)
 732:	0141                	addi	sp,sp,16
 734:	8082                	ret
  n = 0;
 736:	4501                	li	a0,0
 738:	bfe5                	j	730 <atoi+0x40>

000000000000073a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 73a:	1141                	addi	sp,sp,-16
 73c:	e422                	sd	s0,8(sp)
 73e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 740:	02b57663          	bgeu	a0,a1,76c <memmove+0x32>
    while(n-- > 0)
 744:	02c05163          	blez	a2,766 <memmove+0x2c>
 748:	fff6079b          	addiw	a5,a2,-1
 74c:	1782                	slli	a5,a5,0x20
 74e:	9381                	srli	a5,a5,0x20
 750:	0785                	addi	a5,a5,1
 752:	97aa                	add	a5,a5,a0
  dst = vdst;
 754:	872a                	mv	a4,a0
      *dst++ = *src++;
 756:	0585                	addi	a1,a1,1
 758:	0705                	addi	a4,a4,1
 75a:	fff5c683          	lbu	a3,-1(a1)
 75e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 762:	fee79ae3          	bne	a5,a4,756 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 766:	6422                	ld	s0,8(sp)
 768:	0141                	addi	sp,sp,16
 76a:	8082                	ret
    dst += n;
 76c:	00c50733          	add	a4,a0,a2
    src += n;
 770:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 772:	fec05ae3          	blez	a2,766 <memmove+0x2c>
 776:	fff6079b          	addiw	a5,a2,-1
 77a:	1782                	slli	a5,a5,0x20
 77c:	9381                	srli	a5,a5,0x20
 77e:	fff7c793          	not	a5,a5
 782:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 784:	15fd                	addi	a1,a1,-1
 786:	177d                	addi	a4,a4,-1
 788:	0005c683          	lbu	a3,0(a1)
 78c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 790:	fee79ae3          	bne	a5,a4,784 <memmove+0x4a>
 794:	bfc9                	j	766 <memmove+0x2c>

0000000000000796 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 796:	1141                	addi	sp,sp,-16
 798:	e422                	sd	s0,8(sp)
 79a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 79c:	ca05                	beqz	a2,7cc <memcmp+0x36>
 79e:	fff6069b          	addiw	a3,a2,-1
 7a2:	1682                	slli	a3,a3,0x20
 7a4:	9281                	srli	a3,a3,0x20
 7a6:	0685                	addi	a3,a3,1
 7a8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 7aa:	00054783          	lbu	a5,0(a0)
 7ae:	0005c703          	lbu	a4,0(a1)
 7b2:	00e79863          	bne	a5,a4,7c2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 7b6:	0505                	addi	a0,a0,1
    p2++;
 7b8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 7ba:	fed518e3          	bne	a0,a3,7aa <memcmp+0x14>
  }
  return 0;
 7be:	4501                	li	a0,0
 7c0:	a019                	j	7c6 <memcmp+0x30>
      return *p1 - *p2;
 7c2:	40e7853b          	subw	a0,a5,a4
}
 7c6:	6422                	ld	s0,8(sp)
 7c8:	0141                	addi	sp,sp,16
 7ca:	8082                	ret
  return 0;
 7cc:	4501                	li	a0,0
 7ce:	bfe5                	j	7c6 <memcmp+0x30>

00000000000007d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 7d0:	1141                	addi	sp,sp,-16
 7d2:	e406                	sd	ra,8(sp)
 7d4:	e022                	sd	s0,0(sp)
 7d6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 7d8:	00000097          	auipc	ra,0x0
 7dc:	f62080e7          	jalr	-158(ra) # 73a <memmove>
}
 7e0:	60a2                	ld	ra,8(sp)
 7e2:	6402                	ld	s0,0(sp)
 7e4:	0141                	addi	sp,sp,16
 7e6:	8082                	ret

00000000000007e8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 7e8:	4885                	li	a7,1
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 7f0:	4889                	li	a7,2
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 7f8:	488d                	li	a7,3
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 800:	4891                	li	a7,4
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <read>:
.global read
read:
 li a7, SYS_read
 808:	4895                	li	a7,5
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <write>:
.global write
write:
 li a7, SYS_write
 810:	48c1                	li	a7,16
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <close>:
.global close
close:
 li a7, SYS_close
 818:	48d5                	li	a7,21
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <kill>:
.global kill
kill:
 li a7, SYS_kill
 820:	4899                	li	a7,6
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <exec>:
.global exec
exec:
 li a7, SYS_exec
 828:	489d                	li	a7,7
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <open>:
.global open
open:
 li a7, SYS_open
 830:	48bd                	li	a7,15
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 838:	48c5                	li	a7,17
 ecall
 83a:	00000073          	ecall
 ret
 83e:	8082                	ret

0000000000000840 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 840:	48c9                	li	a7,18
 ecall
 842:	00000073          	ecall
 ret
 846:	8082                	ret

0000000000000848 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 848:	48a1                	li	a7,8
 ecall
 84a:	00000073          	ecall
 ret
 84e:	8082                	ret

0000000000000850 <link>:
.global link
link:
 li a7, SYS_link
 850:	48cd                	li	a7,19
 ecall
 852:	00000073          	ecall
 ret
 856:	8082                	ret

0000000000000858 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 858:	48d1                	li	a7,20
 ecall
 85a:	00000073          	ecall
 ret
 85e:	8082                	ret

0000000000000860 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 860:	48a5                	li	a7,9
 ecall
 862:	00000073          	ecall
 ret
 866:	8082                	ret

0000000000000868 <dup>:
.global dup
dup:
 li a7, SYS_dup
 868:	48a9                	li	a7,10
 ecall
 86a:	00000073          	ecall
 ret
 86e:	8082                	ret

0000000000000870 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 870:	48ad                	li	a7,11
 ecall
 872:	00000073          	ecall
 ret
 876:	8082                	ret

0000000000000878 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 878:	48b1                	li	a7,12
 ecall
 87a:	00000073          	ecall
 ret
 87e:	8082                	ret

0000000000000880 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 880:	48b5                	li	a7,13
 ecall
 882:	00000073          	ecall
 ret
 886:	8082                	ret

0000000000000888 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 888:	48b9                	li	a7,14
 ecall
 88a:	00000073          	ecall
 ret
 88e:	8082                	ret

0000000000000890 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 890:	1101                	addi	sp,sp,-32
 892:	ec06                	sd	ra,24(sp)
 894:	e822                	sd	s0,16(sp)
 896:	1000                	addi	s0,sp,32
 898:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 89c:	4605                	li	a2,1
 89e:	fef40593          	addi	a1,s0,-17
 8a2:	00000097          	auipc	ra,0x0
 8a6:	f6e080e7          	jalr	-146(ra) # 810 <write>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6105                	addi	sp,sp,32
 8b0:	8082                	ret

00000000000008b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8b2:	7139                	addi	sp,sp,-64
 8b4:	fc06                	sd	ra,56(sp)
 8b6:	f822                	sd	s0,48(sp)
 8b8:	f426                	sd	s1,40(sp)
 8ba:	f04a                	sd	s2,32(sp)
 8bc:	ec4e                	sd	s3,24(sp)
 8be:	0080                	addi	s0,sp,64
 8c0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 8c2:	c299                	beqz	a3,8c8 <printint+0x16>
 8c4:	0805c863          	bltz	a1,954 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8c8:	2581                	sext.w	a1,a1
  neg = 0;
 8ca:	4881                	li	a7,0
 8cc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 8d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 8d2:	2601                	sext.w	a2,a2
 8d4:	00000517          	auipc	a0,0x0
 8d8:	5fc50513          	addi	a0,a0,1532 # ed0 <digits>
 8dc:	883a                	mv	a6,a4
 8de:	2705                	addiw	a4,a4,1
 8e0:	02c5f7bb          	remuw	a5,a1,a2
 8e4:	1782                	slli	a5,a5,0x20
 8e6:	9381                	srli	a5,a5,0x20
 8e8:	97aa                	add	a5,a5,a0
 8ea:	0007c783          	lbu	a5,0(a5)
 8ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 8f2:	0005879b          	sext.w	a5,a1
 8f6:	02c5d5bb          	divuw	a1,a1,a2
 8fa:	0685                	addi	a3,a3,1
 8fc:	fec7f0e3          	bgeu	a5,a2,8dc <printint+0x2a>
  if(neg)
 900:	00088b63          	beqz	a7,916 <printint+0x64>
    buf[i++] = '-';
 904:	fd040793          	addi	a5,s0,-48
 908:	973e                	add	a4,a4,a5
 90a:	02d00793          	li	a5,45
 90e:	fef70823          	sb	a5,-16(a4)
 912:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 916:	02e05863          	blez	a4,946 <printint+0x94>
 91a:	fc040793          	addi	a5,s0,-64
 91e:	00e78933          	add	s2,a5,a4
 922:	fff78993          	addi	s3,a5,-1
 926:	99ba                	add	s3,s3,a4
 928:	377d                	addiw	a4,a4,-1
 92a:	1702                	slli	a4,a4,0x20
 92c:	9301                	srli	a4,a4,0x20
 92e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 932:	fff94583          	lbu	a1,-1(s2)
 936:	8526                	mv	a0,s1
 938:	00000097          	auipc	ra,0x0
 93c:	f58080e7          	jalr	-168(ra) # 890 <putc>
  while(--i >= 0)
 940:	197d                	addi	s2,s2,-1
 942:	ff3918e3          	bne	s2,s3,932 <printint+0x80>
}
 946:	70e2                	ld	ra,56(sp)
 948:	7442                	ld	s0,48(sp)
 94a:	74a2                	ld	s1,40(sp)
 94c:	7902                	ld	s2,32(sp)
 94e:	69e2                	ld	s3,24(sp)
 950:	6121                	addi	sp,sp,64
 952:	8082                	ret
    x = -xx;
 954:	40b005bb          	negw	a1,a1
    neg = 1;
 958:	4885                	li	a7,1
    x = -xx;
 95a:	bf8d                	j	8cc <printint+0x1a>

000000000000095c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 95c:	7119                	addi	sp,sp,-128
 95e:	fc86                	sd	ra,120(sp)
 960:	f8a2                	sd	s0,112(sp)
 962:	f4a6                	sd	s1,104(sp)
 964:	f0ca                	sd	s2,96(sp)
 966:	ecce                	sd	s3,88(sp)
 968:	e8d2                	sd	s4,80(sp)
 96a:	e4d6                	sd	s5,72(sp)
 96c:	e0da                	sd	s6,64(sp)
 96e:	fc5e                	sd	s7,56(sp)
 970:	f862                	sd	s8,48(sp)
 972:	f466                	sd	s9,40(sp)
 974:	f06a                	sd	s10,32(sp)
 976:	ec6e                	sd	s11,24(sp)
 978:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 97a:	0005c903          	lbu	s2,0(a1)
 97e:	18090f63          	beqz	s2,b1c <vprintf+0x1c0>
 982:	8aaa                	mv	s5,a0
 984:	8b32                	mv	s6,a2
 986:	00158493          	addi	s1,a1,1
  state = 0;
 98a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 98c:	02500a13          	li	s4,37
      if(c == 'd'){
 990:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 994:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 998:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 99c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9a0:	00000b97          	auipc	s7,0x0
 9a4:	530b8b93          	addi	s7,s7,1328 # ed0 <digits>
 9a8:	a839                	j	9c6 <vprintf+0x6a>
        putc(fd, c);
 9aa:	85ca                	mv	a1,s2
 9ac:	8556                	mv	a0,s5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	ee2080e7          	jalr	-286(ra) # 890 <putc>
 9b6:	a019                	j	9bc <vprintf+0x60>
    } else if(state == '%'){
 9b8:	01498f63          	beq	s3,s4,9d6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 9bc:	0485                	addi	s1,s1,1
 9be:	fff4c903          	lbu	s2,-1(s1)
 9c2:	14090d63          	beqz	s2,b1c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 9c6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 9ca:	fe0997e3          	bnez	s3,9b8 <vprintf+0x5c>
      if(c == '%'){
 9ce:	fd479ee3          	bne	a5,s4,9aa <vprintf+0x4e>
        state = '%';
 9d2:	89be                	mv	s3,a5
 9d4:	b7e5                	j	9bc <vprintf+0x60>
      if(c == 'd'){
 9d6:	05878063          	beq	a5,s8,a16 <vprintf+0xba>
      } else if(c == 'l') {
 9da:	05978c63          	beq	a5,s9,a32 <vprintf+0xd6>
      } else if(c == 'x') {
 9de:	07a78863          	beq	a5,s10,a4e <vprintf+0xf2>
      } else if(c == 'p') {
 9e2:	09b78463          	beq	a5,s11,a6a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 9e6:	07300713          	li	a4,115
 9ea:	0ce78663          	beq	a5,a4,ab6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9ee:	06300713          	li	a4,99
 9f2:	0ee78e63          	beq	a5,a4,aee <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 9f6:	11478863          	beq	a5,s4,b06 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9fa:	85d2                	mv	a1,s4
 9fc:	8556                	mv	a0,s5
 9fe:	00000097          	auipc	ra,0x0
 a02:	e92080e7          	jalr	-366(ra) # 890 <putc>
        putc(fd, c);
 a06:	85ca                	mv	a1,s2
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	e86080e7          	jalr	-378(ra) # 890 <putc>
      }
      state = 0;
 a12:	4981                	li	s3,0
 a14:	b765                	j	9bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 a16:	008b0913          	addi	s2,s6,8
 a1a:	4685                	li	a3,1
 a1c:	4629                	li	a2,10
 a1e:	000b2583          	lw	a1,0(s6)
 a22:	8556                	mv	a0,s5
 a24:	00000097          	auipc	ra,0x0
 a28:	e8e080e7          	jalr	-370(ra) # 8b2 <printint>
 a2c:	8b4a                	mv	s6,s2
      state = 0;
 a2e:	4981                	li	s3,0
 a30:	b771                	j	9bc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a32:	008b0913          	addi	s2,s6,8
 a36:	4681                	li	a3,0
 a38:	4629                	li	a2,10
 a3a:	000b2583          	lw	a1,0(s6)
 a3e:	8556                	mv	a0,s5
 a40:	00000097          	auipc	ra,0x0
 a44:	e72080e7          	jalr	-398(ra) # 8b2 <printint>
 a48:	8b4a                	mv	s6,s2
      state = 0;
 a4a:	4981                	li	s3,0
 a4c:	bf85                	j	9bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 a4e:	008b0913          	addi	s2,s6,8
 a52:	4681                	li	a3,0
 a54:	4641                	li	a2,16
 a56:	000b2583          	lw	a1,0(s6)
 a5a:	8556                	mv	a0,s5
 a5c:	00000097          	auipc	ra,0x0
 a60:	e56080e7          	jalr	-426(ra) # 8b2 <printint>
 a64:	8b4a                	mv	s6,s2
      state = 0;
 a66:	4981                	li	s3,0
 a68:	bf91                	j	9bc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a6a:	008b0793          	addi	a5,s6,8
 a6e:	f8f43423          	sd	a5,-120(s0)
 a72:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a76:	03000593          	li	a1,48
 a7a:	8556                	mv	a0,s5
 a7c:	00000097          	auipc	ra,0x0
 a80:	e14080e7          	jalr	-492(ra) # 890 <putc>
  putc(fd, 'x');
 a84:	85ea                	mv	a1,s10
 a86:	8556                	mv	a0,s5
 a88:	00000097          	auipc	ra,0x0
 a8c:	e08080e7          	jalr	-504(ra) # 890 <putc>
 a90:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a92:	03c9d793          	srli	a5,s3,0x3c
 a96:	97de                	add	a5,a5,s7
 a98:	0007c583          	lbu	a1,0(a5)
 a9c:	8556                	mv	a0,s5
 a9e:	00000097          	auipc	ra,0x0
 aa2:	df2080e7          	jalr	-526(ra) # 890 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 aa6:	0992                	slli	s3,s3,0x4
 aa8:	397d                	addiw	s2,s2,-1
 aaa:	fe0914e3          	bnez	s2,a92 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 aae:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 ab2:	4981                	li	s3,0
 ab4:	b721                	j	9bc <vprintf+0x60>
        s = va_arg(ap, char*);
 ab6:	008b0993          	addi	s3,s6,8
 aba:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 abe:	02090163          	beqz	s2,ae0 <vprintf+0x184>
        while(*s != 0){
 ac2:	00094583          	lbu	a1,0(s2)
 ac6:	c9a1                	beqz	a1,b16 <vprintf+0x1ba>
          putc(fd, *s);
 ac8:	8556                	mv	a0,s5
 aca:	00000097          	auipc	ra,0x0
 ace:	dc6080e7          	jalr	-570(ra) # 890 <putc>
          s++;
 ad2:	0905                	addi	s2,s2,1
        while(*s != 0){
 ad4:	00094583          	lbu	a1,0(s2)
 ad8:	f9e5                	bnez	a1,ac8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 ada:	8b4e                	mv	s6,s3
      state = 0;
 adc:	4981                	li	s3,0
 ade:	bdf9                	j	9bc <vprintf+0x60>
          s = "(null)";
 ae0:	00000917          	auipc	s2,0x0
 ae4:	3e890913          	addi	s2,s2,1000 # ec8 <statistics+0x1be>
        while(*s != 0){
 ae8:	02800593          	li	a1,40
 aec:	bff1                	j	ac8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 aee:	008b0913          	addi	s2,s6,8
 af2:	000b4583          	lbu	a1,0(s6)
 af6:	8556                	mv	a0,s5
 af8:	00000097          	auipc	ra,0x0
 afc:	d98080e7          	jalr	-616(ra) # 890 <putc>
 b00:	8b4a                	mv	s6,s2
      state = 0;
 b02:	4981                	li	s3,0
 b04:	bd65                	j	9bc <vprintf+0x60>
        putc(fd, c);
 b06:	85d2                	mv	a1,s4
 b08:	8556                	mv	a0,s5
 b0a:	00000097          	auipc	ra,0x0
 b0e:	d86080e7          	jalr	-634(ra) # 890 <putc>
      state = 0;
 b12:	4981                	li	s3,0
 b14:	b565                	j	9bc <vprintf+0x60>
        s = va_arg(ap, char*);
 b16:	8b4e                	mv	s6,s3
      state = 0;
 b18:	4981                	li	s3,0
 b1a:	b54d                	j	9bc <vprintf+0x60>
    }
  }
}
 b1c:	70e6                	ld	ra,120(sp)
 b1e:	7446                	ld	s0,112(sp)
 b20:	74a6                	ld	s1,104(sp)
 b22:	7906                	ld	s2,96(sp)
 b24:	69e6                	ld	s3,88(sp)
 b26:	6a46                	ld	s4,80(sp)
 b28:	6aa6                	ld	s5,72(sp)
 b2a:	6b06                	ld	s6,64(sp)
 b2c:	7be2                	ld	s7,56(sp)
 b2e:	7c42                	ld	s8,48(sp)
 b30:	7ca2                	ld	s9,40(sp)
 b32:	7d02                	ld	s10,32(sp)
 b34:	6de2                	ld	s11,24(sp)
 b36:	6109                	addi	sp,sp,128
 b38:	8082                	ret

0000000000000b3a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b3a:	715d                	addi	sp,sp,-80
 b3c:	ec06                	sd	ra,24(sp)
 b3e:	e822                	sd	s0,16(sp)
 b40:	1000                	addi	s0,sp,32
 b42:	e010                	sd	a2,0(s0)
 b44:	e414                	sd	a3,8(s0)
 b46:	e818                	sd	a4,16(s0)
 b48:	ec1c                	sd	a5,24(s0)
 b4a:	03043023          	sd	a6,32(s0)
 b4e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b52:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b56:	8622                	mv	a2,s0
 b58:	00000097          	auipc	ra,0x0
 b5c:	e04080e7          	jalr	-508(ra) # 95c <vprintf>
}
 b60:	60e2                	ld	ra,24(sp)
 b62:	6442                	ld	s0,16(sp)
 b64:	6161                	addi	sp,sp,80
 b66:	8082                	ret

0000000000000b68 <printf>:

void
printf(const char *fmt, ...)
{
 b68:	711d                	addi	sp,sp,-96
 b6a:	ec06                	sd	ra,24(sp)
 b6c:	e822                	sd	s0,16(sp)
 b6e:	1000                	addi	s0,sp,32
 b70:	e40c                	sd	a1,8(s0)
 b72:	e810                	sd	a2,16(s0)
 b74:	ec14                	sd	a3,24(s0)
 b76:	f018                	sd	a4,32(s0)
 b78:	f41c                	sd	a5,40(s0)
 b7a:	03043823          	sd	a6,48(s0)
 b7e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b82:	00840613          	addi	a2,s0,8
 b86:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b8a:	85aa                	mv	a1,a0
 b8c:	4505                	li	a0,1
 b8e:	00000097          	auipc	ra,0x0
 b92:	dce080e7          	jalr	-562(ra) # 95c <vprintf>
}
 b96:	60e2                	ld	ra,24(sp)
 b98:	6442                	ld	s0,16(sp)
 b9a:	6125                	addi	sp,sp,96
 b9c:	8082                	ret

0000000000000b9e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b9e:	1141                	addi	sp,sp,-16
 ba0:	e422                	sd	s0,8(sp)
 ba2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ba4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ba8:	00000797          	auipc	a5,0x0
 bac:	4587b783          	ld	a5,1112(a5) # 1000 <freep>
 bb0:	a805                	j	be0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bb2:	4618                	lw	a4,8(a2)
 bb4:	9db9                	addw	a1,a1,a4
 bb6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bba:	6398                	ld	a4,0(a5)
 bbc:	6318                	ld	a4,0(a4)
 bbe:	fee53823          	sd	a4,-16(a0)
 bc2:	a091                	j	c06 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bc4:	ff852703          	lw	a4,-8(a0)
 bc8:	9e39                	addw	a2,a2,a4
 bca:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 bcc:	ff053703          	ld	a4,-16(a0)
 bd0:	e398                	sd	a4,0(a5)
 bd2:	a099                	j	c18 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd4:	6398                	ld	a4,0(a5)
 bd6:	00e7e463          	bltu	a5,a4,bde <free+0x40>
 bda:	00e6ea63          	bltu	a3,a4,bee <free+0x50>
{
 bde:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be0:	fed7fae3          	bgeu	a5,a3,bd4 <free+0x36>
 be4:	6398                	ld	a4,0(a5)
 be6:	00e6e463          	bltu	a3,a4,bee <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bea:	fee7eae3          	bltu	a5,a4,bde <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 bee:	ff852583          	lw	a1,-8(a0)
 bf2:	6390                	ld	a2,0(a5)
 bf4:	02059713          	slli	a4,a1,0x20
 bf8:	9301                	srli	a4,a4,0x20
 bfa:	0712                	slli	a4,a4,0x4
 bfc:	9736                	add	a4,a4,a3
 bfe:	fae60ae3          	beq	a2,a4,bb2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 c02:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c06:	4790                	lw	a2,8(a5)
 c08:	02061713          	slli	a4,a2,0x20
 c0c:	9301                	srli	a4,a4,0x20
 c0e:	0712                	slli	a4,a4,0x4
 c10:	973e                	add	a4,a4,a5
 c12:	fae689e3          	beq	a3,a4,bc4 <free+0x26>
  } else
    p->s.ptr = bp;
 c16:	e394                	sd	a3,0(a5)
  freep = p;
 c18:	00000717          	auipc	a4,0x0
 c1c:	3ef73423          	sd	a5,1000(a4) # 1000 <freep>
}
 c20:	6422                	ld	s0,8(sp)
 c22:	0141                	addi	sp,sp,16
 c24:	8082                	ret

0000000000000c26 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c26:	7139                	addi	sp,sp,-64
 c28:	fc06                	sd	ra,56(sp)
 c2a:	f822                	sd	s0,48(sp)
 c2c:	f426                	sd	s1,40(sp)
 c2e:	f04a                	sd	s2,32(sp)
 c30:	ec4e                	sd	s3,24(sp)
 c32:	e852                	sd	s4,16(sp)
 c34:	e456                	sd	s5,8(sp)
 c36:	e05a                	sd	s6,0(sp)
 c38:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c3a:	02051493          	slli	s1,a0,0x20
 c3e:	9081                	srli	s1,s1,0x20
 c40:	04bd                	addi	s1,s1,15
 c42:	8091                	srli	s1,s1,0x4
 c44:	0014899b          	addiw	s3,s1,1
 c48:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c4a:	00000517          	auipc	a0,0x0
 c4e:	3b653503          	ld	a0,950(a0) # 1000 <freep>
 c52:	c515                	beqz	a0,c7e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c56:	4798                	lw	a4,8(a5)
 c58:	02977f63          	bgeu	a4,s1,c96 <malloc+0x70>
 c5c:	8a4e                	mv	s4,s3
 c5e:	0009871b          	sext.w	a4,s3
 c62:	6685                	lui	a3,0x1
 c64:	00d77363          	bgeu	a4,a3,c6a <malloc+0x44>
 c68:	6a05                	lui	s4,0x1
 c6a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c6e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c72:	00000917          	auipc	s2,0x0
 c76:	38e90913          	addi	s2,s2,910 # 1000 <freep>
  if(p == (char*)-1)
 c7a:	5afd                	li	s5,-1
 c7c:	a88d                	j	cee <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 c7e:	00001797          	auipc	a5,0x1
 c82:	39278793          	addi	a5,a5,914 # 2010 <base>
 c86:	00000717          	auipc	a4,0x0
 c8a:	36f73d23          	sd	a5,890(a4) # 1000 <freep>
 c8e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c90:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c94:	b7e1                	j	c5c <malloc+0x36>
      if(p->s.size == nunits)
 c96:	02e48b63          	beq	s1,a4,ccc <malloc+0xa6>
        p->s.size -= nunits;
 c9a:	4137073b          	subw	a4,a4,s3
 c9e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ca0:	1702                	slli	a4,a4,0x20
 ca2:	9301                	srli	a4,a4,0x20
 ca4:	0712                	slli	a4,a4,0x4
 ca6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ca8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cac:	00000717          	auipc	a4,0x0
 cb0:	34a73a23          	sd	a0,852(a4) # 1000 <freep>
      return (void*)(p + 1);
 cb4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cb8:	70e2                	ld	ra,56(sp)
 cba:	7442                	ld	s0,48(sp)
 cbc:	74a2                	ld	s1,40(sp)
 cbe:	7902                	ld	s2,32(sp)
 cc0:	69e2                	ld	s3,24(sp)
 cc2:	6a42                	ld	s4,16(sp)
 cc4:	6aa2                	ld	s5,8(sp)
 cc6:	6b02                	ld	s6,0(sp)
 cc8:	6121                	addi	sp,sp,64
 cca:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ccc:	6398                	ld	a4,0(a5)
 cce:	e118                	sd	a4,0(a0)
 cd0:	bff1                	j	cac <malloc+0x86>
  hp->s.size = nu;
 cd2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cd6:	0541                	addi	a0,a0,16
 cd8:	00000097          	auipc	ra,0x0
 cdc:	ec6080e7          	jalr	-314(ra) # b9e <free>
  return freep;
 ce0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ce4:	d971                	beqz	a0,cb8 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ce6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ce8:	4798                	lw	a4,8(a5)
 cea:	fa9776e3          	bgeu	a4,s1,c96 <malloc+0x70>
    if(p == freep)
 cee:	00093703          	ld	a4,0(s2)
 cf2:	853e                	mv	a0,a5
 cf4:	fef719e3          	bne	a4,a5,ce6 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 cf8:	8552                	mv	a0,s4
 cfa:	00000097          	auipc	ra,0x0
 cfe:	b7e080e7          	jalr	-1154(ra) # 878 <sbrk>
  if(p == (char*)-1)
 d02:	fd5518e3          	bne	a0,s5,cd2 <malloc+0xac>
        return 0;
 d06:	4501                	li	a0,0
 d08:	bf45                	j	cb8 <malloc+0x92>

0000000000000d0a <statistics>:
#include "kernel/fcntl.h"
#include "user/user.h"

int
statistics(void *buf, int sz)
{
 d0a:	7179                	addi	sp,sp,-48
 d0c:	f406                	sd	ra,40(sp)
 d0e:	f022                	sd	s0,32(sp)
 d10:	ec26                	sd	s1,24(sp)
 d12:	e84a                	sd	s2,16(sp)
 d14:	e44e                	sd	s3,8(sp)
 d16:	e052                	sd	s4,0(sp)
 d18:	1800                	addi	s0,sp,48
 d1a:	8a2a                	mv	s4,a0
 d1c:	892e                	mv	s2,a1
  int fd, i, n;
  
  fd = open("statistics", O_RDONLY);
 d1e:	4581                	li	a1,0
 d20:	00000517          	auipc	a0,0x0
 d24:	1c850513          	addi	a0,a0,456 # ee8 <digits+0x18>
 d28:	00000097          	auipc	ra,0x0
 d2c:	b08080e7          	jalr	-1272(ra) # 830 <open>
  if(fd < 0) {
 d30:	04054263          	bltz	a0,d74 <statistics+0x6a>
 d34:	89aa                	mv	s3,a0
      fprintf(2, "stats: open failed\n");
      exit(1);
  }
  for (i = 0; i < sz; ) {
 d36:	4481                	li	s1,0
 d38:	03205063          	blez	s2,d58 <statistics+0x4e>
    if ((n = read(fd, buf+i, sz-i)) < 0) {
 d3c:	4099063b          	subw	a2,s2,s1
 d40:	009a05b3          	add	a1,s4,s1
 d44:	854e                	mv	a0,s3
 d46:	00000097          	auipc	ra,0x0
 d4a:	ac2080e7          	jalr	-1342(ra) # 808 <read>
 d4e:	00054563          	bltz	a0,d58 <statistics+0x4e>
      break;
    }
    i += n;
 d52:	9ca9                	addw	s1,s1,a0
  for (i = 0; i < sz; ) {
 d54:	ff24c4e3          	blt	s1,s2,d3c <statistics+0x32>
  }
  close(fd);
 d58:	854e                	mv	a0,s3
 d5a:	00000097          	auipc	ra,0x0
 d5e:	abe080e7          	jalr	-1346(ra) # 818 <close>
  return i;
}
 d62:	8526                	mv	a0,s1
 d64:	70a2                	ld	ra,40(sp)
 d66:	7402                	ld	s0,32(sp)
 d68:	64e2                	ld	s1,24(sp)
 d6a:	6942                	ld	s2,16(sp)
 d6c:	69a2                	ld	s3,8(sp)
 d6e:	6a02                	ld	s4,0(sp)
 d70:	6145                	addi	sp,sp,48
 d72:	8082                	ret
      fprintf(2, "stats: open failed\n");
 d74:	00000597          	auipc	a1,0x0
 d78:	18458593          	addi	a1,a1,388 # ef8 <digits+0x28>
 d7c:	4509                	li	a0,2
 d7e:	00000097          	auipc	ra,0x0
 d82:	dbc080e7          	jalr	-580(ra) # b3a <fprintf>
      exit(1);
 d86:	4505                	li	a0,1
 d88:	00000097          	auipc	ra,0x0
 d8c:	a68080e7          	jalr	-1432(ra) # 7f0 <exit>
