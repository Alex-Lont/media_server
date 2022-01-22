#! /bin/bash
#read .evn file
set -o xtrace
export $(egrep -v '^#' .env | xargs)

apt install -y net-tools 
#set static ip
sed -i 's@NETWORK_DRIVER@'"${NETWORK_DRIVER}"'@' 01-network-manager-all.yaml
sed -i 's@IP_ADRESS@'"${IP_ADRESS}"'@' 01-network-manager-all.yaml
sed -i 's@GATEWAY_IP@'"${GATEWAY_IP}"'@' 01-network-manager-all.yaml
sed -i 's@NAMESERVER_IP@'"${NAMESERVER_IP}"'@' 01-network-manager-all.yaml
cp ./01-network-manager-all.yaml /etc/netplan/01-network-manager-all.yaml
netplan apply
ifconfig

#Docker install for linux *note using ubuntu 20.04

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

groupadd docker
usermod -aG docker $USER
newgrp docker

#for hardware acceleration for plex *note using a quatro P400
#distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

apt-get update && apt-get install -y nvidia-container-toolkit
systemctl restart docker

#ip link add ${DOCKER_ROUTING_INTERFACE_NAME} link ${network_driver} type macvlan mode bridge 
#ip addr add ${DOCKERNETWORK_IP_ADDRESS} dev ${DOCKER_ROUTING_INTERFACE_NAME} 
#ip link set ${DOCKER_ROUTING_INTERFACE_NAME} up
#ip route add ${DOCKERNETWORK_IP_RANGE} dev ${DOCKER_ROUTING_INTERFACE_NAME}