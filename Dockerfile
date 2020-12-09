# https://veins.car2x.org/tutorial/
# https://omnetpp.org/doc/omnetpp/InstallGuide.pdf
FROM ubuntu:16.04

MAINTAINER Siim Salin, TalTech

RUN apt-get update
RUN apt-get install -y xauth unzip wget vim 
RUN apt-get install -y build-essential gcc g++ bison flex perl python python3 qt5-default libqt5opengl5-dev tcl-dev tk-dev libxml2-dev zlib1g-dev default-jre doxygen graphviz libwebkitgtk-1.0-0
RUN apt-get install -y libgeos-dev software-properties-common 
RUN add-apt-repository -y ppa:ubuntugis/ppa && apt-get update && apt-get install -y openscenegraph-plugin-osgearth libosgearth-dev
RUN apt-get install -y osgearth osgearth-data
RUN apt-get install -y openmpi-bin libopenmpi-dev
RUN apt-get install -y libpcap-dev
RUN apt-get install -y cmake python g++ libxerces-c-dev libfox-1.6-dev libgdal-dev libproj-dev libgl2ps-dev swig
RUN apt-get install -y autoconf automake libtool libgdal1-dev qt4-dev-tools libopenscenegraph-dev 
#RUN apt-get install libgtk-3-dev

WORKDIR /root
# Buil and Install SUMO
# http://sumo.dlr.de/wiki/Installing/Linux_Build
RUN wget https://sumo.dlr.de/releases/1.2.0/sumo-src-1.2.0.tar.gz --progress=dot:giga && \
	tar zxf sumo-src-1.2.0.tar.gz && rm sumo-src-1.2.0.tar.gz 
RUN mv sumo-1.2.0 sumo
WORKDIR /root/sumo
ENV PATH /root/sumo/bin:$PATH
RUN mkdir build/cmake-build && cd build/cmake-build 
RUN cmake /root/sumo && make -j$(nproc)
#RUN add-apt-repository ppa:sumo/stable && apt-get update && apt-get install sumo sumo-tools sumo-doc

# Build and Install OMNet++ IDE
WORKDIR /root
RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-5.5.1/omnetpp-5.5.1-src-linux.tgz \
         --referer=https://omnetpp.org/ -O omnetpp-src-linux.tgz --progress=dot:giga && \
         tar xf omnetpp-src-linux.tgz && rm omnetpp-src-linux.tgz
RUN mv omnetpp-5.5.1 omnetpp
WORKDIR /root/omnetpp
ENV PATH /root/omnetpp/bin:$PATH
RUN ./configure WITH_OSG=no WITH_OSGEARTH=no && \
    make -j $(nproc) MODE=debug base && make -j $(nproc) MODE=release base

# Download and Unzip Veins
WORKDIR /root
RUN wget https://veins.car2x.org/download/veins-5.0.zip && unzip veins-5.0.zip && rm veins-5.0.zip
RUN mv veins-veins-5.0 veins

COPY ./commands.sh /

ENTRYPOINT ["/commands.sh"]
CMD ["bash"]
