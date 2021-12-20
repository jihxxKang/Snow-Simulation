ArrayList<Snowflake> snow;
PVector gravity;

float zOff = 0;

PImage sprite;


void setup() {
  frameRate(30);
  fullScreen();
  sprite = loadImage("skyflakeyy.png");
  
  snow = new ArrayList<Snowflake>();
  
  gravity = new PVector(0, 0.3);

  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    snow.add(new Snowflake(x, y, sprite));
  }
}




void draw() {
  background(0);

  zOff += 0.01;

  for (int i = 0; i < snow.size(); i++) {
    Snowflake flake = snow.get(i);
    
    float xOff = flake.pos.x / width;
    float yOff = flake.pos.y / height;
    float wAngle = noise(xOff, yOff, zOff) * TWO_PI;
    PVector wind = PVector.fromAngle(wAngle);
    
    
    
    wind.mult(0.2);//size of wind is 0.1

    flake.applyForce(gravity);
    flake.applyForce(wind);
    flake.update();
    flake.render();
  }
}
