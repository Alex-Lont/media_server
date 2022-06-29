# Docker install of Homeassistant
***Debian based distros***<br />
### Step 1 <br>
install dependancies <br>
```sudo apt-get install jq wget curl udisks2 libglib2.0-bin network-manager dbus -y ```

### Step 2 <br>
install docker <br>
```
curl -fsSL get.docker.com | sh
```

### Step 3
install OS Agent
found [here](https://github.com/home-assistant/os-agent/tree/main#using-home-assistant-supervised-on-debian)
wget a relevant [package](https://github.com/home-assistant/os-agent/releases/tag/1.2.2)<br>
***x86***<br>
```wget https://github.com/home-assistant/os-agent/releases/download/1.2.2/os-agent_1.2.2_linux_x86_64.deb```<br>
```sudo dpkg -i os-agent_1.2.2_linux_x86_64.deb```<br>
***test with***<br>
```gdbus introspect --system --dest io.hass.os --object-path /io/hass/os```
***Uninstall with***<br>
 ```sudo dpkg -r os-agent```

### Step 4
install home assistant supervised<br>
```wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb```<br>
```dpkg -i homeassistant-supervised.deb```

### Step 5
install HACS <br>
```docker exec -it hassio_supervisor bash```<br>
navigate to homeassistant location<br>
```cd /data/home``` <br>
```wget -O - https://get.hacs.xyz | bash -```<br>
got to home assistant web page<br>
intergrations and enable HACS<br>

## Note
There seems to be persistant storage attached as HAC only needs to be installed one time.<br>
Automation scripts are stored in hassio_supervisor container at path <br>
```data\homeassistant\.storage```<br>
Home assistant command line is run in the hassio_cli container<br>
forgot password connnect to CLI Container<br>
```docker exec -it hassio_cli bash```<br>
reset passsword with<br>
```ha auth reset --username existing_user --password new_password```