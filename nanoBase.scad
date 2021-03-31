
include <post.scad>;
include <rail.scad>;

postD = 5; // post diameter
postH = 8; // post height;
pilotD = 3; // pilot diameter


nanoX = 57;
nanoY = 85; // messed up at 80

// railwidth = standoff width + 1mm x 2
railW = 10;
railH = 3;


difference() {

    union (){
        // base
        //   
        #rail(nanoY + railW, railW, 3);
        translate([0, nanoX, 0])
        rail(nanoY + railW, railW, 3);
        
        rotate([0, 0, 90])
        rail(nanoX + railW, railW, 3);
        
        translate([nanoY, 0, 0])
        rotate([0, 0, 90])
        rail(nanoX + railW, railW, 3);
        
        // M3 standoffs
        
        translate([0, 0, 0])
        post (postD, postH, pilotD);
        
        translate([0, nanoX, 0])
        post (postD, postH, pilotD);
        
        translate([nanoY, nanoX, 0])
        post (postD, postH, pilotD);
        
        translate([nanoY, 0, 0])
        post (postD, postH, pilotD);
    }
    union (){
        // drill the holes all the way through
        translate([0,0,-10])
        cylinder(r= pilotD/2, h = 20);
        
        translate([nanoY,0,-10])
        cylinder(r= pilotD/2, h = 20);

        translate([nanoY, nanoX,-10])
        cylinder(r= pilotD/2, h = 20);

        translate([0, nanoX,-10])
        cylinder(r= pilotD/2, h = 20);        
    }

}


