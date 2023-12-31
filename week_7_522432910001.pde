ArrayList<PVector> places = new ArrayList();
Particle current;

void setup() {
  size(800, 800);
  frameRate(120);
  background(88, 133, 255);
  current = new Particle(width/2, 0);
}

void draw() {
  for (int i = 0; i < 90; i++) {
    current.update();
    if (current.ends()) {
      current.restart();
    }
  }

  background(88, 133, 255);
  translate(width/2, height/2);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 6, 6);
  }

  rotate(PI / 3);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 5, 5);
  }

  rotate(PI / 3);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 5, 5);
  }

  rotate(PI / 3);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 5, 5);
  }

  rotate(PI / 3);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 5, 5);
  }

  rotate(PI / 3);

  for (int i = 0; i < places.size(); i++) {
    fill(255, 255, 255);
    stroke(255);
    ellipse(places.get(i).x, places.get(i).y, 5, 5);
  }

  // Save the frame after drawing
  saveFrame("output/######.png");  // Save the current frame as a PNG file
}

class Particle {
  float x, y;
  float r = 3;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    x -= 1;
    y += random(4) - 2;
  }

  boolean ends() {
    if (x < 0) {
      return true;
    } else if (checkMatch(x, y)) {
      return true;
    } else {
      return false;
    }
  }

  void restart() {
    places.add(new PVector(x, y));
    places.add(new PVector(x, -y));
    x = width/2;
    y = 0;
  }

  boolean checkMatch(float X, float Y) {
    for (int i = 0; i < places.size(); i++) {
      if (dist(places.get(i).x, places.get(i).y, X, Y) <= 4) {
        return true;
      }
    }
    return false;
  }
}
