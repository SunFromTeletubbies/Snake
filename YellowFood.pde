class YellowFood
{
  Cell mCell;
  Board mBoard;  
  int mPoints=6;
  int mDir;
  int mAge;
  boolean mConsumed;
  boolean mCreated;
  boolean mCellExists;
  PShape mFruit;
  float mSize= 1;
  
  YellowFood (int xIn, int yIn, Board brd)
  {
    mCell = new Cell(xIn,yIn);
    mFruit = loadShape("banana.svg");
    mBoard=brd;
    despawn();
  }
  
  void create()
  {
    mCellExists=true;
    mCreated=true;
    mDir=(int) random(0, 4)+1;
    if(mDir==1)
    {
      mCell.x=2;
      mCell.y=(int) random(2,mBoard.mRow-2);
    }
    else if(mDir==2)
    {
      mCell.x=(int) random(2,mBoard.mColumn-2);
      mCell.y=2;
    }
    else if(mDir==3)
    {
      mCell.x=mBoard.mRow-2;
      mCell.y=(int) random(2,mBoard.mRow-2);
    }
    else if(mDir==4)
    {
      mCell.x=(int) random(2,mBoard.mColumn-2);
      mCell.y=mBoard.mColumn-2;
    }
  }
  
  
  void move()
  {
    if(mCellExists)
    {
      mAge +=1;
      if(mAge%2 ==0)
      {
        if(mDir==1)
        {
          mCell.x+=1;
          mCell.y+=0;
        }
        else if(mDir==2)
        {
          mCell.x+=0;
          mCell.y+=1;
        }
        else if(mDir==3)
        {
          mCell.x+=-1;
          mCell.y+=0;
        }
        else if(mDir==4)
        {
          mCell.x+=0;
          mCell.y+=-1;
       }
      }
    }
    
    if(mCellExists&&mCell.x<1||mCell.x>mBoard.mColumn-2||mCell.y<1||mCell.y>mBoard.mRow-2)
    {
      despawn();
    }
  }
  
  int consume(Cell c)
  {
    mConsumed = false;
    int points = 0;
    if(mCellExists&&c.x == mCell.x && c.y == mCell.y)
    {
      despawn();
      points += mPoints;
      mConsumed = true;
    }
    return points;
  }
  
  void despawn()
  {
    mCellExists=false;
  }
  
  void draw()
  {
    PVector pxl = mBoard.mapToScreen(mCell);
    fill(255,255,0);
    //ellipse(pxl.x, pxl.y, mBoard.mCellPix, mBoard.mCellPix);
    if(mCellExists)
    {
      shape(mFruit, pxl.x, pxl.y, mSize*mBoard.mCellPix, mSize*mBoard.mCellPix);
    }
  }
  
  Cell coord()
   {
     return mCell;
   }
}
