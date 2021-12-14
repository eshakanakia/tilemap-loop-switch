PImage tileset;
//tiles are 32px x 32px
//the tileset contains 1 row of 7 tiles

int [][] tilemap = {{2, 4, 5},
                    {1, -1, 1},
                    {0, 4, 3}};

void setup() {
  tileset = loadImage("simple-tileset-2.png");
  size(384, 384);
  noSmooth();
}

void draw() {
  background(220);
  for (int i = 0; i < 8; i++) { //row
    for (int j = 0; j < 8; j++) { //column
      rect(i*40, j, 50, 50);
      //copy(tileset, tilemap[i][j]*32, 0, 32, 32, 32*4*j, 32*4*i, 32*4, 32*4);
    }
  }

  //array indicies
  int tileColumn = mouseX/128;
  int tileRow = mouseY/128;
  //these are pixel coordinates
  float tileX = tileColumn*128;
  float tileY = tileRow*128;
  
  
int[] emptyNeighbor = getEmptyNeighbor(tileRow, tileColumn, tilemap); 
 println(emptyNeighbor[0],emptyNeighbor[1]);
  //if you click on the tile the mouse is over and it has an empty neighbor swap them
  if (mousePressed && emptyNeighbor[0] != -1) {
    //set the empty one equal to the one your hovering over (whatever # is in the array)
     tilemap[emptyNeighbor[0]][emptyNeighbor[1]] = tilemap[tileRow][tileColumn];
    //set the one hovering over to -1
    tilemap[tileRow][tileColumn] = -1;
    //swap the tile the mouse is over with the empty tile
  }

  

  noStroke();
  fill(220,128);
  rect(tileX, tileY, 32*4, 32*4);
}

int[] getEmptyNeighbor(int diffRow, int diffColumn, int[][] grid) {
  int[] results = {-1,-1};
  if(diffColumn > 0 && grid[diffRow][diffColumn-1] == -1){ //W
    results[0] = diffRow;
    results[1] = diffColumn-1;
  }

  if(diffRow > 0 && grid[diffRow-1][diffColumn] == -1){//N
    results[0] = diffRow-1;
    results[1] = diffColumn;
  }

  if(diffColumn < 2 && grid[diffRow][diffColumn+1] == -1){ //E
  results[0] = diffRow;
  results[1] = diffColumn+1;
  }

  if(diffRow < 2 && grid[diffRow+1][diffColumn] == -1){ //S
    results[0] = diffRow+1;
    results[1] = diffColumn;
  }

  //test all the neighbors to see if any of them contain -1
  //if a neighbor contains -1 then return that neighbors coordinates
  //if not return null
  return results;
}
