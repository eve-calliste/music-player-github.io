/* Purpose: draw various rectangles based on the provided diagram
   Vocabulary
   - Declaration & Initialization
   - Local Variables v Global Variables
   - Population of variables
 */

// Global Variables
float mainRectX, mainRectY, mainRectSize;
float longRectX, longRectY, longRectWidth, longRectHeight;
float squareX, squareY, squareSize, squareSpacing;
int numSquares = 13;

void setup() {
  // Display
  fullScreen();
  println(displayWidth, displayHeight);
  int appWidth = displayWidth;
  int appHeight = displayHeight;
  println(appWidth, appHeight);

  // Main rectangle (now a square) more centered
  mainRectSize = min(appWidth, appHeight) * 0.35;
  mainRectX = (appWidth - mainRectSize) / 2;
  mainRectY = (appHeight * 0.10);

  // Long rectangle below the main rectangle
  longRectX = appWidth * 0.10;
  longRectY = appHeight * 0.55;
  longRectWidth = appWidth * 0.80;
  longRectHeight = appHeight * 0.05;

  // Calculate the size and spacing of the squares
  float totalSpacing = appWidth * 0.10; // Total spacing reserved
  squareSpacing = totalSpacing / (numSquares - 1); // Spacing between squares
  squareSize = (appWidth - totalSpacing) / numSquares; // Size of each square
  squareY = appHeight * 0.85; // Position the squares at the bottom of the screen

} // End setup

void draw() {
  background(0); // Set the background to black
  
  // Draw main rectangle (now a square)
  rect(mainRectX, mainRectY, mainRectSize, mainRectSize);

  // Draw long rectangle
  rect(longRectX, longRectY, longRectWidth, longRectHeight);

  // Draw the squares
  for (int i = 0; i < numSquares; i++) {
    squareX = (width - numSquares * squareSize - (numSquares - 1) * squareSpacing) / 2 + i * (squareSize + squareSpacing); // Center the squares horizontally
    rect(squareX, squareY, squareSize, squareSize);
  }
} // End draw

void mousePressed() {
} // End mousePressed

void keyPressed() {
} // End keyPressed

// End Main Program
