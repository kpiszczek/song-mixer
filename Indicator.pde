public class Indicator {
  float value;
  float x, y, width, height;
  float block_height;
  
  Indicator (float xx, float yy, float ww, float hh){
    x = xx;
    y = yy;
    width = ww;
    height = hh;
    block_height = height/10;
    value = 0;
    Interactive.add(this);
  }
  
  void draw(){
    fill(100);
    rect(x,y,width,height);
    fill(255);
    for (int i = 0; i < min((int)(10*value), 10); i++){
      if (i < 7){
        fill(0, 255, 0);
      } else if (i < 9) {
        fill(255, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rect(x, y + (9-i)*block_height, width, block_height);
    }
    value = 0;
  }
}
