/*####################################################
**
**  All Rights Reserved 2012
**  Created by ' Dany' 
**  Released under MIT License.
**  Visit http://dany.pro for more information
**
**
**  Made for RDGP - Processing Workshop
**
**
**####################################################*/
// Import the pdf library so processing can make a nice . pdf file for you.
import processing.pdf.*;


PFont bigFont;// creates the font for processing to use.
PFont anotherFont;
PFont presentFont;

int fontSize = 200;

float xPos = 5;// starting X position
float yPos = fontSize + 100;// Starting Y value. should be Proportional to the size of text


String evHost = " R.D.P.G. Presents ";
String sentence = "Processing Workshop";
String evTitle = "Processing Workshop";
String evTag = "Learn Creative Coding";
String evLocal = "FS2-106G  May03 5-9PM";
String evInfo = "Processing Workshop";

PImage qrCode;

int curChar = 0;
int extChar = 0;
int lpCounter = 0; //loop counter

float pColor = 0; // dominate color of poster

int vAdjust = 0; // sets the overall vertical position of the signage text

int adjust = 20;

void setup()
{
  //set up the external files for processing to work with
  qrCode = loadImage("qr.png");
  bigFont = createFont("Helvetica-Bold", fontSize);
  //create the size and type of file
  size(792,1224,PDF,"Workshop - Poster.pdf");
  
  pColor = random(1274);// pick your color
  colorMode(HSB, pColor, 100, 100);
  noStroke();
  smooth();
  background(100,0,100);
  

  fill(pColor, random(40, 100), random(40, 100)); 
  presentFont = createFont("MonoSpace", (fontSize/10));
  textFont(presentFont);
  text(evHost, (width/2)-(textWidth(evHost)/2)-20, 20, textWidth(evHost)+10, 290); 
  textFont(bigFont);
  while(yPos < height)
  {
   fill(pColor, random(20,100),random(0,360)); 
   text(sentence.charAt(curChar), xPos, yPos);
   stroke(0);
   noStroke();
   ellipse(xPos,yPos,10,10);
   stroke(pColor, random(40, 100), random(40, 100),20); 
   line(xPos,yPos,( (width-93)-adjust)+5, ((height-93)-adjust*2)+5);
    noStroke();
   fill(pColor, random(20,100),random(0,360)); 
 
   xPos += textWidth(sentence.charAt(curChar));
   
   if(random(6) > 5 || xPos > (width - adjust) )
   {
    xPos = 5;
    yPos += textAscent(); 
   }
   curChar++;
   if(curChar == 10)
   {
     break;
   }
    
  }
  signAge();
  exit();
  
}

void signAge()
{
  anotherFont = createFont("OCRAStd", 25);
  textFont(anotherFont); 
  text(evTitle,(width/2) - (textWidth(evTitle)),(height- 300),textWidth(evTitle), 120);
  noStroke();
  rect((width/2) - (textWidth(evTitle)),(height- 300)+30,textWidth(evTitle), 25);
  anotherFont = createFont("OCRAStd", 22.48);
  textFont(anotherFont); 
  text(evLocal,(width/2) - (textWidth(evLocal))-4,(height- 300)+60,textWidth(evLocal)+23, 123);
  anotherFont = createFont("OCRAStd", 20);
  textFont(anotherFont); 
  fill(100,0,100);
  text(evTag,(width/2) - (textWidth(evTag))-18,(height- 300)+33,textWidth(evTag)+20, 120);
  
  image(qrCode, (width-93)-adjust, (height-93)-adjust*2,(qrCode.width/2)/2,(qrCode.height/2)/2);
 
}
