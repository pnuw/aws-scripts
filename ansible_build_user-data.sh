#!/bin/bash
### ansible_build_user-data.sh
### 20160131 pnuwayser
### this is an aws user-data script to download ansible packages for installation
### on an offline server.
### Requires RHEL6
### reference: http://esbmagic.blogspot.com/2015/09/ansible-installation-on-redhat-rhel.html
### Outcome: a tarball of ansible and dependency RPMs in /tmp/ansible_rpms.tgz
### Install on the destination offline server as follows:
### 1. upload to offline server
### 2. tar zxvf ansible_rpms.tgz
### 3. sudo rpm -Uvh ./ansible/*.rpm

# start in the global tmp directory: /tmp
cd /tmp

# add the Extra Packages for Enterprise Linux (EPEL) yum repository
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm

# update the server
yum update -y

# create an ansible directory inside /tmp
mkdir /tmp/ansible
yum install yum-plugin-downloadonly -y
yum install --downloadonly --downloaddir=/tmp/ansible/ ansible -y
cd /tmp
tar zcf ansible_rpms.tgz ./ansible/* 
