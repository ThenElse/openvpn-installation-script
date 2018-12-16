#!/bin/bash
#
#https://github.com/ThenElse/openvpn-installation-script
#
#Copyright (c) 2018 Can Mert Released under the MIT License.
  
           

clear
#Root Control 
if [ "$(id -u)" != "0" ]; then
   echo -e "\033[33m\033[31mYou Are Not Root You must have root privileges to use Script\033[33m\e[0m" 1>&2
   exit 1
fi
#Root Control End
#Packet İnstall
if cat /etc/*release | grep ^NAME | grep CentOS; then
yum update
sudo yum -y install epel-release
sudo yum repolist
sudo yum install dpkg-devel dpkg-dev
yum install wget
yum install curl 
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
apt-get update
apt-get upgrade
apt-get install wget
apt-get install curl
elif cat /etc/*release | grep ^NAME | grep Debian ; then
apt-get update
apt-get upgrade
apt-get install wget
apt-get install curl
else
echo "Sorry! Unsupported operating system is effective."
exit 1;
fi
#Packet İnstall End
#Tun Control
clear
if [[ ! -e /dev/net/tun ]]; then
echo "The TUN device is not available
You need to enable TUN before running this script"
exit
fi
#Tun Control End
#İnstall
cd /root
check=`uname -m`
if [ "$check" = "x86_64" ];then
wget http://swupdate.openvpn.org/as/openvpn-as-2.6.1-Ubuntu16.amd_64.deb
dpkg -i openvpn-as-2.6.1-Ubuntu16.amd_64.deb
elif [ "$check" = "i686" ];then
wget http://swupdate.openvpn.org/as/openvpn-as-2.6.1-Ubuntu16.i386.deb
dpkg -i openvpn-as-2.6.1-Ubuntu16.i386.deb
elif [ "$check" = "i386" ];then
wget http://swupdate.openvpn.org/as/openvpn-as-2.6.1-Ubuntu16.i386.deb
dpkg -i openvpn-as-2.6.1-Ubuntu16.i386.deb
fi
#İnstall End
#Random Password
MATRIX='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
LENGTH=5
while [ ${n:=1} -le $LENGTH ]; do
PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
let n+=1
done
#Random Password End
#Change Password
echo openvpn:$PASS | chpasswd
#Change Password End
ip=`curl -s icanhazip.com`
clear
echo -e "\033[1;31mİNFO:\033[1;33mAdmin  UI: https://$ip:943/admin
Client UI: https://$ip:943/
username:openvpn ~ password:$PASS  \033[0m"




