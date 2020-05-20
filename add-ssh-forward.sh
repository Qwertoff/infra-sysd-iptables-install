#!/bin/bash


helpFunction()
{
   echo ""
   echo "Usage: $0 -i parameterA -p parameterB"
   echo -e "\t-i Ip of INTERNAL host."
   echo -e "\t-p Destination port."
   exit 1 # Exit script after printing help
}

while getopts "i:p:" opt
do
   case "$opt" in
      i ) parameterA="$OPTARG" ;;
      p ) parameterB="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$parameterA" ] || [ -z "$parameterB" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct and delete all duplicates
prerouting_rule="PREROUTING -p tcp --dport $parameterB -j DNAT --to-destination $parameterA:22"
postrouting_rule="POSTROUTING -j MASQUERADE"
forward_rule="FORWARD -j ACCEPT"

while sudo iptables -t nat -C $prerouting_rule ; do
	sudo iptables -t nat -D $prerouting_rule
done

while sudo iptables -t nat -C $postrouting_rule ; do
        sudo iptables -t nat -D $postrouting_rule
done

while sudo iptables -C $forward_rule ; do
        sudo iptables -D $forward_rule
done

# Adding rules

sudo iptables -t nat -I $prerouting_rule
sudo iptables -t nat -I $postrouting_rule
sudo iptables -I $forward_rule


#enable forwarding
sudo sysctl -w net.ipv4.ip_forward=1

#saving iptables
sudo bash -c "iptables-save > /etc/sysconfig/iptables"

#echo result
# echo "===Now you can connect to internal host with ip $parameterA using port $parameterB==="
