#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "🛑 Must be run as root" 
   exit 1
fi

#Don't use swap - we want to use all of our resources, but once a node is full we should use another node rather than degrade performance
dphys-swapfile swapoff && \
dphys-swapfile uninstall && \
update-rc.d dphys-swapfile remove && \
systemctl disable dphys-swapfile.service

#enable Linux control groups
echo "$(head -n1 /boot/cmdline.txt) cgroup_enable=cpuset cgroup_enable=memory" > /boot/cmdline.txt

#This will allow pods to forward traffic from the internal k8s network to other nodes
sudo iptables -P FORWARD ACCEPT
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get install -y -q iptables-persistent

# Install Docker
curl -sSL get.docker.com | sh && \
usermod pi -aG docker

# Add repo list and install kubeadm
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
apt-get update -q && \
apt-get install -qy kubeadm

echo "✅ Initial setup complete"