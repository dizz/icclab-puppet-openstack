# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :os_ctl do |os_ctl|

    hostname = os_ctl.vm.hostname = "ctl.cloudcomplab.dev"

    os_ctl.vm.box = "raring-server-cloudimg-vagrant-amd64-disk1"
    # os_ctl.vm.box = "ubuntu13-latest"
    os_ctl.vm.box_url = "http://cloud-images.ubuntu.com/raring/current/raring-server-cloudimg-vagrant-amd64-disk1.box"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # [--nictype<1-N> Am79C970A|Am79C973|82540EM|82543GC|82545EM|virtio]
    # [--nicpromisc<1-N> deny|allow-vms|allow-all]

    # eth1
    os_ctl.vm.network :private_network, ip: "10.10.100.51", netmask: "255.255.255.0", nic_type: '82545EM'
    # eth2 pub mgt
    os_ctl.vm.network :private_network, ip: "192.168.100.51", netmask: "255.255.255.0", nic_type: '82545EM'
    # eth3 egress traffic
    os_ctl.vm.network :private_network, ip: "192.168.100.52", netmask: "255.255.255.0", nic_type: '82545EM'
    
    os_ctl.vm.provider :virtualbox do |vb|
      # Boot with headless mode vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      #eth3
      vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    end

    os_ctl.vm.provision :shell, :inline => "apt-get update && apt-get -y upgrade" # && apt-get -y dist-upgrade

    os_ctl.vm.provision :puppet do |os_aio_puppet|
      # let's force that fqdn is set
      os_aio_puppet.facter = { "fqdn" => hostname }
      os_aio_puppet.pp_path = "/tmp/vagrant-puppet"
      os_aio_puppet.module_path = "modules"
      os_aio_puppet.manifests_path = "manifests"
      os_aio_puppet.manifest_file = "site.pp"
      os_aio_puppet.options = "--verbose" #--debug
    end
  end

  config.vm.define :os_cmp do |os_cmp|
    hostname = os_cmp.vm.hostname = "cmp.cloudcomplab.dev"
    # os_cmp.vm.box = "raring-server-cloudimg-vagrant-amd64-disk1"
    os_cmp.vm.box = "ubuntu13-latest"
    os_cmp.vm.box_url = "http://cloud-images.ubuntu.com/raring/current/raring-server-cloudimg-vagrant-amd64-disk1.box"

    # eth1
    os_cmp.vm.network :private_network, ip: "10.10.100.52", netmask: "255.255.255.0", nic_type: '82545EM'

    os_cmp.vm.provider :virtualbox do |vb|
      # Boot with headless mode vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      #eth2
      #vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    end

    os_cmp.vm.provision :shell, :inline => "apt-get update && apt-get -y upgrade" # && apt-get -y dist-upgrade
    
    os_cmp.vm.provision :puppet do |os_aio_puppet|
      # let's force that fqdn is set
      os_aio_puppet.facter = { "fqdn" => hostname }
      os_aio_puppet.pp_path = "/tmp/vagrant-puppet"
      os_aio_puppet.module_path = "modules"
      os_aio_puppet.manifests_path = "manifests"
      os_aio_puppet.manifest_file = "site.pp"
      os_aio_puppet.options = "--verbose" #--debug
    end
  end
end
