#!/bin/sh

##Based off Set-DNS-info by franton (contact@richard-purves.com)

#Set the Network Devices you want to add DNS to
#Set the DNS search domains
Network="Ethernet"
Network2="VPN"
Network3="Wi-Fi"
searchDomain1=""
searchDomain2=""
searchDomain3=""
searchDomain4=""

#Create single array for DNS searches
dnsArray=$"$searchDomain1 $searchDomain2 $searchDomain3 $searchDomain4"

# Set $IFS
OLDIFS=$IFS
IFS=$'\n'

# Read, grep, and add devices to an array.
EtherArray=($( networksetup -listallnetworkservices | grep $Network ))
VPNArray=($( networksetup -listallnetworkservices | grep $Network2 ))
WifiArray=($( networksetup -listallnetworkservices | grep $Network3 ))
 
# Set $IFS back
IFS=$OLDIFS
 
##Add DNS to Ethernet devices
tLen=${#EtherArray[@]}
 for (( i=0; i<${tLen}; i++ ));
do
  echo "Network Service name to be configured - " "${EtherArray[$i]}"
  echo "Specified Search Domains addresses - " $dnsArray
  networksetup -setsearchdomains "${EtherArray[$i]}" $dnsArray
done

##Add DNS to VPN
tLen=${#VPNArray[@]}
 for (( i=0; i<${tLen}; i++ ));
do
  echo "Network Service name to be configured - " "${VPNArray[$i]}"
  echo "Specified Search Domains addresses - " $dnsArray
  networksetup -setsearchdomains "${VPNArray[$i]}" $dnsArray
done

##Add DNS to Wifi
tLen=${#WifiArray[@]}
 for (( i=0; i<${tLen}; i++ ));
do
  echo "Network Service name to be configured - " "${WifiArray[$i]}"
  echo "Specified Search Domains addresses - " $dnsArray
  networksetup -setsearchdomains "${WifiArray[$i]}" $dnsArray
done

# All done!
echo "Completed!"
exit 0