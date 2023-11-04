#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "stddef.h"
#include "kernel/param.h"

void Do(char* cmd, char* argv[MAXARG]){
  if(fork() == 0){
    exec(cmd, argv);
    //exit(0);
  }
  else{
    wait(0);
  }
  //exit(0);
}


int
main(int argc, char *argv[])
{
  if(argc <= 1 || argc > 33){
    fprintf(2, "Invalid input:\nUsage: [command] [argc 1]... | xargs [command] [argc 1]...\n");
    exit(1);
  }
  
  
  char** ARGV = malloc(400);
  char buf[2];
  
  for(int i=1;i<argc;++i){
    ARGV[i-1] = malloc(strlen(argv[i])+1);
  	memmove(ARGV[i-1], argv[i], strlen(argv[i]));
  	ARGV[i-1][strlen(argv[i])] = '\0';
  }
  
  ARGV[argc-1] = malloc(100);
  //ARGV[argc] = NULL;
  
  char* ptr = ARGV[argc-1];
  while(read(0, buf, 1) != 0){
    if(*buf != '\n'){
      *ptr = *buf;
      ptr++;
    }
    else{
      *ptr = '\0';
      Do(ARGV[0], ARGV);
      ptr = ARGV[argc-1];
    }

    //printf("find: %s\n",buf);
    //printf("add to %d: %s\n", argc-1, ARGV[argc-1]);
    /*
    for(int i=0;i<10;++i){
      if(argv[i]!= NULL)
        printf("%s\n",ARGV[i]);
    }
    */
  }
  
  for(int i = 0; i < argc; ++i){
    free(ARGV[i]);  
  }
    
  
  exit(0);
}
