//based off of Meng Jia's predator game example and the gravity example from the Fox Gieg website 
//https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week07/Gravity01
import gifAnimation.*;

class Player {
  
  PVector position;
  PVector speed;
  int timestamp;
  int life = 10;
  int score;
  
  PImage[] creatureFrame = new PImage[4];
  PImage[] creatureNFrame = new PImage[4];
  PImage[] rCreatureFrame = new PImage[5];
  Gif aura;
  
  PFont cModeCounter;
  float aniCreatureCounter = 0;
  float aniRCreatureCounter = 0;
  int aniCreatureFrame = 0;
  int aniRCreatureFrame = 0;
  int eCount = 0;
  
  PImage playerImg;
  boolean jumping = false;
  boolean cMode = false;
  
  Player(float x, float y) {
    position = new PVector(x, y);
    timestamp = millis();
    speed = new PVector(0, random(-1, 2));
    playerImg = loadImage("creature/creature1.png"); 
    cModeCounter = createFont("Arial",24,true);
    loadCreatureImages();
  }
  
  void update() {
    aniCounter();
    
    if(!jumping)
    {
      position.add(speed);
      position.y += gravity;
      speed.mult(friction);
    }
    else
    {   
      gravityDelta = 0.1;
      position.sub(speed);
      position.y -= gravity * 1.5;
      speed.mult(friction);
      
      if (gravity <= 0)
      {
        jumping = false;
      }
    }
    
    position.y = constrain(position.y, -2*playerImg.height, floor - playerImg.height);
    
    if (position.y == floor - playerImg.height)
    {
      gravity = 5;
      gravityDelta = 0; 
    }
  }
  
  void draw() {
    if(!cMode){switchCreatureNFrame();}
    else{switchCreatureFrame();}
    if(jumping)
    { 
      if(!cMode){playerImg = loadImage("creatureN/creatureNJumpUp.png"); playerImg.resize(creatureFrame[0].width, creatureFrame[0].height);}
      else{playerImg = loadImage("creature/creatureJumpUp.png"); playerImg.resize(playerImg.width/3, playerImg.height/3);}  
      
    }
    else if (!jumping && position.y < (floor-playerImg.height))
    {
      if(!cMode){playerImg = loadImage("creatureN/creatureNJumpDown.png"); playerImg.resize(creatureFrame[0].width, creatureFrame[0].height);}
      else{playerImg = loadImage("creature/creatureJumpDown.png"); playerImg.resize(playerImg.width/3, playerImg.height/3);}  
      
    }
    pushMatrix();
    scale(-1.0, 1.0); 
    image(playerImg, -position.x, position.y);
    popMatrix();
  }
  
  void run() {
    update();
    collectEnergy();
    charged();
    draw();  
  }
  
  void jump()
  {
    jumping = true; 
  }
  
  void collectEnergy() {
    PVector positionHead = new PVector(position.x - playerImg.width/2 + 30, position.y + playerImg.height/2 + 10); 
    if (positionHead.dist(energy.positionCore) < 25) {
      energy.alive = false;
    }
    //for debugging
    //line(positionHead.x, positionHead.y, energy.positionCore.x, energy.positionCore.y);
    stroke(255, 0, 0);
    if (!energy.alive && !cMode){eCount++; s=s+0.01;energy.speed=energy.speed+0.05;}
    else if (!energy.alive && cMode)
    {
      life = life - 1;      
    }
  }
  
  void charged()
  {
    if (eCount >= 10)//change to 30 later
    {
      s = s + 0.0005;
      energy.speed = random(10, 35);
      cMode = true;
      aura.play();
      image(aura, position.x - playerImg.width, position.y);
    }
    if (cMode && life>0)
    {
      score++;
      if ((position.y+playerImg.height)<0){life=life-1;}
    }
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void aniCounter()
  {
    aniCreatureCounter++;
    aniRCreatureCounter++;
    if (aniCreatureCounter >= 5){
      aniCreatureCounter = 0; 
      aniCreatureFrame++;
    }   
    if (aniRCreatureCounter >= 6){
      aniRCreatureCounter = 0; 
      aniRCreatureFrame++;
    }  
  }
  
  void loadCreatureImages()
  {
    //gif link
    //https://i.pinimg.com/originals/13/6a/e0/136ae07e424e878636575ff42406853e.gif
    //https://images.app.goo.gl/PHcnNaT8ksfyZfbz9
    creatureFrame[0] = loadImage("creature/creature1.png");
    creatureFrame[1] = loadImage("creature/creature2.png");
    creatureFrame[2] = loadImage("creature/creature3.png");
    creatureFrame[3] = loadImage("creature/creature4.png");
    
    for(int i=0; i<creatureFrame.length; i++){
      creatureFrame[i].resize(creatureFrame[i].width/3, creatureFrame[i].height/3);
    }
    //////////////////////////////////////////////////////
    //gif link
    //https://cdn2.scratch.mit.edu/get_image/user/66367788_60x60.png
    //https://images.app.goo.gl/SEqRLMHYWABJm1bT6
    creatureNFrame[0] = loadImage("creatureN/creatureN1.png");
    creatureNFrame[1] = loadImage("creatureN/creatureN2.png");
    creatureNFrame[2] = loadImage("creatureN/creatureN3.png");
    creatureNFrame[3] = loadImage("creatureN/creatureN4.png");
    
    for(int i=0; i<creatureNFrame.length; i++){
      creatureNFrame[i].resize(creatureFrame[i].width, creatureFrame[i].height);
    }
    //////////////////////////////////////////////////////
    //gif link
    //https://i.pinimg.com/originals/71/b7/aa/71b7aab38cb5d346a973edfae8e0f9e2.gif
    //https://images.app.goo.gl/BZCQQRnF1nfQPY1h9
    rCreatureFrame[0] = loadImage("resting/resting1.png");
    rCreatureFrame[1] = loadImage("resting/resting2.png");
    rCreatureFrame[2] = loadImage("resting/resting3.png");
    rCreatureFrame[3] = loadImage("resting/resting4.png");
    rCreatureFrame[4] = loadImage("resting/resting5.png");
    
    for(int i=0; i<rCreatureFrame.length; i++){
      rCreatureFrame[i].resize(rCreatureFrame[i].width/4, rCreatureFrame[i].height/4);
    }
  }
  
  void switchCreatureFrame()
  {
    if (aniCreatureFrame > 3)
    {
       aniCreatureFrame = 0; 
    }
    for(int i=0; i<creatureFrame.length; i++){
      if(aniCreatureFrame == i) 
      {
        playerImg = creatureFrame[i];      
      }
    }
  }
  
  void switchCreatureNFrame()
  {
    if (aniCreatureFrame > 3)
    {
       aniCreatureFrame = 0; 
    }
    for(int i=0; i<creatureNFrame.length; i++){
      if(aniCreatureFrame == i) 
      {
        playerImg = creatureNFrame[i];      
      }
    }
  }
  
  void switchRCreatureFrame()
  {
    if (aniRCreatureFrame > 4)
    {
       aniRCreatureFrame = 0; 
    }
    for(int i=0; i<rCreatureFrame.length; i++){
      if(aniRCreatureFrame == i) 
      {
        playerImg = rCreatureFrame[i];      
      }
    }
  }   
}
