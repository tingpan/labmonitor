#!/bin/bash
while getopts "m:r:o:" Option 2>/dev/null
do
	case $Option in
                m) MODULE=$OPTARG;;
                r) ROOM=$OPTARG;;
                o) OUTPUT=$OPTARG;;
                *) echo "Usage:  update_regisher.sh -m MODULE [-r ROOM] [-o OUTPUT]"
                exit 1;;
        	esac
done

if [ -z "$MODULE" ]
then
	echo "Usage:  update_regisher.sh -m MODULE [-r ROOM] [-o OUTPUT]"
	exit 1
fi

course=`ls ~/registers/$MODULE 2>/dev/null | egrep $MODULE.reg` 
if [ -z "$course" ]
then
	echo "No such module"
	exit 2
fi

if [ -z "$ROOM" ]
then     
	current_user=`whoami`
	ROOM=` ./who_location.sh $current_user | cut -f "1" -d " "`
fi

if [ -z "$OUTPUT" ]
then
	cp ~/registers/$MODULE/$MODULE.reg ~/registers/$MODULE/$MODULE.bak
	OUTPUT=~/registers/$MODULE/$MODULE.reg
fi

student=`./who_room.sh $ROOM`
firstline=`cat ~/registers/$MODULE/$MODULE.reg| sed -n '1p'`
list=`cat ~/registers/$MODULE/$MODULE.reg| sed '1d'`
echo "$firstline,"`date +%F` >$OUTPUT
for eachline in $list
do
	status=1
	for name in $student
	do
		value=`echo "$eachline" | awk -F "," '$1==name{print $0}' name="$name"`
		if [ -n "$value" ]
		then
		status=0
		fi
	done
	echo "$eachline,$status" >>$OUTPUT
done
exit 0

