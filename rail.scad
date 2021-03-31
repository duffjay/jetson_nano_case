$fn = 50;

module rail(length, width, height) {
    cylR = width / 2;
    cylH = length - width * 3;
    
    difference () {
    // rail ass'y
    {
        // cylinder taken out of rail
        difference() {
            {
            // rail
            translate([-width/2, -width/2, -height])
            cube(size=[length, width, height]);
            }
            // cylinder cutout
            {
            translate([length/2 - cylH/2 - width/2, 0, width/2 - (height - 1)])
            rotate([0, 90, 0]) {
                cylinder(r = cylR, h = cylH);
                // 2 spheres at the ends
                sphere(cylR);
                translate([0,0,cylH])
                sphere(cylR);
                }
            } // end of the cylinder
       } // end of the diff( rail - cylinder) 
   } // end of the rail ass'y
   // remove holes
   {
       // drill holes
       drillRange = cylH - width/2;  
       drillD = width/2;                
       drillCount = round(drillRange/drillD / 2);  
       echo(drillRange, drillD, drillCount);
    
        // hole loop
           inc = (drillRange - drillD) / drillCount;
           echo ("odd- count:", drillCount, inc);
          for (h = [drillD/2:inc:drillRange - drillD/2]) {
               echo ("h:", h);
              difference() {
               translate([length/2 - drillRange/2 - width/2 + h, 0, -height])
               cylinder(r=drillD/2, h=height);
              }
           } // end of hole loop

    } // end of the holes ass'y
} // end of difference (rail ass'y - holes)
} // end of module

