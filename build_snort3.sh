#!/bin/bash
apt-get update && \
  apt-get -y install cmake wget git bison flex g++ libssl-dev pkg-config autoconf \
  libtool libboost-all-dev liblzma-dev vim

wget https://www.tcpdump.org/release/libpcap-1.9.1.tar.gz && \
  tar zxvf libpcap-1.9.1.tar.gz && \
  cd libpcap-1.9.1 && \
  ./configure && make && make install && cd ..

git clone https://github.com/snort3/libdaq.git && cd libdaq/ && \
  ./bootstrap && ./configure && make && make install && ldconfig && \
  cd ..

git clone https://github.com/ofalk/libdnet.git && cd libdnet/ && \
  cp /usr/share/automake-*/config.guess ./config/config.guess && \
  ./configure && make && make install && cd ..

wget https://download.open-mpi.org/release/hwloc/v2.3/hwloc-2.3.0.tar.gz && \
  tar zxvf hwloc-2.3.0.tar.gz && cd hwloc-2.3.0 && ./configure && \
  make && make install && cd ..

wget https://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz && \
  tar zxvf LuaJIT-2.1.0-beta3.tar.gz && cd LuaJIT-2.1.0-beta3/ && \
  make install && cd ..

wget ftp://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz && tar zxvf pcre-8.44.tar.gz && \
  cd pcre-8.44 && ./configure && make && make install && cd ..

#### Install Hyperscan ####
wget http://www.colm.net/files/colm/colm-0.13.0.7.tar.gz && \
  tar zxvf colm-0.13.0.7.tar.gz && cd colm-0.13.0.7 && ./configure && \
  make && make install && ldconfig &&  cd ..

wget http://www.colm.net/files/ragel/ragel-7.0.0.12.tar.gz && \
  tar zxvf ragel-7.0.0.12.tar.gz && cd ragel-7.0.0.12 && ./configure && \
  make && make install && cd ..

mkdir kunpengcomputer-hyperscan && cd kunpengcomputer-hyperscan && \
  git clone https://github.com/kunpengcompute/hyperscan.git . && \
  mkdir build  && cd build && cmake .. && \
  cmake --build . && cmake -P cmake_install.cmake && \
  cd ../..

### Install snort3 ###
git clone https://github.com/snort3/snort3.git && \
  cd snort3 && ./configure_cmake.sh && cd build && \
  make -j $(nproc) install && cd ../..

echo "export PATH=\"/usr/local/snort/bin:$PATH\"" >> /root/.bashrc
