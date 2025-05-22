import ddf.minim.*; // Import the Minim library

// Variables for music and images
Minim minim;
AudioPlayer[] players = new AudioPlayer[3];
int currentSong = 0;

PImage albumArt;
PImage favicon; // Variable for the favicon substitute

// Variables for the timeline bar
float progressBarX, progressBarY, progressBarWidth, progressBarHeight;

// Display size variables
int appWidth, appHeight, appShortSide;

String[] buttonLabels = {
  "Mute", "Shuffle", "Remove", "Prev",
  "Play", "Rewind 10s", "Stop", "FF 10s",
  "Pause", "Next", "Loop 1", "Loop ∞", "Menu"
};

char[] buttonKeybinds = {
  'm', 'h', 'd', 'a',
  'p', 'r', 's', 'f',
  'u', 'n', 'l', 'i', 'q'
};

void setup() {
  // Make the sketch fullscreen
  fullScreen();
  appWidth = displayWidth;
  appHeight = displayHeight;
  appShortSide = (appWidth < appHeight) ? appWidth : appHeight;

  // Initialize Minim and load three MP3 files
  minim = new Minim(this);
  players[0] = minim.loadFile("[SPOTDOWNLOADER.COM] VENOM.mp3");
  players[1] = minim.loadFile("[SPOTDOWNLOADER.COM] MEGAVERSE.mp3");
  players[2] = minim.loadFile("[SPOTDOWNLOADER.COM] TOPLINE (Feat. Tiger JK) (1).mp3");

  // Load album art
  albumArt = loadImage("stray_kids_logo.png"); // Replace with your album art file

  // Load the favicon substitute
  favicon = loadImage("agshadowplayer.png"); // Replace with your updated file path

  // Set up the timeline bar based on fullscreen width/height
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
  AudioPlayer player = players[currentSong];
  float progress = map(player.position(), 0, player.length(), 0, progressBarWidth);
  fill(255, 0, 0); // Red color for the progress
  rect(progressBarX, progressBarY, progress, progressBarHeight); // Draw the progress bar
  noFill();
  stroke(255, 0, 0); // Red color for the outline
  rect(progressBarX, progressBarY, progressBarWidth, progressBarHeight); // Draw the outline

  // Draw 13 buttons in a single row, with keybind legend
  fill(255, 0, 0); // Red color for buttons
  int spacing = 20; // Spacing between buttons
  int buttonsInRow = 13; // Number of buttons in the row
  int startX = (width - (buttonsInRow * 100 + (buttonsInRow - 1) * spacing)) / 2; // Center the row horizontally
  int startY = height - 200; // Start drawing buttons from this y-coordinate

  textSize(16); // Set text size for button labels
  for (int i = 0; i < buttonLabels.length; i++) {
    int x = startX + i * (100 + spacing); // Calculate x position
    int y = startY; // All buttons are in the same row

    // Draw the button
    rect(x, y, 100, 50); // Fixed width and height for buttons
    fill(0); // Black text
    textAlign(CENTER, CENTER);
    text(buttonLabels[i] + " [" + Character.toUpperCase(buttonKeybinds[i]) + "]", x + 50, y + 25); // Draw the label centered in the button
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

  // Song select buttons (with keybind legend)
  for (int i = 0; i < 3; i++) {
    int bx = 30 + i * 120;
    int by = 300;
    rect(bx, by, 100, 40);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Song " + (i + 1) + " [" + (i + 1) + "]", bx + 50, by + 20);
    fill(255, 0, 0);
  }
}

void mousePressed() {
  // Song select buttons
  for (int i = 0; i < 3; i++) {
    int bx = 30 + i * 120;
    int by = 300;
    if (mouseX > bx && mouseX < bx + 100 && mouseY > by && mouseY < by + 40) {
      switchSong(i);
      return;
    }
  }

  // Exit
  int exitX = width - 110;
  int exitY = 10;
  if (mouseX > exitX && mouseX < exitX + 100 && mouseY > exitY && mouseY < exitY + 50) {
    exit();
  }

  // 13 button row
  int spacing = 20;
  int buttonsInRow = 13;
  int startX = (width - (buttonsInRow * 100 + (buttonsInRow - 1) * spacing)) / 2;
  int startY = height - 200;
  for (int i = 0; i < buttonLabels.length; i++) {
    int x = startX + i * (100 + spacing);
    int y = startY;
    if (mouseX > x && mouseX < x + 100 && mouseY > y && mouseY < y + 50) {
      handleButtonAction(i);
      return;
    }
  }
}

// Centralized button action logic for both mouse and keybinds
void handleButtonAction(int idx) {
  AudioPlayer p = players[currentSong];
  switch(idx) {
    case 0: // "Mute"
      if (p.getGain() > -80) p.setGain(-80); else p.setGain(0);
      break;
    case 1: // "Shuffle"
      int next = currentSong;
      while (next == currentSong && players.length > 1) next = int(random(players.length));
      switchSong(next);
      break;
    case 2: // "Remove"
      p.pause(); p.rewind();
      break;
    case 3: // "Prev"
      switchSong((currentSong + players.length - 1) % players.length);
      break;
    case 4: // "Play"
      if (!p.isPlaying()) p.play();
      break;
    case 5: // "Rewind 10s"
      p.skip(-10000);
      break;
    case 6: // "Stop"
      p.pause(); p.rewind();
      break;
    case 7: // "FF 10s"
      p.skip(10000);
      break;
    case 8: // "Pause"
      if (p.isPlaying()) p.pause();
      break;
    case 9: // "Next"
      switchSong((currentSong + 1) % players.length);
      break;
    case 10: // "Loop 1"
      p.loop(1);
      break;
    case 11: // "Loop ∞"
      p.loop();
      break;
    case 12: // "Menu"
      println("Menu opened! (implement your menu logic here)");
      break;
  }
}

void keyPressed() {
  AudioPlayer p = players[currentSong];
  // Song select keybinds
  if (key == '1') {
    switchSong(0);
    return;
  } else if (key == '2') {
    switchSong(1);
    return;
  } else if (key == '3') {
    switchSong(2);
    return;
  }
  // 13 button keybinds
  for (int i = 0; i < buttonKeybinds.length; i++) {
    if (key == buttonKeybinds[i] || key == Character.toUpperCase(buttonKeybinds[i])) {
      handleButtonAction(i);
      return;
    }
  }
}

void switchSong(int idx) {
  if (idx < 0 || idx >= players.length) return;
  if (players[currentSong].isPlaying()) players[currentSong].pause();
  players[currentSong].rewind();
  currentSong = idx;
  players[currentSong].play();
}

void stop() {
  for (int i = 0; i < players.length; i++) players[i].close();
  minim.stop();
  super.stop();
}
