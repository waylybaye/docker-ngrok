# DOCKER NGROK IMAGE

## BUILD IMAGE

```linux
git clone https://github.com/waylybaye/hyperapp-ngrok.git
cd hyperapp-ngrok
docker build -t hyperapp/ngrok .
```

## RUN

```linux
docker run -idt --name ngrok-server \
-v /srv/docker/ngrok:/data \
-e DOMAIN='tunnel.hteen.cn' hyperapp/ngrok
```
