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
  player = minim.loadFile("[SPOTDOWNLOADER.COM] VENOM.mp3"); // Replace "song.mp3" with "[SPOTDOWNLOADER.COM] VENOM.mp3"

  // Load album art
  albumArt = loadImage("stray_kids_logo.png"); // Replace "stray_kids_logo.png" with the logo file name

  // Load the favicon substitute
  favicon = loadImage("Images/agshadowplayerlogo.png"); // Use the exact file path

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

  // Draw timeline bar
  float progress = map(player.position(), 0, player.length(), 0, progressBarWidth);
  fill(255, 0, 0); // Red color for the progress
  rect(progressBarX, progressBarY, progress, progressBarHeight); // Draw the progress bar
  noFill();
  stroke(255, 0, 0); // Red color for the outline
  rect(progressBarX, progressBarY, progressBarWidth, progressBarHeight); // Draw the outline

  // Draw buttons in a grid layout
  fill(255, 0, 0); // Red color for buttons
  int spacing = 20; // Spacing between buttons
  int buttonsPerRow = 4; // Number of buttons per row
  int startX = (width - (buttonsPerRow * 100 + (buttonsPerRow - 1) * spacing)) / 2; // Center the grid horizontally
  int startY = height - 200; // Start drawing buttons from this y-coordinate

  String[] buttonLabels = {
    "Mute", "Shuffle", "Remove", "Prev",
    "Play", "Rewind 10s", "Stop", "FF 10s",
    "Pause", "Next", "Loop 1", "Loop ∞",
    "Menu", "Exit"
  };

  textSize(16); // Set text size for button labels
  for (int i = 0; i < buttonLabels.length; i++) {
    int row = i / buttonsPerRow; // Calculate the row index
    int col = i % buttonsPerRow; // Calculate the column index
    int x = startX + col * (100 + spacing); // Calculate x position
    int y = startY + row * (50 + spacing); // Calculate y position

    // Calculate button width dynamically based on text width
    float buttonWidth = max(100, textWidth(buttonLabels[i]) + 20); // Ensure a minimum width of 100
    float buttonHeight = 50; // Fixed height for buttons

    // Draw the button
    rect(x, y, buttonWidth, buttonHeight); // Draw a rectangle button
    fill(0); // Black text
    textAlign(CENTER, CENTER);
    text(buttonLabels[i], x + buttonWidth / 2, y + buttonHeight / 2); // Draw the label
    fill(255, 0, 0); // Reset fill color for the next button
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
  } else if (key == 'm' || key == 'M') { // Mute
    println("Muted");
    // Add mute functionality here
  } else if (key == 'h' || key == 'H') { // Shuffle
    println("Shuffled playlist");
    // Add shuffle functionality here
  } else if (key == 'x' || key == 'X') { // Remove song
    println("Removed song from playlist");
    // Add remove song functionality here
  } else if (key == 'p' || key == 'P') { // Previous song
    println("Playing previous song");
    // Add previous song functionality here
  } else if (key == 'n' || key == 'N') { // Next song
    println("Playing next song");
    // Add next song functionality here
  } else if (key == 'l' || key == 'L') { // Loop once
    player.loop(1);
    println("Looping once");
  } else if (key == 'i' || key == 'I') { // Loop infinitely
    player.loop();
    println("Looping infinitely");
  } else if (key == 'u' || key == 'U') { // Menu
    println("Opening menu");
    // Add menu functionality here
  }
}

void mousePressed() {
  // Add mouse interaction logic here if needed
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
