//default spaceship class

class SpaceShip {
  //class vars
  int side;
  float x, y, speed;
  float health, damage;
  float shootInterval;
  float lastShootTime = 0;
  String state;
  int size, pointValue;

  int imgNum;
  float switchImageTimer;

  PImage [] explosion = new PImage[17];

  //need coordinates
  SpaceShip() {
    state = "Online";
    for (int i = 0; i < explosion.length; i++) {
      explosion[i] = explosionSprites[i];
      explosion[i].resize(75, 75);
    }
  }

  void operation() {
  }

  void display() {
  }

  void move() {
  }
  
  //random chance to create powerup when ship is destroyed
  void death() {
    if (health <= 0 || y > height + size/2 + 25) {
      state = "Explosion";
      int randomChance = int(random(1, 100));
      if (randomChance <= 10) {
        createPowerup(x, y);
      }
    }
  }

  //checks for collision with player
  boolean collideWithPlayer(SpaceShip thePlayer) {
    if (state == "Online") {
      if ((x + size/2 - 15) > (thePlayer.x - thePlayer.size/2) && (x-size/2 + 15) < (thePlayer.x + thePlayer.size/2) && (y-size/2 + 15) < (thePlayer.y + thePlayer.size/2) && (y + size/2 - 15) > (thePlayer.y - thePlayer.size/2)) {
        return true;
      }
    }
    return false;
  }
}

