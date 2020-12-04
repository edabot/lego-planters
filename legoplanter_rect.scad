studLength = 7;
studWidth = 7;
studSpacing = 8;

height = 30;
bottomThickness = 0.4;
rimThickness = 6;
studDiameter = 5;
studHeight = 1.7;
bottomScale = .6;
minWallThickness = .8;

topWidth = (studWidth - 1) * studSpacing;
topLength = (studLength - 1) * studSpacing;

twistAngle = 90;

drainHoles = 0;
drainDiameter = 5;
drainAngle = 360 / drainHoles;
translate([-topLength / 2, -topWidth / 2]){
  union() {
    for (i=[0:studLength-1]) {
      translate([studSpacing * i, 0, studHeight / 2])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
    }
    for (i=[0:studLength-1]) {
      translate([studSpacing * i, topWidth, studHeight / 2])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
    }
    for (i=[1:studWidth-2]) {
      translate([0, studSpacing * i, studHeight / 2])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
    }
    for (i=[1:studWidth-2]) {
      translate([topLength, studSpacing * i, studHeight / 2])cylinder(r=studDiameter/2, h=studHeight, center=true, $fn = 24);
    }  
  }
}

$fn = 48;

rotate([180,0,0]){
  linear_extrude(height = height, center = false, convexity = 10, twist = twistAngle, slices = height / .2, scale = bottomScale)
  {
    difference(){
      union(){
      translate([ -topLength / 2, -topWidth/2]) circle(d=rimThickness);
      translate([ topLength / 2, -topWidth/2, 0]) circle(d=rimThickness);
      translate([ -topLength / 2, topWidth / 2, 0]) circle(d=rimThickness);
      translate([ topLength / 2, topWidth / 2, 0]) circle(d=rimThickness);
      square([topLength + rimThickness, topWidth],center=true);
      square([topLength, topWidth + rimThickness],center=true);
      }
    union(){
      translate([topLength / 2 - rimThickness, topWidth / 2 - rimThickness, 0]) circle(d=rimThickness);
      translate([topLength / 2 - rimThickness, -topWidth / 2 + rimThickness, 0]) circle(d=rimThickness);
      translate([-topLength / 2 + rimThickness, topWidth / 2 - rimThickness, 0]) circle(d=rimThickness);
      translate([-topLength / 2 + rimThickness, -topWidth / 2 + rimThickness, 0]) circle(d=rimThickness);
      square([topLength - 2 * rimThickness, topWidth - rimThickness],center=true);
      square([topLength - rimThickness, topWidth - 2 * rimThickness],center=true);
    }
    }
  }

  translate([0,0,height])
  rotate([0,0,-twistAngle])
  scale(bottomScale)
  linear_extrude(height = bottomThickness, center = false, convexity = 10, twist = twistAngle * bottomThickness / height, slices = bottomThickness / .2)
  union(){
      translate([ -topLength / 2,   -topWidth/2]) circle(d=rimThickness);
      translate([ topLength / 2, -topWidth/2, 0]) circle(d=rimThickness);
      translate([ -topLength / 2, topWidth / 2, 0]) circle(d=rimThickness);
      translate([ topLength / 2, topWidth / 2, 0]) circle(d=rimThickness);
      square([topLength + rimThickness, topWidth],center=true);
      square([topLength, topWidth + rimThickness],center=true);
  }
}
