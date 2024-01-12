class Orb {
  // Orb has positio and velocity
  PVector position;
  PVector velocity;
  float r;
  // A damping of 80% slows it down when it hits the ground
  float damping = 0.8;

  Orb(float x, float y,float z, float r_) {
    position = new PVector(x, y,z);
    velocity = new PVector(.5, 0,0);
    r = r_;
  }

 /* void move() {
    // Move orb
    velocity.add(gravity);
    position.add(velocity);
  }

  void display() {
    // Draw orb
    noStroke();
    fill(200);
    ellipse(position.x, position.y, r*2, r*2);
  }*/
 void move() {
    // Move orb
    velocity.add(gravity);
    position.add(velocity);

    // Bounce off ground
    if (position.z < r) {
      position.z = r;
      velocity.z *= -damping;
    }
  }

void display() {
    // Draw orb in 3D
    pushMatrix();
    translate(position.x, position.y, position.z);
    noStroke();
    fill(200);
    sphere(r);
    popMatrix();
  }
  // Check boundaries of window
  void checkWallCollision() {
    if (position.x > width-r) {
      position.x = width-r;
      velocity.x *= -damping;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -damping;
    }
  }

  void checkGroundCollision(Ground groundSegment) {

    // Get difference between orb and ground
    float deltaX = position.x - groundSegment.x;
    float deltaY = position.y - groundSegment.y;

    // Precalculate trig values
    float cosine = cos(groundSegment.rot);
    float sine = sin(groundSegment.rot);

    /* Rotate ground and velocity to allow 
     orthogonal collision calculations */
    float groundXTemp = cosine * deltaX + sine * deltaY;
    float groundYTemp = cosine * deltaY - sine * deltaX;
    float velocityXTemp = cosine * velocity.x + sine * velocity.y;
    float velocityYTemp = cosine * velocity.y - sine * velocity.x;

    /* Ground collision - check for surface 
     collision and also that orb is within 
     left/rights bounds of ground segment */
    if (groundYTemp > -r &&
      position.x > groundSegment.x1 &&
      position.x < groundSegment.x2 ) {
      // keep orb from going into ground
      groundYTemp = -r;
      // bounce and slow down orb
      velocityYTemp *= -1.0;
      velocityYTemp *= damping;
    }

    // Reset ground, velocity and orb
    deltaX = cosine * groundXTemp - sine * groundYTemp;
    deltaY = cosine * groundYTemp + sine * groundXTemp;
    velocity.x = cosine * velocityXTemp - sine * velocityYTemp;
    velocity.y = cosine * velocityYTemp + sine * velocityXTemp;
    position.x = groundSegment.x + deltaX;
    position.y = groundSegment.y + deltaY;
  }
}
