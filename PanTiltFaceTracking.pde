/*
Work contributed by gauresh vanjare
connect arduino at any port of pc.
install open cv new version
put haarcascade_frontalface_alt.xml in the processing code folder
include the open cv libraries 
goto http://ubaa.net/shared/processing/opencv/ for more info
*/
import processing.video.*;
import java.awt.*;
import hypermedia.video.*;
import processing.serial.*;
 
Capture video;
OpenCV cam;
 
int w = 640;
int h = 480;
 
int xstart = 0; //starting display position for picture in x direction
int ystart = 0; //starting display position for picture in y direction
 
Serial port; // The serial port
//Variables for keeping track of the current servo positions.
char servoTiltPosition = 90;//reference posiion is at centre. this angles can be changed for calibraion
char servoPanPosition = 90;
//The pan/tilt servo ids for the Arduino serial command interface.
char tiltChannel = 0;
char panChannel = 1;
char ledch=2;
//These variables hold the x and y location for the middle of the detected face.
int midFaceY=0;
int midFaceX=0;
//The variables correspond to the middle of the screen, and will be compared to the midFace values
int midScreenY = (height/2);
int midScreenX = (width/2);
int midScreenWindow = 10;  //This is the acceptable 'error' for the center of the screen.
//The degree of change that will be applied to the servo each time we update the position.
int stepSize=5;//higher values for faster movement of servo motors
int led=0;//test pin 

 
void setup()
{
  size(w, h);
  video = new Capture(this, width, height);
  video.start();
  loadPixels();
  cam = new OpenCV(this);
  cam.allocate(video.width, video.height);
  cam.copy(video);
  cam.cascade(OpenCV.CASCADE_FRONTALFACE_ALT);
 
  println(Serial.list()); // List COM-ports (Use this to figure out which port the Arduino is connected to)
  //select first com-port from the list (change the number in the [] if your sketch fails to connect to the Arduino)
  port = new Serial(this, Serial.list()[0], 9600);   //Baud rate is set to 57600 to match the Arduino baud rate.
  //Send the initial pan/tilt angles to the Arduino to set the device up to look straight forward.
  port.write(tiltChannel);    //Send the Tilt Servo ID
  port.write(servoTiltPosition);  //Send the Tilt Position (currently 90 degrees)
  port.write(panChannel);         //Send the Pan Servo ID
  port.write(servoPanPosition);   //Send the Pan Position (currently 90 degrees)
}


 
void draw()
{
  if(video.available())
  {
    video.read();
    video.loadPixels();
    cam.copy(video);
    background(0);
    cam.read();
  }
 
  loadPixels();
  int vloc = 0;
  color c = color(0, 0, 0);
  for(int i = 0; i<width;i++)
  {
    for(int j = 0; j<height;j++)
    {
      int loc = i + j*width;
     
      c = 0;
     
      if(i<(video.width+xstart-1) && i>=xstart && j<(video.height+ystart-1)&&j>=ystart)
      {
        vloc = i-xstart + (j-ystart)*video.width;
        float r = red(video.pixels[vloc]);
        float g = green(video.pixels[vloc]);
        float b = blue(video.pixels[vloc]);
     
        c = color(r,g,b);
      }
     
      pixels[loc] = c;
    }
 
  }
  updatePixels();
 
  Rectangle[] faces = cam.detect(1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40,40);
  noFill();
  stroke(0,255,255);
  for(int i = 0; i < faces.length;i++)
  {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  ///////////////////////// removed from above '+ xstart  + ystart'
    if(faces.length > 0)
      {
        midFaceY = faces[i].y + (faces[i].height/2);
        midFaceX = faces[i].x + (faces[i].width/2);
   
       //Find out if the Y component of the face is above the middle of the screen.
       //change here for accuracy 
//        if(midFaceY  > 400 && midFaceY < 480)
//        {
//          if(servoTiltPosition > 30)servoTiltPosition -=stepSize; //Update the tilt position variable to lower the tilt servo.
//          if(servoTiltPosition < 30)servoTiltPosition +=stepSize; //Update the tilt position variable to lower the tilt servo.
//        }
        
        if(midFaceY  > 320 && midFaceY < 480)
        {
          if(servoTiltPosition > 60)servoTiltPosition -=stepSize; //Update the tilt position variable to lower the tilt servo.
          if(servoTiltPosition < 60)servoTiltPosition +=stepSize; //Update the tilt position variable to lower the tilt servo.
        }
        
        if(midFaceY > 240  && midFaceY < 320)
        {
          if(servoTiltPosition > 90 )servoTiltPosition -= stepSize; //If it is above the middle of the screen, update the tilt position variable to raise the tilt servo.
          if(servoTiltPosition < 90 )servoTiltPosition += stepSize; //If it is above the middle of the screen, update the tilt position variable to raise the tilt servo.
        }
      
         
      //Find out if the Y component of the face is below the middle of the screen.
         if(midFaceY  > 160 && midFaceY < 240)
        {
          if(servoTiltPosition > 120)servoTiltPosition -=stepSize; //Update the tilt position variable to lower the tilt servo.
          if(servoTiltPosition < 120)servoTiltPosition +=stepSize; //Update the tilt position variable to lower the tilt servo.
        }
        
         if(midFaceY  > 0 && midFaceY < 160)
        {
          if(servoTiltPosition > 150)servoTiltPosition -=stepSize; //Update the tilt position variable to lower the tilt servo.
          if(servoTiltPosition < 150)servoTiltPosition +=stepSize; //Update the tilt position variable to lower the tilt servo.
        }
//          if(midFaceY  > 0 && midFaceY < 80)
//        {
//          if(servoTiltPosition > 180)servoTiltPosition -=stepSize; //Update the tilt position variable to lower the tilt servo.
//          if(servoTiltPosition < 180)servoTiltPosition +=stepSize; //Update the tilt position variable to lower the tilt servo.
//        }
      //Find out if the X component of the face is to the right of the middle of the screen.
      
      //////FOR X
////      
       if(midFaceX < 34 &&   midFaceX > 0)
        {
           if(servoPanPosition > 6 )servoPanPosition -= stepSize; //Update the pan position variable to move the servo to the right.
          if(servoPanPosition < 6 )servoPanPosition += stepSize; //Update the pan position variable to move the servo to the right.
         //led=1;
        }
        
        if(midFaceX < 640 &&   midFaceX > 606)
        {
           if(servoPanPosition > 150 )servoPanPosition -= stepSize; //Update the pan position variable to move the servo to the right.
          if(servoPanPosition < 150 )servoPanPosition += stepSize; //Update the pan position variable to move the servo to the right.
         //led=1;
        }
        
        if( midFaceX > 554 && midFaceX < 606)
        {
              if(servoPanPosition > 140  )servoPanPosition -= stepSize; //Update the pan position variable to move the servo to the right.
          if(servoPanPosition < 140  )servoPanPosition += stepSize; //Update the pan position variable to move the servo to the right.
        //led=1;
        }
      //Find out if the X component of the face is to the left of the middle of the screen.
         if(midFaceX  > 502 && midFaceX < 554)
        {
          if(servoPanPosition >130)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
           if(servoPanPosition <130)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left.
           // led=0;
        }
       
        
      //Find out if the X component of the face is to the left of the middle of the screen.
         if( midFaceX > 450  && midFaceX < 502  )
        {
          if(servoPanPosition >120)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <120)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
         if( midFaceX > 398  && midFaceX < 450  )
        {
          if(servoPanPosition >110)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <110)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
         if( midFaceX > 346  && midFaceX <398  )
        {
          if(servoPanPosition >100)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <100)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
        
        
         if( midFaceX > 294  && midFaceX < 346  )
        {
          if(servoPanPosition >90)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <90)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
        
         if( midFaceX > 242  && midFaceX < 294  )
        {
          if(servoPanPosition >76)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <76)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
        
         if( midFaceX > 190  && midFaceX <242  )
        {
          if(servoPanPosition >62)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition < 62 )servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
        
         if( midFaceX > 138  && midFaceX <190  )
        {
          if(servoPanPosition >48)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition < 48)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }
        
         if( midFaceX > 86  && midFaceX <138  )
        {
          if(servoPanPosition > 34)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <34)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
        }
              
//           
                if( midFaceX > 34  && midFaceX <86  )
        {
          if(servoPanPosition >20)servoPanPosition -=stepSize; //Update the pan position variable to move the servo to the left.
                    if(servoPanPosition <20)servoPanPosition +=stepSize; //Update the pan position variable to move the servo to the left
                    // led=0;
        }      // led=0;
        }
      }
 
  port.write(tiltChannel);      //Send the tilt servo ID
  port.write(servoTiltPosition); //Send the updated tilt position.
  port.write(panChannel);        //Send the Pan servo ID
  port.write(servoPanPosition);  //Send the updated pan position.
  delay(1);
  /////////////////////////
  }

