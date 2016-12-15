FROM ros:indigo-robot
MAINTAINER Chris Timperley "christimperley@googlemail.com"

RUN apt-get update &&\
    apt-get install -y  ros-indigo-turtlebot\
                        ros-indigo-turtlebot-apps\
                        ros-indigo-turtlebot-interactions\
                        ros-indigo-turtlebot-simulator\
                        ros-indigo-kobuki\
                        ros-indigo-rocon-remocon\
                        ros-indigo-ar-track-alvar-msgs\
                        ros-indigo-rocon-qt-library &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install and register Kinect
ENV TURTLEBOT_3D_SENSOR kinect
RUN apt-get update &&\
    cd /tmp &&\
    apt-get install -y freenect ros-indigo-openni-launch &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
