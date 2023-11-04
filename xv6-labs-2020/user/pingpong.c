#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{

  if(argc != 1){
    fprintf(2, "Invalid input:\nUsage: pingpong\n");
    exit(1);
  }
  
  int buf[5];
  int p[2];
  pipe(p);
  char* argv_ = "pingpong";

  int pid = fork();
  if (pid > 0){
    write(p[1], argv_, 4); //parent write to pipe
    close(p[1]);  //parent close output
    wait(0);  //parent wait until the child terminate
    read(p[0], buf, 4);  //parent read from pipe
    printf("%d: received %s\n", getpid(), buf);
    close(p[0]); //parent close input
    exit(0);
  }
  
  else if (pid == 0){
    read(p[0], buf, 4);
    printf("%d: received %s\n", getpid(), buf);
    close(p[0]); 
    write(p[1], argv_+4, 4);
    close(p[1]);
    exit(0);
  }
  else{
   printf("fork error\n");
  }


  exit(0);
}
