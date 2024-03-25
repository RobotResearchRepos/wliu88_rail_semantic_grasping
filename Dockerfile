FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

# Code repository

RUN mkdir -p /catkin_ws/src/

RUN git clone --recurse-submodules \
      https://github.com/RobotResearchRepos/wliu88_rail_semantic_grasping \
      /catkin_ws/src/rail_semantic_grasping

RUN git clone --recurse-submodules \
      https://github.com/GT-RAIL/rail_manipulation_msgs \
      /catkin_ws/src/rail_manipulation_msgs

RUN git clone --recurse-submodules \
      https://github.com/wliu88/rail_part_affordance_detection \
      /catkin_ws/src/rail_part_affordance_detection

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /catkin_ws \
 && catkin_make
 
 
