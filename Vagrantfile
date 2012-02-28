# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "maverick64"
  config.vm.box_url = "https://s3.amazonaws.com/osmdevbox/maverick64.box"
  config.vm.forward_port 80, 7080
  #config.vm.boot_mode = :gui

  # this is a beast, needs a lot of memory
  config.vm.customize [
    "modifyvm", :id,
    "--name", "Accumulo Dev VM v0.2",
    "--memory", "6144"
  ]
  
  

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "maverick64.pp"
  end

end
