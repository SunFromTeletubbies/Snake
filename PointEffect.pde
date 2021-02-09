class PointEffect
{
  int mX, mY;
  float mVY=-1;
  int mScore;
  int mAge;
  boolean mExists = true;
  Board mBoard;
  
  PointEffect(int x, int y, int score, Board brd)
  {
    mX=x; mY=y;
    mScore=score;
    mBoard = brd;
  }
  
  void move()
  {
    mY+=mVY;
    mAge+=1;
    checkDelete();
  }
  
  void draw()
  {
    PVector pxl = mBoard.mapToScreen(coord());
    textSize(20);
    fill(0,1000-150*mAge);
    text("+"+mScore,pxl.x,pxl.y);
  }
  
  boolean checkDelete()
  {
    if(mAge>50&&mExists)
    {
      return true;
    }
    return false;
  }
  
  void update()
  {
    checkDelete();
    move();
    draw();
  }
  
  Cell coord()
  {
    Cell cell = new Cell(mX, mY);
    return cell;
  }
}
