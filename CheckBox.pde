public class CheckBox
{
    boolean checked;
    float x, y, width, height;
    String label;
    float padx = 7;
    
    CheckBox (float xx, float yy, float ww, float hh)
    {
        x = xx; y = yy; width = ww; height = hh;
        Interactive.add( this );
    }
    
    void mouseReleased ()
    {
        checked = !checked;
    }
    
    void draw ()
    {
        fill( 200 );
        rect( x, y, width, height );
        if ( checked )
        {
            fill(10, 220, 10);
            rect( x+4, y+4, width-8, height-8 );
        }
        fill( 255 );
        textAlign( LEFT );
        text( "", x+width+padx, y+height );
    }
    
    // this is a special inside test that includes the label text
    
    boolean isInside ( float mx, float my )
    {
        return Interactive.insideRect( x,y,width+padx+textWidth(label), height, mx, my );
    }
}
