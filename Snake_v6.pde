Game game;
int pixelSize = 20;
//Icon made by Vectors Market from www.flaticon.com

void setup()
{
  size(640,640);
  game = new Game(640/pixelSize,640/pixelSize,pixelSize);
  frameRate(12);
}


void draw()
{
  switch(game.state())
  {
    case 0:
      game.doStart();
    break;
    case 1:
      game.doPlay();
    break;
    case 2:
      game.doEnd();
    break;
    default:
    break;
  }
}


void keyPressed()
{ 
  if(keyCode == UP||key == 'w'||key == 'W')
    game.mSnake.setDirection(0, -1);
  else if(keyCode == DOWN||key =='s'||key == 'S')
    game.mSnake.setDirection(0, 1);
  else if(keyCode == LEFT||key =='a'||key == 'A')
    game.mSnake.setDirection(-1, 0);
  else if(keyCode == RIGHT||key =='d'||key == 'D')
    game.mSnake.setDirection(1, 0);
}
