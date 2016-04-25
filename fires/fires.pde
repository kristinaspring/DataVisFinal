/*
Authors: Jimmy Sherman, Kristina SPring, Myanna Harris
Assignment: Final - forest fires
*/

import java.util.Arrays;

Table fires;
PImage img;

//only indexes 1-9 are used for sake of clarity with the map
int num_fires[][] = new int[10][10];
int rec_pos[][][] = new int[10][10][4];
float wind[][] = new float[81][52];
float temp[][] = new float[81][52];
int sel_i, sel_j, n;

//for bar graph
int[] data=new int[1];

void setup(){
  size(1200, 600, P3D);
  img = loadImage("monte.png");
  fires = loadTable("forestfires.csv");
  fillFire();
  setUpWind();
  setUpTemp();
  num_fires[0][0] = 0;
  sel_i = 1;
  sel_j = 1;
  n = -1;
}

void draw(){
  background(255);
  image(img, 5, 0); 
  makeColorKey();
  colorMap();
  drawText();
  drawSubVis1();
  drawSubVis2();
}


void drawText(){
  fill(0);
  textSize(30);
  text("Sector  " + Integer.toString(sel_j) + "," + Integer.toString(sel_i), 100,  450);
  text("Number of Fires:  " +  Integer.toString(num_fires[sel_j][sel_i]) , 160,  485);
  
}
//Desc: colors the map using the colors from the color key and values from the num_fires array
void colorMap(){
  int i, j;
  int init_rec_x = 5;
  int rec_x = 5;
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
         fill(getRed(num_fires[j][i]), 175);
         
         if (sel_j == j && sel_i == i){
           stroke(#002DA5);
           strokeWeight(2);
         }
         else
         {
           stroke(0);
           strokeWeight(1);
         }
         
         
         if (j == 1){
           if (i == 9){
             rect(rec_x, rec_y, rec_w, rec_h - 10);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + rec_w;
             rec_pos[i][j][2] = rec_y + rec_h - 10;
             rec_pos[i][j][3] = rec_y;
             
             rec_x += rec_w;
           }
           else{
             rect(rec_x, rec_y, rec_w, rec_h);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + rec_w;
             rec_pos[i][j][2] = rec_y + rec_h;
             rec_pos[i][j][3] = rec_y;
             
             rec_x += rec_w;
           }
         }
         
         if ( j > 1 && j < 9){
           if (i == 9){
             rect(rec_x, rec_y, mid_rec_w, rec_h - 10);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + mid_rec_w;
             rec_pos[i][j][2] = rec_y + rec_h - 10;
             rec_pos[i][j][3] = rec_y;
             
             rec_x += mid_rec_w;
           }
           else{
             rect(rec_x, rec_y, mid_rec_w, rec_h);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + mid_rec_w;
             rec_pos[i][j][2] = rec_h + rec_y;
             rec_pos[i][j][3] = rec_y;
             rec_x += mid_rec_w;
           } 
         }
         
         if (j == 9){
           if (i == 9){
             rect(rec_x, rec_y, rec_w - 12, rec_h - 10);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + (rec_w - 12);
             rec_pos[i][j][2] = (rec_h - 10) + rec_y;
             rec_pos[i][j][3] = rec_y;
             rec_x += rec_w - 12;
           }
           else{
             rect(rec_x, rec_y, rec_w - 12, rec_h);
             rec_pos[i][j][0] = rec_x;
             rec_pos[i][j][1] = rec_x + (rec_w - 12);
             rec_pos[i][j][2] = rec_h + rec_y;
             rec_pos[i][j][3] = rec_y;
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
  ellipse(50, 550, 60, 60);
  fill(#ff1a1a, 175);
  ellipse(150, 550, 60, 60);
  fill(#ff0000, 175);
  ellipse(250, 550, 60, 60);
  fill(#e60000, 175);
  ellipse(350, 550, 60, 60);
  fill(#cc0000, 175);
  ellipse(450, 550, 60, 60);
  
  
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
  textAlign(CENTER,CENTER);
  textSize(15);
  text("0-10", 50,  550);
  text("11-20", 150, 550);
  text("21-30", 250, 550);
  text("31-40", 350, 550);
  text("41-50+", 450, 550);
  
  
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


//Desc: fills the num_fire array with values corresponding to howw many times an x-y pairing occurs in the data.
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

void setUpWind() {
  int s = fires.getRowCount();
  int x = 1;
  int y = 1;
  int tn = 0;
  for (int i=0; i<81; i++) {
    for (int j=0; j<52; j++) {
      wind[i][j] = -1;
    }
  }
  for (int i=1; i<s; i++) {
    y = fires.getInt(i, 0);
    x = fires.getInt(i, 1);
    tn = (x-1)*9+y-1;
    for (int j=0; j<52; j++) {
      if (wind[tn][j] == -1) {
        wind[tn][j] = fires.getFloat(i,10);
        j=52;
      }
    }
  }
}


void setUpTemp() {
  int s = fires.getRowCount();
  int x = 1;
  int y = 1;
  int tn = 0;
  for (int i=0; i<81; i++) {
    for (int j=0; j<52; j++) {
      temp[i][j] = -1;
    }
  }
  for (int i=1; i<s; i++) {
    y = fires.getInt(i, 0);
    x = fires.getInt(i, 1);
    tn = (x-1)*9+y-1;
    for (int j=0; j<52; j++) {
      if (temp[tn][j] == -1) {
        temp[tn][j] = fires.getFloat(i,8);
        j=52;
      }
    }
  }
}


//Desc: Createes buttons for all the sectors and when a ssector is clicked causes the subvisdata to change to reflect that data.
void mousePressed(){
  
  int i,j;
 for(i = 1; i < 10; i++)
    {
      for(j = 1; j < 10; j++)
      { 
         if((mouseX >= rec_pos[i][j][0]) && (mouseX <= rec_pos[i][j][1]) && (mouseY <=  rec_pos[i][j][2]) && (mouseY >=  rec_pos[i][j][3])) {
            //Right now just prints but can be used to change data for the subvisuals
            sel_i = i;
            sel_j = j;
            n = (i-1)*9+j-1;
            fill(0);
            textAlign(CENTER,CENTER);
            textSize(30);
            text("Sector", 50,  450);
            //changeSubVisData();
         } 
      }
    }
  
}


void drawSubVis1(){
  int beginx = 740;
  int beginy = 30;
  int subvisw = 400;
  int subvish = 250;
  fill(0);
  stroke(150,0,0);
  drawSub1Axis();
  if (n>-1) {
    boolean done = false;
    int i = 0;
    while (!done) {
      if (wind[n][i]>-1) {
        float xcoord = beginx+temp[n][i]*(subvisw-10)/35;
        float ycoord = beginy+subvish-10-wind[n][i]*(subvish-10)/10;
        line(xcoord-3,ycoord,xcoord+3,ycoord);
        line(xcoord,ycoord-3,xcoord,ycoord+3);
        i++;
        if (i>=52) {
          done = true;
        }
      }
      else {
        done = true;
      }
    }
  }
  
}

void drawSub1Axis() {
  int beginx = 740;
  int beginy = 30;
  int subvisw = 400;
  int subvish = 250;
  line(beginx+4,beginy,beginx+4,beginy+subvish-10);
  line(beginx+4,beginy+subvish-10,beginx+4+subvisw,beginy+subvish-10);
  textSize(12);
  text("Temperature",beginx+subvisw/2,beginy+subvish+15);
  pushMatrix();
  translate(beginx-27,beginy+subvish/2);
  rotate(-PI/2);
  text("wind",0,0);
  popMatrix();
  for (int i=0;i<11;i++) {
    int ycoord = beginy+subvish-10-i*(subvish-10)/10;
    line(beginx-4,ycoord,beginx+4,ycoord);
    textSize(10);
    text(i+".0",beginx-7,ycoord-7);
  }
  for (int i=0;i<8;i++) {
    int ycoord = beginy+subvish-10;
    int xcoord = beginx+4+i*5*(subvisw-10)/35;
    line(xcoord,ycoord,xcoord,ycoord+8);
    textSize(10);
    text(i*5,xcoord,ycoord+12);
    }
}


void drawSubVis2(){
  String[] label = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
  int beginx = 740;
  int beginy = 310;
  int subvisw = 400;
  int subvish = 250;
  int margin = 400/12;
  fill(0);
  //rect(740,320,400,250);
  strokeWeight(1);
  stroke(0);
  line(beginx,beginy,beginx,beginy+subvish); //vertical line
  line(beginx,beginy+subvish,beginx+subvisw,beginy+subvish); //horizontal line
  int x = 0;
  textSize(14);
  for(int i=beginx+margin/2; i<beginx+subvisw;i+=margin){
  line(i,beginy+subvish-5,i,beginy+subvish+5); //vertical tick marks
  text(label[x],i-1,beginy+subvish+10);
  x++;
  }
  text("Month",beginx+subvisw/2,beginy+subvish+30);
}

//referneces https://forum.processing.org/one/topic/create-multiple-buttons-in-processing.html