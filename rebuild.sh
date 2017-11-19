#!/bin/bash

dn=`dirname $0`
if ! [ -z "$dn" ]; then
	cd "$dn"
fi

cd unpacked || exit 3

find . | cpio -o -H newc | gzip > ../initrd.gz
