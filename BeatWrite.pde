import processing.io.*;

/**
  * This sketch plays an entire song so it may be a little slow to load.
  */

import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;

int ledPin =  17;    // LED connected to GPIO pin 17
int ledPin2 =  27;    // LED connected to GPIO pin 27
int ledPin3 =  22;    // LED connected to GPIO pin 22

float kickSize, snareSize, hatSize;

void setup() {
  fullScreen();
  
  minim = new Minim(this);
  
  song = minim.loadFile("data.mp3", 2048);
  song.play();
  // a beat detection object that is FREQ_ENERGY mode that 
  // expects buffers the length of song's buffer size
  // and samples captured at songs's sample rate
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  // set the sensitivity to 300 milliseconds
  // After a beat has been detected, the algorithm will wait for 300 milliseconds 
  // before allowing another beat to be reported. You can use this to dampen the 
  // algorithm if it is giving too many false-positives. The default value is 10, 
  // which is essentially no damping. If you try to set the sensitivity to a negative value, 
  // an error will be reported and it will be set to 10 instead. 
  beat.setSensitivity(100);  
  kickSize = snareSize = hatSize = 16;
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
  
  GPIO.pinMode(ledPin, GPIO.OUTPUT);    
  GPIO.pinMode(ledPin2, GPIO.OUTPUT);  
  GPIO.pinMode(ledPin3, GPIO.OUTPUT);  
}

void draw() {
  background(0);
  fill(255);
  if(beat.isKick()) {
      GPIO.digitalWrite(ledPin, GPIO.HIGH);   // set the LED on
      kickSize = 32;
  }
  if(beat.isSnare()) {
      GPIO.digitalWrite(ledPin2, GPIO.HIGH);   // set the LED on
      snareSize = 32;
  }
  if(beat.isHat()) {
      GPIO.digitalWrite(ledPin3, GPIO.HIGH);   // set the LED on
      hatSize = 32;
  }
  GPIO.digitalWrite(ledPin, GPIO.LOW);    // set the LED off
  GPIO.digitalWrite(ledPin2, GPIO.LOW);    // set the LED off
  GPIO.digitalWrite(ledPin3, GPIO.LOW);    // set the LED off
  textSize(kickSize);
  text("KICK", width/4, height/2);
  textSize(snareSize);
  text("SNARE", width/2, height/2);
  textSize(hatSize);
  text("HAT", 3*width/4, height/2);
  kickSize = constrain(kickSize * 0.95, 16, 32);
  snareSize = constrain(snareSize * 0.95, 16, 32);
  hatSize = constrain(hatSize * 0.95, 16, 32);
}

void stop() {
  // always close Minim audio classes when you are finished with them
  song.close();
  // always stop Minim before exiting
  minim.stop();
  // this closes the sketch
  super.stop();
}
