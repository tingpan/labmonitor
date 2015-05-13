#!/bin/bash
if test $# -eq 1
    then
    filename=`echo $1|sed 's/^zy/65/'`.png
    cd /usr/local/unnc/ae1ust/cw2/id-photos
    if test -f "$filename"
	then
	echo `pwd`/$filename
	exit 0
    else
	echo `pwd`/Unknown.png
	exit 2
    fi
else
    echo "Usage: photo_lookup.sh <username>"
    exit 1
fi