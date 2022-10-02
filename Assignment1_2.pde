// 1.414
Table table;
int N;
float[] lonc, latc, lont, lonp, latp;
String[] city, mon, dir;
int[] temp, days, surv, div;
PFont f;

void setup() {
  size(1799, 1272);
  
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
  for (int i = 0; i < 48; i++) {
    print(dir[i]);
  }
}

void draw() {
  background(255);
  draw_survivors(); //<>//
  stroke(0);
  strokeWeight(10);
  draw_cities();
}

void draw_cities() {
  for (int i = 0; i < 21; i++) {
    point(((lonc[i]-24)*125)+25, (((90-latc[i])-34.2)*125)+400); //Max lat is 90, This inversion flips the chart the right way around
    textFont(f, 16);
    fill(0);
    text(city[i], convert_lon(lonc[i]), convert_lat(latc[i]));
  }
}
  
void draw_survivors() {
  draw_survivors_return();
  draw_survivors_attack();
}

void draw_survivors_attack() {
  stroke(135,62,35);
  for (int i = 1; i < 48; i++) {
    if (dir[i].equals("A")) {
      strokeWeight(surv[i]/3000);
      line(convert_lon(lonp[i-1]), convert_lat(latp[i-1]), convert_lon(lonp[i]), convert_lat(latp[i]));
    }
  }
}

void draw_survivors_return() {
  stroke(0,0,0);
  for (int i = 1; i < 48; i++) {
    if (dir[i].equals("R")) {
      strokeWeight(surv[i]/3000);
      line(convert_lon(lonp[i-1]), convert_lat(latp[i-1]), convert_lon(lonp[i]), convert_lat(latp[i]));
    }
  }
}

float convert_lon(float lon) {
  return ((lon-24)*125)+25;
}

float convert_lat(float lat) {
  return (((90-lat)-34.2)*200)+400;
}

float convert_surv_lon(float lon) {
  return ((lon-24)*125)+25;
}

float convert_surv_lat(float lat) {
  return (((90-lat)-52.4)*200)+400;
}
