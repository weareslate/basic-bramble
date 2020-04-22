#!/bin/bash
echo "🛸 Configuring Pi as K8S master"
if [[ $EUID -ne 0 ]]; then
   echo "🛑 Must be run as root" 
   exit 1
fi

/boot/scripts/setup.sh
/boot/scripts/set-hostname.sh master1.kube.local
kubeadm init --node-name=master1.kube.local --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
echo "✅ All Done"
echo "Please reboot to make sure all settings take effect"