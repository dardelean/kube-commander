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


#kubectl describe pod kube-apiserver -n kube-system
#kubectl get apiservices
