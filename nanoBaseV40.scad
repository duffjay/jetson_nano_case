// jetson NANO
// - early version
// TODO
// - fixed:  58x86
// - do you want the fan mount threaded or pass-thru?

include <post.scad>;
include <rail.scad>;
include <hPost.scad>;

postD = 5; // post diameter
postH = 14; // post height;
pilotD = 2.5; // m2.5 pilot diameter
              // yes, 2.5 pilot will be about right for 2.5 tap

// https://ahnbk.com/?p=625
nanoX = 58;
nanoY = 86; // messed up at 80

// railwidth = standoff width + 1mm x 2
railW = 10;
railH = 3;

// horizontal posts
hPilotD = 3.2;    // try 0.5 to drill this out
hPostW = 10;
hPostH = 8;
hPostD = 4;

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
        translate([(nanoY/2 - yHPostWidth/2),hPostH - railH,-railW/2 + 6])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,0])
        translate([(nanoY/2 + yHPostWidth/2),hPostH - railH,-railW/2 + 6])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        // horizontal mount points for camera
        yHPostWidthCamera = 36;
        echo ("camera mount CL:", (nanoX/2 - yHPostWidthCamera/2));
        rotate([90,0,90])
        // - 6 (10 - 4) == puts the mount points flush on outside
        translate([(nanoX/2 - yHPostWidthCamera/2), 
            hPostH - railH, 
            (-railW/2 + (railW - hPostD)) - 6
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,90])
        translate([(nanoX/2 + yHPostWidthCamera/2), 
            hPostH - railH, 
            (-railW/2 + (railW - hPostD)) - 6
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        // horizontal mount points at the other end
        rotate([90,0,90])
        translate([(nanoX/2 - yHPostWidthCamera/2), 
            hPostH - railH, 
            (nanoY - (railW/2)) + 6
            ])
        hPost(hPilotD, hPostW, hPostH, hPostD);
        
        rotate([90,0,90])
        translate([(nanoX/2 + yHPostWidthCamera/2), 
            hPostH - railH, 
            (nanoY - (railW/2)) + 6
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


