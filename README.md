tracking_targeting
==================
This project aims to track a face from the video feed and target that face using pan andd tilt gun mechanism.
An integrated camera of latop serves as the primary camera for video feed.
The target(FACE) must be in the range of 0.5m to 4m away from camera.
All the prerequisite procedure are stated in the code.


Steps:
-----------------------
1. Make sure haar cascade file is there in the folder containing processing code 
2. Burn arduino codes(.INO) on the uno board.
3. Open the processing code and follow the instructions mentioned in the .pde processing file.
4. Calibrate the pan and tilt mechanism to point at centre position.
5. Make changes in "//change here" comment to increase the accuracy and more segmentation.
6. Nominal stepsize is kept at value 5, but it can be changed to higher values, for fast rotation of pan and tilt               mechanism. 
7. Thats all folks, now try the code and please feel free to make changes and also suggest some alternate routes.


Building the Turret Frame
--------------------------

1. Gun for targeting(toy gun)
 
  ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/plastic_gun.png)


2. Pan and tilt Mechanism

 ![image](https://github.com/gauresh10/tracking_targeting/blob/master/images/gun.png)
 
To build the actual turret frame we have used the VEX motors, gears, screws, and nuts. This piece has the pan motor and gears attached to it.  The entire turret rides on the 84-tooth gear. 
On top of the 84-tooth gear, build a simple U-shaped bracket out of the VEX metal.  This is going to be the bracket that allows the gun to tilt up and down.  On one of the sides of this U-bracket, attach the motor and 12-tooth and 84-tooth gear.  By using a small gear to drive a larger gear, the turret can tilt very precisely and smoothly. Attach the airsoft gun to the 84 tooth tilt gear. 


Interfacing Arduino and Processing

