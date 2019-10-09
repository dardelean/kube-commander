# kube-commander

A set of scripts to deploy k8s with Vagrant, kubeadm and Ansible.

The deployment consists of one master and one compute node.


The master node will have this net config. Vagrant will create a NAT network by default with 192.168.121.0/24 subnet.

```bash
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
 version: 2
 renderer: networkd
 ethernets:
   eth0:
     dhcp4: no
     dhcp6: no
     addresses: [192.168.121.10/24]
     gateway4: 192.168.121.1
     nameservers:
       addresses: [8.8.8.8, 8.8.4.4]
```

The compute node will look almost the same, but with `192.168.121.11` IP.
