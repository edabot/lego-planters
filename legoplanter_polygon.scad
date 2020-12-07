studLength = 5;
studSpacing = 8;
sides = 9;

height = 65;

angle = 360 / (sides * 2);
sideLength = (studLength - 1) * studSpacing;

cornerDistance = sideLength / (sin(angle) * 2);
sideDistance = cornerDistance * cos(angle);

bottomThickness = 1;
rimThickness = 7;
studDiameter = 5;
studHeight = 1.7;
bottomScale = .65;
minWallThickness = .8;

twistAngle = 90;

drainHoles = 6;
drainDiameter = 5;
drainAngle = 360 / drainHoles;

innerDiameterBottom = bottomScale * sideDistance;

echo(inner_diameter_top_is= 2 * cornerDistance-rimThickness);

echo(inner_diameter_top_is= 2 * sideDistance-rimThickness);
echo(inner_diameter_bottom_is= (2 * sideDistance-rimThickness) * bottomScale);


for (j=[0:sides-1]) {
  rotate([0,0,2 * angle * j + angle])
  translate([sideDistance, -sideLength/ 2,0]){
      for (i=[0:studLength-2]) {
        translate([0, studSpacing * i, studHeight / 2])cylinder(d=studDiameter, h=studHeight, center=true, $fn = 24);
      }
  }
}
rotate([180,0,0]){
  linear_extrude(height = height, center = false, convexity = 10, twist = twistAngle, slices = height / .2, scale = bottomScale)
  difference(){
    circle(cornerDistance + rimThickness / 2,$fn=sides);
    circle(cornerDistance - rimThickness / 2,$fn=sides);
  }
}

rotate([0,0,twistAngle])
translate([0,0,-height]) {
  difference(){

    linear_extrude(height = bottomThickness, center = false, convexity = 10, twist = twistAngle * bottomThickness / height, slices = bottomThickness / .2) {
        circle((cornerDistance) * bottomScale,$fn=sides);
    }

    if (drainHoles == 0) {}
    else if (drainHoles == 1) {
      cylinder(d=drainDiameter, h=height*3, center=true, $fn = 24);
      }
    else {
      for (i=[0:drainHoles - 1]) {
          translate([(innerDiameterBottom / 2) * sin(drainAngle * i), (innerDiameterBottom / 2) * cos  (drainAngle * i)])cylinder(r=drainDiameter/2, h=height*3, center=true, $fn = 24);
      }
    }
  }

}
