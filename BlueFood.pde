class BlueFood
{
  Cell mCell;
  Board mBoard;
  int mPoints = 2;
  boolean mConsumed;
  boolean mCellExists;
  
  BlueFood (int xIn, int yIn, Board brd)
  {
    mCell = new Cell(xIn,yIn);
    mBoard=brd;
    create();
  }
  
  void create()
  {
    mCellExists=true;
    mCell.x=(int) random(1,mBoard.mColumn-1);
    mCell.y=(int) random(1,mBoard.mRow-1);
  }
  
  int consume(Cell c)
  {
    mConsumed = false;
    int points = 0;
    if(c.x == mCell.x && c.y == mCell.y)
    {
      create();
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
    fill(0,0,255);
    ellipse(pxl.x, pxl.y, mBoard.mCellPix, mBoard.mCellPix);
  }
  
}
  
