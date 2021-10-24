//Code Obtained from the Fox Gieg wiki gitrepo 
//https://github.com/n1ckfg/Parallaxer

import gifAnimation.*;

class Parallaxer 
{
  float speed;
  Gif img, img2 = null, img3 = null;
  float spriteWidth;
  float startX, endX;
  PVector position, position2, position3;
  
    //constructor 
    Parallaxer(Gif imgIn, float speedIn, PVector positionIn)
    {
      img = imgIn;
      img.loop();
      img.play();
      speed = speedIn;
      position = positionIn;
      
      init();
    }
    
    //constructor for this project
    Parallaxer(Gif imgIn1, Gif imgIn2, float speedIn, PVector positionIn)
    {
      img = imgIn1;
      img.loop();
      img.play();
      
      img2 = imgIn2;
      img2.loop();
      img2.play();
      
      img3 = imgIn1;
      img3.loop();
      img3.play();
      
      speed = speedIn;
      position = positionIn;
      
      init();
    }
    
    void init() {     
      spriteWidth = img.width;
      startX = position.x;
      position2 = new PVector(startX + spriteWidth, 0);
      if (img2 != null)
      {
        endX = startX - spriteWidth*2;
        position3 = new PVector(startX + spriteWidth*2, 0);
      }
      else
      {
        if (!(spriteWidth<500))
        {
          endX = startX - spriteWidth; 
        }
        else
        {
          endX = startX - width - spriteWidth;
        }
      }
    }
   
    void update() {
      
      position.x -= speed;
      
      if (position.x < endX) 
      {
          position = new PVector(startX, position.y);
      } 
      else if (position.x > startX) 
      {
          position = new PVector(endX, position.y);
      }
    }
    
    void draw() {
      pushMatrix();
      translate(position.x, position.y);
      image(img, 0, 0);
      
      if (img2 != null)
      {
        image(img2, position2.x, position2.y);
        image(img3, position3.x, position3.y);
      }
      popMatrix();
    }
    
    void run() {
      update();
      draw();
    }
  
}
