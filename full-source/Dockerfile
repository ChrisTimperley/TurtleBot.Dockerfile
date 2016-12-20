FROM ubuntu:14.04
MAINTAINER Chris Timperley "christimperley@googlemail.com"

# Install prerequisites
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc)" main > \
    /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116
RUN apt-get update && \
    apt-get install -y  wget \
                        git \
                        gcc \
                        g++ \
                        build-essential \
                        python-flask \
                        python-enum \
                        python-ply \
                        python-rosdep \
                        python-rosinstall-generator \
                        python-wstool \
                        python-rosinstall \
                        python-requests \
                        software-properties-common \
                        zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
