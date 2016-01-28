FROM resin/rpi-raspbian

RUN apt-get update
RUN apt-get install -y curl wget libpcap0.8 libmysqlclient18 libnetfilter-queue1 libhiredis0.10
RUN wget http://packages.ntop.org/apt/ntop.key
RUN apt-key add ntop.key
RUN echo "deb http://packages.ntop.org/RaspberryPI/ armhf/" > /etc/apt/sources.list.d/ntop.list
RUN echo "deb http://packages.ntop.org/RaspberryPI/ all/" >> /etc/apt/sources.list.d/ntop.list
RUN apt-get update
RUN apt-get install ntopng

# setup env variables
ENV NPROBE_PORT 5556

# expose ports
EXPOSE 3000

CMD ntopng -i tcp://nprobe:${NPROBE_PORT} -r redis
