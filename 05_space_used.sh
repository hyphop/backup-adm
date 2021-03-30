#!/bin/sh

## hyphop ##

#= display used space for backups

#? usage sh ./04_space_user.sh

ls data -l1

du -sh data/*

