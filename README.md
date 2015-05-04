Tracking_Targeting
==================
This project aims to track a face from the video feed and target that face using pan andd tilt gun mechanism.
An integrated camera of the laptop serves as the primary camera for video feed.
The target(FACE) must be in the range of 0.5m to 4m
All the prerequisite procedure are mentioned in the code.


Steps:
-----------------------
1. Make sure haar cascade file is there in the folder containing processing code 
2. Burn arduino codes(.INO) onto the uno board.
3. Open the processing code and follow the instructions mentioned in the .pde processing file.
4. Calibrate the pan and tilt mechanism to point at center position.
5. Make changes in "//change here" comment to increase the accuracy and hence more segmentation.
6. Nominal stepsize has value 5, but it can be increased to higher values for fast movement of pan and tilt                 
   mechanism. 
7. Thats all folks, now try the code and please feel free to suggest some accountable changes.


Building the Turret Frame
--------------------------

1. Gun for targeting(toy gun)
 
  ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/plastic_gun.png)


2. Pan and tilt Mechanism

 ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/gun.png)
 
To build the actual turret frame we have used the VEX motors, gears, screws, metal frame and nuts. This metal frame has the pan motor and gears attached to it. The entire turret rides on the 84-teeth gear. 
On the top of 84-teeth gear a simple U-shaped bracket is build with the VEX metal.  This structure forms the bracket that allows the gun to tilt up and down. On one side of this U-bracket a motor is attached with the help of 12-teeth and 84-teeth gear. By using a small gear to drive a larger gear, the turret can tilt very precisely and smoothly. Finally an airsoft gun is attached to the 84 teeth tilt gear. 


Interfacing Arduino with Processing
--------------------------------

 ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/flowchart1.png)
 
Processing and Face Tracking
-------------------------------
 ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/flowchart2.png)
Interfacing schematics of the system
------------------------
 ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/flowchart3.png)

---------------------
Work contributed by
1.Gauresh Vanjare
2.Dhairya Thakkar
3.Malay Shah
4.Amit Kadam
