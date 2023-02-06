#!/bin/bash

# Download necessary binaries
cd /tmp
curl -LO https://dl.k8s.io/release/stable.txt
curl -L https://dl.k8s.io/release/$(cat stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
curl -L https://dl.k8s.io/release/$(cat stable.txt)/bin/linux/amd64/kubelet
chmod +x kubelet
sudo mv kubelet /usr/local/bin/
curl -L https://dl.k8s.io/release/$(cat stable.txt)/bin/linux/amd64/kubeadm
chmod +x kubeadm
sudo mv kubeadm /usr/local/bin/

# Start the kubelet service
sudo su
echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl enable kubelet
systemctl start kubelet

# Initialize the cluster
kubeadm init --pod-network-cidr=10.244.0.0/16

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a pod network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
