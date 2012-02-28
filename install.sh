#!/bin/bash

sudo sysctl -w vm.swappiness=0

echo -e "ubuntu\t\tsoft\tnofile\t65536" | sudo tee --append /etc/security/limits.conf
echo -e "ubuntu\t\thard\tnofile\t65536" | sudo tee --append /etc/security/limits.conf


# install software

RELEASE=`lsb_release -c | awk {'print $2'}`

curl -s http://archive.cloudera.com/debian/archive.key | sudo apt-key add -

sudo apt-get install python-software-properties -y
sudo add-apt-repository "deb http://archive.canonical.com/ $RELEASE partner"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ $RELEASE multiverse"
sudo add-apt-repository "deb http://archive.cloudera.com/debian $RELEASE-cdh3b4 contrib"

sudo apt-get update

sudo apt-get install git puppet -y

cd 

# check if you cached the deb files
# need to work on this
#if [ -f "/vagrant/cached/sun-java6-bin_6.31-1~maverick1_amd64.deb" ] 
#then 
#cd /vagrant/cached 
#sudo apt-key add pubkey.asc
#sudo dpkg -f -i sun-java6-bin_6.31-1~maverick1_amd64.deb sun-java6-fonts_6.31-1~maverick1_all.deb sun-java6-javadb_6.31-1~maverick1_all.deb sun-java6-jdk_6.31-1~maverick1_amd64.deb sun-java6-jre_6.31-1~maverick1_all.deb 
#cd

#else
wget https://raw.github.com/flexiondotorg/oab-java6/master/oab-java6.sh -O oab-java6.sh
chmod +x oab-java6.sh
sudo ./oab-java6.sh
sudo apt-get install sun-java6-jdk -y --force-yes
#fi 



ssh-keygen -q -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys
ssh-keyscan localhost >> ~/.ssh/known_hosts
ssh-keyscan 127.0.0.1 >> ~/.ssh/known_hosts
# depending on the cluster configuration, will need to add more to known_hosts
# these need to be added dynamically in puppet 



sudo apt-get install gcc g++ python-software-properties hadoop-0.20 hadoop-0.20-namenode hadoop-0.20-datanode hadoop-0.20-jobtracker hadoop-0.20-tasktracker hadoop-zookeeper xfsprogs -y

sudo apt-get install hadoop-zookeeper-server -y



# get Accumulo

if [ ! -f "/vagrant/cached/accumulo-1.3.5-incubating-dist.tar.gz" ]
then
wget http://www.alliedquotes.com/mirrors/apache/incubator/accumulo/1.3.5-incubating/accumulo-1.3.5-incubating-dist.tar.gz
else
cp /vagrant/cached/accumulo-1.3.5-incubating-dist.tar.gz ~
fi


tar -xzf accumulo-1.3.5-incubating-dist.tar.gz
ln -s accumulo-1.3.5-incubating accumulo

sudo cp accumulo/lib/accumulo-core-1.3.5-incubating.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/log4j-1.2.16.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/libthrift-0.3.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/cloudtrace-1.3.5-incubating.jar /usr/lib/hadoop/lib/
sudo cp /usr/lib/zookeeper/zookeeper.jar /usr/lib/hadoop/lib/


# setup data directory

if [ ! -d "/home/vagrant" ] 
then
  sudo umount /mnt;
  sudo /sbin/mkfs.xfs -f /dev/sdb;
  sudo mount -o noatime /dev/sdb /mnt;

  sudo mkdir /mnt2;
  sudo /sbin/mkfs.xfs -f /dev/sdc;
  sudo mount -o noatime /dev/sdc /mnt2;
else
  sudo mkdir /mnt2;
fi

sudo chown -R ubuntu /mnt
sudo chown -R ubuntu /mnt2

mkdir /mnt/hdfs
mkdir /mnt/namenode
mkdir /mnt/mapred
mkdir /mnt/walogs

mkdir /mnt2/hdfs
mkdir /mnt2/mapred

sudo chown -R hdfs /mnt/hdfs
sudo chown -R hdfs /mnt/namenode
sudo chown -R mapred /mnt/mapred

sudo chown -R hdfs /mnt2/hdfs
sudo chown -R mapred /mnt2/mapred


# Run puppet apply, this sets up various configs

if [ ! -d "/home/vagrant" ] 
then
   sudo puppet apply /home/ubuntu/cloudops/accumulo.pp 
else 
   mkdir -p /home/ubuntu/cloudops/configs/
   cp -r /vagrant/configs/* /home/ubuntu/cloudops/configs
   sudo puppet apply /vagrant/accumulo.pp
fi 


# hack so it can format without bothering user 
sudo chown hdfs /mnt
sudo rmdir /mnt/namenode
sudo -u hdfs hadoop namenode -format
sudo chown root /mnt 

# start up daemons 
sudo /etc/init.d/hadoop-0.20-datanode start
sudo /etc/init.d/hadoop-0.20-namenode start
sudo /etc/init.d/hadoop-0.20-tasktracker start

# I don't recommend this ...
sudo -u hdfs hadoop fs -chmod a+rwx /

# Start up the last daemon 
sudo /etc/init.d/hadoop-0.20-jobtracker start

# Bounce zookeeper 
sudo /etc/init.d/hadoop-zookeeper-server restart 



# install gui development environment if it is the vm 
if [ -d "/home/vagrant" ] 
then
cd
sudo apt-get install xorg -y
sudo apt-get install openbox -y
sudo apt-get install firefox -y
sudo apt-get install gnome-terminal -y
sudo apt-get install libsvn-java -y
#sudo su - ubuntu 
#wget http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz
#tar xzvf eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz
fi 











