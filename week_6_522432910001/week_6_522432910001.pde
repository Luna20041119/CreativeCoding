ArrayList<Particle> particles = new ArrayList<Particle>();
PImage backgroundImage;

void setup() {
  size(800, 600);
  particles.add(new Firework(width/2, height, color(random(255), random(255), random(255))));
  backgroundImage = loadImage("shanghai.jpg");
}

void draw() {
  image(backgroundImage, 0, 0, width, height);
  
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle particle = particles.get(i);
    particle.update();
    particle.display();
    
    if (particle.isFinished()) {
      particles.remove(i);
    }
  }
  
  if (frameCount % 60 == 0) {
    particles.add(new Firework(random(width), height, color(random(255), random(255), random(255))));
  }
}

interface Particle {
  void update();
  void display();
  boolean isFinished();
}

class Firework implements Particle {
  PVector position;
  PVector velocity;
  color fireworkColor;
  boolean exploded = false;
  
  Firework(float x, float y, color c) {
    position = new PVector(x, y);
    velocity = new PVector(0, -15);
    fireworkColor = c;
  }
  
  void update() {
    if (!exploded) {
      position.add(velocity);
      
      if (position.y <= height * 0.5) {
        explode();
      }
    }
  }
  
  void explode() {
    exploded = true;
    for (int i = 0; i < 100; i++) {
      particles.add(new Sparkle(position.x, position.y, fireworkColor));
    }
  }
  
  void display() {
    if (!exploded) {
      noStroke();
      fill(fireworkColor);
      ellipse(position.x, position.y, 10, 10); // Adjust the size (e.g., 10, 10) to increase the size
    }
  }
  
  boolean isFinished() {
    return exploded && particles.size() == 0;
  }
}

class Sparkle implements Particle {
  PVector position;
  PVector velocity;
  color sparkleColor;
  int lifespan = 255;
  
  Sparkle(float x, float y, color c) {
    position = new PVector(x, y);
    velocity = PVector.random2D().mult(random(1, 5));
    sparkleColor = c;
  }
  
  void update() {
    position.add(velocity);
    lifespan -= 2;
  }
  
  void display() {
    noStroke();
    fill(sparkleColor, lifespan);
    ellipse(position.x, position.y, 5, 5); // Adjust the size (e.g., 5, 5) to increase the size
  }
  
  boolean isFinished() {
    return lifespan <= 0;
  }
}
