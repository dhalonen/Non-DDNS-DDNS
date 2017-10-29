#!/bin/bash
# Copyright (c) 2017 David C. Halonen  
# The MIT License

# Capture the ip4 address from the router. This can change per Linux.
# grep for the network interface "inet "
# Substr only the ip address. In this example, a '/24' is included.
# Strip off the last 3 chars using a unix reversal trick.
# Store ip address in ip.txt
ip addr show eth0 | grep "inet " | awk -F' ' '{print substr($2,0)}' | rev | cut -c 4- | rev > ~/ip.txt

currentIp="/home/ubnt/current.txt"
if [ -f "$currentIp" ]
then
	DIFF=$(diff ip.txt current.txt)
	if [ "$DIFF" != "" ]; then
# Simple email notification. Can be email, scp, database entry... whatever you need.
		echo -e "to: youremail@gacme.com\nsubject: ip\n"| (cat - /home/ubnt/ip.txt) | /usr/sbin/ssmtp youremail@gacme.com
# Store the result for next comparison opportunity.
		rm current.txt
		cp ip.txt current.txt
	else
# No change notification - for testing.
		echo -e "to: youremail@gacme.com\nsubject: same\n" | /usr/sbin/ssmtp youremail@gacme.com
	fi
else
# Comparison file doesn't exist. Assume 1st time running, send notification & create comparison file.
	echo -e "to: youremail@gacme.com.com\nsubject: ip\n"| (cat - /home/ubnt/ip.txt) | /usr/sbin/ssmtp youremail@gacme.com
	cp ip.txt current.txt
fi
