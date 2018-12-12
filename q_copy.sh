#!/bin/bash

docker cp debirf-instance:/debirf/rescue/vmlinuz-4.18.0-11-generic out
docker cp debirf-instance:/debirf/rescue/debirf-rescue_disco_4.18.0-11-generic.cgz out
docker cp debirf-instance:/debirf/rescue/debirf-rescue_disco_4.18.0-11-generic.iso out
docker cp debirf-instance:/debirf/rescue/iso/boot/grub/grub.cfg out