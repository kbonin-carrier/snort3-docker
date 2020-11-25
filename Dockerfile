FROM ubuntu:20.04

RUN mkdir -p /root/snort
WORKDIR /root/snort/
COPY ./build_snort3.sh ./

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ./build_snort3.sh
RUN ldconfig

#RUN /bin/bash -c "snort --help && snort -v"

