class Space {
  //twinkle Stars
  ArrayList <Stars> someStars = new ArrayList <Stars> ();

  Space() {
    //create stars
    for (int i = 0; i < 500; i++) {
      Stars aStar = new Stars(1);
      someStars.add(aStar);
    }
  }

  void displayStill(){
    background(0, 0, 30);
    displayStars();
  }
  
  void displayMoving() {
    background(0, 0, 30);
    displayStars();
    move();
    addStars();
  }

  void displayStars() {
    for (int i = someStars.size() - 1; i >= 0; i--){
      Stars item = someStars.get(i);
      item.display();
    }
  }
  
  void move(){
    for (int i = someStars.size() - 1; i >= 0; i--){
      Stars item = someStars.get(i);    
      item.travel();
      if(removeStars(item.y)){
          someStars.remove(item);
        }
      }
  }
  
  //checks if star is out of window. If yes, it will be removed.
  boolean removeStars(float theHeight){
    if(theHeight > height){
      return true;
    }
    else{
      return false;
    }
  }
  
  //stars will be added based on number removed
  void addStars(){
    if(someStars.size() < 500){
      while(someStars.size() < 500){
        Stars newStar = new Stars(0);
        someStars.add(newStar);
      }
    }
  }
}

class Stars {
  float x, y, size, someColor;

  Stars(int random) {
    x = int(random(width));
    if(random == 1){
      y = int(random(height));
    }
    else if(random == 0){
      y = 0;
    }
    size = 2;
    someColor = color(int(random(100, 255)));
  }

  void display() {
    //stars
    noStroke();
    if (random(10) < 1) {
      someColor = int(random(100, 255));
    }
    fill(someColor); 
    ellipse(x, y, size, size);
  }
  
  void travel(){
    y += 1.5;
  }
}

