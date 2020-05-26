# infra-gcp-bastion-init-rh8
scripts of base bastion configure;
## enable-iptables.sh
- Disable and delete firewalld;
- Disable and delete nftables;
- Install and enable iptables-services;
## add-ssh-forward.sh
- Add ssh forward to internal hosts;

Usage: 
        ./add-ssh-forward.sh -i "ip of internal host" -p "external port"
  
 ## setuppritunl.sh
 - Install pritunl vpn server;
  
