// fan mount
//  - this goes at the end where there were camera mounts
// 
// TODO
// - m4_major snug @ 4.1, but acceptable
// - the offset is wrong
//   - was 20 mm
//   - probably more like 10-15
// - make the base face taller (i.e. as if there ere 4 mm of washers)

base_cl = 36.0;      // distance between the holes on the base
base_height = 13.00; // post height: 10 + rail height: 3
base_mnt_hght = 8.0; // the base holes are 8mm from bottom
base_spacer = 8.0;   // add spacer to provide clearance from jetson edge
// Noctua NF-A4x10 5V PWM
//      40x10mm Premium Fan
// https://noctua.at/en/nf-a4x10-flx/specification
fan_cl = 32.0;       // centerline distance between fan holes
fan_abv_jet = 8.0;   // fan needs to be above the floor of jetson 
                     // for screw heads to clear
fan_offset = 10;     // 80/2 - 20 = 20
                     // heatsink is not on center, it's 20mm offset from jetson CL
m4_major_dia = 4.1;  // major + clearance
fan_mnt_face = 8.0;  // mounting face on fan
base_mnt_face = 10.0;// mounting face at base to match jetson base

plate_z = 2.5;       // mounting plate thickness

// support bars
bar_x = 2.5;
bar_y = 2.5;
bar_z = plate_z;

// fan mount height
mnt_height = fan_abv_jet + base_height - base_mnt_hght;

$fn = 50;

difference () {
    union () {
        
        // ----- base mounts ------
        translate([-base_cl/2,0,(base_spacer/2 + plate_z) - plate_z])
        cylinder(r=base_mnt_face/2, h=plate_z + base_spacer, center=true);
        translate([+base_cl/2,0, (base_spacer/2 + plate_z) - plate_z])
        cylinder(r=base_mnt_face/2, h=plate_z + base_spacer, center=true);
        
        // ---- fan mounts ------
        
        // translate X
        // - fan offset + the difference in the CenterLines/2

        translate([- fan_cl/2 + fan_offset, mnt_height, 0])
        cylinder(r=fan_mnt_face/2, h=plate_z, center=true);
        translate([+ fan_cl/2 + fan_offset, mnt_height, 0])
        cylinder(r=fan_mnt_face/2, h=plate_z, center=true);
        
        // cross bars
        translate([0,0,0])
        cube([base_cl, bar_y, bar_z], center = true);
        
        translate([fan_offset, mnt_height,0])
        cube([fan_cl, bar_y, bar_z], center = true);
        
        // hypteneuse LEFT
        
        adj_left  = (- fan_cl/2 + fan_offset) - (-base_cl/2);
        adj_rght =  (+ fan_cl/2 + fan_offset) - (base_cl/2);
        echo ("left adjacent: ", adj_left, "  right adjacent: ", adj_rght);
        
        mnt_angle_left = atan(mnt_height/adj_left);
        sin_angle_left = sin(mnt_angle_left);
        echo ("left mount angle:", mnt_angle_left, "  sin:", sin_angle_left);
        hyp_left = mnt_height/sin_angle_left;
        
        translate([
            -base_cl/2 + adj_left/2,
            mnt_height/2,
            0]) 
        rotate([0,0,mnt_angle_left])
        cube([hyp_left, bar_y, bar_z], center=true);
        
        // hypteneuse RIGHT
        mnt_angle_rght = atan(mnt_height/adj_rght);
        sin_angle_rght = sin(mnt_angle_rght);
        echo ("right mount angle:", mnt_angle_rght, "  sin:", sin_angle_rght);
        hyp_rght = mnt_height/sin_angle_rght;

        translate([
            base_cl/2 + adj_rght/2,
            mnt_height/2,
            0]) 
        rotate([0,0,mnt_angle_rght])
        cube([hyp_rght, bar_y, bar_z], center=true);
        
        // veritical supports
        translate([- fan_cl/2 + fan_offset,mnt_height/2,0])
        cube([bar_x, mnt_height, bar_z], center=true);
        
        translate([+base_cl/2,mnt_height/2,0])
        cube([bar_x, mnt_height, bar_z], center=true);
    }
    {
    // drill holes
        // ----- base mounts ------
        translate([-base_cl/2,0,(base_spacer/2 + plate_z) - plate_z])
        cylinder(r=m4_major_dia/2, h=plate_z + base_spacer, center=true);
        translate([+base_cl/2,0,(base_spacer/2 + plate_z) - plate_z])
        cylinder(r=m4_major_dia/2, h=plate_z + base_spacer, center=true);    
        
        // fan mounts
        translate([- fan_cl/2 + fan_offset, mnt_height, 0])
        cylinder(r=m4_major_dia/2, h=plate_z, center=true);
        translate([+ fan_cl/2 + fan_offset, mnt_height, 0])
        cylinder(r=m4_major_dia/2, h=plate_z, center=true);
    }
}
