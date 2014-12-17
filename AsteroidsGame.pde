SpaceShip ship;
ArrayList <Asteroid> astList;
ArrayList <Bullets> bullet;
int scrSiz, astNum, rectWidth, rectHeight;
boolean endGame, win;
public void setup()
{
  scrSiz = 500;
  astNum = 20;
  rectWidth = 200;
  rectHeight = 100;
  size(scrSiz,scrSiz);
  ship = new SpaceShip();
  bullet = new ArrayList <Bullets>();
  astList = new ArrayList <Asteroid>();
  for (int i=0; i< astNum; i++)
  {
    astList.add(new Asteroid());
  }
  endGame = false;
}

public void mousePressed()
{
  if (mousePressed == true && endGame == false)
    {
      bullet.add(new Bullets(ship));
    }
  if (endGame == true)
    {
      if (mousePressed == true)
      {
        if (mouseX<(scrSiz/2 - rectWidth/2)+ rectWidth && mouseX>(scrSiz/2 - rectWidth/2))
        {
          if (mouseY<(scrSiz/2 + rectHeight) && mouseY>scrSiz/2)
          {
            endGame = false;
          }
        }
      }
    }
}

public void draw() 
{
  background(0);
  if (endGame == false)
  {
    for (int i=0; i< bullet.size(); i++)
    {
      bullet.get(i).show();
      bullet.get(i).move();
    }
    ship.show();
    ship.rotate(ship);
    ship.keyPressed();
    ship.move();
    for (int i=0; i< astList.size()-1; i++)
    {
      astList.get(i).show();
      astList.get(i).move();
      for(int b=0; b < bullet.size(); b++)
      {
        if (dist((float)astList.get(i).getX(),(float)astList.get(i).getY(), (float)bullet.get(b).getX(), (float)bullet.get(b).getY())<20)
        {
        astList.remove(i);
        }

        if (dist((float)astList.get(i).getX(),(float)astList.get(i).getY(), (float)ship.getX(), (float)ship.getY())<10)
        {
        endGame = true;
        win = false;
        astList.get(i).setX((int)(Math.random()*scrSiz));
        astList.get(i).setY((int)(Math.random()*scrSiz));
        if (astList.size()< astNum)
        {
          for (int e=astList.size(); e<astNum; e++)
          {
            astList.add(new Asteroid());
          }
        }
        ship.setX(scrSiz/2);
        ship.setY(scrSiz/2);
        ship.setDirectionX(0);
        ship.setDirectionY(0);
        ship.setPointDirection(-90);
        for(int q=0; q < bullet.size(); q++)
        {bullet.remove(q);}
        }
      }

    if (astList.size() == 1)
        {
        endGame = true;
        win = true;
        astList.get(i).setX((int)(Math.random()*scrSiz));
        astList.get(i).setY((int)(Math.random()*scrSiz));
        if (astList.size()< astNum)
        {
          for (int e=astList.size(); e<astNum; e++)
          {
            astList.add(new Asteroid());
          }
        }
        ship.setX(scrSiz/2);
        ship.setY(scrSiz/2);
        ship.setDirectionX(0);
        ship.setDirectionY(0);
        ship.setPointDirection(-90);
        }
    }
  }
 

  if(endGame == true)
  {
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(50);
    if (win == false)
    {
        text("Game Over", scrSiz/2, scrSiz/2 - rectHeight);
        text("Retry", scrSiz/2, scrSiz/2 + rectHeight/2);
    }
    if (win == true)
    {
        text("YOU WIN", scrSiz/2, scrSiz/2 - rectHeight);
        textSize(30);
        text("New Game", scrSiz/2, scrSiz/2 + rectHeight/2);
    }
    stroke(255);
    noFill();
    rect(scrSiz/2 - rectWidth/2, scrSiz/2, rectWidth, rectHeight);
  }
}

