// Script made by Timo Bickert in 2017
// License see GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007

// This script creates a 3D color cube to explain the LAB color space.
// The script was a training 
// inspired by the work of Daniel Shifferman

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam;
ArrayList<LABColor> p;
int LStep = 4;


public void setup() {
  size(600, 600, P3D);
  translate(width/2, height/2);
  cam = new PeasyCam(this, 100, 0, 0, 400);
  cam.setActive(true);
  p = new ArrayList<LABColor>();

  for (int L = 0; L <= 100; L += LStep) {
    for (int a = -100; a <= 100; a += LStep*2) {
      for (int b = -100; b <= 100; b += LStep*2) {
        LABColor current = new LABColor(L, a, b);
        p.add(current);
      }
    }
  }
  println("Setup done: " + p.size() + " colors were maped");
}

public void draw() {
  background(255);
  for (int i = 0; i < p.size(); i++) {
    noStroke();
    fill((float)p.get(i).getColor().get("RGB_r"), (float)p.get(i).getColor().get("RGB_g"), (float)p.get(i).getColor().get("RGB_b"));
    translate( (float)p.get(i).getColor().get("LAB_L") * 2, (float)p.get(i).getColor().get("LAB_a"), (float)p.get(i).getColor().get("LAB_b")); 
    box(LStep);
    translate(-(float)p.get(i).getColor().get("LAB_L") * 2, -(float)p.get(i).getColor().get("LAB_a"), -(float)p.get(i).getColor().get("LAB_b"));
  }
}