void spawnEnemies(int theScore){
  int level = int(theScore/1500) + 1;
  if(level > 5){
    level = 5;
  }
  
  //difficulty increases based on points
  if(millis() - shipSpawnTimer > 500 * (6 - level)){
   int chance = int(random(1, 21));
   //below are different patterns of enemies that are spawned at a given interval of time
   if(chance <= 9){
     SpaceShip oneEnemyShip = new EnemySpaceShipOne(int(random(50, width-50)), -50);
     SpaceShip twoEnemyShip = new EnemySpaceShipOne(int(random(50, width-50)), -50);
     enemies.add(oneEnemyShip);
     enemies.add(twoEnemyShip);
   }
   else if (chance <= 14){
     SpaceShip oneEnemyShip = new EnemySpaceShipTwo(int(random(50, width-50)), -50);
     SpaceShip twoEnemyShip = new EnemySpaceShipTwo(int(random(50, width-50)), -50);
     SpaceShip threeEnemyShip = new EnemySpaceShipTwo(int(random(50, width-50)), -50);
     enemies.add(oneEnemyShip);
     enemies.add(twoEnemyShip);
     enemies.add(threeEnemyShip);
   }
   else if (chance <= 18){
     SpaceShip enemyShip = new EnemySpaceShipTwo(int(random(50, width-50)), -50);
     enemies.add(enemyShip);
   }
   else{
     SpaceShip enemyShip = new EnemySpaceShipFour(int(random(50, width-50)), -(50 + 50));
     enemies.add(enemyShip);
   }
   shipSpawnTimer = millis();
 }
}

//normal ship with 1 shot fired at a given interval
class EnemySpaceShipOne extends SpaceShip {
  PImage [] sprites = new PImage [8];

  boolean dead = false;

  EnemySpaceShipOne(float _x, float _y) {
    super();
  
    pointValue = 50;
    side = 1;
    x = _x;
    y = _y;
    damage = 15;
    speed = 1;
    health = 100;
    size = 50;

    shootInterval = 1500;
    lastShootTime = millis() + 500;

    switchImageTimer = 0;

    for (int i = 0; i < sprites.length; i++) {
      sprites[i] = enemyOneSprites[i];
      sprites[i].resize(size, size);
    }
  }

  void operation() {
    display();
    if (state == "Online") {
      move();
      shoot();
      death();
    }
  }

  void display() {
    if (state == "Online") {
      if (imgNum < sprites.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites[imgNum], x, y);
    } else if (state == "Explosion") {
      if (dead) {
        imgNum = 0;
        switchImageTimer = millis();
        dead = true;
      }
      if (imgNum < explosion.length - 1) {
        if (millis() - switchImageTimer > 100) {
          imgNum++;
        }
        image(explosion[imgNum], x, y);
      }
      else{
        state = "Offline";
      }
    }
  }

  void move() {
    y += speed;
  }

  void shoot() {
    if (millis() - lastShootTime > shootInterval) {
      Missile aMissile = new Missile(1, x, y + size/2, 35, damage, 4);
      badMissiles.add(aMissile);
      lastShootTime = millis();
    }
  }
}

//light ship that has burst shooting of 3 bullets
class EnemySpaceShipTwo extends SpaceShip {
  PImage [] sprites = new PImage [8];

  boolean dead = false;

  float anotherShotInterval;

  EnemySpaceShipTwo(float _x, float _y) {
    super();

    pointValue = 40;
    side = 1;
    x = _x;
    y = _y;
    damage = 10;
    speed = 1.2;
    health = 70;
    size = 50;

    shootInterval = 2500;
    anotherShotInterval = millis();
    lastShootTime = millis() + 500;

    switchImageTimer = 0;

    for (int i = 0; i < sprites.length; i++) {
      sprites[i] = enemyTwoSprites[i];
      sprites[i].resize(size, size);
    }
  }

  void operation() {
    display();
    if (state == "Online") {
      move();
      death();
      if (millis() - lastShootTime > shootInterval) {
        if (millis() - anotherShotInterval > 250) {
          shoot();
          anotherShotInterval = millis();
        }
        if (millis() - lastShootTime > shootInterval + 750) {
          lastShootTime = millis();
        }
      }
    }
  }

