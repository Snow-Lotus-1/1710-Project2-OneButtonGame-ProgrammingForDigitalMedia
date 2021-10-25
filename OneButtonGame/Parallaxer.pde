//Code Obtained from the Fox Gieg wiki gitrepo 
//https://github.com/n1ckfg/Parallaxer

import gifAnimation.*;

class Parallaxer 
{
  float speed;
  //switched PImages for Gifs
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
      //takes in two images/gifs but uses 3
      //so there is a smooth transitions between the two images/gifs
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
      //define some variables for the prallaxer
      spriteWidth = img.width;
      startX = position.x;
      position2 = new PVector(startX + spriteWidth, 0);
      
      //when there is a second img, run this code
      //if statment here so no problems are caused when first constructor is used
      if (img2 != null)
      {
        endX = startX - spriteWidth*2;
        position3 = new PVector(startX + spriteWidth*2, 0);
      }
      else
      {
        //all crowds have widths less than 500, including bgCrowds
        if (!(spriteWidth<500))
        {
          //makes sure the parallaxer makes it across the screen flawlessly 
          endX = startX - spriteWidth; 
        }
        else
        {
          //otherwise run the normal code for the background
          endX = startX - width - spriteWidth;
        }
      }
    }
   
    void update() {
      //moves the parallaxers 
      position.x -= speed;
      
      if (position.x < endX) 
      {
          position = new PVector(startX, position.y);
      } 
      //honestly don't need this becuase parallaxer only move one way, but kept it here anyway
      else if (position.x > startX) 
      {
          position = new PVector(endX, position.y);
      }
    }
    
    void draw() {
      //draw the parallaxer
      pushMatrix();
      translate(position.x, position.y);
      image(img, 0, 0);
      
      //checks if there is a second img
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
