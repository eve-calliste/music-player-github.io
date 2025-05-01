//Dynamic Programming v Static
//
//Library - Minim
//Add Library in IDE and Code
//
//Global Variables
int appWidth, appHeight;
float ImageX, ImageY, ImageWidth, ImageHeight;
float TimeLineX, TimeLineY, TimeLineWidth, TimeLineHeight;
//
void setup() {
  //Display
  fullScreen();
  appWidth = displayWidth;
  appHeight = displayHeight;

  /*
  X = appWidth*0;
   Y = appHeight*0;
   Width = appWidth*0;
   Height = appHeight*0;
   */

  // TimeLine
  TimeLineX = appWidth*0.10;
  TimeLineY = appHeight*0.70;
  TimeLineWidth = appWidth*0.75;
  TimeLineHeight = appHeight*0.05;

  // Image
  ImageX = appWidth*0.34;
  ImageY = appHeight*0.07;
  ImageHeight = appHeight*0.46;
  ImageWidth = ImageHeight;
//mute
muteX = appWidth*0;
  muteY = appHeight*0 ;
  muteWidth = appwidth*0;
  muteHeight = appheight*0;
shuffleX = 
shuffleY = 
shuffleWidth = 
shuffleHeight = 
 removesongfromplaylistX = 
 removesongfromplaylistY = 
 removesongfromplaylistWidth = 
 removesongfromplaylistHeight = 
 previoussongX = 
 previoussongY = 
 previoussongWidth = 
 previoussongHeight = 
 playX = 
 playY = 
 playWidth = 
 playHeight = 
 rewindtensecondsX = 
 rewindtensecondsY = 
 rewindtensecondsWidth = 
 rewindtensecondsHeight = 
 stopX = 
 stopY = 
 stopWidth = 
 stopHeight = 
 fastfowardtensecondsX = 
 fastfowardtensecondsY = 
 fastfowardtensecondsWidth = 
 fastfowardtensecondsHeight = 
 pauseX = 
 pauseY = 
 pauseWidth = 
 pauseHeight = 
 nextsongX = 
 nextsongY = 
 nextsongWidth = 
 nextsongHeight = 
 looponceX = 
 looponceY = 
 looponceWidth = 
 looponceHeight = 
 loopinfiniteX = 
 loopinfiniteY = 
 loopinfiniteWidth = 
 loopinfiniteHeight = 
 menuX = 
 menuY = 
 menuWidth = 
 menuHeight =
  rect(ImageX, ImageY, ImageWidth, ImageHeight);
  rect(TimeLineX, TimeLineY, TimeLineWidth, TimeLineHeight);
 rect( muteX, muteY, muteWidth, muteHeight );
  rect( shuffleX, shuffleY, shuffleWidth, shuffleHeight );
  rect( removesongfromplaylistX, removesongfromplaylistY, removesongfromplaylistWidth, removesongfromplaylistHeight );
  rect( previoussongX, previoussongY, previoussongWidth, previoussongHeight );
  rect( playX, playY, playWidth, playHeight );
  rect( rewindtensecondsX, rewindtensecondsY, rewindtensecondsWidth, rewindtensecondsHeight );
  rect( stopX, stopY, stopWidth, stopHeight );
  rect( fastfowardtensecondsX, fastfowardtensecondsDY, fastfowardtensecondsWidth, fastfowardtensecondsHeight );
  rect( pauseX, pauseY, pauseWidth, pauseHeight );
  rect( nextsongX, nextsongY, nextsongWidth, nextsongHeight );
  rect( looponceX, looponceY, looponceWidth, looponceHeight );
  rect( loopinfiniteX, loopinfiniteY, loopinfiniteWidth, loopinfiniteHeight );
  rect( menuX, menuY, menuWidth, menuHeight );
}  End setup

  // rect(X, Y, Width, Height);
} //End setup
//
void draw() {
} //End draw
//
void mousePressed() {
} //End mousePressed
//
void keyPressed() {
} //End keyPressed
//
// End Main Program
