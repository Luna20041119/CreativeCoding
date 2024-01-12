import controlP5.*;

int angle = 30; // 花瓣的角度
float radius = 20; // 控制花的初始大小
int clickRadius = 80; // 鼠标点击的有效范围

ArrayList<Flower> flowers = new ArrayList<>();
ControlP5 cp;

void setup() {
  size(400, 400); // 将画布大小缩小至400x400
  background(157, 227, 229); // 设置背景色为湖水蓝绿
  stroke(#FFD35A); // 设置线条颜色为紫色
  UI(); // 初始化用户界面
}

void draw() {
  background(157, 227, 229); // 湖水蓝绿色背景
  for (Flower flower : flowers) {
    drawFlower(flower);
  }
}

void mousePressed() {
  // 检查鼠标点击位置是否在指定区域外
  if (!(mouseX < 300 && mouseY < 70)) {
    radius = cp.getController("radius").getValue(); // 获取 ControlP5 中的半径值
    float weight = cp.getController("strokeWeight").getValue(); // 获取 ControlP5 中的线条粗细值
    Flower newFlower = generateRndFlower(mouseX, mouseY, radius, weight); // 传递鼠标位置、半径和线条粗细
    flowers.add(newFlower);
  }
}

void keyPressed() {
  if (key == ' ') {
    flowers.clear(); // 清除所有花朵
    saveFrame("output.png"); // 保存当前帧为PNG图像
  }
}

Flower generateRndFlower(float x, float y, float radius, float weight) {
  color clr = color(random(255), random(255), random(255));
  return new Flower(x, y, clr, radius, weight);
}

void drawFlower(Flower flower) {
  strokeWeight(flower.weight); // 设置线条粗细
  for (int i = 0; i < 12; i++) {
    float x1 = sin(radians(i * angle)) * flower.radius;
    float y1 = cos(radians(i * angle)) * flower.radius;
    float x2 = sin(radians((i + 1) * angle)) * flower.radius;
    float y2 = cos(radians((i + 1) * angle)) * flower.radius;

    bezier(flower.x + x1, flower.y + y1, flower.x + x1 + x2 / 2, flower.y + y1 + y2 / 2,
      flower.x + x2 / 2 + x1, flower.y + y2 / 2 + y1, flower.x + x2, flower.y + y2);

    bezier(flower.x + x1, flower.y + y1, flower.x + x1 - x2 / 2, flower.y + y1 - y2 / 2,
      flower.x + x2 / 2 - x1, flower.y + y2 / 2 - y1, flower.x + x2, flower.y + y2);
  }
}

class Flower {
  float x, y;
  color clr;
  float radius;
  float weight;

  Flower(float x, float y, color clr, float radius, float weight) {
    this.x = x;
    this.y = y;
    this.clr = clr;
    this.radius = radius;
    this.weight = weight;
  }
}

void UI() {
  cp = new ControlP5(this, createFont("微软雅黑", 16));
  
  cp.addSlider("radius")
    .setPosition(10, 10)
    .setSize(200,20)
    .setRange(20, 50) 
    .setDecimalPrecision(0)
    .setValue(radius)
    .setLabel("莲花大小");
  
  cp.addSlider("strokeWeight")
    .setPosition(10, 40)
    .setSize(200, 20)
    .setRange(1, 5)  // 设置strokeWeight的范围
    .setValue(1)     // 设置初始值
    .setLabel("线条粗细");
}
