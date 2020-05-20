
#!/bin/bash

#stop and disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#delete nftables
sudo yum remove nftables -y

#install iptables-services
sudo yum install iptables-services -y

#start and enable iptables-services
sudo systemctl start iptables-services
sudo systemctl enable iptables services

