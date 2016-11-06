FROM ubuntu:16.04
MAINTAINER Fabien Culpo <fabien.culpo@gmail.com>

RUN apt-get update && \
	apt-get install -y wget apt-transport-https nginx && \
	echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list && \
	wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
	apt-get update && \
	apt-get -y install jitsi-meet && \
	apt-get clean

#ENV PUBLIC_HOSTNAME=192.168.59.103

#/etc/jitsi/meet/localhost-config.js = bosh: '//localhost/http-bind',
#RUN sed s/JVB_HOSTNAME=/JVB_HOSTNAME=$PUBLIC_HOSTNAME/ -i /etc/jitsi/videobridge/config && \
#	sed s/JICOFO_HOSTNAME=/JICOFO_HOSTNAME=$PUBLIC_HOSTNAME/ -i /etc/jitsi/jicofo/config

EXPOSE 80 443 5347
EXPOSE 10000:10010/udp

COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
