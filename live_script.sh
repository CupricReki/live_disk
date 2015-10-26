#!/bin/bash
# Skyler Ogden
# Cupricreki@gmail.com
# Description: This script is ran from a live disk to appropriate the necessary repair utilities for boot repair
# Installed utilities: 
# 1. testdisk - partition recovery and data undeleter (http://www.cgsecurity.org/wiki/TestDisk)
# 2. 

install_programs=(testdisk boot-repair gparted guake sublime-text-installer)

user_conf ()
{ 
echo "Are you sure you would like to install the following software?:"
echo ""
for var in "${install_programs[@]}"; do
	echo "${var}"
done
echo ""
read -p "[Yy/Nn]"
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	echo "exitting"
	exit 1
fi
}	 

root_shell ()
{ # Test to make sure script was run as root user
	if [ "$EUID" -ne 0 ]; then
		echo "Please run $0 as root, exitting"
		exit
	fi
}
internet_access ()
{ # Queries google for connection confirmation --spider tag used to send a HEAD request instead of a GET request
	wget -q --tries=10 --timeout=20 --spider http://google.com 
	if [[ $? -ne 0 ]]; then
		echo "No internet connection, exitting"
		exit
	fi
}

install_basic ()
{
	add-apt-repository -y ppa:yannubuntu/boot-repair
	add-apt-repository -y ppa:webupd8team/sublime-text-3
	apt-get update
	for var in "${install_programs[@]}"; do
		apt-get install -y "${var}"
	done
}

root_shell
user_conf
internet_access
install_basic

echo "The following programs have been installed:"
echo ""
for var in "${install_programs[@]}"; do
	echo "${var}"
done
echo ""

exit


