include <module.scad>
ring_height = 2.8;
ring_radius = 10;
ring_width = 2;
rotation_angle = 20;
facets = 72;
translate([0,0,-10]){
difference() {
    // Create full ring using tube module
    tube(
        outer_radius = ring_radius,
        inner_radius = ring_radius - ring_width,
        height = ring_height,
        center = true
    );
    
    // Cut away negative y half
    translate([0, -ring_radius, 0])
    cube([2*ring_radius, 2*ring_radius, ring_height + 1], center = true);
}}
rotate([0, 0, -rotation_angle])
translate([0,0,-10])
/*
difference() {
    tube(
        outer_radius = ring_radius,
        inner_radius = ring_radius - ring_width,
        height = ring_height,
        center = true
    );
    
    translate([0, -ring_radius, 0])
    cube([2*ring_radius, 2*ring_radius, ring_height + 1], center = true);
}
difference() {
    cylinder(
        h = ring_height,
        r = ring_radius,
        center = true,
        $fn = facets
    );
    
    // Cut away positive y half
    translate([0, ring_radius, 0])
    cube([2*ring_radius, 2*ring_radius, ring_height + 1], center = true);
} */
