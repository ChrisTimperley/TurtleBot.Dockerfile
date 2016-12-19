FROM christimperley/turtlebot:base
MAINTAINER Chris Timperley "christimperley@googlemail.com"

# Install prerequisites
RUN apt-get update &&\
    apt-get install -y  xserver-xorg-video-dummy\
                        gcc\
                        g++\
                        build-essential\
                        python-flask\
                        python-enum\
                        python-ply\
                        python-requests\
                        software-properties-common &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download install files for Rocon, Kobuki and TurtleBot, before merging into one
RUN cd /tmp && \
    wget -q https://raw.githubusercontent.com/robotics-in-concert/rocon/release/indigo/rocon.rosinstall &&\
    wget -q https://raw.githubusercontent.com/yujinrobot/yujin_tools/master/rosinstalls/indigo/kobuki.rosinstall &&\
    wget -q https://raw.githubusercontent.com/yujinrobot/yujin_tools/master/rosinstalls/indigo/turtlebot.rosinstall && \
    cat turtlebot.rosinstall kobuki.rosinstall rocon.rosinstall |\
    egrep -v "^#" |\
    egrep -v "^$" |\
    egrep -v "^(\[|\])$" |\
    grep -v "rocon_rapps" |\
    sed "s/{'git':/- git:/g" |\
    sed "s/}},/}/g" > all.rosinstall &&\
    rm -f turtlebot.rosinstall kobuki.rosinstall rocon.rosinstall

# Create a catkin workspace
ENV catkin_ws /catkin_ws
WORKDIR ${catkin_ws}
RUN mkdir -p "${catkin_ws}/src"
RUN bash -c " source /opt/ros/indigo/setup.bash && \
              cd ${catkin_ws}/src && \
              catkin_init_workspace && \
              cd .. && \
              catkin_make"

# Try to install?
RUN wstool init -j5 src /tmp/all.rosinstall && \
    apt-get update && \
    bash -c " source /opt/ros/indigo/setup.bash &&\
              rosdep install --from-paths '${catkin_ws}/src' --ignore-src --rosdistro indigo -y &&\
              cd ${catkin_ws} && catkin_make" &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
