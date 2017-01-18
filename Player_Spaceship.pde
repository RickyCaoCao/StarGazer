class FriendlySpaceShip extends SpaceShip {
  //class vars
  float shield;
  int numOfBombs;
  int bombRadius;
  int soundNum;

  //images
  PImage sprites_stop;
  PImage [] sprites_up = new PImage[2];
  PImage [] sprites_left = new PImage[3];
  PImage [] sprites_right = new PImage[3];

  float velX, velY;
  boolean up, down, left, right, shooting;

  float maxHealth, maxShield;
  int maxBombs;

  int powerUpChance;

  //constructor
  FriendlySpaceShip() {
    super();

    side = 0;

    x = width/2;
    y = height-50;
    speed = 5;

    maxHealth = 100;
    maxShield = 0;
    maxBombs = 3;

    velX = 0;
    velY = 0;

    size = 60;

    up = false;
    down = false;
    left = false;
    right = false;

    numOfBombs = 3;
    bombRadius = 100;
    shootInterval = 200;
    damage = 35;
    powerUpChance = 5;

    sprites_stop = loadImage("/Blue/Animation/1.png");
    sprites_stop.resize(size, size);

    //upload images
    for (int i = 0; i < sprites_up.length; i++) {
      sprites_up[i] = loadImage("/Blue/Animation/" + (i+2) + ".png");
      sprites_up[i].resize(size, size);
    }

    for (int i = 0; i < sprites_left.length; i++) {
      sprites_left[i] = loadImage("/Blue/Animation/" + (i+4) + ".png");
      sprites_left[i].resize(size, size);
    }

    for (int i = 0; i < sprites_right.length; i++) {
      sprites_right[i] = loadImage("/Blue/Animation/" + (i+7) + ".png");
      sprites_right[i].resize(size, size);
    }
  }

  //main function
  void operation() {
    if (state == "Online") {
      move();
      death();
      if (shooting == true) {
        shoot();
      }
  } else if (state == "Explosion") {
      state = "Offline";
  } else if (state == "Offline") {}
      display();
  }

void display() {
  if (state == "Online") {
    if (left) {
      if (imgNum < sprites_left.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites_left[imgNum], x, y);
    } else if (right) {
      if (imgNum < sprites_right.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites_right[imgNum], x, y);
    } else if (up) {
      if (imgNum < sprites_up.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites_up[imgNum], x, y);
    } else {
      image(sprites_stop, x, y);
    }
  }
}


//!!!!!!!!
//  else if(state == "Offline"){
//  }

void move() {
  x += velX;
  y += velY;
  x = constrain(x, size/2, width - size/2);
  y = constrain(y, size/2, height - size/2);
}

void shoot() {
  //will shoot only at a given interval
  if (millis() - lastShootTime > shootInterval) {
    Missile aMissile = new Missile(0, x, y - size/2, 30, damage, 10);
    goodMissiles.add(aMissile);
    lastShootTime = millis();
  }
}

void placeBomb() {
  //sets bomb if the player has some
  if (numOfBombs > 0) {
    Bomb someBomb = new Bomb(x, y, damage * 1.5, bombRadius);
    goodBombs.add(someBomb);
    numOfBombs--;
  }
}

void restore() {
  //resets the player ship
  state = "Online";
  health = maxHealth;
  shield = maxShield;
  numOfBombs = maxBombs;
  x = width/2;
  y = height - 50;
  velX = 0;
  velY = 0;
  up = false;
  down = false;
  left = false;
  right = false;
}

void pressedKey() {
  if (state == "Online") {
    if (keyCode == UP || keyCode == 'W') {
      up = true;
      velY = -speed;
    } else if (keyCode == DOWN || keyCode == 'S') {
      down = true;
      velY = speed;
    } else if (keyCode == LEFT || keyCode == 'A') {
      left = true;
      velX = -speed;
    } else if (keyCode == RIGHT|| keyCode == 'D') {
      right = true;
      velX = speed;
    } 
    if (keyCode == ' ') {
      shooting = true;
    } 
    if (keyCode == CONTROL) {
      placeBomb();
    }
  }
}

void releasedKey() {
  if (state == "Online") {
    if (keyCode == UP || keyCode == 'W') {
      up = false;
      if (down == false) {
        velY = 0;
      }
    } else if (keyCode == DOWN || keyCode == 'S') {
      down = false;
      if (up == false) {
        velY = 0;
      }
    } else if (keyCode == LEFT || keyCode == 'A') {
      left = false;
      if (right == false) {
        velX = 0;
      }
    } else if (keyCode == RIGHT || keyCode == 'D') {
      right = false;
      if (left == false) {
        velX = 0;
      }
    }

    if (keyCode == ' ') {
      shooting = false;
    }
  }
}
}
