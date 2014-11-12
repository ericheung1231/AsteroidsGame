import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

SpaceShip ship;
ArrayList <Asteroid> astList;
int scrSiz, astNum;
public void setup()
{
  scrSiz = 500;
  astNum = 20;
  size(scrSiz,scrSiz);
  ship = new SpaceShip();
  astList = new ArrayList <Asteroid>();
  for (int i=0; i< astNum; i++)
  {
    astList.add(new Asteroid());
  }
  System.out.println(astList.size());
}
public void draw() 
{
  background(0);
  ship.show();
  ship.keyPressed();
  ship.move();
  for (int i=0; i< astList.size(); i++)
  {
    Asteroid a = (Asteroid) astList.get(i);
    a.show();
    a.move();
    if (dist((float)a.myCenterX,(float)a.myCenterY, (float)ship.myCenterX, (float)ship.myCenterY)<20)
    {
      astList.remove(i);
    }
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
    myCenterX = 250; 
    myCenterY = 250;   
    myDirectionX = 0; 
    myDirectionY = 0; 
    myPointDirection = -90;
  }

  public void keyPressed()
  {
    if (keyPressed && key == 'd')
    {
      rotate(3);
    }
    if (keyPressed && key == 'a')
    {
      rotate(-3);
    }
    if (keyPressed && key == 'w')
    {
      accelerate(0.5f);
    }
    if (keyPressed && key == 's')
    {
      accelerate(-0.5f);
    }
    if (keyPressed && key == 32)
    {
      setX((int)(Math.random()*scrSiz));
      setY((int)(Math.random()*scrSiz));
      setDirectionX(0);
      setDirectionY(0);
    }
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
    if (Math.random() > 0.5f)
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
    myCenterX = 150; 
    myCenterY = 150;
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
