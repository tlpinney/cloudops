Accumulo Rapid Setup 

tlpinney - travis.pinney@gmail.com

Based on 
install.sh: Original from  http://www.accumulodata.com/install.sh
java was removed from ubuntu. Modified to use https://github.com/flexiondotorg/oab-java6 for java.


* To install on Amazon EC2

Set up a m1.large instance manually using aws console 
... or 
use Chef 

* Set up chef 

* Install ruby and rubygems (If not already installed)
* sudo gem install knife-ec2 chef 
 
mkdir ~/.chef 
cp knife.py ~/.chef

# setup your enviroment variables for your keys (in .profile or another file) 
export AWS_ACCESS_KEY_ID=XXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXX

# create a amazon ec2 key pair for accumulo and save it to ~/.ssh/accumulo.pem

 
knife ec2 server create -r 'role[webserver]' -I ami-08f40561 -f m1.large
knife ec2 server list 

# get the ip address and connect to it 

ssh -i ~/.ssh/accumulo.pem ubuntu@ec2box 

sh -c "$(curl -fsSL https://raw.github.com/tlpinney/cloudops/v0.2/seed.sh)"

# set up your instance name and password 
~/accumulo/bin/accumulo init

# start the services 
~/accumulo/bin/start-all.sh
 
# Log into the console 
~/accumulo/bin/accumulo shell -u root 



* To Install Locally (Vagrant Instance)

NOTE: The VM is configured to use 6GB. You will need at least 8GB of ram in your host machine. Only tested on a Mac. Manually open development box in VirtualBox. Give it two cores, and make sure "Use host I/O cache" is enabled on the SATA
controller.

Windows Install 
Recommended if installing vagrant on Windows
http://rubyinstaller.org/

vagrant binary (if you can't install it from the gem for some reason)
http://downloads.vagrantup.com/tags/v1.0.0.rc2

virtualbox
https://www.virtualbox.org/wiki/Downloads



Mac Install
macosx installer for git (if you dont already have it)
http://code.google.com/p/git-osx-installer/

vagrant binary (if you can't install it from the gem for some reason)
http://downloads.vagrantup.com/tags/v1.0.0.rc2

virtualbox
https://www.virtualbox.org/wiki/Downloads


Linux Install 
Install ruby and rubygems
sudo gem install vagrant 






vagrant up 

vagrant ssh  # this will login to the vm as vagrant, you will need to su to ubuntu
sudo su - ubuntu
# the install.sh expects to be run as ubuntu user
sh /vagrant/install.sh
~/accumulo/bin/accumulo init
~/accumulo/bin/start-all.sh
~/accumulo/bin/accumulo shell -u root 

# Optional to install set up gui.
# uncomment out "config.vm.boot_mode = :gui" in VagrantFile

# login and password is : ubuntu
# Reinstall guest additions to get xserver module loaded 
# Go to the tab in VirtualBox, Devices -> Install Guest Additions.. 
sudo mount /dev/cdrom /media/cdrom
sudo sh /media/cdrom/VBoxLinuxAdditions.run

startx 

# this will run openbox 



# Show accumulo classpath
accumulo classpath

# show the available instances 
accumulo org.apache.accumulo.server.util.ListInstances

# example for inserting data  
accumulo org.apache.accumulo.examples.helloworld.InsertWithBatchWriter cloud 127.0.0.1 table root password








