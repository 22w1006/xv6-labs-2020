#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  int i;
  if(argc != 2){
    fprintf(2, "Invalid input:\nUsage: sleep [i]\n");
    exit(1);
  }
  
  i = atoi(argv[1]);
  //printf("Sleep for %d tick(s).\n", i);
  sleep(i);
  exit(0);
}
