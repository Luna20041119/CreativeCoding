final static int FPS = 2, TIMER = 5 * FPS;
String path;
int totalFrames = 300;  // Set the total number of frames you want to save
int currentFrame = 0;
PImage img;
SnakeBrush snBrush;
int iters = 5;

void setup() {
  size(550, 820);
  img = loadImage("MonaLisa.jpg");
  background(30);
  frameRate(FPS);
  snBrush = new SnakeBrush(random(width), random(height), 20);
  path = dataPath("output/MonaLisa.jpg");
}

void draw() {
  if (mousePressed) {
    snBrush.setPos(mouseX, mouseY).updateSegmentsPos().draw();
  } else {
    for (int i = iters; i > 0; --i) {
      snBrush.addToPos(random(-snBrush.step, snBrush.step), random(-snBrush.step, snBrush.step)).updateSegmentsPos().draw();
    }
  }

  if (frameCount % TIMER == 0) {
    saveFrame(path + "/frame-######.png");
    currentFrame++;

    if (currentFrame >= totalFrames) {
      noLoop();  // Stop the sketch after saving the desired number of frames
    }
  }
}

class SnakeBrush {
  float xPos, yPos;
  float wdth, hght;
  float scale = 1;
  float step = 55;
  int segments;
  PVector[] posArr;
  float segmentDist = 8;  
  float strokeWgt = 1.5;

  SnakeBrush(float x, float y, int segmentsCount) {
    xPos = x;
    yPos = y;
    wdth = 25;
    hght = 10;
    scale = 1;
    step = 55;
    segments = segmentsCount;
    posArr = new PVector[segments];

    for (int i = 0; i < segments; i++) {
      posArr[i] = new PVector(i * segmentDist, img.height / 2);
    }
  }

  SnakeBrush setPos(float x, float y) {
    xPos = constrain(x, 1, img.width - 5);
    yPos = constrain(y, 1, img.height - 5);
    return this;
  }

  SnakeBrush addToPos(float x, float y) {
    setPos(xPos + x, yPos + y);
    return this;
  }

  SnakeBrush updateSegmentsPos() {
    posArr[0] = new PVector(xPos, yPos);
    for (int itr = 1; itr < segments; ++itr) {
      if (posArr[itr - 1].dist(posArr[itr]) > segmentDist) {
        PVector tmpVector = posArr[itr - 1].copy().sub(posArr[itr]).normalize().mult(segmentDist);
        posArr[itr] = posArr[itr - 1].copy().sub(tmpVector);
      }
    }
    return this;
  }

  void draw() {
    for (int i = segments - 1; i > -1; --i) {
      push();
      float brightnessValue = getImgBrightness(img, posArr[i].x, posArr[i].y);
      fill(brightnessValue, brightnessValue, brightnessValue, 40);
      translate(posArr[i].x, posArr[i].y);
      if (i > 0) {
        rotate(atan2(posArr[i].y - posArr[i - 1].y, posArr[i].x - posArr[i - 1].x) + HALF_PI);
        stroke(brightnessValue, brightnessValue, brightnessValue, 230);
        strokeWeight(strokeWgt);
        rect(-wdth / 2, 0, wdth, hght);
      }
      pop();
    }
  }
}

float getImgBrightness(PImage img, float x, float y) {
  if (img.pixels == null) {
    img.loadPixels();
  }

  int targetIdx = int(y) * img.width + int(x);

  if (x < 0 || y < 0 || x >= img.width || y >= img.height) {
    return 0.0;
  }

  color pixelColor = img.pixels[targetIdx];
  float brightnessValue = brightness(pixelColor);

  return brightnessValue;
}
