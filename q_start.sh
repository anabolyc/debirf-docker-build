#!/bin/bash

qemu-system-x86_64 --enable-kvm -kernel out/$1/vmlinuz-4.18.0-11-generic -initrd out/$1/debirf-rescue_disco_4.18.0-11-generic.cgz -append "console=tty0 console=ttyS0,115200n8" -m 2G -smp 1 -net nic,vlan=0 -net user $2
