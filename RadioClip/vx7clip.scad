
maxShoulderDia = 19.5;
ShoulderLen = 2.75;
maxThroatDia = 10.8;
minThroatLen = 3.0;
HeadDia = 15.8;
HeadLen = 1.8;
e = 1 + (1/sqrt(2));///<ratio between side length and distanve between opposite sides
Delta = maxShoulderDia;
//Gamma = sqrt((Delta*Delta)/(1+(e*e)));///<distance between sides
//Beta = Gamma / e;///<a side
Beta = sqrt((Delta*Delta)/(1+(e*e)));
Gamma = Beta * e;
ChannelWidth = min(Beta - 2.5, 6);
ChannelHeight = ShoulderLen - 0.25;
TotalHeight = ShoulderLen + minThroatLen + HeadLen;

echo("e: ", e);
echo("Delta: ", Delta);
echo("Gamma: ", Gamma);
echo("Beta: ", Beta);
echo("math check, should equal ShoulderDia: ", sqrt((Gamma*Gamma)+(Beta*Beta)));
echo("Total Height: ", TotalHeight);
difference(){
  blank(maxShoulderDia, ShoulderLen, maxThroatDia, minThroatLen, HeadDia, HeadLen);
  keycutter(maxShoulderDia, ChannelWidth, ChannelHeight);
  vx7cutter(TotalHeight, 1);
}


module blank(maxShoulderDia, ShoulderLen, maxThroatDia, minThroatLen, HeadDia, HeadLen){
  union(){
    cylinder(h=ShoulderLen, d=maxShoulderDia, center=false, $fn=8);
    translate([0,0,0.5]){cylinder(h=minThroatLen + (ShoulderLen + HeadLen) -1, d=maxThroatDia, $fn=360);}
    translate([0,0,ShoulderLen + minThroatLen]){cylinder(h=HeadLen, d=HeadDia, $fn=360);}
  }
}

module keycutter(maxShoulderDia, channelWidth, Depth){
  echo("channelWidth: ", channelWidth);
  rotate(a=[0,0,360/16]){
    translate([0,0,-0.499]){
      union(){
        translate([0,0,0]){cylinder(h=Depth+2.5, d=max(channelWidth, 5.5), $fn=360);}
        translate([-channelWidth/2, 0, 0]){cube([channelWidth, maxShoulderDia, Depth+0.5]);}
        cylinder(h=25, d=2.9, $fn=360);
      }
    }
  }
}

module vx7cutter(totheight, depth){
//note: vx7 needs an M3 bolts
  translate([0,0,totheight - depth]){
    rotate(a=[0,0,360/16]){
      union(){
        cylinder(d=6.4, h=2, $fn=360);
        translate([-3.5/2,0,0]){cube([3.5, 3.5+3.2, 2]);}
      }
    }
  }
}

/*
translate([0,-0.5,-0.5]){
union(){
translate([-1 + -(maxShoulderDia /2),0,0]){cube(1);}
translate([(maxShoulderDia /2),0,0]){cube(1);}
}
}*/