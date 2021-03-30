# back scripts

simple backups 1st disk fs to backup 2nd disk

+ data - backup data folder
+ *.sh - scripts (non exec)

## USAGE EXAMPLE

    blkid /dev/nvme1n1p2
    /dev/nvme1n1p2: LABEL="backup" UUID="61c598e9-4466-4541-9079-c2f6e68dc43d" TYPE="ext4" PARTUUID="b79bec68-02"

    mount LABEL=backup /mnt/backup
    cd /mnt/backup/backup-adm
    sh ./02_boot_sync.sh
    # sh ./03_boot_save_image.sh
    # sh ./03_root_save_image.sh
    sh ./04_backup_fs.sh /dev/vg0/*
    sh ./05_space_used.sh
    cd /
    umount /mnt/backup

## any questions ?

    ask me ## hyphop ##
