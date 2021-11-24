FROM ubuntu:latest

MAINTAINER Widget_An <anchunyu@heywhale.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get -y upgrade && apt-get autoremove && apt-get autoclean
RUN apt-get -y install apt-utils wget git cmake build-essential libc6-dev zlib1g-dev libssl-dev gfortran libnetcdf-dev libnetcdff-dev

RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz && tar zxvf openmpi-4.1.1.tar.gz && rm openmpi-4.1.1.tar.gz
RUN mkdir openmpi && cd openmpi-4.1.1 && ./configure --prefix=/openmpi/.local/openmpi CC=gcc CXX=g++ FC=gfortran && make -j && make install

ENV MPI_HOME /usr/local/openmpi
ENV PATH ${MPI_HOME}/bin:$PATH
ENV LD_LIBRARY_PATH ${MPI_HOME}/lib:$LD_LIBRARY_PATH
ENV MANPATH ${MPI_HOME}/share/man:$MANPATH

RUN cd / && git clone https://github.com/WidgetA/uclales.git && cd uclales/config && cp ubuntu.cmake default.cmake
RUN echo $PATH && cd /uclales && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE .. && make -j
RUN cp uclales ../bin/
