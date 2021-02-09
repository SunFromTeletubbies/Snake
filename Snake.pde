class Snake
{
  int mDirX=0;
  int mDirY=0;
  int mGrowCount=3;
  boolean mStop=false;
  ArrayList<Cell> mBody;
  Board mBoard;
  Foods mFoods;
// Constructor
  Snake(Board brd)
  {
     mBoard=brd;
     init(mBoard.mColumn/2,mBoard.mRow/4);
  }
 
  void init( int x, int y)
  {
    mBody= new ArrayList<Cell> ();
    mBody.add(new Cell(x,y));
    mFoods = new Foods(mBoard);
    mFoods.init();
    mGrowCount=3;
  }
 
  // get head object
  Cell head() {return  mBody.get(0);}
  Cell neck() {return mBody.size()>1 ?mBody.get(1): null;}
 
  // Create Cell node with next head position
  Cell nextHead() {
    Cell newHead= new Cell(head().x+mDirX, head().y+mDirY);
    newHead.x = (newHead.x + mBoard.column()) % mBoard.column();
    newHead.y = (newHead.y + mBoard.row())    % mBoard.row();
    return newHead;
  }
  
  void setDirection( int dirX, int dirY)
  {
    // If new head with (dirX,dirY) hits neck()
    //   do nothing
    mDirX= dirX; mDirY=dirY;
    
    Cell newHead= nextHead();
    // If newHead == neck return
    
    if(neck()!=null && (neck().x== newHead.x && neck().y== newHead.y))
      {
        mDirX= -dirX; mDirY= -dirY;
      }
  }
 
  boolean move()
  {
    // head new direction
    Cell newHead= nextHead();
    mFoods.spawn();
    // If grow, do grow
    // If head foud food
    if(hit(newHead)) 
    {
      return false;
    }
   //if(mBoard.consumeFood(newHead)>0)
   //println(mBoard.consumeFood(newHead));
    if(mBoard.isObstacle(newHead)) // else if head hit obstacle
    {
      return false;
    }
    
    mGrowCount+=mFoods.consumeFood(mBody.get(0));
    if(mBody.size()>1)
      mGrowCount+=mFoods.mYellow.consume(mBody.get(1));
    
    if(mGrowCount >0)
    {
      mGrowCount --;
    }
    else 
    {
      mBody.remove(mBody.size()-1);
    }
      mBody.add(0, newHead);
      //println(mDirX, mDirY);
    sameTileSpawnSnake();
    mFoods.update();
     return true;
  }
  
  void sameTileSpawnSnake()
  {
   if(mFoods.mRed.mCreated||mFoods.mYellow.mCreated||mFoods.mGreen.mCreated)
    {
      for(int i = 0; i<mBody.size()-1; i++)
      {
        if(mFoods.mRed.mCreated&&mFoods.mRed.mCell.x==mBody.get(i).x&&mFoods.mRed.mCell.y==mBody.get(i).y)
        {
          mFoods.mRed.create();
        }
        if(mFoods.mYellow.mCreated&&mFoods.mYellow.mCell.x==mBody.get(i).x&&mFoods.mYellow.mCell.y==mBody.get(i).y)
        {
          mFoods.mYellow.create();
        }
        for(int j = 0; j<mFoods.mGreen.mCell.length; j++)
        {
          if(mFoods.mGreen.mCreated&&mFoods.mGreen.mCell[j].x==mBody.get(i).x&&mFoods.mGreen.mCell[j].y==mBody.get(i).y)
          {
            mFoods.mGreen.create();
          }
        }
      }
    }
  }
  
  int snakeLength() {return mBody.size();};
  // Does Cell c hit this snake?
  boolean hit(Cell c)
  {
    for(int i=1; i<mBody.size(); i++)
    {
      if(c.x==mBody.get(i).x&&c.y==mBody.get(i).y)
      {
        return true;
      }
    }
    return false;
  }
  
  
  void draw() 
  { 
    int w = mBoard.cellSize();
    fill(100);
    rectMode(CENTER);
    for(Cell c: mBody)
    {
      PVector center=mBoard.mapToScreen(c);
      if(mBody.indexOf(c)==0)
      {
        fill(145,245,0);
        rect(center.x, center.y, w, w);
        fill(50,205,50);
      }
      else if(mBody.indexOf(c)==mBody.size()-1)
      {
        fill(0,140,0);
        rect(center.x, center.y, w, w);
        fill(50,205,50);
      }
      else
      {
        rect(center.x, center.y, w, w);
      }
    }
    mFoods.updateEffect();
  }
 
  
  void adjustHeadDir()
  {
  }
 
}// end class
  
