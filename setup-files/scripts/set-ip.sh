#!/bin/bash
ip=$1
gateway=$2
dns=$3
if [ -z $ip ] || [ -z $gateway ] || [ -z $dns ] 
then
	echo "Usage:"
	echo "set-ip.sh <ip> <gateway> <dns>"
	echo "e.g. set-ip.sh 192.168.1.101 192.168.1.1 8.8.8.8"
	exit 1
fi

sudo cat <<EOT >> /etc/dhcpcd.conf
interface eth0
static ip_address=$ip/24
static routers=$gateway
static domain_name_servers=$dns
EOT