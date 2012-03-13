/*####################################################
**
**  All Rights Reserved 2012
**  Created by ' Dany' 
**  Released under MIT License.
**  Visit http://dany.pro for more information
**
**####################################################*/
import processing.pdf.*;

float xPos = 0;
float yPos = 915;// is proportional to the size of text minus adjust
PFont myFont;
PFont anotherFont;
PFont infoFont;
int fontSize = 1500;//1850 vs 1500
String sentence = "Processing Workshop";
String evTitle = "Processing Workshop";
String evTag = "Come Learn About Creative Coding";
String evLocal = "FS2 Room999c, Mar 99"; // add the room number and date
String evInfo = "Please visit processing.org and download the software before attending the workshop.";
PImage qrCode;

int curChar = 0;
int extChar = 0;
int lpCounter = 0;

float pColor = 0;//primary/dominate color of poster 

int vAdjust = 0; //sets the overall vertical position of the signage text

int adjust = 80;

void setup()
{
  size(6180, 8000,PDF, "Workshop - Poster for Processing.pdf");
  pColor = 274;
  colorMode(HSB, 360, 100, 100);
  noStroke();
  background(257, 0, 100);
  smooth();
  qrCode = loadImage("qr.png");
  myFont = createFont("Helvetica-Bold", fontSize);
  textFont(myFont);
  while (yPos < height - ( (fontSize*2)-adjust)-200)
  {
    
    //fontSize = int(random(100, 300));
    //println(xPos);
    fill(pColor, random(20, 100), random(0, 100)); 
    text(sentence.charAt(curChar), xPos, yPos+(adjust*5) + fontSize - textDescent());
 
    stroke(0);//-adjust
    line( (width-qrCode.width)-adjust, (height-qrCode.height)-adjust*2,xPos+(textWidth(sentence.charAt(curChar))),yPos+(adjust*5) + fontSize - textDescent());
    fill(pColor, random(20, 100), random(0, 100)); 
    ellipse(xPos+(textWidth(sentence.charAt(curChar))),yPos+(adjust*5) + fontSize - textDescent(),50,50);

    xPos += textWidth(sentence.charAt(curChar));

    if (random(0, 10) > 9 || xPos > width - (fontSize/2))
    {
      xPos = 0;
      yPos += textAscent();
    }

    curChar++;
    //(curChar == (sentence.length()))
    if (curChar == 10)
    {
      println("bouncing out!");
      break;
    }

/*  This line was upgraded to the code up above.
    if (curChar >= sentence.length())
    {

      curChar = 0;
    }
*/

    println(curChar);
    extChar = curChar;
    lpCounter++;
  }

  signAge();
 // saveFrame("poster_" + year() + "_" + month()+ "_" + day() + "_" + minute() + "_" + second() + ".pdf");
  exit();
}

void signAge()
{
  switch(lpCounter) {
  case 12:
    if (extChar >=11) {
      vAdjust = (((height/2)+880)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 13:
    if (extChar<=3) {
      vAdjust = (((height/2)+800)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 18:
    if (extChar==18) {
      vAdjust = (((height/2)+840)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 19:
    if (extChar==0) {
      vAdjust = (((height/2)+840)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 20:
    if (extChar<=1) {
      vAdjust = (((height/2)+880)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 21:
    if (extChar<=2) {
      vAdjust = (((height/2)+880)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  case 22:
    if (extChar<=3) {
      vAdjust = (((height/2)+880)+(fontSize));
    }
    else {
      vAdjust = (((height/2)+700)+(fontSize));
    }
    break;
  default:
    vAdjust = (((height/2)+700)+(fontSize));
    break;
  }


  fill(0);
  println("current vertical: " + vAdjust);
  println("fixed vertical: " + (((height/2)+800)+(fontSize)));
  println("current width: " + width);
  println("current lenght of the sentence is: " + sentence.length());
  println("total loops: " + lpCounter);
  println("Last known character: " + extChar);
  println("Text Size LG: " + fontSize);
  println("Text Size SM: " + ((fontSize/16)-5));
  println("wtf math is this? : " + textWidth(evInfo));
  println("The color choosen is : " + pColor);
  anotherFont = createFont("OCRAStd", (fontSize/8)+10);
  fill(pColor, 54, 88);
  textFont(anotherFont); 
  text(evTitle, (width/2)-(adjust*6), (vAdjust)- adjust+15, ((width/2)-(adjust*2)), 280);
  stroke(pColor, 54, 88);
  strokeWeight(150);
  strokeCap(SQUARE);
  fill(#ffffff);
  textFont(anotherFont, (fontSize/13)+1); 
  line((width/2)-(adjust*6)+10,(vAdjust)+(adjust*2)+50,((width/2)-(adjust*6)+10)+(textWidth(evTag)),(vAdjust)+(adjust*2)+50);
  text(evTag, (width/2)-(adjust*6)+10, (vAdjust)+(adjust*2), ((width/2)-(adjust*4)), 280);
  fill(pColor, 54, 88);
  textFont(anotherFont, (fontSize/9)+10); 
  text(evLocal, (width/2)-(adjust*6)+10, (vAdjust)+(adjust*4), ((width/2)-(adjust*4)), 280);
  fill(0);
  infoFont = createFont("MonoSpace", (fontSize/16)-5);
  textFont(infoFont); 
  text(evInfo, (width)-(textWidth(evInfo))-adjust, height-(adjust*2)-5, textWidth(evInfo)+adjust, 280); //((width/2)-(adjust*4))

  image(qrCode, (width-qrCode.width)-adjust, (height-qrCode.height)-adjust*2);
}

