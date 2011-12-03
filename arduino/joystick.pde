/*

Joystick Hack

Mark Roland, markroland.com

11/29/2011 - Borrowed code from Button example
11/30/2011 - Update to include y2_axis data and remove extra code

*/

// Set digital pin constants for 2 switches
const int s1 = 2;
const int s2 = 3;

// Setup
void setup() {

  // Initialize the pushbutton pin as an input
  pinMode(s1, INPUT);  
  pinMode(s2, INPUT);
  
  // Initialize serial connection
  Serial.begin(9600);  
}

// Main Loop
void loop(){

  // Read the state of the pushbutton value:
  int s1_state = digitalRead(s1);
  
  // Read the state of the pushbutton value:
  int s2_state = digitalRead(s2);

  // Read analog values
  int x1_axis = analogRead(A0);
  int y1_axis = analogRead(A1);
  int y2_axis = analogRead(A2);
  
  // Output data to Serial port
  // Example: <780 820 923 0 1>
  Serial.print("<");
  Serial.print(x1_axis, DEC);
  Serial.print(" ");
  Serial.print(y1_axis, DEC);
  Serial.print(" ");
  Serial.print(y2_axis, DEC);
  Serial.print(" ");
  Serial.print(s1_state, DEC);
  Serial.print(" ");
  Serial.print(s2_state, DEC);
  Serial.print(">\n");
  
  // Delay for 20 milliseconds (this isn't necessary, but helps throttle the data being sent)
  delay(20);   
}