  void display() {
    if (state == "Online") {
      if (imgNum < sprites.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites[imgNum], x, y);
    } else if (state == "Explosion") {
      if (dead) {
        imgNum = 0;
        switchImageTimer = millis();
        dead = true;
      }
      if (imgNum < explosion.length - 1) {
        if (millis() - switchImageTimer > 100) {
          imgNum++;
        }
        image(explosion[imgNum], x, y);
      } else {
        state = "Offline";
      }
    }
  }

  void move() {
    y += speed;
  }

  void shoot() {
    Missile aMissile = new Missile(1, x, y + size/2, 35, damage, 4);
    badMissiles.add(aMissile);
  }
}


//a large ship that can absorb and deal large damage
class EnemySpaceShipThree extends SpaceShip {
  PImage [] sprites = new PImage [5];

  boolean dead = false;


  EnemySpaceShipThree(float _x, float _y) {
    super();

    pointValue = 100;
    side = 1;
    x = _x;
    y = _y;
    damage = 25;
    speed = 0.8;
    health = 180;
    size = 80;

    shootInterval = 3000;
    lastShootTime = millis() + 500;

    switchImageTimer = 0;

    for (int i = 0; i < sprites.length; i++) {
      sprites[i] = enemyThreeSprites[i];
      sprites[i].resize(size, size);
    }
  }

  void operation() {
    display();
    if (state == "Online") {
      move();
      death();
      shoot();
    }
  }

  void display() {
    if (state == "Online") {
      if (imgNum < sprites.length-1) {
        imgNum++;
      } else {
        imgNum = 0;
      }
      image(sprites[imgNum], x, y);
    } else if (state == "Explosion") {
      if (dead) {
        imgNum = 0;
        switchImageTimer = millis();
        dead = true;
      }
      if (imgNum < explosion.length - 1) {
        if (millis() - switchImageTimer > 100) {
          imgNum++;
        }
        image(explosion[imgNum], x, y);
      } else {
        state = "Offline";
      }
    }
  }

  void move() {
    y += speed;
  }

   void shoot() {
    if (millis() - lastShootTime > shootInterval) {
      Missile aMissile = new Missile(1, x, y + size/2, 50, damage, 4);
      badMissiles.add(aMissile);
      lastShootTime = millis();
    }
  }
}

//a mothership that spawns other ships  
class EnemySpaceShipFour extends SpaceShip {
  PImage sprite;

  boolean dead = false;


  EnemySpaceShipFour(float _x, float _y) {
    super();

    pointValue = 1000;
    side = 1;
    x = _x;
    y = _y;
    damage = 0;
    speed = 0.5;
    health = 800      ;
    size = 200;

    shootInterval = 2500;
    lastShootTime = millis() + 500;
    
    switchImageTimer = 0;

    sprite = enemyFourSprite;
    sprite.resize(size, size);
  }

  void operation() {
    display();
    if (state == "Online") {
      move();
      death();
      spawn();
    }
  }

  void display() {
    if (state == "Online") {
      image(sprite, x, y);
    } else if (state == "Explosion") {
      if (dead) {
        imgNum = 0;
        switchImageTimer = millis();
        dead = true;
      }
      if (imgNum < explosion.length - 1) {
        if (millis() - switchImageTimer > 100) {
          imgNum++;
        }
        image(explosion[imgNum], x, y);
      } else {
        state = "Offline";
      }
    }
  }

  void move() {
    y += speed;
    y = constrain(y, 0, height/3);
  }

   void spawn() {
    if (millis() - lastShootTime > shootInterval) {
      int chance = int(random(1,4));
      if(chance == 1){
        SpaceShip enemyShip = new EnemySpaceShipOne(x, y);
        enemies.add(enemyShip);
      }
      else if(chance == 2){
        SpaceShip enemyShip = new EnemySpaceShipTwo(x, y);
        enemies.add(enemyShip);
      }
      else if(chance == 3){
        SpaceShip enemyShip = new EnemySpaceShipThree(x, y);
        enemies.add(enemyShip);
      }
    lastShootTime = millis();
    }
  }
}

