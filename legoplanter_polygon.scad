
// Top polygon parameters. These determine the size and shape of the top polygon. Look at the ECHO
// messages in the console to see what the internal measurements are as a result of changing these
// if you want a specific internal size. Play around with these.
sides = 9;
studLength = 5;

// Shape parameters. Play around with these.
height = 65;
bottomThickness = .6;
rimThickness = 7;
bottomScale = .65;
twistAngle = 90;
drainHoles = 6;
drainDiameter = 5;

// Parameter that may need calibration. The "official" width is 5mm, but this can vary depending on
// the machine, the printer settings, and the filament being used. It is recommended that the
// legotest.stl is printed first and tested with a LEGO piece to dial in this value.
studDiameter = 5;

// Parameter for layer height when printing.
layerThickness = .2;

// stud constants, do not change
studSpacing = 8;
studHeight = 1.7;

// calculated values, do not change
angle = 360 / (sides * 2);
sideLength = (studLength - 1) * studSpacing;
cornerDistance = sideLength / (sin(angle) * 2);
sideDistance = cornerDistance * cos(angle);
drainAngle = 360 / drainHoles;
innerDiameterBottom = bottomScale * sideDistance;

// Messages for internal size. These vary depending on whether you want to know the max size for a
// cylinder to fit inside (the "sides" value) or the max size to each corner.
echo(inner_diameter_top_corners_is= 2 * cornerDistance - rimThickness);
echo(inner_diameter_top_sides_is= 2 * sideDistance - rimThickness);
echo(inner_diameter_bottom_sides_is= (2 * sideDistance - rimThickness) * bottomScale);


// filename to include parameters
echo(filename=str("legoplanter_polygon_", sides, "x", studLength, "_", height, "h_", bottomScale * 100, "s_", twistAngle, "a_", drainHoles, "x", drainDiameter, "d"  ));

// -------------

// Make the studs
for (j=[0:sides-1]) {
  rotate([0,0,2 * angle * j + angle])
  translate([sideDistance, -sideLength/ 2,0]){
      for (i=[0:studLength-2]) {
        translate([0, studSpacing * i, studHeight / 2])cylinder(d=studDiameter, h=studHeight, center=true, $fn = 24);
      }
  }
}

// Make the sides
rotate([180,0,0]){
  linear_extrude(height = height, center = false, convexity = 10, twist = twistAngle, slices = height / layerThickness, scale = bottomScale)
  difference(){
    circle(cornerDistance + rimThickness / 2, $fn=sides);
    circle(cornerDistance - rimThickness / 2, $fn=sides);
  }
}

// Make the bottom piece
rotate([0,0,twistAngle])
translate([0,0,-height]) {
  difference(){
    
    // Bottom solid
    linear_extrude(height = bottomThickness, center = false, convexity = 10, twist = twistAngle * bottomThickness / height, slices = bottomThickness / layerThickness) {
        circle((cornerDistance) * bottomScale,$fn=sides);
    }

    // Remove drain holes
    if (drainHoles == 0) {}
    else if (drainHoles == 1) {
      cylinder(d=drainDiameter, h=height*3, center=true, $fn = 24);
      }
    else {
      for (i=[0:drainHoles - 1]) {
          translate([(innerDiameterBottom / 2) * sin(drainAngle * i), (innerDiameterBottom / 2) * cos  (drainAngle * i)])cylinder(d=drainDiameter, h=height*3, center=true, $fn = 24);
      }
    }
  }

}
