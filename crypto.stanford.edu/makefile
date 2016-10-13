


url:
	firefox http://crypto.stanford.edu/~blynn/rop/ &

shell: shell.c
	gcc shell.c -o shell

run-shell: shell
	./shell

objdump-shell: shell
	objdump -d shell | sed -n '/needle0/,/needle1/p'

shellcode: shell
	xxd -s0x4ba -l32 -p shell shellcode

victim: victim.c
	gcc -fno-stack-protector -o victim victim.c
	execstack -s victim

run-victim: victim
	setarch `arch` -R ./victim

exploit-victim: victim shellcode exploit.sh
	./exploit.sh ${ADR}

pipe:
	rm -f pip
	mkfifo pip

run-victim-aslr: victim pipe
	cat pip | ./victim
	rm -f pip

exploit-victim-aslr: victim shellcode pip
	./exploit-aslr.sh

clear:
	rm -f shell shellcode victim pip
