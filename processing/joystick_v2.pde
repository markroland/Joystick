/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */

// Import Serial library
import processing.serial.*;
  
// Create object from Serial class
Serial myPort;

// Create new Joystick class object
Joystick j1;

// Setup the sketch
void setup() {
  
  // Set sketch size
  size(800, 800);
  
  // Initialize the serial port
  myPort = new Serial(this, Serial.list()[0], 9600);
  
  // Initialize the joystick object
  j1 = new Joystick();

  // Calibrate the joystick before starting the sketch
  j1.calibrate();
}

// Loop the sketch
void draw() {
  
  // Read the joystick
  j1.read();
  
  // Render a cursor
  if( j1.readFlag == 0 )
    j1.render();
}
