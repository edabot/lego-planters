// This file generates a test piece for dialing in the stud diameters for your particular printer setup
// since LEGO fit can be very finicky. The triangle is there to point to the side with the
// wider studs

studDiameterStart = 4.8;
increment = .05;
versions = 8;
studHeight = 1.7;

// calculated value
studDiameterEnd = studDiameterStart + increment * (versions - 1);

// filename to include parameters
echo(filename=str("legotest_",studDiameterStart * 100, "_to_", studDiameterEnd * 100 ));

for (i=[0:versions-1]) {
  translate([0,8*i]) cylinder(d=studDiameterStart+ i * increment, h=studHeight, $fn=24);
  translate([8,8*i])cylinder(d=studDiameterStart+ i * increment, h=studHeight,$fn=24);
}
translate([-4, -4, -1])cube([16, 8*versions,1]);
translate([4,8*(versions-1)-1, -1])rotate(45)cube([7,7,1]);
