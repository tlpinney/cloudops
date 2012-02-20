#!/bin/sh 

sudo apt-get install git -y
git clone https://github.com/tlpinney/cloudops.git 
cd cloudops 
git checkout v0.2 
sh install.sh 

