// Wristband for "Swatch" watch models, 17mm strap width, with two cutouts in each watch pin cylinder
// Printed successfully on Dremel3d20, high resolution/slow speed setting, using TPC FLEX 45 flexible filament
// Jan Borchers, RWTH Aachen University, http://hci.rwth-aachen.de/borchers

// This version is a remix of the work of the person above!
//This version is adjusted for watches 20 millimeters wide and is slightly thicker in terms of the tongue, band, and where the strap meets the watch.
//Can also be printed on an Ender 3 with TPU shore hardness 95 without modifications.
$fn=32;

// These parameters can be changed as needed:
tongue_length=90; // Length of "tongue" band, excluding elliptical bottom end
buckle_length=75; // Length of "buckle" band

// Changing these parameters will require adjusting pin cylinders manually:
strap_width=20-1; // Strap width, one less than actual length
strap_thickness=2; // Strap thickness, originally 1.6


module trapezoid(width_base, width_top,height,thickness) { // Helper function to create a trapezoid

  linear_extrude(height = thickness) polygon(points=[[0,0],[width_base,0],[width_base-(width_base-width_top)/2,height],[(width_base-width_top)/2,height]], paths=[[0,1,2,3]]); 
  
}

module tongue() { // The "tongue" band with holes
    difference() {
        union() {
            difference() {
                union() {
                    cube([tongue_length-strap_width/2,strap_width,strap_thickness]); // Strap
                    translate([0,-0.5,strap_thickness])rotate([-90,0,0]) cylinder(r=strap_thickness,h=strap_width+1); // Cylinder around watch pin
                }
                translate([-2,4.5,-1]) cube([5.5,2.5,2*strap_thickness+2]); // Left cutout in watch pin cylinder
                translate([-2,12,-1]) cube([5.5,2.5,2*strap_thickness+2]); // Right cutout in watch pin cylinder
            }
            translate([3.5+20,0,0]) rotate([0,0,90]) trapezoid(width_base=strap_width, width_top=strap_width+2*2, height=20, thickness=strap_thickness); // Broaden the top end
            translate([tongue_length-strap_width/2,strap_width/2,0]) scale([3,1,1]) cylinder(r=strap_width/2,h=strap_thickness); // Add round elliptical bottom end
            }

        translate([0,-1,strap_thickness]) rotate([-90,0,0]) cylinder(r=1, h=strap_width+2); // Punch hole into watch pin cylinder

        for (x=[30:7:tongue_length-10]) // Punch holes into strap, 7mm apart
            translate([x,strap_width/2,-1]) scale([1,.7,1]) cylinder(r=1.5,h=strap_thickness+3);
        }
    }
    
module buckle() { // The "buckle" band with buckle and pin
    difference() {
        union() {
            difference() {
                union() {
                    cube([buckle_length,strap_width,strap_thickness]); // Strap
                    translate([0,-0.5,strap_thickness]) rotate([-90,0,0]) cylinder(r=strap_thickness,h=strap_width+1); // Cylinder around watch pin
                }
                translate([-2,4.5,-1]) cube([6.5,2.5,2*strap_thickness+2]); // Left cutout in watch pin cylinder
                translate([-2,12,-1]) cube([6.5,2.5,2*strap_thickness+2]); // Right cutout in watch pin cylinder
            }
            translate([3.5+20,0,0]) rotate([0,0,90]) trapezoid(width_base=strap_width, width_top=strap_width+2*2, height=20, thickness=strap_thickness); // Broaden the top end
            translate([buckle_length,0,strap_thickness+0.25]) rotate([-90,0,0]) cylinder(r=strap_thickness+0.25,h=strap_width);  // Add bottom cylinder for buckle pin
        }

        translate([0,-1,strap_thickness]) rotate([-90,0,0]) cylinder(r=1, h=strap_width+2);  // Punch hole into watch pin cylinder
        translate([buckle_length,-1,strap_thickness+0.25]) rotate([-90,0,0]) cylinder(r=1, h=strap_width+2); // Punch hole into buckle pin cylinder

        translate([buckle_length,strap_width/2,strap_thickness]) scale([1,1/*.7*/,1]) cube([5,2.7/*2*/,5], center=true); // Center cutout in buckle pin cylinder
        }
    }
    
module hold() { // Rectangular moveable sleeve, slides onto buckle band, to stick tongue band through and hold it in place
    translate([0,-strap_thickness-1,0]) difference() {
        cube([4*strap_thickness+2,strap_width+2*strap_thickness+2,10]);
        translate([strap_thickness,strap_thickness,-1]) cube([2*strap_thickness+2,strap_width+2,10+2]);
        }
    }
    
module band() { // Create all parts - comment out parts you wish to skip
    tongue();
    translate([0,2*strap_width,0]) buckle();
    translate([buckle_length+strap_width,2*strap_width,0]) hold();
    }
//cube([4.5,22,5]);
//-----------------------------
module atache1()
{
	n=25;
	difference()
    {
		difference()
        {
			union(){
				translate([0,0,0]) cube([5,20,4],center=true);
				translate([-2,0,0]) rotate([90,90,0]) cylinder(r=2,h=20,$fn=100,center=true);
			}			
			translate([-2.4,0,-0.6])
            rotate([90,90,0]) cylinder(r=0.5,h=n,center=true,$fn=100);
		}
		translate([-1,-3.5,0]) cube([7,2.5,6],true);
		translate([-1,3.5,0]) cube([7,2.5,6],true);
	}	
    translate([2.5,0,0]) cube([3,22,4],true);
}
module atache2()
{
    difference(){
       union(){
           translate([5.5,0,0]) cube([3,22,4],true);
           translate([7.5,0,0]) rotate([0,90,90]) cylinder(r=2,h=22,$fn=100,center=true);
       }
       union(){
       translate([8,0,0]) cube([6,13,5],true);
       translate([7.5,0,0]) rotate([0,90,90]) cylinder(r=0.5,h=23,$fn=100,center=true);
       }
    }
}

module atache3()
{
    difference(){
        union(){
            translate([2.5,0,0]) cube([3,12.5,4],true);
            translate([1,0,0]) rotate([0,90,90]) cylinder(r=2,h=12.5,$fn=100,center=true);
        }
        translate([1,0,0]) rotate([0,90,90]) cylinder(r=0.5,h=12.7,$fn=100,center=true);
    }
    translate([4,0,0]) cube([2,22,4],true);
}


//%band();
//tongue();
//test_part();
//translate([24,19,0]) rotate([0,0,180]) test_part2();
atache1();
translate([3,0,0]) atache2();
translate([9.5,0,0]) atache3();
//translate([-10,0,0]) test_part2();
