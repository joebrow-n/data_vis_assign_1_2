// 1.414
Table table;
int N;
float[] lonc, latc, lont, lonp, latp;
String[] city, mon, dir;
int[] temp, days, surv, div;
PFont f, f_outline;
PImage map;
int survivor_ratio = 3500;
color attack, retreat;

void setup() {
  size(1231, 795);
  
  table = loadTable("minard-data.csv", "header");
  N = table.getRowCount();
  
  lonc = new float[21];
  latc = new float[21];
  city = new String[21];
  
  for (int i = 0; i < 21; i++) {
    TableRow row = table.getRow(i);
    lonc[i] = row.getFloat("LONC");
    latc[i] = row.getFloat("LATC");
    city[i] = row.getString("CITY");
  }
  
  lont = new float[10];
  temp = new int[10];
  days = new int[10];
  mon = new String[10];
  
  for (int i = 0; i < 10; i++) {
    TableRow row = table.getRow(i);
    lont[i] = row.getFloat("LONT");
    temp[i] = row.getInt("TEMP");
    days[i] = row.getInt("DAYS");
    mon[i] = row.getString("MON");
  }
  
  lonp = new float[48];
  latp = new float[48];
  surv = new int[48];
  dir = new String[48];
  div = new int[48];
  
  for (int i = 0; i < 48; i++) {
    TableRow row = table.getRow(i);
    lonp[i] = row.getFloat("LONP");
    latp[i] = row.getFloat("LATP");
    surv[i] = row.getInt("SURV");
    dir[i] = row.getString("DIR");
    div[i] = row.getInt("DIV");
  }
  
  f = createFont("AvenirLTStd-Black.otf",22,true);
  f_outline = createFont("AvenirLTStd-Black.otf",25,true);
  
  map = loadImage("minard-map-1.jpg");
  
  attack = color(230, 153, 0);
  retreat = color(0, 0, 0);
}

void draw() {
  background(148,209,165);
  image(map, 0, 0);
  draw_temp_graph();
  draw_survivors(); //<>//
  draw_cities();
}

void draw_survivors() {
  int i = 46;
  
  while (i >= 0) {  
    if (div[i] == div[i+1]) {
      stroke(retreat);
      if (dir[i].equals("A")) {
        stroke(attack);
      }
      strokeWeight(surv[i]/survivor_ratio);
      line(convert_lon(lonp[i]), convert_lat(latp[i]), convert_lon(lonp[i+1]), convert_lat(latp[i+1]));
      
    }
    else {
      i--;
      stroke(retreat);
      if (dir[i].equals("A")) {
        stroke(attack);
      }
      strokeWeight(surv[i]/survivor_ratio);
      line(convert_lon(lonp[i]), convert_lat(latp[i]), convert_lon(lonp[i+1]), convert_lat(latp[i+1]));
    }
    i--;
  }
}

void draw_cities() {
  for (int i = 0; i < 21; i++) {
    stroke(255, 255, 255);
    strokeWeight(10);
    point(convert_lon(lonc[i]), convert_lat(latc[i]));
    
    textFont(f);
    text(city[i], convert_lon(lonc[i])-40, convert_lat(latc[i])-6);
    fill(255, 255, 255);
  }
}

void draw_temp_graph() {
  stroke(54, 69, 79);
  strokeWeight(2);
  
  //The following are the downward lines for the temp that for some reason were not covered in the for loop
  line(convert_lon(26.75), convert_lat(54.3), convert_lon(26.75), get_offset_temp(-30));   
  line(convert_lon(27.2), convert_lat(54.4), convert_lon(27.2), get_offset_temp(-24));
  line(convert_lon(37.6), convert_lat(55.8), convert_lon(37.6), get_offset_temp(-30));
  
  //For loop to draw downward lines from army path
  for (int i = 1; i < 10; i++) {
    stroke(54, 69, 79);
    strokeWeight(2);
    for (int j = 0; j < 21; j++) {
      if ((lont[i] == lonc[j]) && lont[i] != 36) {
        line(convert_lon(lont[i]), convert_lat(latc[j]), convert_lon(lont[i]), get_offset_temp(temp[i]));
        break;
      }
    }
    
    stroke(0, 0, 0);
    strokeWeight(3);
    
    //Draws the actual temperature lines
    line(convert_lon(lont[i-1]), get_offset_temp(temp[i-1]), convert_lon(lont[i]), get_offset_temp(temp[i]));
  }
  
  stroke(54, 69, 79);
  strokeWeight(2);
  line(convert_lon(26.75), 650, convert_lon(37.6), 650);
  line(convert_lon(26.75), get_offset_temp(-20), convert_lon(37.6), get_offset_temp(-20));
  line(convert_lon(26.75), get_offset_temp(-10), convert_lon(37.6), get_offset_temp(-10));
  line(convert_lon(26.75), get_offset_temp(0), convert_lon(37.6), get_offset_temp(0));
}

float get_offset_temp(float temperature) {
  return (abs(temperature) * 5) + 500;
}

float convert_lon(float lon) {
  return ((lon-24)*81)+80;
}

float convert_lat(float lat) {
  return (((90-lat)-34.2)*150)+100;
}
