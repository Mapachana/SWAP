#!/bin/sh

# Script para denegar todo el trafico

iptables -P INPUT DROP
iptables -p OUTPUT DROP
iptables -P FORWARD DROP
iptables -L -n -v
