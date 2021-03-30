#!/bin/sh

## hyphop ##

#= backup root snap image

#? USAGE sh ./02_root_save_image.sh

#/dev/vg0/*snap*

SRC=/dev/vg0/root-snap2

TMP=data/root.img.tmp
IMG=data/root.img.zst

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
