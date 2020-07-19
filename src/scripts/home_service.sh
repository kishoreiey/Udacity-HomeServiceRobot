#!/bin/sh

# Run this script from catkin_ws
# Args:
# 0 - Run all
# 1 - Selectively run corresponding stages.
# >= 10 - Extra stages which can be run to either debug or on demand.

echo $1;
if [ $1 -eq 0 -o $1 -eq 1 ]; then
 echo "Running Gazebo World";
 export ROBOT_INITIAL_POSE="-x -5 -y 0 -Y 0"
 export TURTLEBOT_GAZEBO_WORLD_FILE=/home/workspace/catkin_ws/src/my_robot/worlds/kishore_world_without_robot.world
 #xterm  -e  "roslaunch turtlebot_gazebo turtlebot_world.launch" &
 xterm  -e  "roslaunch turtlebot_gazebo turtlebot_world.launch world_file:=/home/workspace/catkin_ws/src/my_robot/worlds/kishore_world_without_robot.world" &
 #xterm  -e  "roslaunch my_robot world.launch" &
 sleep 5
elif [ $1 -eq 0 -o $1 -eq 2 ]; then
 echo "Running AMCL DEMO";
 xterm  -e  "roslaunch turtlebot_gazebo amcl_demo.launch map_file:=/home/workspace/catkin_ws/src/my_robot/maps/kishore.yaml" & 
 #xterm  -e  "roslaunch turtlebot_gazebo amcl_demo.launch" & 
 #xterm  -e  "roslaunch my_robot amcl.launch" & 
 sleep 5
elif [ $1 -eq 0 -o $1 -eq 3 ]; then
 echo "Running RVIZ view navigation";
 #xterm  -e  "roslaunch turtlebot_rviz_launchers view_navigation.launch" &
 # roslaunch turtlebot_teleop keyboard_teleop.launch 
 xterm  -e  "roslaunch add_markers view_navigation.launch" &
 sleep 5
elif [ $1 -eq 0 -o $1 -eq 4 ]; then
 echo "Running Add Markers";
 xterm  -e  "roslaunch add_markers add_markers.launch" &
 sleep 5
elif [ $1 -eq 0 -o $1 -eq 5 ]; then
 echo "Running Pick Objects";
 xterm  -e  "roslaunch pick_objects pick_objects.launch" &
 sleep 5
elif [ $1 -eq 0 -o $1 -eq 10 ]; then
 echo "Extras: Running TeleOp Keyboard";
 xterm -e "roslaunch turtlebot_teleop keyboard_teleop.launch" & 
elif [ $1 -eq 0 -o $1 -eq 11 ]; then
 echo "Extras: Running Mapping Node to generate new Map. Run after teleop for this purpose.";
 xterm -e "roslaunch my_robot mapping.launch" &
else
 echo "Not a recognized option";
fi
