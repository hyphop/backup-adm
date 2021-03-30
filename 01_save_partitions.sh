#!/bin/sh

## hyphop ##

#= save partitions dump

#? USAGE sh ./01_save_partitions.sh

mkdir -p data

sfdisk --dump /dev/nvme0n1 | tee data/disk1.parts
sfdisk --dump /dev/nvme1n1 | tee data/disk2.parts

ls -l1 data
