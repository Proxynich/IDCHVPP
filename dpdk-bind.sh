#!/bin/bash

# Bring Up the Driver
modprobe vfio-pci

# Unbind NIC from Kernel Driver
echo 0000:2d:00.0 > /sys/bus/pci/devices/0000:2d:00.0/driver/unbind
echo 0000:2d:00.1 > /sys/bus/pci/devices/0000:2d:00.1/driver/unbind
echo 0000:23:00.0 > /sys/bus/pci/devices/0000:23:00.0/driver/unbind
echo 0000:23:00.1 > /sys/bus/pci/devices/0000:23:00.1/driver/unbind

# Bind to DPDK Compatible Driver
dpdk-devbind.py --bind=mlx5_core 0000:2d:00.0
dpdk-devbind.py --bind=mlx5_core 0000:2d:00.1
dpdk-devbind.py --bind=vfio-pci 0000:23:00.0
dpdk-devbind.py --bind=vfio-pci 0000:23:00.1
