#!/bin/sh

# Run this script from catkin_ws
# Args:
# 0 - Run all (default)
# 1 - Selectively run corresponding stages.
# >= 10 - Extra stages which can be run to either debug or on demand.

# Assign default 0 if not defined.
OPTION=${1:-0}

echo "Option: $OPTION";
if [ $OPTION -eq 0 -o $OPTION -eq 1 ]; then
 echo "Running Gazebo World";
 # Find world file.
 worldFile=$(find / -name 'kishore_world_without_robot.world');
 echo "\tUsing World File: ${worldFile}"
 # export ROBOT_INITIAL_POSE="-x -5 -y 0 -Y 0"
 export TURTLEBOT_GAZEBO_WORLD_FILE=$worldFile
 #xterm  -e  "roslaunch turtlebot_gazebo turtlebot_world.launch" &
 xterm  -e  "roslaunch turtlebot_gazebo turtlebot_world.launch" &
 #xterm  -e  "roslaunch my_robot world.launch" &
 sleep 5
fi
if [ $OPTION -eq 0 -o $OPTION -eq 2 ]; then
 echo "Running AMCL DEMO";
 # Find kishore.yaml map file.
 mapFile=$(find / -name 'kishore.yaml');
 echo "\tUsing Map File: ${mapFile}"
 xterm  -e  "roslaunch turtlebot_gazebo amcl_demo.launch map_file:=${mapFile}" & 
 #xterm  -e  "roslaunch turtlebot_gazebo amcl_demo.launch" & 
 #xterm  -e  "roslaunch my_robot amcl.launch" & 
 sleep 5
fi
if [ $OPTION -eq 0 -o $OPTION -eq 3 ]; then
 echo "Running RVIZ view navigation";
 #xterm  -e  "roslaunch turtlebot_rviz_launchers view_navigation.launch" &
 # roslaunch turtlebot_teleop keyboard_teleop.launch 
 xterm  -e  "roslaunch add_markers view_navigation.launch" &
 sleep 5
fi
if [ $OPTION -eq 0 -o $OPTION -eq 4 ]; then
 echo "Running Add Markers";
 xterm  -e  "roslaunch add_markers add_markers.launch" &
 sleep 5
fi
if [ $OPTION -eq 0 -o $OPTION -eq 5 ]; then
 echo "Running Pick Objects";
 xterm  -e  "roslaunch pick_objects pick_objects.launch" &
 sleep 5
fi

if [ $OPTION -eq 10 ]; then
 echo "Extras: Running TeleOp Keyboard";
 xterm -e "roslaunch turtlebot_teleop keyboard_teleop.launch" & 
fi
if [ $OPTION -eq 11 ]; then
 echo "Extras: Running Mapping Node to generate new Map. Run after teleop for this purpose.";
 xterm -e "roslaunch my_robot mapping.launch" &
fi

echo "Done running.";
