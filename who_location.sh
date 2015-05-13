#!/bin/bash
if test $# -eq 1
then
	Number=$1
	DNS=` who | awk '$1==Number{gsub(/\(|\)|(:[0-9].[0-9])/,"");if(a[$5]==0){print $5;a[$5]=1}}' Number=$Number `
	if test -z "$DNS"
		then
			exit 0
		else
			for adress in $DNS
			do
				IP=`host $adress|awk '{print $4}'`
				awk '$1==IP||$1==adress {
   				     print $2" "$3;
   			             result=1;}
		                     END{if(result==0){print "Unknown Unknown"}
		                     }' IP="$IP" adress="$adress" /usr/local/unnc/ae1ust/cw2/ip-to-room.txt
			done
			exit 0
		fi
else
	echo "Usage: who_location.sh <username>"
	exit 1
fi
