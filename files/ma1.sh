#!/usr/bin/bash

MGT_IPADDRESS=$(ip addr list ma1 | grep inet |cut -d ' ' -f6|cut -d/ -f1)
DEFAULT_GW=$(/sbin/ip route | awk '/default/ { print $3 }')

echo $MGT_IPADDRESS
echo $DEFAULT_GW


FastCli -p 15 -c "configure 
ip routing
!
ip routing vrf management
!
vrf definition management
   rd 100:100
!
interface Management1
  vrf forwarding management
  ip address $mgt_ipaddress/24
  no shutdown
!
ip route vrf management 0.0.0.0/0 $DEFAULT_GW
exit"
