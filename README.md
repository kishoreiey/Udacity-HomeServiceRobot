Introduced two nodes as part of this project:
1. pick_objects
2. add_markers

Main Script:
src/scripts/home_service.sh

Also these additional changes are required to run the script:
1. Place navigation_with_marker.rviz (updated rviz config) in turtlebot_rviz_launchers/rviz/ folder.
  $ cp navigation_with_marker.rviz src/turtlebot_interactions/turtlebot_rviz_launchers/rviz/
2. Replace turtlebot_interactions view_navigation.launch file to use the new rviz config file. 
  $ cp view_navigation.launch src/turtlebot_interactions/turtlebot_rviz_launchers/launch/
