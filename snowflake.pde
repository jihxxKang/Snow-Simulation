float getRandomSize() {
  //return (float)Math.exp(random(0,5))*0.2;
  return 1/random(0,1);
  //return constrain(r * 32, 2, 32);//too small->2
}


class Snowflake {
  PImage img;
  PVector pos, vel, acc;
  float angle, dir, xOff, r;
  
  Snowflake(float sx, float sy, PImage simg) {
    img = simg;
    pos = new PVector(sx, sy);
    vel = new PVector(0, 0);
    acc = new PVector();
    angle = random(TWO_PI);
    dir = (random(1) > 0.5) ? 1 : -1;
    xOff = 0;
    r = getRandomSize();
  }


  void applyForce(PVector force) {
    // Parallax Effect hack
    PVector f = force.copy().mult(r);
    acc.add(f);
  }

  void randomize() {
    float x = random(width);
    float y = random(-100, -10);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector();
    r = getRandomSize();
  }

  void update() {

    vel.add(acc);
    acc.mult(0);
    vel.limit(r * 0.2);
    if (vel.mag() < 1) 
      vel.normalize();

    pos.add(vel);
    

    // Out Of Screen
    if (pos.y > height + r) randomize();
    if (pos.x < -r) pos.x = width + r;
    if (pos.x > width + r) pos.x = -r;

    angle += dir * vel.mag() / 200;//angular speed is proportional to speed
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    imageMode(CENTER);
    image(img, 0, 0, r, r);
    popMatrix();
  }
}
