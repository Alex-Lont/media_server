# Docker install of apps for media server
***note i am using x86 architecture. I have not tested this with arm***
Include docker compose for 20 containers_
Designed for primarily as a media server
But used server monitoring and IOT/Home Automation

# Bash Script 
**Designed for ubuntu 20.04**
update relevant files in .env file 
ip ranges
network driver
file locations
VPN credientials i use PIA
User and PUID and GUID
Timezone

What the script does
sets up a static ip address based on what you set in the .env files.
installs docker and adds user.
nvidia docker support for plex hardware accelleration (Quatro P400)
***hash lines 23-31 in run.sh and lines 292-293 in docker-compose.yaml to remove this***

set up Macvlan for pi Hole adress
will be used for Nginx proxy/swag and nextcloud

# Run script with
```sudo ./run.sh```

# Containers
-Qbittorrent with VPN
https://hub.docker.com/r/markusmcnugen/qbittorrentvpn
-Jacket with VPN
https://hub.docker.com/r/dyonr/jackettvpn
-Radarr
https://hub.docker.com/r/linuxserver/radarr
-Sonarr
https://hub.docker.com/r/linuxserver/sonarr
-Bazarr
https://hub.docker.com/r/linuxserver/bazarr
-Organizr
https://hub.docker.com/r/organizr/organizr
-Wireshark
https://hub.docker.com/r/linuxserver/wireshark
-Code-server
https://hub.docker.com/r/linuxserver/code-server
-Prometheus
https://hub.docker.com/r/prom/prometheus
-Node-exporter
https://github.com/prometheus/node_exporter
-Grafana
https://hub.docker.com/r/grafana/grafana
-Node-Red
https://hub.docker.com/r/nodered/node-red
-Mosquitto MQTT
https://hub.docker.com/_/eclipse-mosquitto
-Watchtower
https://hub.docker.com/r/containrrr/watchtower
-PiHole
https://hub.docker.com/r/pihole/pihole
-Home Assistant
https://hub.docker.com/r/homeassistant/home-assistant
-Portainer-ce
https://hub.docker.com/r/portainer/portainer-ce
-Dozzle
https://hub.docker.com/r/amir20/dozzle
-SpeedTest
https://hub.docker.com/r/henrywhitaker3/speedtest-tracker
-Plex
https://hub.docker.com/r/linuxserver/plex
-OpenVPN
https://hub.docker.com/r/kylemanna/openvpn

# Coming soon
-nginx Reverse proxy/SWAG
-Fail2ban
-NextCloud
-Openvpn docker compose hopefully

# For vpn apps qbit and jacket
vpn files in config
/config/openvpn
ca.rsa.4096
ca.rsa.4096.pem
Singapore.ovpn

# Openvpn via docker cli
OVPN_DATA="ovpn-data"
	
docker volume create --name $OVPN_DATA
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://lontnetwork.tplinkdns.com
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki

docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn