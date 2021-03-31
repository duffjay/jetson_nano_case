
include <post.scad>;
include <rail.scad>;
include <hPost.scad>;

postD = 5; // post diameter
postH = 12; // post height;
pilotD = 2.5; // pilot diameter


nanoX = 57;
nanoY = 85; // messed up at 80

// railwidth = standoff width + 1mm x 2
railW = 10;
railH = 3;

// horizontal posts
hPilotD = 0.5;    // try 0.5 to drill this out
hPostW = 10;
hPostH = 8;
hPostD = 9;

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
        
        // horizontal mount points for antenna
        yHPostWidth = 54;
        rotate([90,0,0])
        translate([(nanoY/2 - yHPostWidth/2),hPostH - railH,-railW/2])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,0])
        translate([(nanoY/2 + yHPostWidth/2),hPostH - railH,-railW/2])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        // horizontal mount points for camera
        yHPostWidthCamera = 36;
        rotate([90,0,90])
        translate([(nanoX/2 - yHPostWidthCamera/2), 
            hPostH - railH, 
            (-railW/2 + (railW - hPostD))
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,90])
        translate([(nanoX/2 + yHPostWidthCamera/2), 
            hPostH - railH, 
            (-railW/2 + (railW - hPostD))
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        // horizontal mount points at the other end
        rotate([90,0,90])
        translate([(nanoX/2 - yHPostWidthCamera/2), 
            hPostH - railH, 
            (nanoY - (railW/2))
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,90])
        translate([(nanoX/2 + yHPostWidthCamera/2), 
            hPostH - railH, 
            (nanoY - (railW/2))
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
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


