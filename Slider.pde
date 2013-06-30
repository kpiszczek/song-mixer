public class Slider
{
    float x, y, width, height;
    float valueX = 0, value;
    
    Slider ( float xx, float yy, float ww, float hh, float vv) 
    {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        
        value = vv;
        
        valueX = map(value, 0,1, x, x+width);
    
        // register it
        Interactive.add( this );
    }
    
    // called from manager
    void mouseDragged ( float mx, float my )
    {
        valueX = mx - height/2;
        
        if ( valueX < x ) valueX = x;
        if ( valueX > x+width-height ) valueX = x+width-height;
        
        value = map( valueX, x, x+width-height, 0, 1 );
    }

    void draw () 
    {  
      
        fill( 100 );
        stroke(0);
        rect(x, y, width, height, 10);
        line(x+10, y+height/2, x+width-10, y+height/2);
        stroke(40);
        
        fill( 175 );
        stroke(0);
        rect( valueX, y, height, height, 10 );
        line(valueX+6, y+3, valueX+6, y+height-3);
        stroke(0);
        line(valueX+10, y+3, valueX+10, y+height-3);
        stroke(0);
    }
}

