class Powerup{
  float x,y, timer;
  int alphaNum, alphaDecrease, size;
  PImage theImage;
  
  Powerup(float _x, float _y){
      x = _x;
      y = _y;
     
     alphaNum = 255;
     alphaDecrease = -5;
     
     size = 40;
  }
  
  void display(){
    y += 1.5;
    
    //powerup will flash
    if(millis() - timer >= 100){
      if(alphaNum == 0 || alphaNum == 255){
        alphaDecrease = -alphaDecrease;
      }
        alphaNum -= alphaDecrease;
    }
    
    tint(255, alphaNum);
    image(theImage, x, y);
    noTint();
  }
  
  void operation(){}
  
  boolean collision(SpaceShip thePlayer){
    if ((x + size/2 - 10) > (thePlayer.x - thePlayer.size/2) && (x-size/2 + 10) < (thePlayer.x + thePlayer.size/2) && (y-size/2 + 10) < (thePlayer.y + thePlayer.size/2) && (y + size/2) > (thePlayer.y - thePlayer.size/2)) {
      return true;
    }
    else{
      return false;
    }
  }
}

//adds hp to player
class HealthPowerup extends Powerup{  
  HealthPowerup(float _x, float _y){
    super(_x, _y);
    theImage = powerups[0];
    theImage.resize(size,size);
  }
  
  void operation(){
    if(player.maxHealth - player.health <= 50){
      player.health = player.maxHealth;
    }
    else{
      player.health += 50;
    }
  }
}

//blows up all enemy ships
class NukePowerup extends Powerup{
  NukePowerup(float _x, float _y){
      super(_x, _y);
      theImage = powerups[2];
      theImage.resize(size,size);
  }
  
  void operation(){
    for(int i = enemies.size() - 1; i >= 0; i--){
      SpaceShip someEnemy = enemies.get(i);
      someEnemy.health = 0;
    }
  }
}

//gives max bombs to player
class MaxBombsPowerup extends Powerup{
  MaxBombsPowerup(float _x, float _y){
    super(_x, _y);
    theImage = powerups[1];
    theImage.resize(size,size);
  }
  
  void operation(){
    player.numOfBombs = 3;
  }
}

void createPowerup(float _x, float _y){
  Powerup somePowerup;
  int chance = int(random(1,8));
  if(chance <= 3){
    somePowerup = new HealthPowerup(_x, _y);
  }
  else if(chance <= 6){
    somePowerup = new MaxBombsPowerup(_x, _y);
  }
  else{
    somePowerup = new NukePowerup(_x, _y);
  }
  thePowerups.add(somePowerup);
}
