import processing.video.*;
Capture video; //begins the camera
PShape tankU; // creates the svg tank file
PFont font;
/* video recording has been disabled due to low testing conditions
MovieMaker mmCode;
MovieMaker mmArt;
float imgPick;
int mi = millis();
int d;
*/
int h;

int minsArt;
int minsFin;


String mfName1;
String mfName2;
String mfNameCheck;
boolean capIt;

int numPixels; 
int[] previousFrame;
int[][] diffPoints;
int diffAmount = 0;

int colorSpec1; 
int colorSpec2;

//create number holders for r,g,b values
int currR;
int currG;
int currB;
  
int prevR;
int prevG;
int prevB;

int diffR;
int diffG;
int diffB;

int particleMin = 10;
int particleAlpha = 160;//will show the alpha of each particle

//random number holders
float b; 

//
color diff;
color currColor;
color prevColor;


void setup() 
{
  size(1920, 1200);//deployment size
  frameRate(60);
  noStroke();
  smooth();
  video = new Capture(this, width, height, 60);
  numPixels = width * height;
  previousFrame = new int[numPixels];
  diffPoints = new int[height][width];  
  font = loadFont("SuperhelioExtendedultra-48.vlw");
  noCursor();
  //unleashCamera();
}
/*
void unleashCamera(){
  
  d = day();
  h = hour();

  background(255);
  mfName1 = "sky" + "_"+ d +  h + mi + "_a" + ".mov"; //name the movie file
  mfName2 ="sky" + "_" + d +  h + mi + "_b" + ".mov";
  mmCode = new MovieMaker( this, width, height, mfName1,60);
  mmArt = new MovieMaker( this, width, height, mfName2,60);
  
 
                           
}
*/
void createEnv(){
float imgPick = floor(random(6));
  //establish the hour of day
  if (h < 5) { //early night
       colorSpec2 = 0;
    }else if(h > 16) { //late night
       colorSpec2 = 0;
   }else{ //  day time
        colorSpec2 = 255;
  }

//draw the images
  if(imgPick==0){
    tankU = loadShape("shape_01.svg");
  }else if(imgPick==1){
    tankU = loadShape("shape_02.svg");
  }else if(imgPick==2){
    tankU = loadShape("shape_03.svg");
  }else if(imgPick==3){
    tankU = loadShape("shape_04.svg");
  }else {
    tankU = loadShape("shape_05.svg");
  }

}

void captureEvent(Capture video) {
  video.read();
 /* if (capIt){
     mmCode.addFrame(video.pixels,720,450);
     mmArt.addFrame();
  }else{
    return;
  }
  */
}

void draw() 
{ 
  createEnv();//call create environment (runs constantly)

  float colorSpec = random(245,255);
  fill(0,0,colorSpec,2);
  rect(0, 0, width, height); 
  
  diffAmount = 0;
  for (int i = 0; i < numPixels; i++) 
  {
    diffPoints[abs(i / width)][i % width] = 0;
    currColor = video.pixels[i];
    prevColor = previousFrame[i];
    // Extract the red, green, and blue components from current pixel
    currR = (currColor >> 16) & 0xFF; // Like red(), but faster
    currG = (currColor >> 8) & 0xFF;
    currB = currColor & 0xFF;
    // Extract red, green, and blue components from previous pixel
    prevR = (prevColor >> 16) & 0xFF;
    prevG = (prevColor >> 8) & 0xFF;
    prevB = prevColor & 0xFF;
    // Compute the difference of the red, green, and blue values
    diffR = abs(currR - prevR);
    diffG = abs(currG - prevG);
    diffB = abs(currB - prevB);    
    // Render the difference image to the screen
    diff = color(diffR, diffG, diffB);
    
    int isPointDiff = 0;
    if (diff > -15666000)      //-16777216 
    {
      isPointDiff = 1;
      ++diffAmount;
    }
    diffPoints[abs(i / width)][i % width] = isPointDiff;
  }  
  
  checkForNewPoint(diffAmount);
  
  //tagIt();
    
  arraycopy(video.pixels, previousFrame);  
  fill(colorSpec2,colorSpec2,colorSpec2,5);
  rect(0, 0, width, height); 

}

void checkForNewPoint(int diffAmount)
{  
   if (diffAmount < 42){ //if no change the bounce out     
     return; //40
  }
  if(diffAmount > 50000) return;
  float milliseconds = millis();
  if (milliseconds < 1000) return; //1000 runs faster at 100
  int blocks = 0;
  for (int i = 0; i < height; i++) 
  {
    for (int j = 0; j < width; j++)
    {      
      if(i > 1 && j > 1 && diffPoints[i][j] == 1)
      {
        if(diffPoints[i - 1][j] == 1 && diffPoints[i - 2][j] == 1 
            || diffPoints[i][j - 1] == 1 && diffPoints[i][j - 2] == 1)
        {
          ++blocks;
          int randNum = 10;
          int randX = int((randNum / 2) - random(randNum));
          int randY = int((randNum / 2) - random(randNum)); 
          color c = previousFrame[(i * width) + j];
          float value = brightness(c);
          fill(c, particleAlpha);
          int particleSize = diffAmount / 1000; // 10; 
          if(random(particleSize) > (particleSize - (.99999999 / particleSize))) 
          {
            shapeMode(CENTER);
            shape(tankU, j, i,particleMin + particleSize, particleMin + particleSize);
            tankU.disableStyle();
          }
          b = diffAmount; //sets all info on tagIt (if color differnce is high then something will happen
        }
      }
    }
  }  
}
/*
void tagIt () {
  
  
 
 if(b > 43000.0) { //if lots of movement happens start this condional
    capIt = true;
    minsArt = minute();
 }   else if((b < 43)){
     pleaseStop ();
     return;
   }else{
     return;
   }

  //begining of word plugin.. needs a new font selection and maybe a case select added

  if(b < particleMin){
    fill(0,0,0,8);
    rect(0,0,width, height);
    fill(255,255,255,10);
    textFont(font,28);
    text(" " + "" + " " + "" + " "+ "",width/2,height/2);
    text(" " + "now isn't this fancy" + " " + "" + " "+ "",width/2,height/2 + 40);
  }else if(b < (particleMin + 3)){
    fill(255,255,255,b);
    textFont(font,28);
    text(" " + "" + "hello " + "" + " "+ "",width/2,height/2);
    text(" .:" + "some more words" + ":. " + "" + " "+ "",width/2,height/2 + 40);
    fill(colorSpec2,colorSpec2,colorSpec2,8);
    rect(0,0,width, height);
  }

    
}


void mousePressed() {
  minsFin = minute();
  if((minsArt - minsFin) < 3){ // must run for 3 minutes
  
    return;
  }
  
  if (mouseButton == LEFT) {
    fill(0,0,0,80);
  } else if (mousePressed && (mouseButton == RIGHT)) {
    fill(255,255,255,210);
  } else {
    fill(0,0,0,80);
  }
  rect(0, 0, width, height);
  
}

void keyPressed() {
  if (key == ' ') {
    pleaseStop();
  }
}

void pleaseStop(){    
  
  h = hour();
  mfNameCheck = "sky" + "_"+ d + h + mi + "_a" + ".mov";
  if(capIt){
     capIt = false;
     mmCode.finish();
     mmArt.finish();   
  }else{
    return;
  }
 
 if(mfName1.equals(mfNameCheck) == false){
   unleashCamera();
 }

}
*/
