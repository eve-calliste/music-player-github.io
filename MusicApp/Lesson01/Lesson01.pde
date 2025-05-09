import ddf.minim.*; // Import the Minim library

// Variables for music
Minim minim;
AudioPlayer player1, player2, player3;
AudioPlayer currentPlayer; // Tracks the currently playing song

void setup() {
  size(800, 600); // Set the window size

  // Initialize Minim and load MP3 files
  minim = new Minim(this);

  player1 = minim.loadFile("[SPOTDOWNLOADER.COM] MEGAVERSE.mp3");
  if (player1 == null) {
    println("Error: Could not load MEGAVERSE.mp3");
  }

  player2 = minim.loadFile("[SPOTDOWNLOADER.COM] TOPLINE (Feat. Tiger JK) (1).mp3");
  if (player2 == null) {
    println("Error: Could not load TOPLINE.mp3");
  }

  player3 = minim.loadFile("[SPOTDOWNLOADER.COM] VENOM.mp3");
  if (player3 == null) {
    println("Error: Could not load VENOM.mp3");
  }

  currentPlayer = player1; // Set the default player
}

void draw() {
  background(0); // Set the background to black
  fill(255); // White text
  textSize(16);
  text("Press 1 to play MEGAVERSE", 10, 20);
  text("Press 2 to play TOPLINE", 10, 40);
  text("Press 3 to play VENOM", 10, 60);
  text("Press SPACE to pause/resume", 10, 80);
  text("Press S to stop", 10, 100);
}

void keyPressed() {
  if (key == '1') {
    switchPlayer(player1);
    println("Playing MEGAVERSE");
  } else if (key == '2') {
    switchPlayer(player2);
    println("Playing TOPLINE");
  } else if (key == '3') {
    switchPlayer(player3);
    println("Playing VENOM");
  } else if (key == ' ') {
    if (currentPlayer != null && currentPlayer.isPlaying()) {
      currentPlayer.pause();
      println("Music paused");
    } else if (currentPlayer != null) {
      currentPlayer.play();
      println("Music playing");
    }
  } else if (key == 's' || key == 'S') {
    if (currentPlayer != null) {
      currentPlayer.pause();
      currentPlayer.rewind();
      println("Music stopped");
    }
  }
}

void switchPlayer(AudioPlayer newPlayer) {
  if (currentPlayer != null) {
    currentPlayer.pause();
    currentPlayer.rewind();
  }

  if (newPlayer != null) {
    currentPlayer = newPlayer;
    currentPlayer.play();
  } else {
    println("Error: newPlayer is null");
  }
}

void stop() {
  if (player1 != null) player1.close();
  if (player2 != null) player2.close();
  if (player3 != null) player3.close();
  minim.stop();
  super.stop();
}