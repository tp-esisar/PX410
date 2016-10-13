#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
  char cmd[64];
  sprintf(cmd, "pmap %d", getpid());
  system(cmd);
  return 0;
}
