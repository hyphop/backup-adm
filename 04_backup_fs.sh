#!/bin/sh

## hyphop ##

#= backup fs for lvs

#? usage sh ./03_backup_fs /dev/vg0/*

TS=$(date +%s)

CMD(){
    echo "# $@">&2
    "$@"
}

for a in "$@" ; do
    case $a in
	/dev/*snap*)
	    echo "[w] snap $a ignored">&2
	    continue
	;;
	/dev/*)
	[ -b $a ] || {
	    echo "[e] $a not block dev">&2
	    exit 1
	}
	case $a in
	    /dev/mapper/*)
	    N=${a#/dev/mapper/}
	    ;;
	    *)
	    N=$(echo ${a#/dev/} | sed -e s/-/--/ -e s/\\//\\-/ )
	    ;;
	esac
	S=$(echo "${N#*-}" | sed -e s/--/-/)
	MNT2="/tmp/$S.$TS"
	NAME="$S.snap.$TS"
	SNAP="$a.snap.$TS"
	DST="data/$S"
	echo "$a -> $N($S) => $MNT2 <= $SNAP => $DST">&2
	CMD mkdir -p "$MNT2" || exit 1
	CMD mkdir -p "$DST" || exit 1
	CMD lvcreate -prw -s -L20% -n "$NAME" $a || exit 2
	CMD mount -o ro "$SNAP" "$MNT2" || exit 3
	CMD rsync -a --delete --info=progress2 "$MNT2"/. "$DST" || exit 4
	CMD umount "$MNT2" || exit 5
	CMD rmdir "$MNT2" || exit 6
	CMD lvremove -y "$SNAP" || exit 7
	echo "DONE $a"
	;;
    esac
done
