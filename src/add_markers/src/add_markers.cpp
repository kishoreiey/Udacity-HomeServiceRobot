#include <ros/ros.h>
#include <visualization_msgs/Marker.h>
#include "nav_msgs/Odometry.h"

ros::Publisher marker_pub;
visualization_msgs::Marker marker;

// This callback function continuously executes and reads the odom data
void odom_callback(const nav_msgs::Odometry::ConstPtr& msg)
{ 
  //ROS_INFO_THROTTLE(3, "Seq: [%d]", msg->header.seq);
  ROS_INFO_THROTTLE(3, "Position-> x: [%f], y: [%f], z: [%f]", msg->pose.pose.position.x,msg->pose.pose.position.y, msg->pose.pose.position.z);

  if (msg->pose.pose.position.x >= 0.7) {
    ROS_INFO_THROTTLE(2, "Making marker invisible at x: [%f], y: [%f]", msg->pose.pose.position.x,msg->pose.pose.position.y);
    marker.color.a = 0.0;
    marker_pub.publish(marker);
  }
  
  if (msg->pose.pose.position.x < -6.2 && msg->pose.pose.position.y > 0.6) {
    ROS_INFO_THROTTLE(2, "Making marker visible at x: [%f], y: [%f]", msg->pose.pose.position.x,msg->pose.pose.position.y);
    marker.pose.position.x = -6.15;
    marker.pose.position.y = 0.7;
    marker.color.a = 1.0;
    sleep(2);
    marker_pub.publish(marker);
  }
}

int main( int argc, char** argv )
{
  ros::init(argc, argv, "add_markers");
  ros::NodeHandle n;
  ros::Rate r(1);

  marker_pub = n.advertise<visualization_msgs::Marker>("visualization_marker", 1);
  ros::Subscriber sub1 = n.subscribe("odom", 100, odom_callback);

  // Set our initial shape type to be a cube
  uint32_t shape = visualization_msgs::Marker::CUBE;

  //while (ros::ok())
  //{
  //  visualization_msgs::Marker marker;
    // Set the frame ID and timestamp.  See the TF tutorials for information on these.
    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();

    // Set the namespace and id for this marker.  This serves to create a unique ID
    // Any marker sent with the same namespace and id will overwrite the old one
    marker.ns = "basic_shapes";
    marker.id = 0;

    // Set the marker type.  Initially this is CUBE, and cycles between that and SPHERE, ARROW, and CYLINDER
    marker.type = shape;

    // Set the marker action.  Options are ADD, DELETE, and new in ROS Indigo: 3 (DELETEALL)
    marker.action = visualization_msgs::Marker::ADD;

    // Set the pose of the marker.  This is a full 6DOF pose relative to the frame/time specified in the header
    marker.pose.position.x = 1;
    marker.pose.position.y = 0;
    marker.pose.position.z = 0;
    marker.pose.orientation.x = 0.0;
    marker.pose.orientation.y = 0.0;
    marker.pose.orientation.z = 0.0;
    marker.pose.orientation.w = 1.0;

    // Set the scale of the marker -- 1x1x1 here means 1m on a side
    marker.scale.x = 0.2;
    marker.scale.y = 0.2;
    marker.scale.z = 0.2;

    // Set the color -- be sure to set alpha to something non-zero!
    marker.color.r = 0.0f;
    marker.color.g = 1.0f;
    marker.color.b = 0.0f;
    marker.color.a = 1.0;

    marker.lifetime = ros::Duration();

    // Publish the marker
    while (marker_pub.getNumSubscribers() < 1)
    {
      if (!ros::ok())
      {
        return 0;
      }
      ROS_WARN_ONCE("Please create a subscriber to the marker");
      sleep(1);
    }
    ROS_INFO_ONCE("Found a subscriber to the marker");
    marker_pub.publish(marker);

    //r.sleep();
  //}
  ros::spin();

  return 0;
}
