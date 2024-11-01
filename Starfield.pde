Particle[] lan;
int myTheme;
double mySize;
boolean night = false;
PImage tree, moon;
float offset = 0;
float easing = 0.05;
int[] starColors = {
        color(255, 255, 255), color(240, 240, 240), color(230, 230, 230),
        color(220, 220, 220), color(210, 210, 210), color(200, 200, 200),
        color(250, 250, 245), color(245, 245, 250), color(255, 250, 245),
        color(245, 248, 255)
      };

void setup() {
  size(800, 800);
  background(0);
  tree = loadImage("https://img.freepik.com/premium-photo/starry-night-sky-background-illustration_954894-65493.jpg");
  moon = loadImage("https://static.vecteezy.com/system/resources/previews/045/354/775/non_2x/lunar-radiance-clear-background-moon-free-png.png");
  /*PImage original = loadImage("https://img.freepik.com/premium-photo/starry-night-sky-background-illustration_954894-65493.jpg");
  
  // Create a new image with an alpha channel
  tree = createImage(original.width, original.height, ARGB);
  tree.copy(original, 0, 0, original.width, original.height, 0, 0, original.width, original.height);
  
  // Modify each pixel's alpha value to make the image semi-transparent
  tree.loadPixels();
  for (int i = 0; i < tree.pixels.length; i++) {
    color pixelColor = tree.pixels[i];
    int r = (pixelColor >> 16) & 0xFF;
    int g = (pixelColor >> 8) & 0xFF;
    int b = pixelColor & 0xFF;
    
    // Set the new color with semi-transparency (alpha = 128)
    tree.pixels[i] = color(r, g, b, 128);
  }
  tree.updatePixels(); */
  lan = new Particle[50];
    int pos1 = (int)(Math.random() * width);
    int pos2 = (int)(Math.random() * height);
  for (int i = 0; i < lan.length; i++) {
    lan[i] = new Particle(pos1, pos2);
    lan[0] = new OddballParticle(pos1, pos2);
  }
}

void draw() {
  if (!night) {
    fill(0, 20);
    rect(0, 0, width, height);
  } else {
    image(tree, 0, 0, width, height);
    //tint(255, 127);
  }
  for (int i = 0; i < lan.length; i++) {
    lan[i].show();
    lan[i].move();
  }
}

class Particle {
  double myX, myY, myAngle, mySpeed;
  color myColor;
  float mySize;
  
  Particle(double x, double y) {
    myX = x;
    myY = y;
    myAngle = Math.random() * 2 * Math.PI;
    mySpeed = Math.random() * 4 + 1;

    if (!night) {
      mySize = (float)(Math.random() * 15) + 10;
      myColor = color((int)(Math.random() * 105) + 150, (int)(Math.random() * 105) + 150, (int)(Math.random() * 105) + 150);
    } else {
      myColor = starColors[(int)(Math.random() * starColors.length)];
      mySize = (float)(Math.random() * 10) + 1;
      myAngle = Math.random() * -1 * Math.PI/8 - 3 * PI/2;
    }
  }
    
  void show() {
    fill(myColor);
    noStroke();
    ellipse((float)myX, (float)myY, mySize, mySize);
    if (Math.random() < 0.5) {
      mySize += 0.05;
    } else {
      mySize -= 0.05;
    }
    mySize = constrain(mySize, 2, 50);
  }
    
  void move() {
    myX += Math.sin(myAngle) * mySpeed;
    myY += Math.cos(myAngle) * mySpeed;
    if (myX > width) myX = 0;
    if (myX < 0) myX = width;
    if (myY > height) myY = 0;
    if (myY < 0) myY = height;
    
    if (night && myY > 500 || night && myX > 800) {
      myX = (int)(Math.random() * 100) - 100;
      myY = (int)(Math.random() * 50);
    }
  }
}

void keyPressed() {
  night = false;
  background(0);
  lan = new Particle[50];
    int pos1 = (int)(Math.random() * width);
    int pos2 = (int)(Math.random() * height);
  for (int i = 0; i < lan.length; i++) {
    lan[i] = new Particle(pos1, pos2);
    lan[0] = new OddballParticle(pos1, pos2);
  }
}

void mousePressed() {
  if (!night) {
    night = true;
    lan = new Particle[50];
    for (int i = 0; i < lan.length; i++) {
      lan[i] = new Particle((int)(Math.random() * width), (int)(Math.random() * height));
      lan[0] = new OddballParticle(-10, 50);
    }
  }
}

class OddballParticle extends Particle {
  int cx = 500;//x coord of moon
  int cy = 100;//y coord of moon
  int a = 450; // major axis of ellipse
  int b = 250; // minor axis of ellipse
  float t = millis()/10000.0f; //increase to slow down the movement
  OddballParticle(int x, int y) {
    super(x, y);
    myColor = color((int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255));
  }
  void show() {
    fill(myColor);
    if(night == false)
      rect((float)myX, (float)myY, mySize, mySize);
    if(night == true){
      //fill(255,0,0);
      //ellipse(cx, cy, 50, 50);
      image(moon, cx, cy, width/15, height/15);
    }
  }
  void move(){
    if(night == false){
      myAngle = Math.random() * 2 * Math.PI;
      myX += Math.sin(myAngle) * mySpeed;
      myY += Math.cos(myAngle) * mySpeed;
      myColor = color((int)(Math.random() * 105) + 150, (int)(Math.random() * 105) + 150, (int)(Math.random() * 105) + 150);
      fill(myColor);
      if (myX > width) myX = 0;
      if (myX < 0) myX = width;
      if (myY > height) myY = 0;
      if (myY < 0) myY = height;
    }
    if(night == true){
      for (int i = 1 ; i <= 12; i++) {
        t = t + 100;
        cx = (int)(cx + a * cos(t));
        cy = (int)(cy + b * sin(t));
      }
    }
  }
}
