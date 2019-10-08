# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.define "kubemaster" do |kubemaster|
    kubemaster.vm.box = "ubuntu/bionic64"
    kubemaster.vm.hostname = 'kubemaster'
    kubemaster.vm.network "private_network", ip: "192.168.1.10"
    kubemaster.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end

  config.vm.define "kubenode" do |kubenode|
    kubenode.vm.box = "ubuntu/bionic64"
    kubenode.vm.hostname = 'kubenode'
    kubenode.vm.network "private_network", ip: "192.168.1.11"
    kubenode.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end
end
