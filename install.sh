#!/bin/bash

if [ -z "$1" ]; then
	echo Usage: "$0" path-to-tftp-root 
	exit 2
fi

dir="$1"
if ! [ -d $dir ]; then
	echo "Directory $dir not found"
	exit 3
fi

dn=`dirname $0`

if ! [ -z "$dn" ]; then
	cd "$dn"
fi


cp -a didaily "$dir/"

./rebuild.sh

cp initrd.gz "$dir"/didaily/armhf/daily/netboot/

