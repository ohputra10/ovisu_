![fuxa logo](/client/src/favicon.ico) 
# OVISU
OVISU is a web-based Process Visualization (SCADA/HMI/Dashboard) software. With FUXA you can create modern process visualizations with individual designs for your machines and real-time data display.

![fuxa editor](/screenshot/fuxa-editor.png) 

![fuxa ani](/screenshot/fuxa-ani.gif)

## Features
- Devices connectivity with Modbus RTU/TCP, Siemens S7 Protocol, OPC-UA, BACnet IP, MQTT, Ethernet/IP (Allen Bradley)
- SCADA/HMI Web-Editor - Engineering and Design completely web-based
- Cross-Platform Full-Stack - Backend with NodeJs and Frontend with Web technologies (HTML5, CSS, Javascript, Angular, SVG)

## Installing and Running
OVISU is developed with NodeJS (backend) and Angular (frontend).

running from docker (first option)
```
docker pull ohputra/ovisu:latest
docker run -d -p 1881:1881 ohputra/ovisu:latest

// persistent storage of application data (project), daq (tags history), logs and images (resource)
docker run -d -p 1881:1881 -v ovisu_appdata:/usr/src/app/ovisu/server/_appdata -v ovisu_db:/usr/src/app/ovisu/server/_db -v ovisu_logs:/usr/src/app/ovisu/server/_logs -v ovisu_images:/usr/src/app/ovisu/server/_images ohputra/ovisu:latest

// with Docker compose
// persistent storage will be at ./appdata ./db ./logs and ./images
wget https://raw.githubusercontent.com/ohputra10/ovisu/master/compose.yml
docker compose up -d
```

Open up a browser (better Chrome) and navigate to http://localhost:1881

## License
MIT.
