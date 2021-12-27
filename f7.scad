filter_width = 170; 
filter_height = 30; 
filter_depth = 330;
frame_thickness = 8;
hook_length = 8;
hook_thickness = 5;
hook_end_width = hook_thickness * 2;
hook_spacing_width = 39;
hook_spacing_depth = 39;
hook_offset_width = 18;
hook_offset_depth = 20;
middle_bar_thickness = 5;

module hook(x, y) {
    translate([x, y, filter_height / 2])
        rotate([0, 90, 0]) 
        cylinder(hook_length, hook_thickness / 2, hook_thickness / 2, $fn=8);
    translate([x + hook_length, y + hook_end_width / 2, (filter_height) / 2])
        rotate([90, 0, 0]) 
        cylinder(hook_end_width, hook_thickness / 2, hook_thickness / 2, $fn=8);
}

difference(){
    cube([filter_width, filter_depth, filter_height]);
    translate([frame_thickness, frame_thickness, 0])
        cube([
            filter_width - frame_thickness * 2, 
            filter_depth - frame_thickness * 2, 
            filter_height]
        );
}

translate([frame_thickness, filter_depth / 2, (filter_height - middle_bar_thickness) / 4])
    cube([filter_width - frame_thickness * 2, middle_bar_thickness, middle_bar_thickness]);

for (y = [frame_thickness + hook_offset_depth : hook_spacing_depth : filter_depth]) {
    hook(frame_thickness, y);
    rotate([180, 180, 0])
        hook(-filter_width + frame_thickness, y - filter_depth);
}

for (x = [frame_thickness + hook_offset_width : hook_spacing_width : filter_width]) {
    rotate([0, 0, 90]) 
        hook(frame_thickness / 2 + filter_width - filter_depth / 2 -hook_thickness / 2, 
             x - filter_width);
    rotate([0, 180, 90])
        translate([0, 0, -filter_height])
        hook(frame_thickness / 2 + filter_width - filter_depth / 2 * 3 -hook_thickness / 2, 
             x - filter_width);
}
