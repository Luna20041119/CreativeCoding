import peasy.*;

int segmentCount = 12;  // Number of segments in the sphere
float sphereRadius = 100;
float sphereHeight = 100;  // Initial height of the sphere
float sphereWidth = 100;   // Initial width of the sphere
color sphereColor;

PeasyCam cam;

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 200);
  randomizeColor();
}

void draw() {
  background(0);
  drawSphere(sphereRadius, sphereHeight, sphereWidth, segmentCount);
}

void keyPressed() {
  if (key == 'a') {
    segmentCount++;
    saveFrame("output-######.png");
  } else if (key == 'z') {
    if (segmentCount > 3) {
      segmentCount--;
      saveFrame("output-######.png");
    }
  } else if (key == 'r') {
    randomizeColor();
    saveFrame("output-######.png");
  } else if (key == 'h') {
    sphereHeight += 20;  // Increase height
    saveFrame("output-######.png");
  } else if (key == 'l' && sphereHeight > 20) {
    sphereHeight -= 20;  // Decrease height, with a minimum height of 20
    saveFrame("output-######.png");
  } else if (key == 'w') {
    sphereWidth += 20;   // Increase width
    saveFrame("output-######.png");
  } else if (key == 'n' && sphereWidth > 20) {
    sphereWidth -= 20;   // Decrease width, with a minimum width of 20
    saveFrame("output-######.png");
  } else if (key == 's') {
    saveFrame("output-######.png");
  }
}

void drawSphere(float radius, float height, float width, int segments) {
  fill(sphereColor);
  float angleIncrement = TWO_PI / segments;

  for (float angle1 = 0; angle1 < PI; angle1 += angleIncrement) {
    beginShape(QUAD_STRIP);
    for (float angle2 = 0; angle2 < TWO_PI + angleIncrement; angle2 += angleIncrement) {
      float x1 = radius * sin(angle1) * cos(angle2);
      float y1 = radius * sin(angle1) * sin(angle2);
      float z1 = height * cos(angle1);

      float x2 = (radius + width) * sin(angle1) * cos(angle2);
      float y2 = (radius + width) * sin(angle1) * sin(angle2);
      float z2 = (height + width) * cos(angle1);

      vertex(x1, y1, z1);
      vertex(x2, y2, z2);
    }
    endShape();
  }
}

void randomizeColor() {
  sphereColor = color(random(255), random(255), random(255));
}
