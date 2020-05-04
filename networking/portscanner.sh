#!/bin/bash

#populate vars from args
host=$1
startp=$2
stopp=$3

#function pingcheck
#ping a device to see if it is up
function pingcheck {
ping=`ping -c 1 $host | grep bytes | wc -l`
 if [ "$ping" -gt 1 ];then
     echo "$host is up";
 else
     echo "$host is down... quitting";
     exit
 fi
}
#function portcheck
#tests an open port
function portcheck {
    for (( counter=$startp; counter<=$stopp; counter++))
    do
        (echo >/dev/tcp/$host/$counter) > /dev/null 2>&1 && echo "$counter open"
    done
}

#run our shit
pingcheck
portcheck
