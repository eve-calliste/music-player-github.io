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
  fill(255, 0, 0); // Red text
  textSize(32);
  textAlign(CENTER, TOP);
  text("@g Shadow Player", width / 2, 10); // Updated text

  // Draw the favicon substitute in the top-left corner
  if (favicon != null) {
    image(favicon, 10, 10, 330, 330); // Display the favicon at (10, 10) with a size of 32x32 pixels
  }

  // Draw album art
  if (albumArt != null) {
    image(albumArt, width / 2 - 400, 50, 800, 700); // Center the album art
  }

  // Draw the timeline bar
  AudioPlayer player = players[currentSong];
  float progress = map(player.position(), 0, player.length(), 0, progressBarWidth);
  fill(255, 0, 0); // Red color for the progress
  noStroke();
  rect(progressBarX, progressBarY, progress, progressBarHeight); // Draw the progress bar
  noFill();
  stroke(255, 0, 0); // Red color for the outline
  rect(progressBarX, progressBarY, progressBarWidth, progressBarHeight); // Draw the outline

  // --- Show elapsed and total song time in MM:SS format ---
  fill(255, 0, 0);
  textSize(18);
  textAlign(LEFT, BOTTOM);
  text(millisToTime(player.position()), progressBarX, progressBarY - 5);
  textAlign(RIGHT, BOTTOM);
  text(millisToTime(player.length()), progressBarX + progressBarWidth, progressBarY - 5);
  // --------------------------------------------------------

  // Draw 13 buttons in a single row, with keybind legend
  int spacing = 20; // Spacing between buttons
  int buttonsInRow = 13; // Number of buttons in the row
  int startX = (width - (buttonsInRow * 100 + (buttonsInRow - 1) * spacing)) / 2; // Center the row horizontally
  int startY = height - 200; // Start drawing buttons from this y-coordinate

  textSize(16); // Set text size for button labels
  for (int i = 0; i < buttonLabels.length; i++) {
    int x = startX + i * (100 + spacing); // Calculate x position
    int y = startY; // All buttons are in the same row

    // Draw button background for click area
    fill(0);
    stroke(255, 0, 0);
    strokeWeight(2);
    rect(x, y, 100, 50, 10);
    noStroke();

    // Draw 2D icon for each button
    drawButtonIcon(i, x, y);

    // Draw label/keybind centered below the icon
    fill(255, 0, 0);
    textAlign(CENTER, TOP);
    text(buttonLabels[i] + " [" + Character.toUpperCase(buttonKeybinds[i]) + "]", x + 50, y + 54);
  }

  // Draw the "Exit" button at the top-right corner as a rounded X (Xbox style, no circle)
  int exitX = width - 110; // Position 10px from the right edge
  int exitY = 10; // Position 10px from the top edge

  fill(0);
  stroke(255, 0, 0);
  strokeWeight(2);
  rect(exitX, exitY, 100, 50, 10); // Button
  pushMatrix();
  translate(exitX + 50, exitY + 25);
  // Draw rounded X in red and black
  stroke(255, 0, 0);
  strokeWeight(11);
  strokeCap(ROUND);
  line(-18, -18, 18, 18);
  line(-18, 18, 18, -18);
  stroke(0); // black accent
  strokeWeight(4);
  line(-18, -18, 18, 18);
  line(-18, 18, 18, -18);
  popMatrix();

  // Song select buttons (with keybind legend)
  for (int i = 0; i < 3; i++) {
    int bx = 30 + i * 120;
    int by = 300;
    fill(0);
    stroke(255, 0, 0);
    rect(bx, by, 100, 40, 8);
    fill(255, 0, 0);
    noStroke();
    textAlign(CENTER, CENTER);
    text("Song " + (i + 1) + " [" + (i + 1) + "]", bx + 50, by + 20);
  }
}

String millisToTime(int ms) {
  int seconds = ms / 1000;
  int minutes = seconds / 60;
  seconds = seconds % 60;
  return nf(minutes, 2) + ":" + nf(seconds, 2);
}

