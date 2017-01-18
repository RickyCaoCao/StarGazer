//need to remove missile once exit screen or super lag eventually

class Missile {
  //0 for friendly, 1 for enemy
  int side;
  float x, y, speed, damage;
  int size;
  PImage bullet;

  Missile(int _side, float _x, float _y, int _size, float _damage, float _speed) {
    side = _side;
    if(side == 0){
      bullet = loadImage("/Blue/bullet.png");
    }
    else if(side == 1){
      bullet = loadImage("/Red/bullet_red.png");
    }
    size = _size;
    bullet.resize(size, size);
    x = _x;
    y = _y;
    damage = _damage;
    speed = _speed;
  }
  
  void display(){
    image(bullet, x, y);
  }
  
  void move(){
    if(side == 0){
          y -= speed;
    }
    else if(side == 1){
          y += speed;
    }
  }
  
  //checks for collision with ships
  boolean collision(SpaceShip aShip){
    if(side != aShip.side){
      if((x + size/2 - 15) > (aShip.x - aShip.size/2) && (x-size/2 + 15) < (aShip.x + aShip.size/2) && (y-size/2 + 15) < (aShip.y + aShip.size/2) && (y + size/2 - 15) > (aShip.y - aShip.size/2)){
        return true;
      }
    }
      return false;
  }
}

class Bomb {
    float x, y, damage, detonationTimer;
    int size;
    float triggerDiameter;
    String state;
    
    PImage [] bombs = new PImage[3];
    int imgNum;
    
    float switchImageTimer = 0;
    

    Bomb(float _x, float _y, float _damage, int _triggerDiameter) {
      x = _x;
      y = _y;
      damage = _damage;
      size = 50;
      triggerDiameter = _triggerDiameter;

      imgNum = 2;
      for (int i = 0; i < bombs.length; i++) {
        bombs[i] = loadImage("/Blue/Spacebombs/" + (i+1) + ".png");
        bombs[i].resize(size, size);
      }
      state = "Online";
    }
    
    void operation(){
      display();
      if(state == "Detonating"){
        if(millis() - detonationTimer >= 1000){
          state = "Explosion";
        }
      }
    }

    void display() {
      if (millis() - switchImageTimer >= 200) {
        if (imgNum < 2) {
          imgNum++;
        } else {
          imgNum = 0;
        }
        switchImageTimer = millis();
      }
      if(state != "Explosion"){
        //will change color if the bomb has been triggered
        if(state == "Online"){
          stroke(60, 160, 200);
          fill(80, 185, 255, 100);
        }
        else if(state == "Detonating"){
          stroke(200, 10, 10);
          fill(255, 40, 25, 100);
        }
        strokeWeight(5);
        ellipse(x, y, triggerDiameter, triggerDiameter);
        image(bombs[imgNum], x, y);
      }
    }

    //checks for ships and the bomb will be triggered
    boolean triggerCollision(SpaceShip aShip) {
      if (aShip.side == 1) {
        if ((aShip.x + aShip.size/2) > (x - triggerDiameter/2) && (aShip.y + aShip.size/2) > (y - triggerDiameter/2) && (x + triggerDiameter/2) > (aShip.x - aShip.size/2) && (y + triggerDiameter/2) > (aShip.y - aShip.size/2)) {
          return true;
        }
      }
      return false;
    }
    
    //checks ships within the detontation radius when exploded
    boolean collision(SpaceShip aShip) {
      if (aShip.side == 1) {
        if ((aShip.x + aShip.size/2) > (x - triggerDiameter/2) && (aShip.y + aShip.size/2) > (y - triggerDiameter/2) && (x + triggerDiameter/2) > (aShip.x - aShip.size/2) && (y + triggerDiameter/2) > (aShip.y - aShip.size/2)) {
          return true;
        }
      }
      return false;
    }
  }

