FROM ripl/lcm:1.4.0

# set ROS codename
ENV ROS_DISTRO "kinetic"

# set default ROS master hostname
ENV ROS_MASTER_HOST "localhost"

# Setup ROS sources
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $UBUNTU_DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'

# Setup ROS keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# update apt lists and install system libraries, then clean the apt cache
RUN apt update && apt install -y \
    ros-$ROS_DISTRO-desktop \
    # clean the apt cache
    && rm -rf /var/lib/apt/lists/*

# source ROS
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc

# copy and set entrypoint
COPY assets/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
