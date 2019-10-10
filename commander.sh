#!/bin/bash

# prepare and deploy kubeadm
ansible-playbook -i hosts ~/kube-cluster/initial.yml
ansible-playbook -i hosts ~/kube-cluster/kube-dependencies.yml
ansible-playbook -i hosts ~/kube-cluster/master.yml
ansible-playbook -i hosts ~/kube-cluster/workers.yml

# deploy the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
kubectl create -n kube-system serviceaccount admin
kubectl create clusterrolebinding permissive-binding \
	--clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts

# install helm and addons
sudo snap install helm
helm init
helm repo update
helm install stable/metrics-server --name metrics-server --namespace kube-system
### path the metrics server deployment
#kubectl edit deploy -n kube-system metrics-server
#        - --kubelet-preferred-address-types=InternalIP
#        - --kubelet-insecure-tls=true
#        - --kubelet-port=10250


### install NFS SC
# on comppute node
sudo apt-get install nfs-common

# on master node
sudo apt install nfs-kernel-server -y
sudo mkdir -p /mnt/kubeshare
sudo chown nobody:nogroup /mnt/kubeshare/
sudo chmod 777 /mnt/kubeshare/
# in /etc/exports /mnt/kubeshare 192.168.121.0/24(rw,sync,no_subtree_check)
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
helm install --name nfs-client-provisioner --namespace kube-system --set nfs.server=192.168.121.10 --set nfs.path=/mnt/kubeshare stable/nfs-client-provisioner

helm install stable/prometheus --name prometheus --namespace kube-system


### useful commands
#kubectl -n kube-system get cm kubeadm-config -oyaml
#kubectl describe pod kube-apiserver -n kube-system
#kubectl get apiservices
#kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
#kubectl run --rm utils -it --generator=run-pod/v1 --image arunvelsriram/utils bash
