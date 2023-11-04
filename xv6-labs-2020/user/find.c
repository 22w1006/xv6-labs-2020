#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return no-blank-padded name.
  return p;
}



void
find(char *path, char* filename, char* father)
{
  char buf[512];
  char *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:
    //printf("Got file %s\n", fmtname(path));

    if(strcmp(fmtname(path), filename) == 0){
      fprintf(1, "%s/%s\n", father, filename); //warning
    }
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf("ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      //printf("Got directory %s\n", de.name);
      if(de.inum == 0){
        //printf("skip\n");
        continue;
      }
      if(strcmp(de.name, ".") == 0){
        //printf("skip\n");
        continue;
      }
      if(strcmp(de.name, "..") == 0){
        //printf("skip\n");
        continue;
      }
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf("ls: cannot stat %s\n", buf);
        continue;
      }
      if(st.type == T_DIR){
        //printf("Not skip, run into %s\n", p);
        char* father_buf = malloc(100), *tmp;
        strcpy(father_buf, father);
        tmp = father_buf + strlen(father_buf);
        *tmp++ = '/';
        strcpy(tmp, p);
        //printf("Not skip, run into %s(accurately %s)\n", father_buf, de.name);
        find(father_buf+2, filename, father_buf);
        free(father_buf);
      }
      else
        if(strcmp(p, filename) == 0){
          fprintf(1, "%s/%s\n", father, filename); //warning
        }
        //find(de.name, filename, father);
    }
    break;
  }
  close(fd);
}



int
main(int argc, char *argv[])
{
  //printf("T_FILE = %d, T_DIR = %d\n",T_FILE, T_DIR);
  if(argc != 3){
    fprintf(2, "Invalid input:\nUsage: find [tree name] [filename]\n");
    exit(1);
  }
  
  find(argv[1],argv[2],argv[1]);
  
  exit(0);
}
