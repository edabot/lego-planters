// Planter parameters. Play with these.
studs = 34;
height = 50;
bottomThickness = 0.6;
rimThickness = 6;
drainHoles = 2;
drainDiameter = 5;
taper = 10; // The difference in radius from top to bottom
minWallThickness = 1;

// IMPORTANT: this may need to be changed. LEGO is finicky for fit so use the legotest.stl file to
// determine the best diameter for your setup
studDiameter = 5;
studHeight = 1.7;

// calculated values
angle = 360 / studs;
radius = 4 / sin(angle/2);
innerDiameterTop = 2 * radius - rimThickness;
drainAngle = 360 / drainHoles;
innerDiameterBottom = taper > rimThickness - minWallThickness ? innerDiameterTop - 2 * (taper - rimThickness + minWallThickness) : innerDiameterTop;

// ECHO to display interior dimensions
echo(inner_diameter_top_is= innerDiameterTop);
echo(inner_diameter_bottom_is= innerDiameterBottom);

// suggested filename to include parameters
echo(filename=str("legoplanter_round_", studs, "s_", height, "h_", taper, "t_", drainHoles, "x", drainDiameter, "d"  ));

for (i=[0:studs-1]) {
  translate([radius * sin(angle * i), radius * cos(angle * i)])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
}

difference(){
  translate([0,0,-(height + studHeight) / 2])cylinder(r1 = radius  + rimThickness / 2 - taper, r2= radius + rimThickness / 2, h = height, center = true, $fn=128);
  translate([0,0,-(height + studHeight) /2 + bottomThickness])cylinder(d1=innerDiameterBottom, d2=innerDiameterTop, h = height, center = true, $fn=128);
  if (drainHoles == 0) {}
  else if (drainHoles == 1) {
    cylinder(d=drainDiameter, h=height*3, center=true, $fn = 24);
  }
  else {
    for (i=[0:drainHoles - 1]) {
        translate([(innerDiameterBottom / 4) * sin(drainAngle * i), (innerDiameterBottom / 4) * cos  (drainAngle * i)])cylinder(r=drainDiameter/2, h=height*3, center=true, $fn = 24);
    }
  }
}
