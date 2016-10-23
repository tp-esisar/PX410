
lib=/lib/x86_64-linux-gnu/libc.so.6

url:
	firefox http://crypto.stanford.edu/~blynn/rop/ &

attaque :
	gcc findbase.c -o findbase.out
	gcc -fno-stack-protector victim.c -o victim.out
	./get-element.sh

clear:
	rm -f findbase.out victim.out

