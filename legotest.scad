studDiameterStart = 4.8;
increment = .05;
studHeight = 1.7;
versions = 8;

for (i=[0:versions-1]) {
  translate([0,8*i]) cylinder(d=studDiameterStart+ i * increment, h=studHeight, $fn=24);
  translate([8,8*i])cylinder(d=studDiameterStart+ i * increment, h=studHeight,$fn=24);
}
translate([-4, -4, -1])cube([16, 8*versions,1]);
translate([4,8*(versions-1)-1, -1])rotate(45)cube([7,7,1]);
