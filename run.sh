#! /bin/bash
#read .evn file
set -o xtrace
export $(egrep -v '^#' .env | xargs)
#apt install -y curl
#Docker install for linux *note using ubuntu 20.04

read -p "Have you set a static ip" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    break
else
    apt install -y net-tools 
    #set static ip
    sed -i 's@NETWORK_DRIVER@'"${NETWORK_DRIVER}"'@' 01-network-manager-all.yaml
    sed -i 's@IP_ADRESS@'"${IP_ADRESS}"'@' 01-network-manager-all.yaml
    sed -i 's@GATEWAY_IP@'"${GATEWAY_IP}"'@' 01-network-manager-all.yaml
    sed -i 's@NAMESERVER_IP@'"${NAMESERVER_IP}"'@' 01-network-manager-all.yaml
    cp ./01-network-manager-all.yaml /etc/netplan/01-network-manager-all.yaml
    netplan apply
    ifconfig
fi

echo "You must manually run docker installation file"
read -p "Is Docker installed" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    break
else
    curl -fsSL https://get.docker.com -o get-docker.sh
    echo "run sh get-docker.sh"
    exit 1
fi

read -p "Do you have nvidia hardware for docker" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
        && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
        && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    apt update
    apt install -y nvidia-docker2
    systemctl restart docker
fi

read -p "Have you set up MACVLAN" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    break
else 
    ip link add dockerrouteif link ${NETWORK_DRIVER} type macvlan mode bridge 
    ip addr add ${DOCKERNETWORK_IP_ADDRESS} dev dockerrouteif 
    ip link set dockerrouteif up
    ip route add ${DOCKERNETWORK_IP_RANGE} dev dockerrouteif
fi

sed -i 's@${NETWORK_DRIVER}@'"${NETWORK_DRIVER}"'@' docker-compose.yml
sed -i 's@${DOCKERLAN_NETWORK}@'"${DOCKERLAN_NETWORK}"'@' docker-compose.yml
sed -i 's@${DOCKERNETWORK_IP_RANGE}@'"${DOCKERNETWORK_IP_RANGE}"'@' docker-compose.yml
sed -i 's@${DOCKERGATEWAY_IP}@'"${DOCKERGATEWAY_IP}"'@' docker-compose.yml

docker-compose up -d