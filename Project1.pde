/* @pjs preload="wallpaper.jpg"; */

//import de.bezier.guido.*;

int num_tracks;
float sample_rate;
float max_cutoff;
int spectrum_length;
int num_bands;

Slider [] volume_sliders;
Slider speed_slider;
Slider [] cutoff_sliders;
Slider [] resonance_sliders;
CheckBox [] filter_checks;
Indicator [] spectrum_indicators;

String [] track_names;
float [] current_spectrum;
float [] temp_spectrum;

Maxim maxim;
AudioPlayer [] players;

PImage bg;
PFont font;

void setup()
{
  num_tracks = 7;
  num_bands = 10;
  sample_rate = 44100;
  spectrum_length = 1024;
  max_cutoff = sample_rate/4;
  
  temp_spectrum = new float[spectrum_length];
  current_spectrum = new float[spectrum_length];
  
  for (int i = 0; i < spectrum_length; i++){
    temp_spectrum[i] = 0;
    current_spectrum[i] = 0;
  }
  
  size(800,600);
  
  font = loadFont("Arial.ttf"); 
  bg = loadImage("wallpaper.jpg");
  background(bg);
  
  Interactive.make( this );
  maxim = new Maxim(this); 
  
  players = loadTracks(maxim, "track", ".wav", num_tracks);
  
  volume_sliders = new Slider[num_tracks];
  cutoff_sliders = new Slider[num_tracks];
  resonance_sliders = new Slider[num_tracks];
  
  filter_checks = new CheckBox[num_tracks];
  
  spectrum_indicators = new Indicator[num_bands];
  
  set_track_names();
  
  textFont(font, 28);
  fill(255);
  text("Volume", 115, 35);
  fill(255);
  text("Speed", 365, 420);
  fill(255);
  text("Filter", 280, 35);
  fill(255);
  text("Cut-off", 406, 35);
  fill(255);
  text("Resonance", 615, 35);
  fill(255);
  textFont(font, 20);
  
  for (int i = 0; i < num_tracks; i++){
    volume_sliders[i] = new Slider(70, 52 + i*50, width/4,16, 0);
    filter_checks[i] = new CheckBox(300, 52 + i*50, 20, 20);
    cutoff_sliders[i] = new Slider(350, 52 + i*50, width/4, 16, 0.45);
    resonance_sliders[i] = new Slider(580, 52 + i*50, width/4, 16, 0.45);
    
    players[i].setLooping(true);
    players[i].cue(0);
    
    text(track_names[i], 2, 67 + 50*i);
    fill(255);
  }
  
  for (int i = 0; i < num_bands; i++){
    spectrum_indicators[i] = new Indicator(150 + 50*i, 460, 50, 140);
  }
  speed_slider = new Slider(200, 430, width/2, 16, 0.5);
}

void set_track_names(){
  track_names = new String[num_tracks];
  track_names[0] = "Beat";
  track_names[1] = "Perc 1";
  track_names[2] = "Perc 2";
  track_names[3] = "Bass 1";
  track_names[4] = "Bass 2";
  track_names[5] = "Synth 1";
  track_names[6] = "Synth 2";
}

void draw(){
  imageMode(CENTER);
  
  for (int i = 0; i < num_tracks; i++){
    players[i].volume(volume_sliders[i].value);
    players[i].speed(map(speed_slider.value, 0, 1, 0.8, 1.2));
  
    if (players[i].isPlaying()) {
      if (filter_checks[i].checked){
        players[i].setFilter(
          map(pow(10, cutoff_sliders[i].value),
              1, 10, 0, max_cutoff),
          resonance_sliders[i].value
        );
      } else {
        players[i].setFilter(max_cutoff, 0);
      }
      temp_spectrum = players[i].getPowerSpectrum();
      for (int j = 0; j < spectrum_length; j ++){
        current_spectrum[j] += temp_spectrum[j];
      }
    } else {
      players[i].setAnalysing(true);
      players[i].play();
    }
  }
  update_indicators();
}

void update_indicators(){
  for (int b = 0; b < num_bands; b++){
    int start = pow(2, b);
    int end = pow(2, b+1);
    float temp = 0;
    for (int i = start; i < end; i++){
      temp += current_spectrum[i];
    }
    temp /= num_bands;
    temp /= (end - start);
    spectrum_indicators[b].value = map(log10(1-temp), 1.9, 1.6, 0, 1);
  }
  for (int i = 0; i < spectrum_length; i++){
    current_spectrum[i] = 0;
  }
}

float log10 (float x) {
  return (log(x) / log(10));
}
