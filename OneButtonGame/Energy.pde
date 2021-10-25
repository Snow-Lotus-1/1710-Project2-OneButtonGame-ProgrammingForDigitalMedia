//this class is based off of Meng Jia's predator game example
class Energy {
  
  PVector position, position2, positionCore;
  boolean alive = true;
  float speed = 5;
  float spriteWidth;
  float startX, endX;
  
  PImage spark;
  PImage[] sparkFrame = new PImage[12];
  float aniSparkCounter = 0;
  int aniSparkFrame = 0;
  
  Energy(float x, float y) {
    position = new PVector(x, y);
    spark = loadImage("spark/spark1.png"); 
    loadSparkImages();
    init();
  }
  
  void init() {
    spriteWidth = spark.width;
    startX = position.x;
    endX = startX - width - spriteWidth;
    position2 = new PVector(startX + spriteWidth, 0);
    positionCore = new PVector(position.x + spriteWidth/6, position.y + spriteWidth/6);
  }
  
  void update() {
    aniCounter();
    position.x -= speed;
      
      if (position.x < endX) 
      {
        //during cMode, energy can appear at any height, othewise it's in jumping range
        if (!player.cMode)
        {
          position = new PVector(startX, random(275, height - 150));
        }
        else
        {
          position = new PVector(startX, random(height - 150));
        }
      } 
      else if (position.x > startX) 
      {
          position = new PVector(endX, position.y);
      }
      //get the center of the energy sphere so player can get it 
      positionCore = new PVector(position.x + spriteWidth/6, position.y + spriteWidth/6);
  }
  
  void draw() {
    if (!alive) {
      //when the energy resets it's goes back to the rightside of the screen
      position.x = width;
      if (!player.cMode)
      {
        position = new PVector(startX, random(275, height - 150));
      }
      else
      {
        position = new PVector(startX, random(height - 150));
      }
      alive = true;
    }
    switchSparkFrame();
    pushMatrix();
    translate(position.x, position.y);
    image(spark, 0, 0);
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  void aniCounter()
  {
    aniSparkCounter++;
    if (aniSparkCounter >= 10)
    {
      aniSparkCounter = 0;
      aniSparkFrame++;
    }
  }
  void loadSparkImages()
  {
    //gif link
    //https://www.herculeanpixel.com/images/news/ppb_shock.gif
    //https://www.herculeanpixel.com/news/topic/pixel-art?page=9
    sparkFrame[0] = loadImage("spark/spark1.png");
    sparkFrame[1] = loadImage("spark/spark2.png");
    sparkFrame[2] = loadImage("spark/spark3.png");
    sparkFrame[3] = loadImage("spark/spark4.png");
    sparkFrame[4] = loadImage("spark/spark5.png");
    sparkFrame[5] = loadImage("spark/spark6.png");
    sparkFrame[6] = loadImage("spark/spark7.png");
    sparkFrame[7] = loadImage("spark/spark8.png");
    sparkFrame[8] = loadImage("spark/spark9.png");
    sparkFrame[9] = loadImage("spark/spark10.png");
    sparkFrame[10] = loadImage("spark/spark11.png");
    sparkFrame[11] = loadImage("spark/spark12.png");
    
    //resizes images
    for(int i=0; i<sparkFrame.length; i++){
      sparkFrame[i].resize(sparkFrame[i].width/3, sparkFrame[i].height/3);
    }
  }
  //switches spark out for each frame baised on counters
  void switchSparkFrame()
  {
    if (aniSparkFrame > 11)
    {
       aniSparkFrame = 0; 
    }
    for(int i=0; i<sparkFrame.length; i++){
      if(aniSparkFrame == i) 
      {
        spark = sparkFrame[i]; 
      }
    }
  }
}
