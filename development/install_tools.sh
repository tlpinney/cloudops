# this should run as the ubuntu user 
# add in the 

cd
mkdir local
cd local
wget http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz
tar xzvf eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz
wget http://mirrors.ibiblio.org/apache/maven/binaries/apache-maven-3.0.4-bin.tar.gz
tar xzvf apache-maven-3.0.4-bin.tar.gz
echo "export PATH=$PATH:$HOME/accumulo/bin:$HOME/local/eclipse:$HOME/local/apache-maven-3.0.4/bin" >> ~/.profile 

# install m2e plugin in maven
# open up an existing maven project at /home/ubuntu/accumulo-1.3.5-incubating 
# there may be build errors when loading up the maven file, right click on the 
# red Xs and hit Quick Fix
  
