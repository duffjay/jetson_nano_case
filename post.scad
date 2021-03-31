// POST (or standoff)
// default is for an M3 thread

$fn=50;

module post (postD = 5, postH = 8, pilotD = 3) {
    f = postD / 2; // filllet
    
    difference () {
        cylinder(r = postD/2, h = postH);
        cylinder(r = (pilotD/2) * 0.90, h = postH);
    }
    rotate_extrude(convesivity = 10) {
        translate([2.5, 0, 0]) {
            intersection() {
                difference() {
                    square(f * 2, center = true);
                    translate([f, f, 0]) circle(f);
                }
                square(f * 2);
            }
        }
    }
}

