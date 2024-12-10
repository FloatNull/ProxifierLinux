#!/bin/sh

# del rules in REDSOCKS chain
iptables -t nat -D REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -D REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -D REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -D REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -D REDSOCKS -d 172.16.0.0/16 -j RETURN
iptables -t nat -D REDSOCKS -d 172.17.0.0/16 -j RETURN
iptables -t nat -D REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -D REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -D REDSOCKS -d 240.0.0.0/4 -j RETURN
iptables -t nat -D REDSOCKS -p tcp -j REDIRECT --to-ports 12345

# del REDSOCKS related OUTPUT rules
iptables -t nat -D OUTPUT -p tcp --dport 443 -j REDSOCKS
iptables -t nat -D OUTPUT -p tcp --dport 80 -j REDSOCKS

# del REDSOCKS related PREROUTING rules
iptables -t nat -D PREROUTING -p tcp --dport 443 -j REDSOCKS
iptables -t nat -t PREROUTING -p tcp --dport 80 -j REDSOCKS

# del custom chain
iptables -t nat -X REDSOCKS

killall redsocks
fuser -k 12345/tcp
