# TurtleBot.Dockerfile

Provides a working Dockerfile for running ROS Indigo/TurtleBot on physical
TurtleBot devices. Assumes a Kobuki base, TurtleBot version 2, and a Kinect
camera are being used.

## Installation

To get up and running, there is no need to clone this repository. Instead, you
can download a pre-built image from DockerHub, using the command below.

```
docker pull christimperley/turtlebot
```

## Usage

```
docker run --rm \
           --privileged \
           -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
           -v /dev/kobuki:/dev/kobuki \
           -v /dev/serial:/dev/serial \
           -v /dev/bus/usb:/dev/bus/usb \
           -it \
           christimperley/turtlebot\
           /bin/bash
```
