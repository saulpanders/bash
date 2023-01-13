#!/bin/sh

# automate iptables forwarding for redsocks
# to use on a Ubuntu16 router VM, to redir all traffic using this VM a gateway through a SOCKS proxy connection to target
# NOTE: proxy host and router VM must be on same subnet - proxy host must have router VM configured as its gateway
# edit the target ip & local VM net as needed (here 172.16.1.0/24 is hard-coded as the subnet)
# Empty all rules

iptables -t filter -F

iptables -t filter -X

# setup rules
iptables -t nat -F
iptables -t nat -N REDSOCKS
iptables -t nat -A PREROUTING -i ens33 -p tcp -j REDSOCKS
iptables -t nat -A PREROUTING -i ens33 -p udp -j REDSOCKS
iptables -t nat -L
iptables -t nat -A REDSOCKS -d 172.16.1.0/24 -j RETURN
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-port 8081

# setup port forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# show results
iptables -t nat -L
cat /proc/sys/net/ipv4/ip_forward

## CONNECTION DETAILS
# once redsocks is installed & configured
# ssh -L 8088:localhost:<socks port> root@<targetIP>
