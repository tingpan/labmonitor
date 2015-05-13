#!/bin/bash
if test $# -eq 2
    then
    room=`echo $1 | tr '[a-z]' '[A-Z]'`
    picture=`ls /usr/local/unnc/ae1ust/cw2/room-images | egrep $room.png`
	if [ -z "$picture" ]
	then
		echo "Unknown room"
		exit 1
	else
		cp /usr/local/unnc/ae1ust/cw2/room-images/$picture $2
		people=`./who_room.sh $room`
		for name in $people
		do
			photo=`./photo_lookup.sh $name`
			location=`./who_location.sh $name | awk '$1==room {print $2}' room="$room"`
			for seat in $location
				do
				position=`awk '$1==seat{print $2}' seat="$seat" /usr/local/unnc/ae1ust/cw2/room-images/$room.txt`
				composite -geometry $position $photo $2 $2
			done
		done
		exit 0
	fi
else
	echo "Usage: visual_who.sh <Room> <Output>"
	exit 1
fi

