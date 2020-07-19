Introduced two nodes as part of this project:
1. pick_objects
2. add_markers

Main Script:
```sh src/scripts/home_service.sh```

Test mapping using 
```sh src/scripts/test_slam.sh```

This exercise includes:
* Robot first localizes in the map/env provided.
* Takes in first location from where an object has to be picked.
* Simulates a robot autonomously traversing to this first location and picking up the object.
* The robot then receives second location coordinates.
* Robot then autonomously navigates to it if its reachable.
* Simulates dropping off the picked object at this second location.
