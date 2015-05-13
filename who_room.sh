#!/bin/bash
if test $# -eq 1
    then
    room=`echo $1 |tr "[a-z]" "[A-Z]"`
    IP=`awk '$2==room{print $1}' room="$room" /usr/local/unnc/ae1ust/cw2/ip-to-room.txt`
    for ip in $IP
      do
      DNS=`host $ip | awk '{sub(/\.$/,"");print $5}'`
      who | awk '$0~DNS || $0~ip {if (a[$1]==0) {print $1; a[$1]=1} }' DNS="$DNS" ip="$ip" 
    done |sort -u
    exit 0
else
    echo "Usage: who_room.sh <roomname>"
    exit 1
fi
