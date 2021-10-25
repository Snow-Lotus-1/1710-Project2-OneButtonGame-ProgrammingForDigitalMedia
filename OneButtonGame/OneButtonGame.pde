//based off of the gravity example from the Fox Gieg website
//https://github.com/eecs17xx/eecs1710-2021f/tree/main/Week07/Gravity01
import gifAnimation.*;

//player, aka the avatar
Player player;
//the energy that needs to be collected then avoided
Energy energy;
//bg is the main background, c1 and c2 give a more filled out feel to the background, c3 adds a bit of randomness to the background so it's not always the same
Parallaxer bg, c1, c3, c2;
//6 gifs used to make the primary background
Gif background1, background2, bgCrowd1, bgCrowd2, bgCrowd3, bgCrowd4;
Gif[] crowd = new Gif[10];

float gravity = 5;
float gravityDelta = 0.5;
float friction = 0.99;
float floor;
float delta;
float stopDelta = 0.5;
float s = 0.3;
PFont eCount;
PFont score;

void setup() {
  frameRate(60);
  size(800, 600, P2D);
  floor = height;
  eCount = createFont("Arial",24,true);
  score = createFont("Arial",24,true);
  
  //background gifs
  //https://pin.it/4eGyIja
  //https://pin.it/5fQuB4b
  background1 = new Gif(this, "background/background1.gif"); background2 = new Gif(this, "background/background2.gif"); 
  bg = new Parallaxer(background1, background2, delta, new PVector(0,12.5));
  
  //gif crowds
  //https://pin.it/6jZatiI 
  //https://pin.it/2npiNNT
  //https://nughtaedgames.itch.io/overcrowded
  bgCrowd1 = new Gif(this, "crowd/crowd11.gif"); bgCrowd2 = new Gif(this, "crowd/crowd12.gif"); 
  bgCrowd3 = new Gif(this, "crowd/crowd13.gif"); bgCrowd4 = new Gif(this, "crowd/crowd14.gif");
  c1 = new Parallaxer(bgCrowd1, bgCrowd4, delta*1.2, new PVector(0, 160));
  c2 = new Parallaxer(bgCrowd2, bgCrowd3, delta*1.5, new PVector(0, 145));
  
  //crowd gifs 1-10
  //https://www.ilikesticker.com/LineStickerAnimation/W4101957-AZUR-LANE-Pixel-Sticker/en 
  crowd[0] = new Gif(this, "crowd/crowd1.gif"); crowd[1] = new Gif(this, "crowd/crowd2.gif"); crowd[2] = new Gif(this, "crowd/crowd3.gif");
  crowd[3] = new Gif(this, "crowd/crowd4.gif"); crowd[4] = new Gif(this, "crowd/crowd5.gif"); crowd[5] = new Gif(this, "crowd/crowd6.gif");
  crowd[6] = new Gif(this, "crowd/crowd7.gif"); crowd[7] = new Gif(this, "crowd/crowd8.gif"); crowd[8] = new Gif(this, "crowd/crowd9.gif");
  crowd[9] = new Gif(this, "crowd/crowd10.gif");
  //selects a random gif out of the 10
  Gif crowdR = crowd[int(random(crowd.length-1))];
  c3 = new Parallaxer(crowdR, delta*2, new PVector(width, height - 310 - crowdR.height));
  player = new Player(width/2, height/2);
  energy = new Energy(width, random(300, height - 50));
  player.aura = new Gif(this, "spark/original.gif");
  player.aura.loop();
}

void draw() {
  if(c3.position.x + c3.spriteWidth <= 10 && !player.cMode)
  {
    Gif crowdR = crowd[int(random(crowd.length-1))];
    c3 = new Parallaxer(crowdR, delta*2, new PVector(width, height - 310 - crowdR.height));
  }

  if (energy.position.x + energy.spriteWidth <= 3)
  {
    energy = new Energy(width, random(250, height - 75));
  }
  
  background(127);
  pushMatrix();
  scale(height / background1.height);
  delta = abs(5) * s;
  
  bg.speed = delta;
  bg.run();
  c1.speed = delta * 1.2;
  c1.run();
  c2.speed = delta * 1.5;
  c2.run();
  if (c3 != null)
  {
    c3.speed = delta * 2;
    c3.run();
  }
  popMatrix();
  
  textFont(eCount,20);
  fill(255);
  if (!player.cMode){text("Press 'space' to jump, collect 15 energy to unlock Supercharged mode. Energy Count: " + player.eCount,5,18);}
  else {
    if (player.life <= 0)
    {
      text("Game Over: You Overloaded and Ran Out of Lives                          Score: " + player.score,5,18);      
    }
    else
    {
      text("Supercharged mode, press 'space' midair to double jump.    Life: " + player.life +"   Score: " + player.score + "\nCrashing into energy or ceiling will loose life.",5,18);    
    }
  }
  
  player.run();
  energy.run();
  
  if(player.jumping == false)
  {
    gravity += gravityDelta;
  }
  else
  {
    gravity -= gravityDelta;
  }
  
  surface.setTitle("" + frameRate);
}
