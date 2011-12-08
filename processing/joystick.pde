/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */

// Import Serial library
import processing.serial.*;

Serial myPort;  // Create object from Serial class
int inByte;      // Data received from the serial port
int readFlag = 0;

int x1_val = 0;
int y1_val = 0;
int y2_val = 0;
int s1_val = 0;
int s2_val = 0;

void setup() {
  size(800, 800);
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  
 // read value from serial port
  while (myPort.available() > 0) {
    inByte = myPort.read();
    
    // start of transmission: "<"
    if(inByte == 60){
      x1_val = 0;
      y1_val = 0;
      y2_val = 0;
      readFlag = 1;
    }
    
    // between ASCII numbers 0-9
    if(readFlag > 0 && (inByte >= 48) && (inByte <= 57)){ 
      
      if(readFlag == 1){
        x1_val *= 10;
        x1_val += inByte-48;
      }
      
      if(readFlag == 2){
        y1_val *= 10;
        y1_val += inByte-48;
      }
      
      if(readFlag == 3){
        y2_val *= 10;
        y2_val += inByte-48;
      }
      
      if(readFlag == 4){
        s1_val = inByte - 48;
      }

      if(readFlag == 5){
        s2_val = inByte - 48;
      }      
      
    }
    
    // space between points
    if(inByte == 32) 
      readFlag++;  

    // end of transmission: ">"
    if(inByte == 62){
      readFlag = 0;
      //println(x1_val);
      render();
    }
  } 
}

void render(){
  
  // Draw background
  background(255);
  
  // Start a translation matrix
  pushMatrix();
  
  // translate to center
  translate(0.5*width, 0.5*height);
  
  // Draw center axis
  stroke(0,64);
  strokeWeight(1);
  line(-0.5*width, 0, 0.5*width, 0);
  line(0, 0.5*height, 0, -0.5*height);
    
  // Push Button s1 (front button) and s2 (top button)
  if( s1_val == 0 || s2_val == 0){
    fill(255 - 255 * s1_val, 255 - 255 * s2_val, 0, 64);
    noStroke();
    rectMode(CORNER);
    rect(-0.5*width, -0.5*height, width, height);
  }
  
  // Draw cursor position
  stroke(255,0,0);

  // Y2-position
  stroke(0,0,255);
  float min_z = 535.0;
  float max_z = 1023.0;
  float z_range = max_z - min_z;
  float normalized_z = (y2_val - min_z) / z_range;
  strokeWeight( 10 * abs(normalized_z) );
 
  // X-position
  int min_x = 545;
  int max_x = 1023;
  int x_range = max_x - min_x;
  float median_x = 0.5 * (x_range) + min_x;
  float normalized_x = (x1_val - median_x) / (0.5 * x_range);   
  line(-0.5*width*normalized_x, 0.5*height, -0.5*width*normalized_x, -0.5*height);

  // Y-position
  int min_y = 545;
  int max_y = 1023;
  int y_range = max_y - min_y;
  float median_y = 0.5 * (y_range) + min_y;
  float normalized_y = (y1_val - median_y) / (0.5 * y_range);    
  line(0.5*width, -0.5*height*normalized_y, -0.5*width, -0.5*height*normalized_y);
  
  // Close translation matrix
  popMatrix();
}
