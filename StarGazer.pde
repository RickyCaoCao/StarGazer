//Richard Cao
//Computer Science 30
//"UTE StarGazer"
//SoundFile crashed my computer, deleting this page's worth of code... ._. That's why I'm using Minim. Removed sound effects as I spent 2 hours on it and still kept running into bugs.
//Things Implemented:
//Lasers, bombs, 3 powerups, 4 different enemies, collision with enemy, explosions, health, score, HUD, spawn chances, music, star background (thanks to Jing), title/game/gameover states
//The game increases difficulty as the player gains more points

//set up global vars
import ddf.minim.*;
Minim minim;
AudioPlayer menuMusic;
AudioPlayer gameplayMusic;

Space background;

String GameState; 

FriendlySpaceShip player;
ArrayList <Missile> goodMissiles = new ArrayList <Missile> ();
ArrayList <Bomb> goodBombs = new ArrayList <Bomb> ();
ArrayList <Powerup> thePowerups = new ArrayList <Powerup> (); 

ArrayList <SpaceShip> enemies = new ArrayList <SpaceShip> ();
ArrayList <Missile> badMissiles = new ArrayList <Missile> ();

PImage [] enemyOneSprites = new PImage [8];
PImage [] enemyTwoSprites = new PImage [8];
PImage [] enemyThreeSprites = new PImage [5];
PImage [] explosionSprites = new PImage [17];
PImage [] powerups = new PImage [3];
PImage enemyFourSprite;
PImage healthSymbol;
PImage bombSymbol;

PFont font_one, font_two, font_three;

int playerScore = 0;
float shipSpawnTimer;

void setup() {
  //create window
  size(600, 700);

  minim = new Minim(this);

  //setup images
  for (int i = 0; i < explosionSprites.length; i++) {
    explosionSprites[i] = loadImage("/Effects/Red Explosion/1_" + i + ".png");
  }

  for (int i = 0; i < enemyOneSprites.length; i++) {
    enemyOneSprites[i] = loadImage("/Red/Enemy_animation/" + (i+1) + ".png");
  }
  
  for (int i = 0; i < enemyTwoSprites.length; i++) {
    enemyTwoSprites[i] = loadImage("/Red/Red Plane animation/" + (i+1) + ".png");
  }
  
  for (int i = 0; i < enemyThreeSprites.length; i++) {
    enemyThreeSprites[i] = loadImage("/Red/small_ship_animation/" + (i+1) + ".png");
  }
  
  for (int i = 0; i < powerups.length; i++) {
    powerups[i] = loadImage("/Powerups/Powerup_" + (i+1) + ".png");
  }
  
  healthSymbol = loadImage("HP Symbol.png");
  healthSymbol.resize(25,25);

  bombSymbol = loadImage("/Blue/Spacebombs/1.png");
  bombSymbol.resize(40,40);
  
  enemyFourSprite = loadImage("/Red/mothership_try.png");
  
  //load music
  menuMusic = minim.loadFile("/Music/Menu_Music.mp3");
  gameplayMusic = minim.loadFile("/Music/Gameplay_Music.mp3");
  
  //create players and the background
  player = new FriendlySpaceShip();
  background = new Space();
  //sets game state
  GameState = "Title";
  
  //define miscellaneous settings
  imageMode(CENTER);
  textAlign(CENTER);
  font_one = createFont("Calibri.vlw", 36);
  font_two = createFont("Comic Sans MS Bold", 48);
  font_three = createFont("Calibri.vlw", 18);
}

void draw() {
  if (GameState == "Title") {
    TitleScreen();
    
    //play music
    gameplayMusic.rewind();
    gameplayMusic.pause();
    menuMusic.play();
    
  } else if (GameState == "GameBegin") {
    //play music
    menuMusic.rewind();
    menuMusic.pause();
    gameplayMusic.play();

    //debugging();

    //draw background
    background.displayMoving();
    
    //move and operate player's spaceship
    player.operation();
    
    //work through interactions
    battle();
    
    spawnEnemies(playerScore);
    
    //moves items like missiles and enemy space ships
    operateItems();

    //will clear everything if player is destroyed
    if (player.state == "Offline") {
      enemies.clear();
      goodMissiles.clear();
      badMissiles.clear();
      goodBombs.clear();
      thePowerups.clear();
      GameState = "GameOver";
    }
    
    //draws the HP, score and current number of bombs
    HUD(); 
  }
  
  else if(GameState == "GameOver"){
    GameOverScreen();
  }
//  else if(GameState == "Upgrade"){
//      UpgradeScreen();
//    }
}

void HUD(){
  textFont(font_three);
  fill(255);
  
  //draws HP
  image(healthSymbol, 25, 25);
  String playerHealth = str(int(player.health)) + "%";
  text(playerHealth, 75, 32);
  
  //draws number of bombs
  image(bombSymbol, 25, 60);
  text(player.numOfBombs, 55, 65);
  
  //draws player score
  String aScore = "Score: " + playerScore;
  text(aScore, 54, 100);
}

void keyPressed() {
  player.pressedKey();
}

void keyReleased() {
  player.releasedKey();
}