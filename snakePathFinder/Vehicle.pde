class Vehicle { //<>//

  PVector lastVector;
  PVector desired, loc;
  float dir, theta;
  int spacing;
  color c;
  boolean noMoves = false;
  int turnCount = 0;

  Vehicle(PVector start, int spacing_) {
    spacing = spacing_;
    loc = start;
    dir = (int)random(0, 4);
    desired = new PVector();
    c = color(255);
    lastVector = new PVector(loc.x, loc.y);
  }

  void move(Tile[][] grid_) {
    //create angle from dir
    theta = map(dir, 0, 4, 0, TWO_PI);

    float x = spacing*cos(theta);
    float y = spacing*sin(theta);

    desired.x = loc.x + x;
    desired.y = loc.y + y;
    //
    desired.x/=spacing;
    desired.y/=spacing;
    if (desired.x >0 
      && desired.x < grid_.length 
      && desired.y > 0 
      && desired.y < grid_[0].length) 
    {
      if (!grid_[(int)desired.x][(int)desired.y].checked) {
        loc.x += x;
        loc.y += y;
        show();
        lastVector.x = desired.x*spacing;  //for the show 
        lastVector.y = desired.y*spacing;
        turnCount=0;
      } else if (grid_[(int)desired.x][(int)desired.y].checked) {
        if (turnCount==1) {
          dir -=1;
        }
        if (turnCount==2) {
          dir +=2;
        }
        turnCount++;
        if (dir == 4) {
          dir = 0;
        }
      }


      grid_[(int)loc.x/spacing][(int)loc.y/spacing].update();
    } else {
      if (turnCount==1) {
        dir -=1;
      }
      if (turnCount==2) {
        dir +=2;
      }
      turnCount++;
      if (dir == 4) {
        dir = 0;
      }
    }
  }

  void show() {
    stroke(c);
    line(loc.x, loc.y, lastVector.x, lastVector.y);
    //rect(loc.x, loc.y, spacing, spacing);
  }

  PVector findUnchecked(Tile[][] grid_) {
    ArrayList<PVector> possibles = new ArrayList<PVector>();
    PVector newLoc = new PVector(0, 0);
    for (int i = 0; i < grid_.length; i++) {
      for (int j = 0; j < grid_[0].length; j++) {
        if (grid_[i][j].checked == false) {
          newLoc =new PVector(random(0, grid_.length * spacing), random(0, grid_[0].length*spacing));
          possibles.add(newLoc);
        }
      }
    }
    println(possibles.size());
    return newLoc;
  }
}