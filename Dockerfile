FROM golang:1.7.1-alpine
MAINTAINER HyperApp <hyperappcloud@gmail.com>

RUN apk add --no-cache git make openssl

RUN git clone https://github.com/tutumcloud/ngrok.git /usr/src/ngrok \
    && cd /usr/src/ngrok \
    && make release-server \
    && cp bin/ngrokd /usr/local/bin/ \
    && rm -rf /usr/src/ngrok

RUN mkdir /data
WORKDIR /data
VOLUME /data

ENV DOMAIN=
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

EXPOSE 4443
EXPOSE 80
EXPOSE 443

ADD server.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/server.sh
CMD ['server.sh']
