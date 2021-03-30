#!/bin/sh

## hyphop ##

#= sync boot

#? USAGE sh ./02_boot_sync.sh

SRC=/dev/nvme0n1p1
DST=/dev/nvme1n1p1

mount -o remount,ro /boot || exit 1
rsync -vP --inplace --copy-devices  $SRC $DST || exit 2
e2label $DST | grep boot && echo ok
