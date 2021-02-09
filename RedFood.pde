class RedFood extends FoodMain
{
  Cell mCell;
  Board mBoard;
  int mPoints = 3;
  boolean mConsumed;
  boolean mCreated;
  boolean mCellExists;
  PShape mFruit;
  float mSize= 1;
  
  RedFood (int xIn, int yIn, Board brd)
  {
    super(brd);
    mCell = new Cell(xIn,yIn);
    mFruit = loadShape("apple.svg");
    mBoard=brd;
    create();
  }
  
  void create()
  {
    mCreated=true;
    mCellExists=true;
    mCell.x=(int) random(2,mBoard.mColumn-2);
    mCell.y=(int) random(2,mBoard.mRow-2);
  }
  
  int consume(Cell c)
  {
    mConsumed=false;
    int points = 0;
    if(c.x == mCell.x && c.y == mCell.y)
    {
      points += mPoints;
      mConsumed=true;
    }
    return points; //<>//
  }
  
  void despawn()
  {
     mCellExists=false;
  }

  void draw()
  {
    PVector pxl = mBoard.mapToScreen(mCell);
    fill(255,0,0);
    shapeMode(CENTER);
    //ellipse(pxl.x, pxl.y, mBoard.mCellPix, mBoard.mCellPix);
    shape(mFruit, pxl.x, pxl.y, mSize*mBoard.mCellPix, mSize*mBoard.mCellPix);
  }
  
  Cell coord()
  {
    return mCell;
  }
}
  
