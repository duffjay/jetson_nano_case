
$fn = 50;

module hPost (pilotD = 3,  // pilot diameter
    mountW = 10,           // H post dia & width
    mountH = 8,          // H post height
    mountD = 9) {        // H post depth
        
    // overall height = mountW/2 + mountH
    //                = 5 + 8 = 13

    difference () {
        // main
        {
        union () {
            cylinder (r = mountW/2, h = mountD);
            translate([-mountW/2,-mountH,0])
            cube(size=[mountW, mountH, mountD]);
        }
        }
        // hole for threads
        cylinder (r = pilotD/2, h = mountD);
    }

    
}


