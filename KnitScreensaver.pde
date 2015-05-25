int time;
ArrayList<Wave> waveList;

void setup() {
  size(displayWidth, displayHeight);
  frameRate(60);
  stroke(32);
  waveList = new ArrayList<Wave>();
  waveList.add(new Wave(25, 180, 0.07, 3, displayHeight * 2 / 3, 10));
  waveList.add(new ColorWave(20, 200, 0.05, 2, displayHeight * 2 / 3, 10));
  waveList.add(new Wave(20, 250, 0.03, 3, displayHeight * 2 / 3, 10));
  waveList.add(new Wave(25, 300, 0.06, 2, displayHeight * 2/ 3, 10));
  waveList.add(new Wave(30, 400, -0.04, 2, displayHeight * 2 / 3, 10));
}

void draw() {
  time++;
  background(255);
  for (Wave wave : waveList) {
    wave.update();
  }
}

void mouseMoved() {
  if(time > 10)exit();
}

void mousePressed() {
  if(time > 10)exit();
}

void keyPressed() {
  if(time > 10)exit();
}

class Wave {
  float amplitude;
  float waveLength;
  float count;
  float countV;
  int lineWeight;
  float standardY;
  int partition;

  Wave() {
  }
  Wave(float amplitude, float waveLength, float countV, int lineWeight, float standardY, int partition) {
    this.amplitude = amplitude;
    this.waveLength = waveLength;
    count = 0;
    this.countV = countV;
    this.lineWeight = lineWeight;
    this.standardY = standardY;
    this.partition = partition;
  }

  void update() {
    count += countV;
    draw();
  }

  void draw() {
    noFill();
    strokeWeight(lineWeight);
    beginShape();
    vertex(-50, standardY);
    quadraticVertex(-40, standardY, -30, standardY + amplitude * sin(count));
    for (int i = 0; i < partition; i++) {
      float controlX = displayWidth / partition * (i + 0.5);
      float terminalX = displayWidth / partition * (i + 1);
      quadraticVertex(controlX, standardY + amplitude * sin(count + controlX / waveLength), terminalX, standardY + amplitude * sin(count + terminalX / waveLength));
    }
    quadraticVertex(displayWidth, standardY + amplitude * sin(count + displayWidth / waveLength), displayWidth + 30, standardY + amplitude * sin(count + (displayWidth + 30) / waveLength));
    endShape();
  }
}

class ColorWave extends Wave {
  color col = color(252, 200, 0);

  ColorWave(float amplitude, float waveLength, float countV, int lineWeight, float standardY, int partition) {
    super(amplitude, waveLength, countV, lineWeight, standardY, partition);
  }
  
  void draw() {
    fill(col);
    strokeWeight(lineWeight);
    beginShape();
    vertex(-50, standardY);
    quadraticVertex(-40, standardY, -30, standardY + amplitude * sin(count));
    for (int i = 0; i < partition; i++) {
      float controlX = displayWidth / partition * (i + 0.5);
      float terminalX = displayWidth / partition * (i + 1);
      quadraticVertex(controlX, standardY + amplitude * sin(count + controlX / waveLength), terminalX, standardY + amplitude * sin(count + terminalX / waveLength));
    }
    quadraticVertex(displayWidth, standardY + amplitude * sin(count + displayWidth / waveLength), displayWidth + 30, standardY + amplitude * sin(count + (displayWidth + 30) / waveLength));
    vertex(displayWidth + 30, displayHeight + 10);
    vertex(-50, displayHeight + 10);
    endShape(CLOSE);
  }
}


