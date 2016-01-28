FROM resin/rpi-raspbian

RUN apt-get update
RUN apt-get install -y curl wget libpcap0.8 libmysqlclient18 libnetfilter-queue1 libhiredis0.10
RUN wget http://packages.ntop.org/apt/ntop.key
RUN apt-key add ntop.key
RUN echo "deb http://packages.ntop.org/RaspberryPI/ armhf/" > /etc/apt/sources.list.d/ntop.list
RUN echo "deb http://packages.ntop.org/RaspberryPI/ all/" >> /etc/apt/sources.list.d/ntop.list
RUN apt-get update
RUN apt-get install nprobe

# setup env variables
ENV ZMQ_PORT 5556
ENV COLLECT_PORT 2055
ENV CONTROL_PORT 6999
ENV VERB_LEVEL 0

# expose ports
EXPOSE ${ZMQ_PORT}
EXPOSE ${COLLECT_PORT}/udp
EXPOSE ${CONTROL_PORT}/udp

#CMD [ "sh", "-c", "nprobe", "--zmq", "tcp://*:${ZMQ_PORT}", "-i", "none", "-n", "none", "--collector-port", "${COLLECT_PORT}"]
CMD nprobe --zmq "tcp://*:${ZMQ_PORT}" -i none -n none --collector-port ${COLLECT_PORT} --verbose ${VERB_LEVEL}
