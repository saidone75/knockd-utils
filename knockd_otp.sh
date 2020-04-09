#!/bin/bash

IFS=$'\n'

function random() {
    echo -ne $(((RANDOM % $1)+1))
}

function random_range() {
    r=$(random $2)
    while (($r < $1));
    do
	r=$(random $2)
    done
    echo -ne $r
}

function random_port() {
    echo -ne $(random_range 1024 65535)
}

function random_seq_length() {
    echo -ne $(random_range 3 4)
}

#trap '' TERM INT

function usage () {
    echo "Generate a knockd one time sequences list"
    echo "Usage: `basename $0` -n rows"
    echo "-n	number of sequences to be generated"
    exit 0
}

n_specified=0

# parse command-line arguments
while getopts ":n:" opt
do
    case $opt in
	n ) n_specified=1
	    rows=$OPTARG ;;
	\?) usage ;;
    esac
done

if [ $n_specified -eq 0 ]
then
    usage
fi

#info "$(basename $0) started"

for (( r=1; r<=$rows; r++ ))
do
    echo -ne " "
    for (( p=1; p<$(random_seq_length); p++ ))
    do
	echo -ne $(random_port),
    done
    echo $(random_port)
done

#info "$(basename $0) done!"
