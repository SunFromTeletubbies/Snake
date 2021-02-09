class GreenFood// extends FoodMain
{
  Cell mCell [] = new Cell[9]; 
  Board mBoard;
  int mPointsPerFruit = 3;
  int mPointsPerPiece = 1;
  boolean mConsumed;
  int mEatenPiece;
  boolean mCreated;
  boolean mLastEaten;
  boolean mCellExists[] = new boolean [9]; 
  PShape mFruit;
  float mSize= 1;
  
  GreenFood (int xIn, int yIn, Board brd)
  {
    //super(brd);
    mCell[4] = new Cell(xIn,yIn);
    mBoard = brd;
    mFruit = loadShape("watermelon.svg");
    int idx = 0;
    while(idx<mCell.length)
    {
      for(int i=-1; i<2; i++)
      {
        for(int j=-1; j<2; j++)
        {
          mCell[idx]= new Cell (i+mCell[4].x, j+mCell[4].y);
          //despawn(i);
          //mCellExists[idx] = true;
          despawn(idx);
          idx+=1;
        }
      }
    }
  }
  
  void create()
  {
    mCreated=true;
    mCell[4].x=(int) random(3,mBoard.mColumn-3);
    mCell[4].y=(int) random(3,mBoard.mRow-3);
    int idx = 0;
    while(idx<mCell.length)
    {
      for(int i=-1; i<2; i++)
      {
        for(int j=-1; j<2; j++)
        {
          mCell[idx].x=(i+mCell[4].x);
          mCell[idx].y=(j+mCell[4].y);
          mCellExists[idx]=true;
          idx+=1;
        }
      }
    }
  }
  
   int consume (Cell c)
   {
     mConsumed = false;
     int points = 0;
     for(int i = 0; i<mCell.length; i++)
     {
       if(mCellExists[i]&&c.x==mCell[i].x&&c.y==mCell[i].y)
       {
          points += mPointsPerPiece;
          mEatenPiece=i;
          despawn(i);
          mConsumed = true;
       }
     }
     if(mEaten()&&mConsumed)
     {
       //create();
       points+=mPointsPerFruit;
     }
     return points;
   }
   
   boolean mEaten()
   {
     for(int i = 0; i<mCell.length; i++)
     {
       if(mCellExists[i])
       return false;
     }
     return true;
   }
   
   void despawn(int i)
   {
     mCellExists[i]=false;
   }
   
   
   void draw()
   {
    PVector pxl;
    fill(0,255,0);
    if(!mEaten())
    {
      pxl=mBoard.mapToScreen(mCell[4]);
        //ellipse(pxl.x, pxl.y, 2.95*mBoard.mCellPix, 2.95*mBoard.mCellPix);
      shape(mFruit,pxl.x, pxl.y, mSize*2.75*mBoard.mCellPix, mSize*3*mBoard.mCellPix);
    }
    for(int i=0; i<mCell.length; i++)
    {
      pxl = mBoard.mapToScreen(mCell[i]);
      if(!mCellExists[i]&&!mEaten())
      {
        noStroke();
        int tile = mCell[i].y*mBoard.mColumn+mCell[i].x;
        if(tile%2!=mCell[i].y%2)
          fill(232,240,248);
        else
          fill(217,230,243);
        rect(pxl.x, pxl.y, mBoard.mCellPix, mBoard.mCellPix);
      }
    }
   }
   
   Cell coord(int i)
   {
     return mCell[i];
   }
}
  
