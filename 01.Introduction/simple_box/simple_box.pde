

void setup()
{
 size(600,300); 
 background(0);
}

void draw()
{
}

void keyPressed()
{
 int x = int(random(0,600));
 int y = int(random(0,300));
fill(255);
rect(x,y,10,10); 
  
}
void mouseDragged()
{
  fill(255);
 rect(mouseX,mouseY,10,10); 
}
