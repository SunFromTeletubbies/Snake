class Foods
{ 
  FoodMain mMain;
  Board mBoard;
  RedFood mRed;
  YellowFood mYellow;
  GreenFood mGreen;
  ArrayList<PointEffect> mEffects;
  int mRounds=0;
  
  int mSpecialSpawningInterval= (int) random(3,6);
  int mYellowSpawnChance = 5;
  int mGreenSpawnChance = 5;
  //int mBlueSpawnChance = 5;
  
  Foods(Board brd)
  {
     mBoard=brd;
     init();
  } 
  
  void init()
  {
    mMain = new FoodMain(mBoard);
    mRed = new RedFood(10,10, mBoard);
    mYellow = new YellowFood(10,10, mBoard);
    mGreen = new GreenFood(10, 10, mBoard);
    mEffects = new ArrayList<PointEffect>();
  }
  
  int consumeFood (Cell c)
  {
    int points;
    points = mRed.consume(c)+mYellow.consume(c)+mGreen.consume(c);
    return points;
  }
  
  void spawnSpecial()
  {
    mRounds=0;
    int takenSlots = 0;
    PVector spawnYellow, spawnGreen;
    spawnYellow = new PVector(takenSlots+1, mYellowSpawnChance+takenSlots);
    takenSlots += mYellowSpawnChance;
    spawnGreen = new PVector(takenSlots+1, mGreenSpawnChance+takenSlots);
    takenSlots += mGreenSpawnChance;
    /*spawnBlue = new PVector(takenSlots+1, mBlueSpawnChance+takenSlots);
    takenSlots += mBlueSpawnChance;*/
    
    int drawnNumber = (int) random(0, takenSlots)+1;
    if(drawnNumber >= spawnYellow.x && drawnNumber<=spawnYellow.y)
    {
      mYellow.create();
    }
    else if(drawnNumber >= spawnGreen.x && drawnNumber <= spawnGreen.y)
    {
      mGreen.create();
    }
    /*else if(drawnNumber >= spawnBlue.x && drawnNumber <= spawnBlue.y)
    {
      mBlue.create();
    }*/
  }
  
  void spawn()
  { 
    if(mRed.mConsumed)
    {
      mRed.create();
    }
    notCreated();
    if(mRed.mConsumed)
    {
      mRounds+=1;
      if(mRounds==mSpecialSpawningInterval)
      {
        spawnSpecial();
        mSpecialSpawningInterval=(int) random(3,6);
      }
    }
    if(mYellow.mCellExists||!mGreen.mEaten())
    {
      mRounds=0;
    }
    sameTileSpawnFoods();
  }
  
  void update()
  {
    move();
    draw();
  }
  
  void updateEffect()
  {
    checkCreateEffect();
   for(int i = 0; i<mEffects.size(); i++)
   {
     if(mEffects.get(i).checkDelete())
     {
       mEffects.remove(i);
       return;
     }
     mEffects.get(i).update();
   }
  }
  
  void sameTileSpawnFoods()
  { 
    if(mRed.mCreated)
    {
      if(mRed.mCell.x==mYellow.mCell.x&&mRed.mCell.y==mYellow.mCell.y)
      {
        mRed.create();
      }
      for(int i = 0; i<mGreen.mCell.length; i++)
      {
        if(mRed.mCell.x==mGreen.mCell[i].x&&mRed.mCell.y==mGreen.mCell[i].y)
        {
          mRed.create();
        }
      }
    }
    if(mYellow.mCreated)
    {
      if(mRed.mCell.x==mYellow.mCell.x||mRed.mCell.y==mYellow.mCell.y)
      {
        mYellow.create();
      }
      for(int i = 0; i<mGreen.mCell.length; i++)
      {
        if(mYellow.mCell.x==mGreen.mCell[i].x&&mYellow.mCell.y==mGreen.mCell[i].y)
        {
          mYellow.create();
        }
      }
    }
    if(mGreen.mCreated)
    {
      for(int i = 0; i<mGreen.mCell.length; i++)
      {
        if(mRed.mCell.x==mGreen.mCell[i].x&&mRed.mCell.y==mGreen.mCell[i].y)
        {
          mGreen.create();
        }
        if(mYellow.mCell.x==mGreen.mCell[i].x&&mYellow.mCell.y==mGreen.mCell[i].y)
        {
          mGreen.create();
        }
      }
    }
  }
  
  void notCreated()
  {
    mRed.mCreated=false; 
    mYellow.mCreated=false; 
    mGreen.mCreated=false;
  }
  
  void draw()
  {
    mRed.draw();
    mYellow.draw();
    mGreen.draw();
    //mBlue.draw();
  }
  
  void move()
  {
    mYellow.move();
  }
  
  void checkCreateEffect()
  {
    PointEffect mNewEffect;
    if(mRed.mConsumed)
    {
      mNewEffect = new PointEffect(mRed.coord().x, mRed.coord().y, mRed.mPoints, mBoard);
      mEffects.add(0, mNewEffect);
    }
    if(mYellow.mConsumed)
    {
      mNewEffect = new PointEffect(mYellow.coord().x, mYellow.coord().y, mYellow.mPoints, mBoard);
      mEffects.add(0, mNewEffect);
    }
    if(mGreen.mConsumed)
    {
      mNewEffect = new PointEffect(mGreen.coord(mGreen.mEatenPiece).x, mGreen.coord(mGreen.mEatenPiece).y, mGreen.mPointsPerPiece, mBoard);
      mEffects.add(0, mNewEffect);
    }
    if(mGreen.mEaten()&&mGreen.mConsumed)
    {
      mNewEffect = new PointEffect(mGreen.coord(4).x, mGreen.coord(4).y, mGreen.mPointsPerFruit, mBoard);
      mEffects.add(0, mNewEffect);
    }
  }
  
}
