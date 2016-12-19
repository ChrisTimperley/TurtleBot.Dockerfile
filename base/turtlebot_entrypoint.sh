#!/bin/bash
# setup ros environment
source "/opt/ros/${ROS_DISTRO}/setup.bash"

# start up dbus and avahi daemons
# TODO: check these aren't already running!
dbus-daemon --system
/etc/init.d/avahi-daemon start

exec "$@"
