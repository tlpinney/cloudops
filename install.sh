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

sudo apt-get install git -y

cd 
wget https://raw.github.com/flexiondotorg/oab-java6/master/oab-java6.sh -O oab-java6.sh
chmod +x oab-java6.sh
sudo ./oab-java6.sh
sudo apt-get install sun-java6-jdk



sudo apt-get install gcc g++ python-software-properties hadoop-0.20 hadoop-0.20-namenode hadoop-0.20-datanode hadoop-0.20-jobtracker hadoop-0.20-tasktracker hadoop-zookeeper xfsprogs -y


# get Accumulo

wget http://www.alliedquotes.com/mirrors/apache/incubator/accumulo/1.3.5-incubating/accumulo-1.3.5-incubating-dist.tar.gz
tar -xzf accumulo-1.3.5-incubating-dist.tar.gz
ln -s accumulo-1.3.5-incubating accumulo

sudo cp accumulo/lib/accumulo-core-1.3.5-incubating.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/log4j-1.2.16.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/libthrift-0.3.jar /usr/lib/hadoop/lib/
sudo cp accumulo/lib/cloudtrace-1.3.5-incubating.jar /usr/lib/hadoop/lib/
sudo cp /usr/lib/zookeeper/zookeeper.jar /usr/lib/hadoop/lib/


# setup data directory

sudo umount /mnt;
sudo /sbin/mkfs.xfs -f /dev/sdb;
sudo mount -o noatime /dev/sdb /mnt;

sudo mkdir /mnt2;
sudo /sbin/mkfs.xfs -f /dev/sdc;
sudo mount -o noatime /dev/sdc /mnt2;

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


