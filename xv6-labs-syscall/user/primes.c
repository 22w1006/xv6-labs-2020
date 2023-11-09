#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{

  if(argc != 1){
    fprintf(2, "Invalid input:\nUsage: primes\n");
    exit(1);
  }

  int p[100];
  
  int buf[35];
  for(int i=2;i<=35;++i){
    buf[i-2] = i;
  }

  pipe(p);  // 0,1,2,p[0],p[1]

  int pid = fork();
  if (pid > 0){
    close(p[0]);

    for(int i=2;i<=35;++i){
      write(p[1], buf+i-2, 4); //parent write to pipe
      //printf("<%d>: pass %d to child <%d>\n", getpid(), i, pid);
    }
    
  }
  
  else if (pid == 0){
    close(p[1]); //p[0]

    int it = 0;
    
    int tmp1 = 0;
    int tmp2 = 1;
    
    while(it < 12){
      it++;
      tmp2 = 0;
      pipe(p+2*it); //p[0,2,3]
      
      pid = fork(); 
      if (pid > 0){
        //printf("hello from <%d>\n",getpid());
        close(p[0+2*it]);  //p[0,3]
        while(read(p[0+2*(it-1)], &tmp1, 4)!=0){
          if(tmp2 == 0){
            tmp2 = tmp1;
            printf("prime %d\n",tmp1);
          }
          else{
            //printf("%d %d\n",tmp1,tmp2);
            if(tmp1 % tmp2 != 0){
              write(p[1+2*it], &tmp1, 4);
              //printf("<%d>: pass %d to child <%d>\n", getpid(), tmp1, pid);
            } 
          }
        }
        close(p[0+2*(it-1)]); 
        close(p[1+2*it]);
        
        exit(0);
      }
      else if (pid == 0){
        close(p[0+2*(it-1)]); 
        close(p[1+2*it]);
        if(it >= 12){
          sleep(5);  //warning
          //printf("bye from <%d>\n",getpid());
          for(int i=getpid()-1;i>1;--i){
            kill(i);
          } 
          exit(0);
        }
      }
      else{
        printf("fork error\n");
      }
    
    }
    wait(0);
    exit(0);
  } 
  else{
   printf("fork error\n");
  }
  
  wait(0);
  exit(0);
}