void drawButtonIcon(int i, int x, int y) {
  pushMatrix();
  translate(x + 50, y + 25); // Center icon in button

  switch(i) {
        case 0: // Mute button: speaker, slash if muted, sound waves if not
  boolean isMuted = false;
  AudioPlayer p = null;
  if (players != null && currentSong >= 0 && currentSong < players.length) {
    p = players[currentSong];
    if (p != null && p.getGain() <= -80) isMuted = true;
  }

  // --- Always draw the speaker base and cone in RED ---
  fill(255, 0, 0); // RED
  noStroke();
  rectMode(CENTER);
  rect(-15, 0, 9, 18, 2);

  fill(255, 0, 0); // RED
  noStroke();
  float coneW = 19;
  float coneH = 18;
  triangle(
    -15 + 9, -coneH/2,
    10, 0,
    -15 + 9, coneH/2
  );

  // --- Draw mute slash or sound waves ---
  if (isMuted) {
    stroke(255, 0, 0);
    strokeWeight(3.5);
    line(-22, -12, 22, 12);
  } else {
    noFill();
    stroke(255, 0, 0); // RED sound waves
    strokeWeight(1.7);
    arc(13, 0, 13, 13, -PI/3, PI/3);
    arc(19, 0, 20, 20, -PI/3, PI/3);
  }
  rectMode(CORNER);
  break;
    case 1: // Shuffle - wide X with arrow tips
      stroke(255, 0, 0);
      strokeWeight(7);
      noFill();
      float w = 22; // half-width
      float h = 10; // half-height
      line(-w, -h, w, h);
      line(-w, h, w, -h);
      float arrLen = 12;
      float arrAng = PI/6;
      drawArrowTip(-w, -h, w, h, arrLen, arrAng, 0);
      drawArrowTip(w, h, -w, -h, arrLen, arrAng, 0);
      drawArrowTip(-w, h, w, -h, arrLen, arrAng, 0);
      drawArrowTip(w, -h, -w, h, arrLen, arrAng, 0);
      break;

    case 2: // Remove - circle with minus
      fill(255, 0, 0);
      stroke(255, 0, 0);
      ellipse(0, 0, 44, 44);
      stroke(0);
      strokeWeight(6);
      line(-16, 0, 16, 0);
      break;

    case 3: // Previous - bar and left triangle
      fill(255, 0, 0);
      noStroke();
      rect(-25, -15, 8, 30, 3);
      fill(255, 0, 0);
      triangle(15, -15, 15, 15, -10, 0);
      break;

    case 4: // Play - right-pointing triangle
      fill(255, 0, 0);
      noStroke();
      triangle(-12, -20, -12, 20, 20, 0);
      break;

   
              case 5: // Rewind 10s - left-facing arc with arrowhead and "10"
      pushMatrix();
        scale(-1, 1); // Mirror horizontally to face left

        // Use unique variable names to avoid conflicts
        float arcDiameterR = 36;
        float arcRadiusR = arcDiameterR / 2;
        float startDegR = 30;
        float endDegR = 330;
        float startAngleR = radians(startDegR);
        float endAngleR = radians(endDegR);

        // Draw the arc
        stroke(255, 0, 0);
        strokeWeight(4);
        noFill();
        arc(0, 0, arcDiameterR, arcDiameterR, startAngleR, endAngleR);

        // Draw the arrowhead at the end (after flip, this is left side)
        float arrowTipAngleR = endAngleR;
        float arrowTipXR = cos(arrowTipAngleR) * arcRadiusR;
        float arrowTipYR = sin(arrowTipAngleR) * arcRadiusR;
        float arrowSizeR = 8;
        float tangentAngleR = arrowTipAngleR + HALF_PI;
        float angleOffsetR = radians(30);
        float arrowAngle1R = tangentAngleR + angleOffsetR;
        float arrowAngle2R = tangentAngleR - angleOffsetR;
        stroke(255, 0, 0);
        line(arrowTipXR, arrowTipYR, arrowTipXR - arrowSizeR * cos(arrowAngle1R), arrowTipYR - arrowSizeR * sin(arrowAngle1R));
        line(arrowTipXR, arrowTipYR, arrowTipXR - arrowSizeR * cos(arrowAngle2R), arrowTipYR - arrowSizeR * sin(arrowAngle2R));
      popMatrix();

      // Draw "10" in the middle (unflipped)
      noStroke();
      fill(255, 0, 0);
      textSize(15);
      textAlign(CENTER, CENTER);
      text("10", 0, 0);
      textSize(16);
      break;
    case 6: // Stop - square
      fill(255, 0, 0);
      stroke(255, 0, 0);
      rectMode(CENTER);
      rect(0, 0, 32, 32, 4);
      rectMode(CORNER);
      break;

    case 7: // FF 10s - right-facing arc with arrowhead and "10"
      // Outer blank circle
      noFill();
      stroke(255, 0, 0);
      strokeWeight(4);
      //ellipse(0, 0, 44, 44);

      // Arc (right-facing, red)
      stroke(255, 0, 0);
      strokeWeight(4);
      noFill();
      float arcDiameter = 36;
      float arcRadius = arcDiameter / 2;
      float startDeg = 30;
      float endDeg = 330;
      float startAngle = radians(startDeg);
      float endAngle = radians(endDeg);
      arc(0, 0, arcDiameter, arcDiameter, startAngle, endAngle);

      // Arrowhead at end of arc (330°)
      float arrowTipAngle = endAngle;
      float arrowTipX = cos(arrowTipAngle) * arcRadius;
      float arrowTipY = sin(arrowTipAngle) * arcRadius;
      float arrowSize = 8;
      float tangentAngle = arrowTipAngle + HALF_PI;
      float angleOffset = radians(30);
      float arrowAngle1 = tangentAngle + angleOffset;
      float arrowAngle2 = tangentAngle - angleOffset;
      stroke(255, 0, 0);
      line(arrowTipX, arrowTipY, arrowTipX - arrowSize * cos(arrowAngle1), arrowTipY - arrowSize * sin(arrowAngle1));
      line(arrowTipX, arrowTipY, arrowTipX - arrowSize * cos(arrowAngle2), arrowTipY - arrowSize * sin(arrowAngle2));

      // "10" in bright red in the center
      noStroke();
      fill(255, 0, 0);
      textSize(15);
      textAlign(CENTER, CENTER);
      text("10", 0, 0);
      textSize(16);
      break;

    case 8: // Pause - two vertical bars
      fill(255, 0, 0);
      noStroke();
      rect(-10, -16, 8, 32, 3);
      rect(10 - 8, -16, 8, 32, 3);
      break;

    case 9: // Next - right triangle and bar
      fill(255, 0, 0);
      noStroke();
      triangle(-15, -15, -15, 15, 10, 0);
      rect(12, -15, 8, 30, 3);
      break;

        case 10: // Loop 1 - two arcs with arrowheads and "1"
      // Parameters for scaling the icon to fit the button
      float arcDiameterL = 32;
      float radiusL = arcDiameterL / 2;
      float topOffsetL = -7;
      float bottomOffsetL = 7;
      float arrowSizeL = 5;

      // Top arc (downward)
      pushMatrix();
        translate(0, topOffsetL);
        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);
        arc(0, 0, arcDiameterL, arcDiameterL, PI, TWO_PI);
      popMatrix();

      // Bottom arc (upward)
      pushMatrix();
        translate(0, bottomOffsetL);
        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);
        arc(0, 0, arcDiameterL, arcDiameterL, 0, PI);
      popMatrix();

      // Arrowheads for top arc (pointing up)
      float topLeftX = cos(PI) * radiusL;
      float topLeftY = sin(PI) * radiusL + topOffsetL;
      float topRightX = cos(TWO_PI) * radiusL;
      float topRightY = sin(TWO_PI) * radiusL + topOffsetL;
      stroke(255, 0, 0);
      strokeWeight(3);
      // Left
      line(topLeftX, topLeftY, topLeftX - arrowSizeL/2, topLeftY - arrowSizeL);
      line(topLeftX, topLeftY, topLeftX + arrowSizeL/2, topLeftY - arrowSizeL);
      // Right
      line(topRightX, topRightY, topRightX - arrowSizeL/2, topRightY - arrowSizeL);
      line(topRightX, topRightY, topRightX + arrowSizeL/2, topRightY - arrowSizeL);

      // Arrowheads for bottom arc (pointing down)
      float botLeftX = cos(PI) * radiusL;
      float botLeftY = sin(PI) * radiusL + bottomOffsetL;
      float botRightX = cos(0) * radiusL;
      float botRightY = sin(0) * radiusL + bottomOffsetL;
      // Left
      line(botLeftX, botLeftY, botLeftX - arrowSizeL/2, botLeftY + arrowSizeL);
      line(botLeftX, botLeftY, botLeftX + arrowSizeL/2, botLeftY + arrowSizeL);
      // Right
      line(botRightX, botRightY, botRightX - arrowSizeL/2, botRightY + arrowSizeL);
      line(botRightX, botRightY, botRightX + arrowSizeL/2, botRightY + arrowSizeL);

      // Centered "1"
      noStroke();
      fill(255, 0, 0);
      textSize(13);
      textAlign(CENTER, CENTER);
      text("1", 0, 0);
      textSize(16);
      break;

        case 11: // Loop ∞ - two arcs with arrowheads and "∞"
      // Parameters for scaling the icon to fit the button
      float arcDiameterInf = 32;
      float radiusInf = arcDiameterInf / 2;
      float topOffsetInf = -7;
      float bottomOffsetInf = 7;
      float arrowSizeInf = 5;

      // Top arc (downward)
      pushMatrix();
        translate(0, topOffsetInf);
        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);
        arc(0, 0, arcDiameterInf, arcDiameterInf, PI, TWO_PI);
      popMatrix();

      // Bottom arc (upward)
      pushMatrix();
        translate(0, bottomOffsetInf);
        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);
        arc(0, 0, arcDiameterInf, arcDiameterInf, 0, PI);
      popMatrix();

      // Arrowheads for top arc (pointing up)
      float topLeftXInf = cos(PI) * radiusInf;
      float topLeftYInf = sin(PI) * radiusInf + topOffsetInf;
      float topRightXInf = cos(TWO_PI) * radiusInf;
      float topRightYInf = sin(TWO_PI) * radiusInf + topOffsetInf;
      stroke(255, 0, 0);
      strokeWeight(3);
      // Left
      line(topLeftXInf, topLeftYInf, topLeftXInf - arrowSizeInf/2, topLeftYInf - arrowSizeInf);
      line(topLeftXInf, topLeftYInf, topLeftXInf + arrowSizeInf/2, topLeftYInf - arrowSizeInf);
      // Right
      line(topRightXInf, topRightYInf, topRightXInf - arrowSizeInf/2, topRightYInf - arrowSizeInf);
      line(topRightXInf, topRightYInf, topRightXInf + arrowSizeInf/2, topRightYInf - arrowSizeInf);

      // Arrowheads for bottom arc (pointing down)
      float botLeftXInf = cos(PI) * radiusInf;
      float botLeftYInf = sin(PI) * radiusInf + bottomOffsetInf;
      float botRightXInf = cos(0) * radiusInf;
      float botRightYInf = sin(0) * radiusInf + bottomOffsetInf;
      // Left
      line(botLeftXInf, botLeftYInf, botLeftXInf - arrowSizeInf/2, botLeftYInf + arrowSizeInf);
      line(botLeftXInf, botLeftYInf, botLeftXInf + arrowSizeInf/2, botLeftYInf + arrowSizeInf);
      // Right
      line(botRightXInf, botRightYInf, botRightXInf - arrowSizeInf/2, botRightYInf + arrowSizeInf);
      line(botRightXInf, botRightYInf, botRightXInf + arrowSizeInf/2, botRightYInf + arrowSizeInf);

      // Centered "∞"
      noStroke();
      fill(255, 0, 0);
      textSize(15);
      textAlign(CENTER, CENTER);
      text("∞", 0, 0);
      textSize(16);
      break;
    case 12: // Menu - three rectangles (hamburger)
      fill(255, 0, 0);
      noStroke();
      rectMode(CENTER);
      rect(0, -10, 34, 5, 2);
      rect(0, 0, 34, 5, 2);
      rect(0, 10, 34, 5, 2);
      rectMode(CORNER);
      break;
  }

  popMatrix();
}

// Draws an arrow tip at the end of a line segment from (x1,y1) to (x2,y2)
void drawArrowTip(float x1, float y1, float x2, float y2, float arrLen, float arrAng, int colorOverride) {
  float angle = atan2(y2 - y1, x2 - x1);
  float ax = x2;
  float ay = y2;
  float tip1x = ax + cos(angle + PI - arrAng) * arrLen;
  float tip1y = ay + sin(angle + PI - arrAng) * arrLen;
  float tip2x = ax + cos(angle + PI + arrAng) * arrLen;
  float tip2y = ay + sin(angle + PI + arrAng) * arrLen;
  stroke(0);
  strokeWeight(3);
  line(ax, ay, tip1x, tip1y);
  line(ax, ay, tip2x, tip2y);
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
