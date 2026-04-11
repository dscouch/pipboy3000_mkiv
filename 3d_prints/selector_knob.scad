include <module.scad>
height = 15;
radius = 15;
rounding_radius = 2;
facets = 64;
inner_height = 10.01;  // Extended to create through-bottom opening
inner_radius = 13;
second_hollow_height = 3;
second_hollow_radius = 11;
h_cut = 3;
r_cut = 2;
x_offset = 11;
z_base = 10;
n_cutouts = 16;
difference() {
    // Outer rounded cylinder
    translate([0,0,height/2])
    rounded_cylinder(
        height = height,
        radius = radius,
        rounding_radius = rounding_radius,
        facets = facets
    );
    
    // Inner hollow cylinder - aligned with bottom plane
    translate([0, 0, 0])
    cylinder(
        h = inner_height,
        r = inner_radius,
        center = false,
        $fn = facets
    );
    
    // Second hollow cylinder stacked on top of the first
    translate([0, 0, inner_height])
    cylinder(
        h = second_hollow_height,
        r = second_hollow_radius,
        center = false,
        $fn = facets
    );
    
    // 16 cylindrical cutouts in circular pattern
    for (i = [0:n_cutouts-1]) {
        rotate([0, 0, i * (360/n_cutouts)])
        translate([x_offset, 0, z_base])
        cylinder(
            h = h_cut,
            r = r_cut,
            center = false,
            $fn = facets
        );
    }
}
