# Docker install of apps for media server
***Please note i am using x86 architecture. I have not tested this with arm***<br />
Include docker compose for 20 containers <br />
Designed for primarily as a media server <br />
But used server monitoring and IOT/Home Automation <br />

# Bash Script 
**Designed for ubuntu 20.04**
update relevant files in .env file 
- ip ranges
- network driver
- file locations
- VPN credientials i use PIA
- User and PUID and GUID
- Timezone

### What the script does
sets up a static ip address based on what you set in the .env files.<br />
installs docker and adds user.<br />
nvidia docker support for plex hardware accelleration (Quatro P400)<br />
***hash lines 23-31 in run.sh and lines 292-293 in docker-compose.yaml to remove this***<br />

set up Macvlan for pi Hole adress<br />
will be used for Nginx proxy/swag and nextcloud<br />

# Run script with
```sudo ./run.sh```

# Containers
- Qbittorrent with VPN
https://hub.docker.com/r/markusmcnugen/qbittorrentvpn
- Jacket with VPN
https://hub.docker.com/r/dyonr/jackettvpn
- Radarr
https://hub.docker.com/r/linuxserver/radarr
- Sonarr
https://hub.docker.com/r/linuxserver/sonarr
- Bazarr
https://hub.docker.com/r/linuxserver/bazarr
- Organizr
https://hub.docker.com/r/organizr/organizr
- Wireshark (commented out)
https://hub.docker.com/r/linuxserver/wireshark
- Code-server
https://hub.docker.com/r/linuxserver/code-server
- Prometheus
https://hub.docker.com/r/prom/prometheus
- Node-exporter
https://github.com/prometheus/node_exporter
- Grafana
https://hub.docker.com/r/grafana/grafana
- Node-Red
https://hub.docker.com/r/nodered/node-red
- Mosquitto MQTT
https://hub.docker.com/_/eclipse-mosquitto
- Watchtower (commented out)
https://hub.docker.com/r/containrrr/watchtower
- Home Assistant
https://hub.docker.com/r/homeassistant/home-assistant
- Portainer-ce
https://hub.docker.com/r/portainer/portainer-ce
- Dozzle
https://hub.docker.com/r/amir20/dozzle
- SpeedTest
https://hub.docker.com/r/henrywhitaker3/speedtest-tracker
- Plex
https://hub.docker.com/r/linuxserver/plex
- PiHole
https://hub.docker.com/r/pihole/pihole
- Cloudflared
https://hub.docker.com/r/cloudflare/cloudflared
- nginx
https://nginxproxymanager.com/guide/#project-goal
- PiHole
https://hub.docker.com/r/pihole/pihole
- Cloudflair dns
https://hub.docker.com/r/oznu/cloudflare-ddns/
- Wireguard (commented out)
https://hub.docker.com/r/linuxserver/wireguard
- Tdarr
https://hub.docker.com/r/haveagitgat/tdarr

# Coming soon
- Fail2ban
- NextCloud
- influxdb

# For vpn apps qbit and jacket
vpn files in config <br />
/config/openvpn <br />
ca.rsa.4096 <br />
ca.rsa.4096.pem <br />
Singapore.ovpn <br />