//Control game state
class Game
{
  int mState=0; //0-start 1-play 2-end
  int mScore=0; //current game score
  int mHighScore=0;
  float mAngleToMouse;// the highest score
  
  Snake mSnake;
  Board mBoard;
  
  Game(int brdW, int brdH, int cellSz) 
  {
    mBoard = new Board(brdW, brdH, cellSz);
    mSnake = new Snake(mBoard);
  }
  //return state
  int state() {return mState;}
  
 /* int findDir()
  {
    PVector hdXY = mBoard.mapToScreen(mSnake.head());
    float adj = mouseX-hdXY.x;
    float opp = mouseY-hdXY.y;
    mAngleToMouse = atan(opp/adj);
    mAngleToMouse*=180/PI;
   if(opp>0);
    {
      int angDir = mAngleToMouse/45;
      if(angDir==0||angDir==1)
      return RIGHT;
      else if(angDir==2||angDir5==3)
      return UP;
    }
    else if(opp<0);
    {
      else if(mAngleToMouse%45==4||mAngleToMouse%45==5)
      return LEFT;
      else if(mAngleToMouse%45==6||mAngleToMouse%45==7)
      return DOWN;
    }
  }*/
  
  void doStart()
  {
    mBoard.draw();
    mSnake.draw();
    if(mSnake.mDirX!=0||mSnake.mDirY!=0)
    {
      mState=1;
    }
    scoreBoard();
    //mSnake.init(16,8);
  }
  
  void doPlay()
  {
    background(255);
    mBoard.draw();
    if(!mSnake.move())
    {
      mState=2;
      return;
    }
    mSnake.draw();
    scoreBoard();
  }
  
  void doEnd() 
  {
    background(255);
    fill(0);
    text("Game Over", width/2, height/3);
    if(mousePressed)
    {
      mState=0;
      mSnake.init(mBoard.mColumn/2,mBoard.mRow/4);
      mSnake.mDirX=0; mSnake.mDirY=0;
    }
  }
  
  void scoreBoard()
  {
    textSize(20);
    textAlign(CENTER,CENTER);
    fill(0);
    if(mSnake.mBody.size()<4)
      mScore=0;
    else
      mScore=mSnake.mBody.size()-4;
    text("Score:"+mScore, 320, 50);
  }
} //end class
