#!/bin/sh

echo "Running Gazebo World";
# Find world file.
worldFile=$(find / -name 'kishore_world_without_robot.world');
echo "\tUsing World File: ${worldFile}"
export TURTLEBOT_GAZEBO_WORLD_FILE=$worldFile
xterm  -e  "roslaunch turtlebot_gazebo turtlebot_world.launch" &
sleep 5

echo "Running Turtlebot gmapping_demo";
xterm -e "roslaunch turtlebot_gazebo gmapping_demo.launch" &
sleep 5

echo "Running RVIZ view navigation";
xterm  -e  "roslaunch add_markers view_navigation.launch" &
sleep 5

echo "Extras: Running TeleOp Keyboard";
xterm -e "roslaunch turtlebot_teleop keyboard_teleop.launch" & 
sleep 5

#echo "Extras: Running Mapping Node to generate new Map. Run after teleop for this purpose.";
#xterm -e "roslaunch my_robot mapping.launch" &
#sleep 5

echo "Done running.";
