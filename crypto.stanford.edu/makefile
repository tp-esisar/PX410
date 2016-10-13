
lib=/lib/x86_64-linux-gnu/libc.so.6

url:
	firefox http://crypto.stanford.edu/~blynn/rop/ &

get-element :
	gcc findbase.c -o findbase
	gcc -fno-stack-protector victim.c -o victim 
	./get-element.sh


victim: victim.c
	gcc -fno-stack-protector -o victim victim.c

run-victim: victim
	setarch `arch` -R ./victim

exploit-victim: victim shellcode
	./exploit.sh ${ADR}

clear:
	rm -f shell shellcode victim findbase

