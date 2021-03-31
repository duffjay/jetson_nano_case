// camera mount
$fn = 50;

// hole center
holeCenter = 36;
cableWidth = 0.650 * 25.4;
coaxD = 0.232 * 25.4;

// from nanoBase
hPostH = 8;
hPostW = 10;
hPostD = 9;

railH = 3;
railW = 10;

// 1/2 Diameter + height - thinkness of rail
// defaults = 10
level2Width = hPostW/2 + hPostH - railH;
level2Thick = railW - hPostD + 2;

module roundCorner () {
    intersection () {
    difference () { 
            cube([hPostW, hPostW, (railW - hPostD) * 4]);
            cylinder(r=hPostW/2, h=level2Thick * 4);
        }
    cube([hPostW/2, hPostW/2, level2Thick * 4]);
    }
}

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// this is designed upside down (with regard to printing)
// so comment out this rotate, do your design work
// rotate it when finished
rotate ([0,180,0])
union () {
    // level 1 -- fits between the mounts
    translate([hPostW/2, 
                -level2Width/2,
                -2])
    cube ([holeCenter - hPostW,
            level2Width - hPostW/2,
            2]);
    // level 2 -- affix to mount
    difference () {
        {
        translate([-hPostW/2, 
                -level2Width/2,
                0])
            {
            cube ([holeCenter + hPostW, 
                level2Width,         // width
                level2Thick]);       // thickness
            }
        }
        // subtract holes & corners
       union () {
            // holes
            cylinder(r = 3.5/2, h = 8);
            translate([holeCenter,0,0])
            cylinder(r = 3.5/2, h = 8);
            // rounded corners
            translate([holeCenter,0,0])
            roundCorner();
            //
            rotate([0,180,0])
            translate([0,0,-level2Thick* 1.2])
            roundCorner();
        }    
    }
    // level 3 -- camera mount
    // make level 2 thicker
    // add lip
    translate([-hPostW/2, -(level2Width - hPostW/2 + railH), 1])
    cube([holeCenter + hPostW,
        railH,
        2]);
    
    // camera face
    translate([(holeCenter/2 - 24/2),
            8,
            1]){
        difference () {
            union () {
            cube ([24,25,2]);
            
            translate([2,23,-2])
            cylinder (r=2,h=4);
                
            translate([22,23,-2])
            cylinder (r=2, h = 4);
            
            translate([2,23-12.5,-2])
            cylinder (r=2, h = 4);
            
            translate([22,23-12.5,-2])
            cylinder (r=2, h = 4);
                
            // connect to base
            translate([0,-4,0])
            cube([3,4,2]);
                
            translate([21,-4,0])
            cube([3,4,2]);
                
            }
            {
                translate([2,23,-4])
                cylinder (r=1, h = 8);
                
                translate([22,23,-4])
                cylinder (r=1, h = 8);
                
                translate([2,23-12.5,-4])
                cylinder (r=1, h = 8);
                
                translate([22,23-12.5,-4])
                cylinder (r=1, h = 8);
                
                translate([4,4,0])
                cube ([16,17,2]);
            }
        }
    }
}
