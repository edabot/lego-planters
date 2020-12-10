// Planter parameters. Play with these.
studLength = 7;
studWidth = 8;
height = 30;
bottomThickness = 0.4;
rimThickness = 6;
bottomScale = .7;
twistAngle = 10;
drainHoles = 3;
drainDiameter = 3;

// IMPORTANT: this may need to be changed. LEGO is finicky for fit so use the legotest.stl file to
// determine the best diameter for your setup
studDiameter = 5;

layerHeight = .2;  // printer setting

//LEGO standard
studSpacing = 8;
studHeight = 1.7;

// calculated values
topWidth = (studWidth - 1) * studSpacing;
topLength = (studLength - 1) * studSpacing;
drainAngle = 360 / drainHoles;
halfLength = topLength / 2;
halfWidth = topWidth / 2;
halfInnerLength = halfLength - rimThickness;
halfInnerWidth = halfWidth - rimThickness;
drainSpaceRadius = halfInnerLength > halfInnerWidth ? bottomScale * halfInnerWidth / 2 : bottomScale * halfInnerLength / 2;

echo(inner_width_top=2 * halfInnerWidth);
echo(inner_length_top=2 * halfInnerLength);
echo(inner_width_bottom=2 * halfInnerWidth * bottomScale);
echo(inner_length_bottom=2 * halfInnerLength * bottomScale);

echo(drainSpaceRadius);

// suggested filename to include parameters
echo(filename=str("legoplanter_rect_", studLength, "x", studWidth, "s_", bottomScale * 100, "s_", twistAngle, "t_", drainHoles, "x", drainDiameter, "d"  ));

//----------

//make studs
translate([-halfLength, -halfWidth]){
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
  // make body
  linear_extrude(height = height, center = false, convexity = 10, twist = twistAngle, slices = height / layerHeight, scale = bottomScale)
  {
    difference(){
      union(){
      translate([ -halfLength, -halfWidth]) circle(d=rimThickness);
      translate([ halfLength, -halfWidth]) circle(d=rimThickness);
      translate([ -halfLength, halfWidth]) circle(d=rimThickness);
      translate([ halfLength, halfWidth]) circle(d=rimThickness);
      square([topLength + rimThickness, topWidth],center=true);
      square([topLength, topWidth + rimThickness],center=true);
      }
    union(){
      translate([halfInnerLength, halfInnerWidth]) circle(d=rimThickness);
      translate([halfInnerLength, -halfInnerWidth]) circle(d=rimThickness);
      translate([-halfInnerLength, halfInnerWidth]) circle(d=rimThickness);
      translate([-halfInnerLength, -halfInnerWidth]) circle(d=rimThickness);
      square([2 * halfInnerLength, topWidth - rimThickness],center=true);
      square([topLength - rimThickness, 2 * halfInnerWidth],center=true);
    }
    }
  }
  // make bottom
  translate([0,0,height])
  rotate([0,0,-twistAngle]){
      difference(){
  scale(bottomScale)
  linear_extrude(height = bottomThickness, center = false, convexity = 10, twist = twistAngle * bottomThickness / height, slices = bottomThickness / layerHeight)
  union(){
      translate([ -halfLength, -halfWidth]) circle(d=rimThickness);
      translate([ halfLength, -halfWidth, 0]) circle(d=rimThickness);
      translate([ -halfLength, halfWidth, 0]) circle(d=rimThickness);
      translate([ halfLength, halfWidth, 0]) circle(d=rimThickness);
      square([topLength + rimThickness, topWidth],center=true);
      square([topLength, topWidth + rimThickness],center=true);
  }
  if (drainHoles == 0) {}
  else if (drainHoles == 1) {
    cylinder(d=drainDiameter, h=height*3, center=true, $fn = 24);
  }
  else {
    for (i=[0:drainHoles - 1]) {
        translate([(drainSpaceRadius) * sin(drainAngle * i), (drainSpaceRadius) * cos  (drainAngle * i)])cylinder(r=drainDiameter/2, h=height*3, center=true, $fn = 24);
    }
  }
  }
  }
}
