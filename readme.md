# Docker install of apps for media server
***Please note i am using x86 architecture. I have not tested this with arm***<br />
Include docker compose for 28 containers <br />
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

*hash lines 23-31 in run.sh and lines 292-293 in docker-compose.yaml to remove this*<br />

Set up Macvlan for pi-Hole adress<br />
This will be used for Nginx proxy/swag and nextcloud<br />

# Run script with
```
sudo ./run.sh
```

# Containers
- [Qbittorrent with VPN](https://hub.docker.com/r/markusmcnugen/qbittorrentvpn)
- [Jacket with VPN](https://hub.docker.com/r/dyonr/jackettvpn)
- [Radarr](https://hub.docker.com/r/linuxserver/radarr)
- [Sonarr](https://hub.docker.com/r/linuxserver/sonarr)
- [Bazarr](https://hub.docker.com/r/linuxserver/bazarr)
- [Organizr](https://hub.docker.com/r/organizr/organizr)
- [Wireshark](https://hub.docker.com/r/linuxserver/wireshark)
- [Code-server](https://hub.docker.com/r/linuxserver/code-server)
- [Prometheus](https://hub.docker.com/r/prom/prometheus)
- [Node-exporter](https://github.com/prometheus/node_exporter)
- [Grafana](https://hub.docker.com/r/grafana/grafana)
- [Node-Red](https://hub.docker.com/r/nodered/node-red)
- [Mosquitto MQTT](https://hub.docker.com/_/eclipse-mosquitto)
- [Watchtower](https://hub.docker.com/r/containrrr/watchtower)
- [Home Assistant](https://hub.docker.com/r/homeassistant/home-assistant)
- [Portainer-ce](https://hub.docker.com/r/portainer/portainer-ce)
- [Dozzle](https://hub.docker.com/r/amir20/dozzle)
- [SpeedTest](https://hub.docker.com/r/henrywhitaker3/speedtest-tracker)
- [Plex](https://hub.docker.com/r/linuxserver/plex)
- [PiHole](https://hub.docker.com/r/pihole/pihole)
- [Cloudflared](https://hub.docker.com/r/cloudflare/cloudflared)
- [Nginx](https://nginxproxymanager.com/guide/#project-goal)
- [PiHole](https://hub.docker.com/r/pihole/pihole)
- [Cloudflair dns](https://hub.docker.com/r/oznu/cloudflare-ddns/)
- [Wireguard](https://hub.docker.com/r/linuxserver/wireguard)
- [Tdarr](https://hub.docker.com/r/haveagitgat/tdarr)
- [Homarr](https://github.com/ajnart/homarr)
- [NextCloud](https://hub.docker.com/r/linuxserver/nextcloud)
- [Heimdall](https://hub.docker.com/r/linuxserver/heimdall)

# Coming soon
- Fail2ban
- influxdb

# Force recreate
```
docker compose up -d --force-recreate
```

# Updating
**Auto update**
Uncomment watchtower in docker compose. <br />

**Update manually via watch tower** <br />
```
docker run -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --run-once
```
**Update manually** <br />
```
docker compose pull
``` 
```
docker compose up -d 
```
```
docker image prune -a
``` 

# For vpn apps qbit and jacket
copy vpn files into config <br />
**Jackett**<br>
```
cp /PIAOpenvpn/ca.rsa.4096 ~/config/jackett/openvpn/ca.rsa.4096 
```
```
cp /PIAOpenvpn/ca.rsa.4096.pem ~/config/jackett/openvpn/ca.rsa.4096.pem
```
```
cp /PIAOpenvpn/Singapore.ovpn ~/config/jackett/openvpn/Singapore.ovpn
```
```
touch ~/config/jackett/openvpn/credentials/conf
```
add vpn username<br>
add vpn password<br>

**Qbit**<br>
```
cp /PIAOpenvpn/ca.rsa.4096 ~/config/qbittorent/openvpn/ca.rsa.4096
```
```
cp /PIAOpenvpn/ca.rsa.4096.pem ~/config/qbittorent/openvpn/ca.rsa.4096.pem 
```
```
cp /PIAOpenvpn/Singapore.ovpn ~/config/qbittorent/openvpn/Singapore.ovpn 
```
```
touch ~/config/jackett/openvpn/credentials/conf
```
add vpn username<br>
add vpn password<br>