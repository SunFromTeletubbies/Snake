//Board size, cell size
class Board
{
  //stat
  int mColumn=640;
  int mRow   =640;
  int mCellPix;
  int mYellowFoodDir;
  
  Board(int r, int c, int cSize)
  {
    mRow = r; mColumn = c; mCellPix = cSize;
  }
  
  int column() {return mColumn;}
  int row() {return mRow;}
  int cellSize() {return mCellPix;}
  
  PVector mapToScreen(Cell c)
  {
    PVector pxl = new PVector (c.x*mCellPix + 0.5 * mCellPix,
                               c.y*mCellPix + 0.5 * mCellPix);
    return pxl;
  }      
  
  void draw()
  {
    int tile=0;
    noStroke();
    for(int i = 0; i<mColumn; i++)
    {
      for(int j = 0; j<mRow; j++)
      {
        tile+=1;
        if(i==0||j==0||i==mColumn-1||j==mRow-1)
          fill(112,162,211);
        else if(tile%2==i%2)
          fill(232,240,248);
        else
          fill(217,230,243);
        rect(i*mCellPix+0.5*mCellPix, j*mCellPix+0.5*mCellPix, mCellPix, mCellPix);
      }
    }
  }
        
   
  boolean isObstacle (Cell c)
  {
    if(c.x==0||c.y==0||c.x==mColumn-1||c.y==mRow-1)
    {
      return true;
    }
    return false;
  }
}
