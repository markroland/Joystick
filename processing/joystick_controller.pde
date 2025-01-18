/**
 * Joystick Controller Class
 *
 * Mark Roland, markroland.com
 *
 * 12/3/2011
 *
 */
class Joystick{

  // Public variables
  public int readFlag = -1;
  float x1_pos;
  float y1_pos;
  float x2_pos;
  float y2_pos;

  // Private variables

  int x1_val = 0;
  int y1_val = 0;
  int y2_val = 0;
  int s1_val = -1;
  int s2_val = -1;

  int x1_min;
  int x1_max;
  int y1_min;
  int y1_max;

  int x2_min;
  int x2_max;
  int y2_min;
  int y2_max;

  void read(){

    // Data received from the serial port
    int inByte;

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
        //print_data();
        //render();
      }
    }

  }

  void print_data(){
    println("<" + x1_val + " " + y1_val + " " + y2_val + " " + s1_val + " " + s2_val + ">");
  }

  void calibrate(){

    int calibration_num = 1;
    int s1_pressed = 0;
    int s1_released = 0;

    // Prompt for calibration
    println("Please move Joystick to top left and press the joystick front trigger");

    while( calibration_num < 3 ){

      // read the data
      read();

      // Check to see if button 's1' has been pressed. If so, set a "pressed" flag
      // If "pressed" flag is set and s1 has been released, increment the released
      // counter to proceed to the next calibration setting.
      if( s1_val == 0 ){
        s1_pressed = 1;
      }else if( s1_pressed == 1 ){
        s1_released++;
        s1_pressed = 0;
      }

      if( calibration_num == 1 && s1_released == 1){
        x1_max = x1_val;
        y1_max = y1_val;
        println("x1_max: " + x1_max);
        println("y1_max: " + y1_max);
        println("Please move Joystick to bottom right and press the joystick front trigger");
        calibration_num++;
      }

      if( calibration_num == 2 && s1_released == 2){
        x1_min = x1_val;
        y1_min = y1_val;
        println("x1_min: " + x1_min);
        println("y1_min: " + y1_min);
        println("Calibration complete");
        calibration_num++;
      }

    } // End while

  } // End calibrate()

  void render(){

    // Draw background
    background(255);

    // Start a translation matrix
    pushMatrix();

    // translate to center
    translate(0.5*width, 0.5*height);

    crosshairs();
    render_buttons();

    // Close translation matrix
    popMatrix();
  }

  void render_buttons(){
    // Push Button s1 (front button) and s2 (top button)
    if( s1_val == 0 || s2_val == 0){
      fill(255 - 255 * s1_val, 255 - 255 * s2_val, 0, 64);
      noStroke();
      rectMode(CORNER);
      rect(-0.5*width, -0.5*height, width, height);
    }
  }

  void crosshairs(){



    // Draw center axis
    stroke(0,64);
    strokeWeight(1);
    line(-0.5*width, 0, 0.5*width, 0);
    line(0, 0.5*height, 0, -0.5*height);



    // Y2 Position (use for crosshair thickness)
    stroke(0,0,255);
    float min_z = 535.0;
    float max_z = 1023.0;
    float z_range = max_z - min_z;
    float normalized_z = (y2_val - min_z) / z_range;
    strokeWeight( 10 * abs(normalized_z) );

    // X1 Position
    int x_range = x1_max - x1_min;
    float median_x = 0.5 * (x_range) + x1_min;
    float normalized_x = (x1_val - median_x) / (0.5 * x_range);
    line(-0.5*width*normalized_x, 0.5*height, -0.5*width*normalized_x, -0.5*height);

    // Y2 Pposition
    int y_range = y1_max - y1_min;
    float median_y = 0.5 * (y_range) + y1_min;
    float normalized_y = (y1_val - median_y) / (0.5 * y_range);
    line(0.5*width, -0.5*height*normalized_y, -0.5*width, -0.5*height*normalized_y);

    // Display normalized position of cursor
    println("[" + normalized_x + "," + normalized_y +"]");

  }

} // END class
