class Ground {
  float x1, y1, x2, y2, z;
  float x, y, len, rot;

  Ground(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    z = 0;
    x = (x1 + x2) / 2;
    y = (y1 + y2) / 2;

    // Ajustez la largeur du sol ici (par exemple, multipliez par 2 pour l'élargir)
    len = dist(x1, y1, x2, y2);

    rot = atan2((y2 - y1), (x2 - x1));
  }

  void display() {
    pushMatrix();
    translate(x, y, z);
    rotateZ(rot);
    box(len, 10, 10 + abs(y1 - y2));  // Réduction de la hauteur du sol
    popMatrix();
  }
}
