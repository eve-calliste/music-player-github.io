int appWidth, appHeight;
float squareWidth, squareHeight;
float horizontalSpacing;  // Horizontal space between squares
float verticalSpacing;    // Vertical space between squares
int squaresPerRow = 13;   // Total number of squares in a row
int squaresPerColumn = 1; // 1 row of squares at the bottom

void setup() {
  // Initialize the display
  fullScreen();
  appWidth = displayWidth;
  appHeight = displayHeight;

  // Calculate the size of the squares (width and height)
  squareWidth = (appWidth - (horizontalSpacing * (squaresPerRow + 1))) / squaresPerRow; 
  squareHeight = appHeight * 0.10; // Set square height (adjustable)

  // Set horizontal and vertical spacing between squares
  horizontalSpacing = 20; // Adjust this for horizontal gap between squares
  verticalSpacing = 20;   // Adjust this for vertical gap between rows (optional)

  // Calculate Y position for the squares (near the bottom of the screen)
  float squareY = appHeight - squareHeight - verticalSpacing;

  // Draw squares
  noFill();
  stroke(255);  // Set the color to white for the square borders

  // Loop to draw the squares in the row
  for (int i = 0; i < squaresPerRow; i++) {
    float squareX = horizontalSpacing + i * (squareWidth + horizontalSpacing); // Calculate X position with spacing
    rect(squareX, squareY, squareWidth, squareHeight);  // Draw the square
  }
}

void draw() {
  // Your animation or logic can be added here if you want to change the squares over time
}

void mousePressed
