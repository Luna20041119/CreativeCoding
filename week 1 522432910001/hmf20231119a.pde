float circleCount = 20;
float tileWidth;
float tileHeight;
float endSize = 100;
float endOffset = 200;

int tileCountX = 5;
int tileCountY = 5;

void setup(){
  size(800, 800);
  
  noFill();
  stroke(255, 204, 0);
  strokeWeight(5);
  
  tileWidth = width/tileCountX;
  tileHeight = height/tileCountY;
}

void draw(){
  background(#0000CC);
  
  randomSeed(0);
  
  endSize = map(mouseX, 0, max(width, mouseX), tileWidth/2, 0);
  endOffset = map(mouseY, 0, max(height, mouseY), (tileWidth - endSize)/2, 0);
  circleCount = mouseX/40+1;
  
  for(int gridX = 0; gridX <= tileCountX; gridX++) { 
    for(int gridY = 0; gridY <= tileCountY; gridY++) { 
  
      push();
      translate(tileWidth*gridX, tileHeight*gridY);
      
      int angle = int(random(0,3));
      if(angle == 0)rotate(-HALF_PI);
      if(angle == 1)rotate(0);
      if(angle == 2)rotate(HALF_PI);
      
      for(int i = 0; i < circleCount; i++){
        float diameter = map(i, 0, circleCount, tileWidth, endSize);
        float offset = map(i, 0, circleCount, 0, endOffset);
        ellipse(offset, 0, diameter, diameter);
      }
      pop();
    }
  }
  saveFrame();
}
