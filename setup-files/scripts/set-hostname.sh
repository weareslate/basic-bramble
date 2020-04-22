#!/bin/bash
if [[ -z $1 ]]; then
	echo "Usage:"
	echo "set-hostname.sh <hostname>"
	echo "e.g. set-hostname.sh node1.kube.local"
	exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "must be run as root" 
   exit 1
fi
hostnamectl --transient set-hostname $1
hostnamectl --static set-hostname $1
hostnamectl --pretty set-hostname $1
sed -i s/raspberrypi/$1/g /etc/hosts
