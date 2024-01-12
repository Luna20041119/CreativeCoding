import controlP5.*;

PImage backgroundImage; // 用于存储背景图片
PFont microsoftYaHei;
int dia = 10; // 修改为整数类型
ControlP5 cp;

ArrayList<Pearl> pearls = new ArrayList<>();
int merit = 0; // 使用中文“功德”代替分数

void setup() {
  size(400, 400);

  backgroundImage = loadImage("muyu.png");

  microsoftYaHei = createFont("微软雅黑", 20);
  UI();
}

void draw() {
  // Save each frame as an image
  saveFrame("output/frame-######.png"); 
  image(backgroundImage, 0, 0, width, height);

  // 绘制和更新每个珠珠
  for (int i = pearls.size() - 1; i >= 0; i--) {
    Pearl pearl = pearls.get(i);
    pearl.update();
    pearl.display();
    if (pearl.isFinished()) {
      pearls.remove(i);
    }
  }

  // 显示功德
  fill(0);
  textSize(20);
  textFont(microsoftYaHei);
  text("功德: " + merit, 20, 70);
}

void mousePressed() {
  // 定义允许生成珠珠的中心区域
  float centerX = width / 2;
  float centerY = height / 2;
  float allowedRadius = 100; // 半径为100的区域

  // 计算鼠标位置到中心的距离
  float distanceToCenter = dist(mouseX, mouseY, centerX, centerY);

  // 检查鼠标位置是否在允许的区域内
  if (distanceToCenter <= allowedRadius) {
    // 生成随机数量和位置的珠珠
    int numPearls = (int) random(1, 6); // 生成5到15个珠珠
    merit += numPearls; // 增加功德值
    for (int i = 0; i < numPearls; i++) {
      float startX = mouseX + random(-20, 20);
      float startY = mouseY + random(-20, 20);
      int pearlSize = (int) cp.getController("dia").getValue(); // 获取控制珠珠大小的整数值
      float pearlMass = map(pearlSize, 10, 50, 1, 5); // 映射大小到质量范围
      pearls.add(new Pearl(startX, startY, color(255, 0, 0), pearlSize, pearlMass)); // 传入珠珠大小和质量
    }
  }
}

class Pearl {
  float x, y;
  float speedX, speedY;
  float gravity = 0.1;
  float size; // 珠珠大小
  float mass; // 珠珠质量
  int lifespan = 255;
  color pearlColor;

  Pearl(float x, float y, color pearlColor, float size, float mass) {
    this.x = x;
    this.y = y;
    this.speedX = random(-2, 2);
    this.speedY = random(-5, -1);
    this.pearlColor = pearlColor;
    this.size = size;
    this.mass = mass;
  }

  void update() {
    x += speedX;
    y += speedY;
    speedY += gravity * mass; // 加入质量的影响
    lifespan -= 2;
  }

  void display() {
    stroke(0);
    strokeWeight(4);
    pearlColor = color(157, 116, 90);

    fill(pearlColor);
    ellipse(x, y, size, size);

    // 添加高光
    noStroke();
    float shineSize = size / 5; // 调整高光大小
    fill(255, 255, 255, 150); // 设置高光颜色和透明度
    ellipse(x + size / 4, y - size / 4, shineSize, shineSize);
  }

  boolean isFinished() {
    return lifespan < 0 || y > height; // 珠珠飘到屏幕底部也算结束
  }
}

void UI(){
  cp = new ControlP5(this, createFont("微软雅黑", 16));
  cp.addSlider("dia")
     .setPosition(20, 20)
     .setSize(200, 20)
     .setRange(20, 50) 
     .setDecimalPrecision(0) 
     .setValue(20) 
     .setLabel("功德珠大小");
}
