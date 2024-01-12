// Import de la bibliothèque PeasyCam pour la manipulation de la caméra

import peasy.*;

PeasyCam cam;
Orb orb;
PVector gravity = new PVector(0, 0.05);
int segments = 40;
Ground[] ground = new Ground[segments];

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, width / 2, height / 2, 0, 500);
  orb = new Orb(50, 50, 0, 10);  // Position z ajustée pour être au-dessus du sol
  float[] peakHeights = new float[segments + 1];
  for (int i = 0; i < peakHeights.length; i++) {
    peakHeights[i] = height - 50 + random(-20, 20);  // Ajout de reliefs aléatoires au sol
  }
  float segs = segments;
  float widthFactor = 1.0;
  for (int i = 0; i < segments; i++) {
    ground[i] = new Ground(width / segs * i* widthFactor, peakHeights[i], width / segs * (i + 1), peakHeights[i + 1]);
  }
}

void draw() {
  background(0);

  // Move and display the orb
  orb.move();
  orb.display();
  orb.checkWallCollision();

  for (int i = 0; i < segments; i++) {
    orb.checkGroundCollision(ground[i]);
  }

  // Draw ground
  fill(127);
  for (int i = 0; i < segments; i++) {
    ground[i].display();
  }
}

void keyPressed() {
  // Gestion du mouvement de la caméra avec les touches du clavier
  if (key == 'z' || key == 'Z') {
    cam.rotateX(radians(5));  
  } else if (key == 's' || key == 'S') {
     cam.rotateX(radians(-5));
  } else if (key == 'q' || key == 'Q') {
    cam.rotateY(radians(5));  // Rotation vers la gauche
  } else if (key == 'd' || key == 'D') {
    cam.rotateY(radians(-5));  // Rotation vers la droite
  }else if (key == 'w' || key == 'W'){
    cam.setMinimumDistance(cam.getDistance() * 0.95);// Zoom indd
  } else if (key == 'x' || key == 'X') {
    cam.setMinimumDistance(cam.getDistance() * 1.05);  // Zoom out
  }
}
