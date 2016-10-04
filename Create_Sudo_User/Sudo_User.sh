#!/bin/bash
# Create a New User With Sudo Privileges for Testing Purposes

display_usage() {
	echo -e "\nUsage: sudo $0 [UserNameToAdd] \n"
	}

if [[ -z "$1" ]] || [[ $1 == "--help" ]] || [[ $USER != "root" ]]
	then
		display_usage
		exit 0
else
	PASS=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c8`
	useradd -m $1
	echo "=== Your $1 user password is $PASS ==="
	echo "$1:$PASS" | chpasswd
	unset PASS
	usermod -a -G sudo $1
	chsh -s /bin/bash $1
fi
