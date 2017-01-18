//need to do reverse so I can remove missile/bomb once hit
void battle() {
  for (int i = enemies.size () - 1; i >= 0; i--) {
    SpaceShip someEnemy = enemies.get(i);
    
    //bullets vs enemies
    for (int j = goodMissiles.size () - 1; j >= 0; j--) {
      Missile someMissile = goodMissiles.get(j);
      if (someMissile.collision(someEnemy)) {
        someEnemy.health -= someMissile.damage;
        goodMissiles.remove(someMissile);
      }
    }


    //bombs vs enemies
    //triggers bomb activation
    for (int k = goodBombs.size () - 1; k >= 0; k--) {
      Bomb someBomb = goodBombs.get(k);
      if (someBomb.state == "Online") {
        if (someBomb.collision(someEnemy)) {
          someBomb.detonationTimer = millis();
          someBomb.state = "Detonating";
        }
      }
    }

    //player vs enemies
    if (someEnemy.collideWithPlayer(player)) {
      player.health -= (someEnemy.damage) * 2.5;
      someEnemy.health = 0;
    }
  }

  //more bombs vs enemies
  //detonation of bomb
  for (int k = goodBombs.size () - 1; k >= 0; k--) {
    Bomb someBomb = goodBombs.get(k);
    for (int i = enemies.size () - 1; i >= 0; i--) {
      SpaceShip someEnemy = enemies.get(i);
      if (someBomb.state == "Explosion") {
        if (someBomb.collision(someEnemy)) {
          someEnemy.health -= player.damage * 3;
        }
      }
    }
    if (someBomb.state == "Explosion") {
      goodBombs.remove(someBomb);
    }
  }

  //bullets vs player
  for (int i = badMissiles.size () - 1; i >= 0; i--) {
    Missile someMissile = badMissiles.get(i);
    if (someMissile.collision(player)) {
      player.health -= someMissile.damage;
      badMissiles.remove(someMissile);
    }
  }

  //player and powerups
  for (int i = thePowerups.size () - 1; i >= 0; i--) {
    Powerup item = thePowerups.get(i);
    if (item.collision(player)) {
      item.operation();
      thePowerups.remove(i);
    }
  }
}

void operateItems() {
  //moves and displays good missiles
  for (int i = goodMissiles.size () - 1; i >= 0; i--) {
    Missile item = goodMissiles.get(i);
    item.display();
    item.move();
    if (item.y < -50) {
      goodMissiles.remove(item);
    }
  }

  //deals with bad missiles
  for (int i = badMissiles.size () - 1; i >= 0; i--) {
    Missile item = badMissiles.get(i);
    item.display();
    item.move();
    if (item.y > height + 50) {
      badMissiles.remove(item);
    }
  }

  //move and displays powerups
  for (int i = thePowerups.size () - 1; i >= 0; i--) {
    Powerup item = thePowerups.get(i);
    item.display();
  }

  //move and displays bombs
  for (Bomb item : goodBombs) {
    item.operation();
  }

  //check if enemy ship is destroyed and will remove if yes
  for (int i = enemies.size () - 1; i >= 0; i--) {
    SpaceShip aShip = enemies.get(i);
    if (aShip.state == "Offline") {
      playerScore += aShip.pointValue;
      enemies.remove(aShip);
    } else {
      aShip.operation();
    }
  }
}