class SpaceShip extends Floater  
{   
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;} 
  public void setY(int y) {myCenterY = y;} 
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}     
  public double getDirectionY() {return myDirectionY;}  
  public void setPointDirection(int degrees) {myPointDirection = degrees;}  
  public double getPointDirection() {return myPointDirection;}

  public SpaceShip()
  {
    corners = 4;  
    xCorners = new int[corners];
    yCorners = new int[corners];
      xCorners[0]=10;
      xCorners[1]=-5;
      xCorners[2]=-3;
      xCorners[3]=-5;
      yCorners[0]=0;
      yCorners[1]=5;
      yCorners[2]=0;
      yCorners[3]=-5;  
    myColor = 255;   
    myCenterX = scrSiz/2; 
    myCenterY = scrSiz/2;   
    myDirectionX = 0; 
    myDirectionY = 0; 
    myPointDirection = -90;
  }

  public void rotate(SpaceShip theShip)
  {  
     //first quadrant   
     if (mouseX>theShip.getX() && mouseY<theShip.getY())
     {
      myPointDirection = (-1)*(180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
     }
     //second quadrant
     if (mouseX<theShip.getX() && mouseY<theShip.getY())
     {
      myPointDirection = 180 + (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
     }
     //third quadrant
     if (mouseX<theShip.getX() && mouseY>theShip.getY())
     {
      myPointDirection = 180 - (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
     }
     //fourth quadrant
     if (mouseX>theShip.getX() && mouseY>theShip.getY())
     {
      myPointDirection = (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
     }
  }

  public void keyPressed()
  {
    if (keyPressed && key == 32)
    {
      ship.accelerate(0.1);
    }
    if (keyPressed && keyCode == DOWN)
    {
      ship.accelerate(-0.1);
    }
    if (keyPressed && keyCode == ALT)
    {
      ship.setX((int)(Math.random()*scrSiz));
      ship.setY((int)(Math.random()*scrSiz));
      ship.setDirectionX(0);
      ship.setDirectionY(0);
    }
  }
}

class Bullets extends Floater
{
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;} 
  public void setY(int y) {myCenterY = y;} 
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}     
  public double getDirectionY() {return myDirectionY;}  
  public void setPointDirection(int degrees) {myPointDirection = degrees;}  
  public double getPointDirection() {return myPointDirection;}

  public Bullets(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
  }
  public void show()
  {
    fill(255,255,0);
    noStroke();
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);
  }
  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  }
}

class Asteroid extends Floater
{
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;} 
  public void setY(int y) {myCenterY = y;} 
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}     
  public double getDirectionY() {return myDirectionY;}  
  public void setPointDirection(int degrees) {myPointDirection = degrees;}  
  public double getPointDirection() {return myPointDirection;}
  public int rotSpeed, scal;
  public double speed, ang;
  //
  public Asteroid()
  {
    if (Math.random() > 0.5)
    {
      rotSpeed = (int)(Math.random()*2)+2;
    }
    else
    {
      rotSpeed = ((int)(Math.random()*2)+2)*(-1);
    }
    scal = (int)(Math.random()*4)+2;
    corners = 6;  
    xCorners = new int[corners];
    yCorners = new int[corners];
      xCorners[0]=(int)(Math.random()*5*scal)+5*scal;
      xCorners[1]=(int)(Math.random()*3*scal);
      xCorners[2]=-(int)(Math.random()*3*scal);
      xCorners[3]=(int)(Math.random()*5*scal)-5*scal;
      xCorners[4]=-(int)(Math.random()*3*scal);
      xCorners[5]=(int)(Math.random()*3*scal);
      yCorners[0]=(int)(Math.random()*3*scal)-2*scal;
      yCorners[1]=(int)(Math.random()*3*scal)-5*scal;
      yCorners[2]=(int)(Math.random()*3*scal)-5*scal;
      yCorners[3]=(int)(Math.random()*3*scal)-2*scal;
      yCorners[4]=(int)(Math.random()*3*scal)+5*scal;
      yCorners[5]=(int)(Math.random()*3*scal)+5*scal; 
    myColor = 255;   
    myCenterX = (Math.random()*scrSiz); 
    myCenterY = (Math.random()*scrSiz);
    speed = Math.random()*5;
    ang = Math.random()*2*Math.PI;
    myDirectionX = Math.cos(ang)*speed;
    myDirectionY = Math.sin(ang)*speed; 
    myPointDirection = 0;
  }

  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
    myPointDirection+=rotSpeed;     

    //wrap around screen    
    if(myCenterX >scrSiz)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = scrSiz;    
    }    
    if(myCenterY >scrSiz)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = scrSiz;    
    } 

  }

  public void show ()
  {             
    fill(0);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);
  } 
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }  
} 

