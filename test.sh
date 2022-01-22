#! /bin/bash
#read .evn file
set -o xtrace
export $(egrep -v '^#' .env | xargs)

sed -i 's@NETWORK_DRIVER@'"${NETWORK_DRIVER}"'@' 01-network-manager-all.yaml
sed -i 's@IP_ADRESS@'"${IP_ADRESS}"'@' 01-network-manager-all.yaml
sed -i 's@GATEWAY_IP@'"${GATEWAY_IP}"'@' 01-network-manager-all.yaml
sed -i 's@NAMESERVER_IP@'"${NAMESERVER_IP}"'@' 01-network-manager-all.yaml