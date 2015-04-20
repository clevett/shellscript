#!/bin/sh


##################################
# Clean out DNS Searches for following items
##################################

#Create a list of DNS
dnssuf=$""

#Find out what network servers are present
device=$(networksetup -listallnetworkservices)

#Check Network Services for the installed devices & add the DNS

#Check for standard Ethernet 
if ethernet=$(echo "$device" | grep -m 1 Ethernet); then
	/usr/sbin/networksetup -setsearchdomains "Ethernet" $dnssuf
	echo "$ethernet $dnssuf"
fi

#Check for Thunderbolt Ethernet
if thundere=$(echo "$device" | grep "Thunderbolt Ethernet"); then
	/usr/sbin/networksetup -setsearchdomains "$thundere" $dnssuf
	echo "$thundere $dnssuf"
fi

#Check for Wi-Fi
if wifi=$(echo "$device" | grep "Wi-Fi"); then
	/usr/sbin/networksetup -setsearchdomains "Wi-Fi" $dnssuf
	echo "$wifi $dnssuf"
fi
