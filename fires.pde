/*
Authors: Jimmy Sherman, Kristina SPring, Myanna Harris
Assignment: Final - forest fires
*/

import java.util.Arrays;

Table fires;
PImage img;

//only indexes 1-9 are used for sake of clarity with the map
int num_fires[][] = new int[10][10];
void setup(){
  size(1200, 950, P3D);
  img = loadImage("monte.png");
  fires = loadTable("forestfires.csv");
  fillFire();
}

void draw(){
  background(255);
  image(img, 250, 0); 
  makeColorKey();
  colorMap();
  drawSubVis1();
  drawSubVis2();
}

//Desc: colors the map using the colors from the color key and values from the num_fires array
void colorMap(){
  int i, j;
  int init_rec_x = 250;
  int rec_x = 250;
  int rec_y = 0;
  int rec_h = 50;
  int rec_w = 73;
  int mid_rec_w = 79;
  strokeWeight(1);
  stroke(0);
  for(i = 1; i < 10; i++)
    {
      for(j = 1; j < 10; j++)
      {
         fill(getRed(num_fires[i][j]), 175);
         
         if (j == 1){
           if (i == 9){
             rect(rec_x, rec_y, rec_w, rec_h - 10);
             rec_x += rec_w;
           }
           else{
             rect(rec_x, rec_y, rec_w, rec_h);
             rec_x += rec_w;
           }
         }
         
         if ( j > 1 && j < 9){
           if (i == 9){
             rect(rec_x, rec_y, mid_rec_w, rec_h - 10);
             rec_x += mid_rec_w;
           }
           else{
             rect(rec_x, rec_y, mid_rec_w, rec_h);
             rec_x += mid_rec_w;
           } 
         }
         
         if (j == 9){
           if (i == 9){
             rect(rec_x, rec_y, rec_w - 12, rec_h - 10);
             rec_x += rec_w - 12;
           }
           else{
             rect(rec_x, rec_y, rec_w - 12, rec_h);
             rec_x += rec_w - 12;
           }
         }
         

      }
      
      rec_x = init_rec_x; //+ (rec_h * i);
      rec_y = rec_y + rec_h - 2;

    }
  
}

//Desc: creates the color coded circles to the right of the map 
void makeColorKey(){
  noStroke();
  fill(#ff4d4d, 175);
  ellipse(1050, 50, 60, 60);
  fill(#ff1a1a, 175);
  ellipse(1050, 125, 60, 60);
  fill(#ff0000, 175);
  ellipse(1050, 200, 60, 60);
  fill(#e60000, 175);
  ellipse(1050, 275, 60, 60);
  fill(#cc0000, 175);
  ellipse(1050, 350, 60, 60);
  
  
  /*fill(#ff0000, 100);
  ellipse(1050, 50, 60, 60);
  fill(#e50000, 100);
  ellipse(1050, 125, 60, 60);
  fill(#cc0000, 100);
  ellipse(1050, 200, 60, 60);
  fill(#b20000, 100);
  ellipse(1050, 275, 60, 60);
  fill(#990000, 100);
  ellipse(1050, 350, 60, 60);*/
  
  
  fill(255);
  textSize(15);
  text("0-10", 1034,  55);
  text("11-20", 1030, 130);
  text("21-30", 1030, 205);
  text("31-40", 1030, 280);
  text("41-50+", 1023, 355);
  
  
}

//Desc: takes an integer and assigns the correct shade of red corresponding to the color key
int getRed(int num){
  if( num > -1 && num < 11)
    return #FF9999;
  if( num >= 11 && num < 21)
    return #ff7f7f;
  if( num >= 21 && num < 31)
    return #ff4c4c;
  if( num >= 31 && num < 41)
    return #ff3232;
  if( num >= 41)
    return #ff0000;
  
  
  return 0;
}


//Desc: fills the num_fire array with values corresponding to howw many times an x-y pairing occurs in the data
void fillFire(){
  int i, j, x, y;
  int k = fires.getRowCount();
  // initialize values to zero
  for (i = 0; i < 10; i++){
    Arrays.fill(num_fires[i], 0);    
  }
  
  for (j = 0; j < k; j++){
    x = fires.getInt(j, 0);
    y = fires.getInt(j, 1);
    num_fires[x][y] = num_fires[x][y] + 1;
    
  }
 
 /* for(i = 1; i < 10; i++)
    {
      for(j = 1; j < 10; j++)
      {
         System.out.println(num_fires[i][j]);
      }

    }*/
}

void drawSubVis1(){
  
  
}


void drawSubVis2(){
  
  
}
