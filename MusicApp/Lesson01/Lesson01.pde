import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Variables for music and images
Minim minim;
AudioPlayer player;
PImage albumArt;

// Variables for the timeline bar
float progressBarX, progressBarY, progressBarWidth, progressBarHeight;

void setup() {
  size(800, 600); // Set the window size

  // Initialize Minim and load an MP3 file
  minim = new Minim(this);
  player = minim.loadFile("[SPOTDOWNLOADER.COM] MEGAVERSE.mp3"); // Replace "downloaded_song.mp3" with the actual file name

  // Load album art
  albumArt = loadImage("stray_kids_logo.png"); // Replace "downloaded_album_art.png" with the actual file name

  // Set up the timeline bar
  progressBarX = 50;
  progressBarY = height - 50;
  progressBarWidth = width - 100;
  progressBarHeight = 20;
}

void draw() {
  background(0); // Set the background to black

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

  // Draw buttons (example: play button)
  fill(255, 0, 0); // Red color for buttons
  ellipse(width / 2, height - 100, 50, 50); // Example button (circle)
  fill(0);
  textAlign(CENTER, CENTER);
  text("Play", width / 2, height - 100); // Label for the button
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
