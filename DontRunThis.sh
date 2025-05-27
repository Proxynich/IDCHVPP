#!/bin/bash

echo "Downloading Required Packages"
apt-get install cpufrequtils iftop htop git build-essential net-tools ipmitool lshw rsync net-tools traceroute snmpd snmp iptables ipmitool lm-sensors libmnl-dev ethtool traceroute make  -y
echo "-----------------------------"
echo ""
echo ""
echo "-----------------------------"
echo "Set Up Performance Mode in Governor"
echo 'GOVERNOR="performance"' > /etc/default/cpufrequtils
systemctl enable cpufrequtils
systemctl start cpufrequtils
mkdir -p /var/log/vpp
echo "-----------------------------"
echo ""
echo ""
echo "-----------------------------"
echo "Applying Configuration for HugePages and etc"
cp ./80-vpp.conf /etc/sysctl.d/86-vpp.conf
cp ./81-vpp-netlink.conf /etc/sysctl.d/81-vpp-netlink.conf
cp ./netns-dataplane.service /usr/lib/systemd/system/netns-dataplane.service
cp ./ssh-dataplane.service /usr/lib/systemd/system/ssh-dataplane.service
cp ./dpdk-bind.sh /usr/local/bin/dpdk-bind.sh
cp ./dpdk-bind.service /etc/systemd/system/dpdk-bind.service
cp +x /etc/systemd/system/dpdk-bind.service
sysctl -p -f /etc/sysctl.d/80-vpp.conf
sysctl -p -f /etc/sysctl.d/81-vpp-netlink.conf
systemctl enable netns-dataplane
systemctl start netns-dataplane
systemctl enable ssh-dataplane
systemctl start ssh-dataplane
systemctl enable dpdk-bind.service
echo "-----------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------"
echo "Downloading VPP and Installing VPP"
mkdir -p ~/src
cd ~/src
git clone -b stable/2502 https://gerrit.fd.io/r/vpp
cd vpp/
make install-deps
make install-ext-deps
make build-release
make pkg-deb
dpkg -i build-root/*.deb
echo "-----------------------------"
echo ""
echo ""
echo ""
echo "-----------------------------"
echo "REBOOTING SYSTEM"
echo "You Will Not Able To Power On This Server Again :D"

