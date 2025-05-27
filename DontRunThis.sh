#!/bin/bash

echo "Downloading Required Packages"
apt-get install cpufrequtils iftop htop git build-essential net-tools ipmitool lshw rsync net-tools traceroute snmpd snmp iptables ipmitool lm-sensors libmnl-dev ethtool traceroute make -y
echo "-----------------------------"
echo ""
echo "-----------------------------"
echo "Set Up Performance Mode in Governor"
echo 'GOVERNOR="performance"' > /etc/default/cpufrequtils
systemctl enable cpufrequtils
systemctl start cpufrequtils
echo "REBOOTING SYSTEM"
echo "You Will Not Able To Power On This Server Again :D"

