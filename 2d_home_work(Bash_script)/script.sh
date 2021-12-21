#!/bin/bash

name=`basename $0`
n=5
w=0
cmd="netstat"
q='$5'
s="-tunp"
if [ ! -n "$1" ]
then
  echo "You need to enter at least the name or PID of process"
  exit 1
fi

PID=$1

if [[ "$(whoami)" != root ]]; then
  echo "WARNING: you don't have root privileges. Script will acts of your behalf.\n To avoid this you must run script whith sudo.\n ex: sudo $name firefox"
fi

while [ -n "$1" ]
do
  if [ "$1" == "--ss" ]; then
    q='$6'
    cmd=ss; fi
  if [ "$1" == "-w" ]; then
    w=1; fi
  if [ "$1" == "-n" ]; then
    shift
    n=$1; fi
  if [ "$1" == "-s" ]; then
    shift
    if [ "$1" == "a" ] || [ "$1" == 'l' ]; then
      s+=$1
    else
      echo 'You need to enter "a" or "l" flag whth option "-s"'
      exit 1; fi
  fi
  shift
done


$cmd $s |
  awk "/$PID/ {print $q}" |
    cut -d: -f1 |
      sort |
	uniq -c |
	  sort |
#	    tail -n $n |
	      grep -oP '(\d+\.){3}\d+' |
		while read IP
		  do 
		      who="$(whois $IP)"
		      ans=$(echo "$who" | awk -F':' '/^Organization/ {print $2}')
		      if [ $w -eq 1 ]; then
		        ans+=$(echo "$who" | awk -F':' '/^Address/ {print $2}')
		        ans+=$(echo "$who" | awk -F':' '/^City/ {print $2}')
		        ans+=$(echo "$who" | awk -F':' '/^Country/ {print $2}'); fi
		      if [ -n "$ans" ]; then
			echo $ans; fi
		  done | 
		    tail -n $n
