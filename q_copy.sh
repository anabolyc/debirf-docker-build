#!/bin/bash

docker cp debirf-instance-$1:/debirf/rescue/vmlinuz-4.18.0-11-generic out/$1
docker cp debirf-instance-$1:/debirf/rescue/debirf-rescue_disco_4.18.0-11-generic.cgz out/$1
docker cp debirf-instance-$1:/debirf/rescue/debirf-rescue_disco_4.18.0-11-generic.iso out/$1
docker cp debirf-instance-$1:/debirf/rescue/iso/boot/grub/grub.cfg out/$1