//import("/home/desnot/Bureau/interupteur.stl");
//

module plate(){
    difference(){
        cube([47.5,60,6],true);
        translate([-23,0,2]) cube([4,5,3],true);
        translate([15,0,-2]) cube([5,12,5],true);
        union(){
            translate([0,0,2]) cube([43,56,4],true);
            translate([-21,0,4.7]) rotate([0,10,0]) cube([20,79,5],true);
            translate([21,0,4.7]) rotate([0,-10,0]) cube([20,79,5],true);
            translate([0,0,3]) cube([23.175,79,5],true);
            difference(){
                translate([0,0,2]) cube([4,61,6],true);
                translate([0,0,2]) cube([4,48,6],true);
            }
        }
    }
}
module clips()
{
    difference()
    {
        difference()
        {
            translate([0,0,1]) rotate([90,0,0]) cylinder(60,3.25,3.25,$fn=100,center=true);
            translate([0,0,1.5]) rotate([90,0,0]) cylinder(61,1.75,1.75,$fn=100,center=true);
            translate([0,0,3.7]) rotate([90,0,0]) cylinder(61,1.75,1.75,$fn=100,center=true);
        // translate([0,0,2]) cube([9,60,2],true);
            translate([0,0,1]) cube([45,48,6],true);
        }
        translate([0,26,4]) rotate([40,0,0]) cube([6.5,10,4],true);
        translate([0,-26,4]) rotate([-40,0,0]) cube([6.5,10,4],true);
        translate([0,0,3.5]) cube([6,70,1],true);
    }
}
module conne()
{
   // difference()
   // {
    translate([0,0,0]) cylinder(8,3,2,$fn=100);
    //translate([0,0,0]) cylinder(9,1,1,$fn=100);
   // }
}
module support()
{
    translate([0,0,8]) cube([1,60,4],true);   
    translate([0,0,10.5]) cube([45,60,1],true);   
    translate([0,0,4.5]) rotate([0,90,90]) cylinder(60,1.75,1.75,$fn=100,center=true);
}
module interupteur(){
    difference()
    {  
        union(){
            // solid part
            translate([0,0,3]) clips();
            translate([0,0,3]) plate();
            translate([-10,-9.5,0]) conne();
            translate([10,-9.5,0]) conne();
            translate([-10,9.5,0]) conne();
            translate([10,9.5,0]) conne();
        }
        union(){
            //border to delete
            translate([0,30,-1]) rotate([45,0,0]) cube([50,6,3],true);
            translate([0,-30,-1]) rotate([-45,0,0]) cube([50,6,3],true);
            translate([-23.6,0,-1]) rotate([0,45,0])  cube([6,60,3],true);
            translate([23.6,0,-1]) rotate([0,-45,0])  cube([6,60,3],true);
        }
        translate([17,0,-0.5]) rotate([0,45,0]) cube([5,12,3],true);
        translate([13,0,-0.5]) rotate([0,-45,0]) cube([5,12,3],true);
        
    }
}
mode=""; //"test"
if(mode=="test"){
    translate([-1.1,0,0]) rotate([0,10,0]) interupteur();
    %translate([0,0,0]) support();
}
else
{
    interupteur();
}
