#!/usr/bin/bash

MGT_IPADDRESS=$(ip addr list ma1 | grep inet |cut -d ' ' -f6|cut -d/ -f1)
DEFAULT_GW=$(/sbin/ip route | awk '/default/ { print $3 }')
CIDR=/24

echo $MGT_IPADDRESS$CIDR

FastCli -p 15 -c "configure 
vrf definition management
   rd 100:100
!
interface Management1
  no ip address
  ip address $MGT_IPADDRESS$CIDR
  no shutdown
!
exit"
