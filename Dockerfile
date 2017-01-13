FROM harmish/ros:indigo-devel

    # install pepper related packages
RUN apt-get update && \
    apt-get install -y \
        ros-$ROS_DISTRO-joint-state-publisher \
        ros-$ROS_DISTRO-rviz && \

    # clean-up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    
    # setup pepper meshes
    git clone https://github.com/ros-naoqi/pepper_meshes.git /catkin_ws/src/pepper_meshes && \
    bash -c "source /opt/ros/indigo/setup.bash && catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/indigo -C /catkin_ws install"

VOLUME /catkin_ws/src/pepper_robot
COPY . /catkin_ws/src/pepper_robot
RUN bash -c "source /opt/ros/indigo/setup.bash && catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/indigo -C /catkin_ws install"