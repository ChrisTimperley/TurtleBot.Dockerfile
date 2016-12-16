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

# Fix inability to launch avahi-daemon correctly
# Modified instructions from https://github.com/dockerimages/docker-systemd
RUN apt-get update && apt-get install -y libnss-mdns netatalk systemd
RUN mkdir -p /var/run/dbus
RUN cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /lib/systemd/system/plymouth*; \
    rm -f /lib/systemd/system/systemd-update-utmp*
ENV init /lib/systemd/systemd
VOLUME ["/sys/fs/cgroup"]

# install and register Kinect
ENV TURTLEBOT_3D_SENSOR kinect
RUN apt-get install -y wget
RUN cd /tmp &&\
    wget -q https://github.com/avin2/SensorKinect/archive/v0.93-5.1.2.1.tar.gz &&\
    tar -xf v0.93-5.1.2.1.tar.gz &&\
    cd SensorKinect-0.93-5.1.2.1/Bin &&\
    tar xjf SensorKinect093-Bin-Linux-x64-v5.1.2.1.tar.bz2 &&\
    cd Sensor-Bin-Linux-x64-v5.1.2.1 &&\
    bash install.sh &&\
    rm -rf /tmp/v0.93-5.1.2.1.tar.gz /tmp/SensorKinect-0.93-5.1.2.1
RUN apt-get install -y ros-indigo-openni-launch
#RUN apt-get update &&\
#    cd /tmp &&\
#    apt-get install -y freenect ros-indigo-openni-launch &&\
#    apt-get clean &&\
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add entrypoint
ADD turtlebot_entrypoint.sh /turtlebot_entrypoint.sh
ENTRYPOINT ["/turtlebot_entrypoint.sh"]
CMD []
