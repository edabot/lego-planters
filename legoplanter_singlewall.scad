// This is an experimental variation of the round planter, but with a single wall. I have not printed this yet.


// Planter parameters. Play with these.
studs = 34;
height = 50;
bottomThickness = 0.6;
rimThickness = 6;

// Taper is how far in the side goes towards the center from top to bottom. This affects the radius
// so the diameter will be 2x smaller
taper = 10;

drainHoles = 3;
drainDiameter = 5;

// IMPORTANT: this may need to be changed. LEGO is finicky for fit so use the legotest.stl file to
// determine the best diameter for your setup
studDiameter = 5;

studHeight = 1.7;
minWallThickness = .7;

// calculated values
angle = 360 / studs;
radius = 4 / sin(angle/2);
drainAngle = 360 / drainHoles;
outerDiameterTop = 2 * radius + rimThickness;
innerDiameterTop = 2 * radius - rimThickness;
outerDiameterBottom = outerDiameterTop - 2 * taper;
innerDiameterBottom = taper > rimThickness - minWallThickness ? innerDiameterTop - 2 * (taper - rimThickness + minWallThickness) : innerDiameterTop;

// ECHO comments to show internal dimensions
echo(inner_diameter_top_is= innerDiameterTop);
echo(inner_diameter_bottom_is= innerDiameterBottom);


// filename to include parameters
echo(filename=str(studs, "s_", height, "h_", taper, "t_", drainHoles, "x", drainDiameter, "d"  ));

// -------

// make studs
for (i=[0:studs-1]) {
  translate([radius * sin(angle * i), radius * cos(angle * i)])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
}

// make sides
difference(){
  translate([0,0,-(height + studHeight) / 2])cylinder( d1 = outerDiameterBottom, d2 = outerDiameterTop, h = height, center = true, $fn=128);
  translate([0,0,-(2 * rimThickness + studHeight) /2 ])cylinder(d1=outerDiameterTop, d2=innerDiameterTop, h = 2 * rimThickness + 1, center = true, $fn=128);
  
  translate([0,0,-(height - 2 * rimThickness) ])cylinder(d=outerDiameterTop, h = height, center = true, $fn=16);
  }

//make bottom
difference(){
  translate([0,0,-(height + studHeight) / 2])cylinder(r1 = radius  + rimThickness / 2 - taper, r2= radius + rimThickness / 2, h = height, center = true, $fn=128);
  
  translate([0,0,-(height + studHeight) /2 + bottomThickness])cylinder(d1=innerDiameterBottom, d2=outerDiameterTop - 2 * minWallThickness, h = height, center = true, $fn=128);
    
  //remove drain holes
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
