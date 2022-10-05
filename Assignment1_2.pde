// 1.414
Table table;
int N;
float[] lonc, latc, lont, lonp, latp;
String[] city, mon, dir;
int[] temp, days, surv, div;
PFont f;
int survivor_ratio = 3500;

void setup() {
  size(1125, 795);
  
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
  
  f = createFont("Arial",16,true);
}

void draw() {
  background(255);
  draw_survivors(); //<>//
  draw_cities();
}

void draw_survivors() {
  int i = 46;
  
  while (i >= 0) {  
    if (div[i] == div[i+1]) {
      stroke(127, 253, 228);
      if (dir[i].equals("A")) {
        stroke(212, 73, 73);
      }
      strokeWeight(surv[i]/survivor_ratio);
      line(convert_lon(lonp[i]), convert_lat(latp[i]), convert_lon(lonp[i+1]), convert_lat(latp[i+1]));
      
    }
    else {
      i--;
      stroke(127, 253, 228);
      if (dir[i].equals("A")) {
        stroke(212, 73, 73);
      }
      strokeWeight(surv[i]/survivor_ratio);
      line(convert_lon(lonp[i]), convert_lat(latp[i]), convert_lon(lonp[i+1]), convert_lat(latp[i+1]));
    }
    i--;
  }
}

void draw_cities() {
  for (int i = 0; i < 21; i++) {
    stroke(0, 0, 0);
    strokeWeight(10);
    point(convert_lon(lonc[i]), convert_lat(latc[i]));
    textFont(f);
    text(city[i], convert_lon(lonc[i])-15, convert_lat(latc[i])-6);
    fill(0,0,0);
  }
}
float convert_lon(float lon) {
  return ((lon-24)*75)+80;
}

float convert_lat(float lat) {
  return (((90-lat)-34.2)*180)+200;
}
