#!/bin/bash

IFS=$'\n'

NMAP=$(which nmap)
NC=$(which nc)

#trap '' TERM INT

function usage () {
    echo "Knock a host using netcat or nmap"
    echo "Usage: `basename $0` -h host -s seq"
    echo "-h	the host to be knocked"
    echo "-s	comma separated unlocking sequence"
    exit 0
}

h_specified=0

# Parse command-line arguments.
while getopts ":h:s:" opt
do
    case $opt in
	h ) h_specified=1
	    h=$OPTARG ;;
	s ) s_specified=1
	    s=$OPTARG ;;
	\?) usage ;;
    esac
done

if [[ $h_specified -eq 0 ]] || [[ $s_specified -eq 0 ]]
then
    usage
fi

seq=($(echo "$s" | tr ',' '\n'))

echo "$(basename $0) started"

if [[ ! $NMAP && ! $NC ]]; then
    echo "fatal: neither nmap nor netcat are available on this system";
fi

for i in "${!seq[@]}"; do
    if [ $NMAP ]; then
	$NMAP -Pn --host_timeout 201 --max-retries 0 -p ${seq[i]} $h
    else
	$NC -q1 -z $h ${seq[i]} &
    fi;
    sleep 1
done

echo "$(basename $0) done!"
