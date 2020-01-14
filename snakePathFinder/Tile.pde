class Tile {

  PVector loc;
  boolean checked;

  Tile(float x, float y) {
    loc = new PVector(x,y);
    checked = false;
  }
  
  boolean check(){
    
    return checked;
  }
  void update(){
    
    checked = true;
  }
}