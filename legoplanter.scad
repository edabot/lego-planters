

studs = 40;
height = 65;
drainHoles = 2;
drainDiameter = 10;
bottomThickness = 1;
rimThickness = 8;
studDiameter = 4.95;
studHeight = 1.7;
taper = 14;

offset = 0;
angle = 360 / studs;
radius = 4 / sin(angle/2);
innerDiameter = 2 * radius - rimThickness;
drainAngle = 360 / drainHoles;

echo(inner_diameter_is= innerDiameter);

for (i=[0:studs-1]) {
  translate([radius * sin(angle * i), radius * cos(angle * i)])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
}

difference(){
  translate([0,0,-height /2 - studHeight/2])cylinder(r1 = radius  + rimThickness / 2- taper, r2= radius + rimThickness / 2, h = height, center = true, $fn=128);
  if (rimThickness - taper < 1) {
    offset = taper - rimThickness + 1;
    translate([0,0,-height /2 - studHeight/2 + bottomThickness])cylinder(r1=radius - rimThickness / 2 - offset, r2=radius - rimThickness / 2, h = height, center = true, $fn=128);
  }
  for (i=[0:drainHoles - 1]) {
    translate([(innerDiameter /4) * sin(drainAngle * i), (innerDiameter /4) * cos(drainAngle * i)])cylinder(r=drainDiameter/2, h=height*3, center=true, $fn = 24);
  }
}
