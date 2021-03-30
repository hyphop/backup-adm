# back scripts

Simple backups 1st disk fs to backup 2nd disk. https://github.com/hyphop/backup-adm

+ data - backup data folder
+ *.sh - scripts (non exec)

## USAGE EXAMPLE

    blkid /dev/nvme1n1p2
    /dev/nvme1n1p2: LABEL="backup" UUID="..." TYPE="ext4" PARTUUID="..."

    mount LABEL=backup /mnt/backup
    cd /mnt/backup/backup-adm
    cat README.md
    sh ./02_boot_sync.sh
    # sh ./03_boot_save_image.sh
    # sh ./03_root_save_image.sh
    sh ./04_backup_fs.sh /dev/vg0/*
    sh ./05_space_used.sh
    cd /
    umount /mnt/backup

## Setup

    mkdir -p /tmp/backup
    # ...
    mount LABEL=backup /mnt/backup
    cd /mnt/backup/
    mkdir -p backup-data
    git clone https://github.com/hyphop/backup-adm
    cd backup-adm
    ln -s ../backup-data data
    cat README.md

## any questions ?

    ask me ## hyphop ##
