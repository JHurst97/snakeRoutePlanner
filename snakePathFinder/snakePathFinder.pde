//each vehicle always wants to turn to the right, 
//if that space is occupied, it will move forward.

void setup() {
  frameRate(30);
  background(0);
  size(1000, 1000);
  res = 20;
  rows = width/res;
  cols = height/res;
  grid = new Tile[cols][rows];
  totalVeh = 7;
  vehicles = new Vehicle[totalVeh];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Tile(i*res, j*res);
    }
  }

  for (int i = 0; i < vehicles.length; i++) {

    vehicles[i] = new Vehicle(new PVector((int)random(cols)*res, (int)random(rows)*res), res);
  }
}

Tile[][] grid;
Vehicle[] vehicles;
int rows, cols, res, totalVeh;

void draw() {
  //println(frameRate);
  strokeWeight(res/2);
  /*show grid
   for (int i = 0; i < cols; i++) {
   for (int j = 0; j < rows; j++) {
   rect(grid[i][j].loc.x,grid[i][j].loc.y,res,res);
   }
   }*/

  //each vehicle
  for (int v = 0; v < vehicles.length; v++) {
    vehicles[v].move(grid);
    if (vehicles[v].turnCount > 4) {
      vehicles[v] = new Vehicle(new PVector((int)random(cols)*res, (int)random(rows)*res), res);
    }
  }
}

PVector checkValidPlace(int v_) {
  float x = 0;
  float y = 0;
  PVector newLoc = new PVector(0, 0);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (!grid[i][j].checked) {
        newLoc = new PVector(grid[i][j].loc.x, grid[i][j].loc.y);
      }
    }
  }
  println(newLoc.x +"      "+ newLoc.y);
  return newLoc;
}

void mouseClicked(){
  int total = 0;
  int filled = 0;
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(grid[i][j].checked){
        filled++;
      }
      total++;
    }
  }
  
  println("total: "+total+" filled: "+filled);
}