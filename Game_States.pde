void TitleScreen(){
  //draws star background
  background.displayStill();
  
  //lists instructions
  fill(255);
  textFont(font_one);
  text("Press Space to Start", width/2, height/2 - 50);
  text("WASD to Move, Space to Shoot", width/2, height/2);
  text("CTRL to drop bombs", width/2, height/2 + 50); 
  //changes state if space pressed
  if(keyPressed){
    if(key == ' '){
      GameState = "GameBegin";
      player.restore();
    }
  }
}

void GameOverScreen(){
   //draws star background
  background.displayStill();

  //lists score and the option for player to restart
  textFont(font_two);
  text("GAME OVER", width/2, height/2 - 75);
  String theScore = "SCORE: " + str(playerScore);
  text(theScore, width/2, height/2 + 25);
  textFont(font_one);
  text("Press SPACE to retry!", width/2, height/2 + 100);
  if(keyPressed){
    if(key == ' '){
      GameState = "GameBegin";
      player.restore();
      playerScore = 0;
    }
  }
}
//void UpgradeScreen(){
//  background.displayStill();
//  fill(255)
//  text("Upgrades!", width/2, 
//}
