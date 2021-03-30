#!/bin/sh

## hyphop ##

#= display used space for backups

#? usage sh ./04_space_user.sh

DATA=data

echo "[i] $DATA $()"2>&2

ls -l1 $DATA
ls $DATA -Ll1

du -sh $DATA/*

