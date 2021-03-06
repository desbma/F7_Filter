filter_width = 170; 
filter_depth = 330;
filter_height = 30; 

fabric_thickness = 1.5;
inner_frame_thickness = 11;
inner_frame_height = 22;

middle_bar_thickness = 5;

outer_frame_thickness = 4;
bottom_thickness = filter_height - inner_frame_height;

stick_height = 2 * inner_frame_height / 3;
stick_thickness = 3;
stick_hole_margin = 0.5;
stick_spacing = outer_frame_thickness + inner_frame_thickness / 2 + fabric_thickness;

display_z_gap = 100;
display_y_gap = 5;

//
// upper part
//

translate([outer_frame_thickness + fabric_thickness, 
           outer_frame_thickness + fabric_thickness, 
           outer_frame_thickness * 2 + display_z_gap]) {
    difference() {
        // inner frame
        difference() {
            cube([filter_width - outer_frame_thickness * 2 - fabric_thickness * 2, 
                  filter_depth + display_y_gap - outer_frame_thickness * 2 - fabric_thickness * 2, 
                  inner_frame_height- fabric_thickness]);
            union() {
                translate([inner_frame_thickness, 
                           inner_frame_thickness, 
                           0]) {
                    cube([filter_width - inner_frame_thickness * 2 - outer_frame_thickness * 2 - fabric_thickness * 2, 
                          filter_depth + display_y_gap - inner_frame_thickness * 2 - outer_frame_thickness * 2 - fabric_thickness * 2, 
                          inner_frame_height]
                    );
                }
                
                // corner stick holes
                translate([inner_frame_thickness / 2, 
                           inner_frame_thickness / 2, 
                           0]) {
                    stick_hole();
                }
                translate([filter_width - outer_frame_thickness * 2 - fabric_thickness * 2 - inner_frame_thickness / 2, 
                           inner_frame_thickness / 2, 
                           0]) {
                    stick_hole();
                }
                translate([inner_frame_thickness / 2, 
                           filter_depth + display_y_gap - outer_frame_thickness * 2 - fabric_thickness * 2 - inner_frame_thickness / 2, 
                           0]) {
                    stick_hole();
                }
                translate([filter_width - outer_frame_thickness * 2 - fabric_thickness * 2 - inner_frame_thickness / 2, 
                           filter_depth + display_y_gap - outer_frame_thickness * 2 - fabric_thickness * 2 - inner_frame_thickness / 2, 
                           0]) {
                    stick_hole();
                }
                
                // middle sticks holes
                translate([inner_frame_thickness / 2, 
                           inner_frame_thickness / 2 + filter_depth / 2, 
                           0]) {
                    stick_hole();
                }
                translate([filter_width - outer_frame_thickness * 2 - fabric_thickness * 2 - inner_frame_thickness / 2, 
                           inner_frame_thickness / 2 + filter_depth / 2, 
                           0]) {
                    stick_hole();
                }
            }
        }
        translate([0, filter_depth / 2 + stick_spacing, 0]) {
            cube([filter_width, 
                  display_y_gap, 
                  filter_height]);
        }
    }

    // middle bar
    translate([inner_frame_thickness, 
               filter_depth / 2 - inner_frame_thickness / 2 + middle_bar_thickness / 2, 
               inner_frame_height / 2]) {
        cube([filter_width - inner_frame_thickness * 2 - outer_frame_thickness * 2, 
              middle_bar_thickness, 
              middle_bar_thickness]);
    }
    
}


//
// lower part
//

module stick() {
    cylinder(stick_height + fabric_thickness, 
             stick_thickness / 2, 
             stick_thickness / 2, 
             $fn=8);
}

module stick_hole() {
    cylinder(stick_height + stick_hole_margin, 
             stick_thickness / 2 + stick_hole_margin / 2, 
             stick_thickness / 2 + stick_hole_margin / 2, 
             $fn=8);
}

translate([0, 0, 0]) {

    difference() {
        union() {
            // outer frame
            difference() {
                cube([filter_width, 
                      filter_depth + display_y_gap, 
                      filter_height]);
                translate([outer_frame_thickness, 
                           outer_frame_thickness, 
                           0]) {
                    cube([filter_width - outer_frame_thickness * 2, 
                          filter_depth + display_y_gap - outer_frame_thickness * 2, 
                          filter_height]
                    );
                }
            }
            
            // bottom
            difference() {
                cube([filter_width, 
                      filter_depth + display_y_gap , 
                      bottom_thickness]);
                translate([outer_frame_thickness + inner_frame_thickness, 
                           outer_frame_thickness + inner_frame_thickness, 
                           0]) {
                    cube([filter_width - outer_frame_thickness * 2 - inner_frame_thickness * 2, 
                          filter_depth + display_y_gap - outer_frame_thickness * 2 - inner_frame_thickness * 2, 
                          bottom_thickness]
                    );
                }
            }
            
            // corner sticks
            translate([stick_spacing, 
                       stick_spacing, 
                       bottom_thickness]) {
                stick();
            }
            translate([filter_width - stick_spacing, 
                       stick_spacing, 
                       bottom_thickness]) {
                stick();
            }
            translate([stick_spacing, 
                       filter_depth + display_y_gap - stick_spacing, 
                       bottom_thickness]) {
                stick();
            }
            translate([filter_width - stick_spacing, 
                       filter_depth + display_y_gap - stick_spacing,
                       bottom_thickness]) {
                stick();
            }
            
            // middle sticks
            translate([stick_spacing, 
                       filter_depth / 2 + display_y_gap + stick_spacing, 
                       bottom_thickness]) {
                stick();
            }
            translate([filter_width - stick_spacing, 
                       filter_depth / 2 + display_y_gap + stick_spacing, 
                       bottom_thickness]) {
                stick();
            }
        }
        translate([0, filter_depth / 2, 0]) {
            cube([filter_width, 
                  display_y_gap, 
                  filter_height]);
        }
    }
}