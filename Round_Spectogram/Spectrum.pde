class Spectrum {
  SoundFile music;
  FFT fft;
  
  float angleIncrement;
  float angle;
  int radius;
  float[] spectrum = new float[radius];
  int startingAngle = 90;
  
  float ampHeight = 100;
  
  Spectrum(PApplet context, SoundFile music_, int rad) {
    radius = rad;
    music = music_;
    angleIncrement = 0;
    
    music.play();
    fft = new FFT(context, radius);
    fft.input(music);
  }
  
  void show() {
    fft.analyze();
    spectrum = reverseSpectrum(fft.spectrum);
    //spectrum = fft.spectrum;
    angleIncrement = 360 / (music.duration() * frameRate);
    
    graphics.beginDraw();
    graphics.push();
    graphics.translate(graphics.width/2, graphics.height/2);

    for (int i = 0; i < spectrum.length; i++) {
      float amp = spectrum[i];
      float a = map(i, 0, spectrum.length, 1, 3);
      println(a, i);
      
      PVector pixelPos = polar_to_cartesian(i, startingAngle-angle);
      float c = map(amp, 0, 1, 5, 510);
      c *= a;
      
      graphics.stroke(c);
      graphics.strokeWeight(1);
      graphics.point(pixelPos.x, pixelPos.y);
    }
    
    if (!(angle >= 360)) {
      angle += angleIncrement;
    }

    graphics.pop();
    graphics.endDraw();
    
    push();
    translate(width/2, height/2);
    rotate(radians(angle));
    image(graphics, -graphics.width/2, -graphics.height/2);
    pop();
    
    drawSpectrum(spectrum);
  }
  
  void drawSpectrum(float[] spectrum) {
    push();
    translate(width/2, height/2);
    stroke(255);
    noFill();
       
    beginShape();
    
    for (int i = 0; i < spectrum.length; i++) {
      float x = map(spectrum[i], 0, 1, 0, ampHeight);
      vertex(x, i);
    }
    
    endShape();
    pop();
  }
  
  float[] reverseSpectrum(float[] spectrum) {
    int length = spectrum.length;
    
    for(int i = 0; i < length/2 ; i++) {
      float swap = spectrum[i];
      spectrum[i] = spectrum[length-i-1];
      spectrum[length-i-1] = swap;
    }
    
    return spectrum;
  }
  
  PVector polar_to_cartesian(int rad, float angle) {
    float x = cos(radians(angle)) * rad;
    float y = sin(radians(angle)) * rad;
    
    return new PVector(x, y);
  }
}
