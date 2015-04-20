#!/bin/sh

######################################
##This script will enabled Remote Management & Remote Login.
##It will change the computer name to a naming scheme based off last 7 digits of serial.
##Disable the Gatekeeper and launch Safari to the Casper enrollment page.
#######################################

##Turn on Remote Management for all users
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -allUsers -access -on -restart -agent -privs -all

##Turn on Remote Login
sudo systemsetup -setremotelogin on 

##Set Security to open apps from anywhere.
sudo spctl --master-disable

##Get serial number to turn it into a computer name
serial=$(ioreg -rd1 -c IOPlatformExpertDevice | awk -F '"' '/IOPlatformSerialNumber/{print $4}'| sed 's/.*\(.......\)/\1/')

##Add assinged prefix
cname=$"M-$serial"

##Set the machine names
scutil --set ComputerName "$cname"
scutil --set LocalHostName "$cname"
scutil --set HostName "$cname"

echo $cname

##This requires the domains, a user name + password, and OU
dsconfigad -add "" -username "" -password "" -ou "OU=,OU=,DC=" -force

exit
