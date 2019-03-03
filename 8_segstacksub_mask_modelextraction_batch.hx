remove -all
#### mask image, extract subvolume, and convert to binary by Hannah Menke on 20 April 2015. Email: h.menke12@imperial.ac.uk



#### USER INPUT set first and last scan numbers that you would like segmented
set ref {18}
set first {19}
set last {52}

#### END USER INPUT

set loopno "$first"
set loopno2 "$ref"

[ load D:/hannah/est0.5/segref/mask.am ] setLabel "mask"
[ load D:/hannah/est0.5/segref/maskneg.am ] setLabel "maskneg"


for {set loopno "$first"} {$first <= $last} {incr loopno} {
echo $loopno
echo $last
echo $loopno2

#### USER INPUT set input directory and directory of avizo script objects
[ load D:/hannah/est0.5/segdiffphase/segdiffphase_$loopno.am ] setLabel "new"

[ load D:/hannah/est0.5/segmasked/segmasked_$loopno2.am ] setLabel "old"

#### END USER INPUT

set hideNewModules 0
create HxArithmetic "Arithmetic2"
"Arithmetic2" inputA connect "old"
"Arithmetic2" inputB connect "new"
"Arithmetic2" expr0 setState (A-B)
[ "Arithmetic2" create ] setLabel "newold"

###newold save "Avizo binary" D:/hannah/est0.5/segdiffsub/segdiffsub_$loopno.am

set hideNewModules 0
create HxArithmetic "Arithmetic3"
"Arithmetic3" inputA connect "newold"
"Arithmetic3" inputB connect "mask"
"Arithmetic3" inputC connect "maskneg"
"Arithmetic3" expr0 setState (A*B+C)
[ "Arithmetic3" create ] setLabel "newmasked"

newmasked save "Avizo binary" D:/hannah/est0.5/segmasked/segmasked_$loopno.am

set hideNewModules 0
create HxLatticeAccess "Extract Subvolume"
"Extract Subvolume" setIconPosition 295 119
"Extract Subvolume" setVar "CustomHelp" {HxLatticeAccess}
"Extract Subvolume" data connect "segmasked_$loopno.am"
"Extract Subvolume" time disconnect
"Extract Subvolume" time setMinMax 0 1
"Extract Subvolume" time setSubMinMax 0 1
"Extract Subvolume" time setValue 0
"Extract Subvolume" time setDiscrete 0
"Extract Subvolume" time setIncrement 0.01
"Extract Subvolume" time animationMode -once
"Extract Subvolume" fire
"Extract Subvolume" dataset setIndex 0 0
"Extract Subvolume" boxUnits setValue 0
"Extract Subvolume" boxMin setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxMin setValue 0 0
"Extract Subvolume" boxMin setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxMin setValue 1 0
"Extract Subvolume" boxMin setMinMax 2 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxMin setValue 2 100
"Extract Subvolume" boxSize setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxSize setValue 0 747
"Extract Subvolume" boxSize setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxSize setValue 1 750
"Extract Subvolume" boxSize setMinMax 2 -3.40282346638529e+038 3.40282346638529e+038
"Extract Subvolume" boxSize setValue 2 800
"Extract Subvolume" options setValue 0 0
"Extract Subvolume" options setToggleVisible 0 1
"Extract Subvolume" options setValue 1 0
"Extract Subvolume" options setToggleVisible 1 1
"Extract Subvolume" options setValue 2 1
"Extract Subvolume" options setToggleVisible 2 0
"Extract Subvolume" subsample setMinMax 0 -16777216 16777216
"Extract Subvolume" subsample setValue 0 4
"Extract Subvolume" subsample setMinMax 1 -16777216 16777216
"Extract Subvolume" subsample setValue 1 4
"Extract Subvolume" subsample setMinMax 2 -16777216 16777216
"Extract Subvolume" subsample setValue 2 4
"Extract Subvolume" timeSlider setMinMax 0 0
"Extract Subvolume" timeSlider setButtons 1
"Extract Subvolume" timeSlider setEditButton 1
"Extract Subvolume" timeSlider setIncrement 1
"Extract Subvolume" timeSlider setValue 0
"Extract Subvolume" timeSlider setSubMinMax 0 0
"Extract Subvolume" applyTransformToResult 1
"Extract Subvolume" fire
"Extract Subvolume" setViewerMask 49151
"Extract Subvolume" setPickable 1

set hideNewModules 0
[ "Extract Subvolume" create ] setLabel "modelextracted"


set hideNewModules 0
create HxCastField "Convert Image Type"
"Convert Image Type" setIconPosition 168 190
"Convert Image Type" setVar "CustomHelp" {HxCastField}
"Convert Image Type" data connect "modelextracted"
"Convert Image Type" colormap setDefaultColor 1 0.8 0.5
"Convert Image Type" colormap setDefaultAlpha 0.500000
"Convert Image Type" colormap setLocalRange 1
"Convert Image Type" colormap setLocalMinMax 1.000000 8.000000
"Convert Image Type" colormap enableAlpha 1
"Convert Image Type" colormap enableAlphaToggle 1
"Convert Image Type" colormap setAutoAdjustRangeMode 1
"Convert Image Type" colormap setColorbarMinMax 1 8
"Convert Image Type" colormap connect "labels.am"
"Convert Image Type" fire
"Convert Image Type" outputType setIndex 0 0
"Convert Image Type" scaling setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038
"Convert Image Type" scaling setValue 0 1
"Convert Image Type" scaling setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038
"Convert Image Type" scaling setValue 1 0
"Convert Image Type" voxelGridOptions setValue 0 1
"Convert Image Type" voxelGridOptions setToggleVisible 0 1
"Convert Image Type" colorFieldOptions setIndex 0 0
"Convert Image Type" applyTransformToResult 1
"Convert Image Type" fire
"Convert Image Type" setViewerMask 49151
"Convert Image Type" setPickable 1

set hideNewModules 0
[ "Convert Image Type" create
 ] setLabel "model8bit"


model8bit save "Raw Data 3D" D:/hannah/est0.5/modelbinary/$loopno.raw


remove "Arithmetic2" "Arithmetic3" "segphase_$loopno.am" "segdiffsub_$loopno.am" "new" "old" "newold" "$loopno.am" "segmasked_$loopno.am" "modelextracted" "newmasked" "model8bit"

set loopno2 [expr $loopno2+1]

}

remove -all