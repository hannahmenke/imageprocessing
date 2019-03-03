remove -all
#### Watershed segmentation batch script for Avizo 9.0.0-rc-2 beta by Hannah Menke on 15 Jan 2015. Email: h.menke12@imperial.ac.uk



#### USER INPUT set first and last scan numbers that you would like segmented
set first {2}
set last {54}
#### END USER INPUT

set loopno "$first"
set loopno2 "first"


for {set loopno "$first"} {$first <= $last} {incr loopno} {
echo $loopno
echo $last

#### USER INPUT set input directory and directory of avizo script objects
[ load D:/hannah/est0.5/diffrefilt/$loopno.am ] setLabel "new"
load "C:/Program Files/Avizo-9.0.0/share/script-objects/WatershedSegmentation2.scro"
#### END USER INPUT


"Watershedsegmentation2_Scro" data connect "new"
Watershedsegmentation2_Scro fire
#trigger 1st action if num phases == 3
"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire
#trigger gradient computation
"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire


##### USER INPUT set gradient thresholding and trigger next step
"Watershedsegmentation2_Scro" "gradientThreshold" setValue 4500
#### END USER INPUT

"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire


##### USER INPUT set Threshold phase 0 and trigger next step
"Watershedsegmentation2_Scro" slider0 setMinMax 0 2500
#### END USER INPUT


"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire


##### USER INPUT set Threshold phase 1 and trigger next step
"Watershedsegmentation2_Scro" slider1 setMinMax 2500 65534
#### END USER INPUT

"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire


##### USER INPUT set Threshold phase 2 and trigger next step
"Watershedsegmentation2_Scro" slider2 setMinMax 65535 65535
#### END USER INPUT

"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire
#Trigger Watershed
"Watershedsegmentation2_Scro" action hit 2
Watershedsegmentation2_Scro fire

#### USER INPUT set saving directory
basins save "Avizo binary" D:/hannah/est0.5/segdiffbasins/segdiffbasins_$loopno.am
#### END USER INPUT

set hideNewModules 0
create HxArithmetic "Arithmetic1"
"Arithmetic1" inputA connect "segdiffbasins_$loopno.am"
"Arithmetic1" expr0 setState (A==2)
[ "Arithmetic1" create ] setLabel "segdiffphase"

segdiffphase save "Avizo binary" D:/hannah/est0.5/segdiffphase/segdiffphase_$loopno.am

remove "new" "basins" "WatershedSegmentation2.scro" "$loopno.am" "segdiffbasins_$loopno.am" "segdiffphase_$loopno.am" "segdiffsub_$loopno.am"

set loopno2 [expr $loopno+1]

}

remove -all