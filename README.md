# Basic Bramble

This repo will help you setup a basic Kubernetes cluster using Raspberry Pis

## Flashing SD cards
1. Get 2 or more Raspberry Pi 4's plus SD cards (I went with 32GB)
2. Download "raspbian buster lite" image: https://www.raspberrypi.org/downloads/raspbian/
3. Flash each of your cards
4. Copy the contents of setup-files onto the "boot" partition of the SD card, which should be mounted on your machine. (this includes a folder of scripts and a file called ssh which enables you to ssh in without needing a monitor/keyboard etc.)
5. Copy script folder from this repo to boot partition
6. Put cards in Pis

## Master setup
1. Power on first pi (we do one by one so we can figure out IPs)
2. Figure out the IP - your router or some IP scanner software can help
3. ssh in using username pi and password raspberry
4. Run `/boot/scripts/init-master.sh`
5. Copy contents of /etc/kubernetes/admin.conf to your local machine as $HOME/.kube/config

## Nodes setup
1. Power on another pi (we do one by one so we can figure out IPs)
2. Figure out the IP - your router or some IP scanner software can help
3. ssh in using username pi and password raspberry
4. Run `sudo echo "192.168.1.39 master1.kube.local" >> /etc/hosts`
5. Run `/boot/scripts/init-node.sh node1` (change node number as you do each one)
6. Repeat for each node

## Finishing off
Reboot all the Pis as some changes need this