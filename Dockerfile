################################################################################################
# This Dockerfile creates the base image for use in Golang+Docker development workflows
################################################################################################
# Base image
FROM centos:latest

# Maintainer
MAINTAINER Will Rowe <will.rowe@stfc.ac.uk>

################################################################################################
# Install core packages + OpenMPI
################################################################################################
RUN yum update && yum group install -y "Development Tools" && yum -y clean all
RUN yum install -y \
	wget \
	openmpi \
	openmpi-devel \
	glibc-devel.i686 \
	libgcc.i686 \
  libstdc++-devel.i686 \
	yum -y clean all

################################################################################################
# Install Go (Version 1.8.3)
################################################################################################
RUN cd /tmp && \
	wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz && \
	tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz && \
	rm go1.8.3.linux-amd64.tar.gz
ENV GOLANG_VERSION 1.8.3
RUN export PATH="/usr/local/go/bin:/usr/lib64/openmpi/bin:$PATH" && \
	go version

################################################################################################
# Set up environment
################################################################################################
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/lib64/openmpi/bin:$PATH
ENV C_INCLUDE_PATH=/usr/include/openmpi-x86_64
ENV LD_LIBRARY_PATH=/usr/lib64/openmpi/lib
ENV CGO_LDFLAGS='-L/usr/lib64/openmpi/lib -lmpi'

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
