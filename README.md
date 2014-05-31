tracking_targeting
==================
This project aims to track a face from the video feed and target that face using pan andd tilt gun mechanism.
An integrated camera of latop serves as the primary camera for video feed.
The target(FACE) must be in the range of 0.5m to 4m away from camera.
All the prerequisite procedure are stated in the code.


Steps:
1.Make sure haar cascade file is there in the folder containing processing code 
2.Burn arduino codes(.INO) on the uno board.
3.Open the processing code and follow the instructions mentioned in the .pde processing file.
4.Calibrate the pan and tilt mechanism to point at centre position.
5.Make changes in "//change here" comment to increase the accuracy and more segmentation.
6.Nominal stepsize is kept at value 5, but it can be changed to higher values, for fast rotation of pan and tilt mechanism. 
7.Thats all folks, now try the code and please feel free to make changes and also suggest some alternate routes.
