# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

Vagrant.configure("2") do |config|
  config.vm.define "kubemaster" do |kubemaster|
    kubemaster.vm.box = "generic/ubuntu1804"
    kubemaster.vm.hostname = 'kubemaster'
#    kubemaster.vm.network :private_network,
#      :libvirt__network_name => "cloud",
#      :libvirt__host_ip => '192.168.100.10'
    kubemaster.vm.provider :libvirt do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "kubenode" do |kubenode|
    kubenode.vm.box = "generic/ubuntu1804"
    kubenode.vm.hostname = 'kubenode'
#    kubenode.vm.network :private_network,
#      :libvirt__network_name => "cloud",
#      :libvirt__host_ip => '192.168.100.11'
    kubenode.vm.provider :libvirt do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end
end
