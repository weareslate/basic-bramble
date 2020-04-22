#!/bin/bash
if [[ -z $1 ]]; then
	echo "Usage:"
	echo "init-node.sh <nodename>"
	echo "e.g. init-node.sh node1"
	exit 1
fi
echo "🛸 Configuring Pi as K8S worker node"
if [[ $EUID -ne 0 ]]; then
   echo "must be run as root" 
   exit 1
fi
/boot/scripts/setup.sh
/boot/scripts/set-hostname.sh $1.kube.local
echo "🔑 You will now be asked for master1 password"
joincmd=$(ssh -t pi@master1.kube.local 'sudo kubeadm token create --print-join-command 2> /dev/null')
joincmd=$(echo $joincmd | sed 's/\r//g')
eval sudo $joincmd
echo "✅ All Done"
echo "Please reboot to make sure all settings take effect"