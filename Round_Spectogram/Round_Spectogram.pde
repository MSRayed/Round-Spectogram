import processing.sound.*;


Spectrum spectrum;
SoundFile music;
int bands = 256;
PGraphics graphics;


void setup() {
  size(800, 800, P2D);
  //frameRate(60);
  
  music = new SoundFile(this, "music3.mp3");
  spectrum = new Spectrum(this, music, bands);
  graphics = createGraphics(bands*2, bands*2);
}

void draw() {
  background(0);
  
  spectrum.show();

}
