#!/bin/sh

/usr/sbin/sysctl -w net.inet.ip.forwarding=0
/usr/sbin/sysctl -w net.inet6.ip6.forwarding=0

# 1) Fetch the pf reference token that was generated on
#    Wireguard startup with postup.sh
TOKEN=`cat /usr/local/var/run/wireguard/pf_wireguard_token.txt`
TOKEN6=`cat /usr/local/var/run/wireguard/pf_wireguard_ipv6_token.txt`

# 2) Remove the reference (and by extension, the pf rule that
#    generated it). Adding and removing rules by references
#    like this will automatically disable the packet filter
#    firewall if there are no other references left, but will
#    leave it up and intact if there are.
ANCHOR='com.apple/wireguard'
pfctl -a $ANCHOR -F all || exit 1
echo "Removed rule with anchor: $ANCHOR"

pfctl -X $TOKEN || exit 1
echo "Removed reference for token: $TOKEN"

rm -f /usr/local/var/run/wireguard/pf_wireguard_token.txt
echo "Deleted token file"


## Do the same for IPv6
ANCHOR6='com.apple/wireguard_ipv6'
pfctl -a $ANCHOR6 -F all || exit 1
echo "Removed rule with anchor: $ANCHOR6"

pfctl -X $TOKEN6 || exit 1
echo "Removed reference for token: $TOKEN6"

rm -f /usr/local/var/run/wireguard/pf_wireguard_ipv6_token.txt
echo "Deleted token6 file"
