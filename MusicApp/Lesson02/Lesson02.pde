import ddf.minim.*; // Import the Minim library

// Variables for music and images
Minim minim;
AudioPlayer player;
PImage albumArt;
PImage favicon; // Variable for the favicon substitute

// Variables for the timeline bar
float progressBarX, progressBarY, progressBarWidth, progressBarHeight;

void setup() {
  size(800, 600); // Set the window size

  // Initialize Minim and load an MP3 file
  minim = new Minim(this);
  player = minim.loadFile("[SPOTDOWNLOADER.COM] VENOM.mp3"); // Replace with your MP3 file

  // Load album art
  albumArt = loadImage("stray_kids_logo.png"); // Replace with your album art file

  // Load the favicon substitute
  favicon = loadImage(""); // Replace with your updated file path

  // Set up the timeline bar
  progressBarX = 50;
  progressBarY = height - 50;
  progressBarWidth = width - 100;
  progressBarHeight = 20;
}

void draw() {
  background(0); // Set the background to black

  // Display the player name
  fill(255); // White text
  textSize(32);
  textAlign(CENTER, TOP);
  text("@g Shadow Player", width / 2, 10); // Updated text

  // Draw the favicon substitute in the top-left corner
  if (favicon != null) {
    image(favicon, 10, 10, 32, 32); // Display the favicon at (10, 10) with a size of 32x32 pixels
  }

  // Draw album art
  if (albumArt != null) {
    image(albumArt, width / 2 - 100, 50, 200, 200); // Center the album art
  }

  // Draw the timeline bar
  float progress = map(player.position(), 0, player.length(), 0, progressBarWidth);
  fill(255, 0, 0); // Red color for the progress
  rect(progressBarX, progressBarY, progress, progressBarHeight); // Draw the progress bar
  noFill();
  stroke(255, 0, 0); // Red color for the outline
  rect(progressBarX, progressBarY, progressBarWidth, progressBarHeight); // Draw the outline

  // Draw 13 buttons in a single row
  fill(255, 0, 0); // Red color for buttons
  int spacing = 20; // Spacing between buttons
  int buttonsInRow = 13; // Number of buttons in the row
  int startX = (width - (buttonsInRow * 100 + (buttonsInRow - 1) * spacing)) / 2; // Center the row horizontally
  int startY = height - 200; // Start drawing buttons from this y-coordinate

  String[] buttonLabels = {
    "Mute", "Shuffle", "Remove", "Prev",
    "Play", "Rewind 10s", "Stop", "FF 10s",
    "Pause", "Next", "Loop 1", "Loop ∞", "Menu"
  };

  textSize(16); // Set text size for button labels
  for (int i = 0; i < buttonLabels.length; i++) {
    int x = startX + i * (100 + spacing); // Calculate x position
    int y = startY; // All buttons are in the same row

    // Draw the button
    rect(x, y, 100, 50); // Fixed width and height for buttons
    fill(0); // Black text
    textAlign(CENTER, CENTER);
    text(buttonLabels[i], x + 50, y + 25); // Draw the label centered in the button
    fill(255, 0, 0); // Reset fill color for the next button
  }

  // Draw the "Exit" button at the top-right corner
  String exitLabel = "Exit";
  int exitX = width - 110; // Position 10px from the right edge
  int exitY = 10; // Position 10px from the top edge

  rect(exitX, exitY, 100, 50); // Draw "Exit" button
  fill(0); // Black text
  textAlign(CENTER, CENTER);
  text(exitLabel, exitX + 50, exitY + 25); // Draw the label
}

void mousePressed() {
  // Check if mouse is over the "Exit" button
  int exitX = width - 110;
  int exitY = 10;
  if (mouseX > exitX && mouseX < exitX + 100 && mouseY > exitY && mouseY < exitY + 50) {
    exit(); // Exit the program
  }

  // Check if mouse is over any of the 13 buttons in the bottom row
  int spacing = 20;
  int buttonsInRow = 13;
  int startX = (width - (buttonsInRow * 100 + (buttonsInRow - 1) * spacing)) / 2;
  int startY = height - 200;

  String[] buttonLabels = {
    "Mute", "Shuffle", "Remove", "Prev",
    "Play", "Rewind 10s", "Stop", "FF 10s",
    "Pause", "Next", "Loop 1", "Loop ∞", "Menu"
  };

  for (int i = 0; i < buttonLabels.length; i++) {
    int x = startX + i * (100 + spacing);
    int y = startY;
    if (mouseX > x && mouseX < x + 100 && mouseY > y && mouseY < y + 50) {
      println("Button clicked: " + buttonLabels[i]);
      // Add functionality for each button here
    }
  }
}

void keyPressed() {
  if (key == ' ') { // Space bar for play/pause
    if (player.isPlaying()) {
      player.pause();
      println("Music paused");
    } else {
      player.play();
      println("Music playing");
    }
  } else if (key == 's' || key == 'S') { // Stop the music
    player.pause();
    player.rewind();
    println("Music stopped");
  } else if (key == 'r' || key == 'R') { // Rewind 10 seconds
    player.skip(-10000);
    println("Rewind 10 seconds");
  } else if (key == 'f' || key == 'F') { // Fast forward 10 seconds
    player.skip(10000);
    println("Fast forward 10 seconds");
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
