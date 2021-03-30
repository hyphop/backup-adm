#!/bin/sh

## hyphop ##

#= backup boot image

#? USAGE sh ./02_boot_save_image.sh

SRC=/dev/nvme0n1p1

TMP=/tmp/boot.img.tmp
IMG=data/boot.img.zst

CMD(){
    echo "# $@">&2
    "$@"
}

which zstd 2>/dev/null || \
    sudo apt-get install zstd || exit 1

echo "backup image for $SRC => $IMG">&2

CMD dd bs=1M if=$SRC of="$TMP" || {
    rm "$TMP"
    exit 3
}

CMD zerofree -v $TMP || exit 3
CMD fsck -f $TMP || exit 4

CMD zstd -T4 -c $TMP -o $IMG.tmp || exit 5

CMD rm "$TMP" || exit 6

[ -s "$IMG" ] && mv $IMG $IMG.old

mv $IMG.tmp $IMG || exit 7

echo OK

ls -l1 $IMG
