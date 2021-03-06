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
                        sudo \
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

# Create a turtlebot user
RUN useradd -g sudo -s /bin/bash turtlebot && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/turtlebot && \
    chown -R turtlebot /home/turtlebot
USER turtlebot
WORKDIR /home/turtlebot

# Get the ROS dependencies
RUN sudo -u turtlebot bash -c "sudo rosdep init && rosdep update"

# Create a catkin workspace for ROS
RUN mkdir -p ros_catkin_ws
ENV ros_catkin_ws /home/turtlebot/ros_catkin_ws
WORKDIR ${ros_catkin_ws}

# Install desktop variant of ROS
RUN rosinstall_generator desktop_full --rosdistro indigo --deps --wet-only --tar \
      > desktop.install
RUN wstool init -j8 src desktop.install
