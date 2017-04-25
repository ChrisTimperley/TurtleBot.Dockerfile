#FROM ros:indigo-robot
FROM ros:kinetic
MAINTAINER Chris Timperley "christimperley@googlemail.com"

# Fix inability to launch avahi-daemon correctly
# Modified instructions from https://github.com/dockerimages/docker-systemd
RUN apt-get update && \
    apt-get install -y  wget \
                        libnss-mdns \
                        netatalk \
                        systemd \
                        ros-kinetic-openni-launch \
                        ros-kinetic-image-view && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
RUN cd /tmp &&\
    wget -q https://github.com/avin2/SensorKinect/archive/v0.93-5.1.2.1.tar.gz &&\
    tar -xf v0.93-5.1.2.1.tar.gz &&\
    cd SensorKinect-0.93-5.1.2.1/Bin &&\
    tar xjf SensorKinect093-Bin-Linux-x64-v5.1.2.1.tar.bz2 &&\
    cd Sensor-Bin-Linux-x64-v5.1.2.1 &&\
    bash install.sh &&\
    rm -rf /tmp/v0.93-5.1.2.1.tar.gz /tmp/SensorKinect-0.93-5.1.2.1

# Add entrypoint
ADD turtlebot_entrypoint.sh /turtlebot_entrypoint.sh
ENTRYPOINT ["/turtlebot_entrypoint.sh"]
CMD []
