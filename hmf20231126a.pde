//第三周作业，以蒙特里安作品为灵感，设计看似无序，实质有序的图形
void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(255);
  drawMondrianStyle();
}

void drawMondrianStyle() {
  float minSize = 40;
  float maxSize = 120;

  for (float x = 0; x < width; x += random(minSize, maxSize)) {
    for (float y = 0; y < height; y += random(minSize, maxSize)) {
      float choice = random(1);
      if (choice < 0.25) {
        drawRectangle(x, y, random(minSize, maxSize), random(minSize, maxSize), color(255, 0, 0));
      } else if (choice < 0.5) {
        drawRectangle(x, y, random(minSize, maxSize), random(minSize, maxSize), color(0, 0, 255));
      } else if (choice < 0.75) {
        drawRectangle(x, y, random(minSize, maxSize), random(minSize, maxSize), color(255));
      } else {
        drawRectangle(x, y, random(minSize, maxSize), random(minSize, maxSize), color(0));
      }
    }
  }
}

void drawRectangle(float x, float y, float w, float h, color c) {
  fill(c);
  strokeWeight(10);
  rect(x, y, w, h);
}
