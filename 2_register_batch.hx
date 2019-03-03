remove -all

set startno {2}

set endno {3}

set refscan {1}
set dirno1 "$startno"

set dirno2 "$startno"


for {set dirno1 "$startno"} {$dirno1 <= $endno} {incr dirno1} 
{ 
set hideNewModules 0

[ load E:/hannah/ketton/$loopno.am ] 
setLabel "filtered"


#### LOAD REFERENCE SAMPLE


set hideNewModules 0
[ load E:/hannah/ketton/$refscan.am ] 
setLabel "refscan.am"

"filtered" setIconPosition 20 76

"filtered" master connect 

refscan.view crop 300 500 300 500 300 500

filtered.view crop 300 500 300 500 300 500


set hideNewModules 0

create HxAffineRegistration "Register Images"

"Register Images" model connect "filtered.view"

"Register Images" reference connect "refscan.view"

"Register Images" reference2 disconnect

"Register Images" reference3 disconnect

"Register Images" fire

"Register Images" optimizer setIndex 0 0

"Register Images" optimizer setIndex 1 0

"Register Images" extensiveSearch setValue 0 0

"Register Images" extensiveSearch setToggleVisible 0 1

"Register Images" step setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" step setValue 0 100

"Register Images" step setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" step setValue 1 0.16666667163372

"Register Images" nLevelsGradient setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" nLevelsGradient setValue 0 1

"Register Images" nLevelsGradient setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" nLevelsGradient setValue 1 9.99999974737875e-005

"Register Images" coarsestResolution setMinMax 0 1 250

"Register Images" coarsestResolution setValue 0 16

"Register Images" coarsestResolution setMinMax 1 1 250

"Register Images" coarsestResolution setValue 1 16

"Register Images" coarsestResolution setMinMax 2 1 250

"Register Images" coarsestResolution setValue 2 16

"Register Images" metric setIndex 0 1

"Register Images" histogramRangeRef setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" histogramRangeRef setValue 0 10172

"Register Images" histogramRangeRef setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" histogramRangeRef setValue 1 64130

"Register Images" histogramRangeMod setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" histogramRangeMod setValue 0 9481

"Register Images" histogramRangeMod setMinMax 1 -3.40282346638529e+038 3.40282346638529e+038

"Register Images" histogramRangeMod setValue 1 63494

"Register Images" histogramBins setMinMax 0 -16777216 16777216

"Register Images" histogramBins setValue 0 255

"Register Images" histogramBins setMinMax 1 -16777216 16777216

"Register Images" histogramBins setValue 1 255

"Register Images" options setValue 0 1

"Register Images" options setToggleVisible 0 1

"Register Images" options2 setValue 0 0

"Register Images" options2 setToggleVisible 0 1

"Register Images" transform setValue 0 1

"Register Images" transform setToggleVisible 0 1

"Register Images" transform setValue 1 0

"Register Images" transform setToggleVisible 1 1

"Register Images" transform setValue 2 0

"Register Images" transform setToggleVisible 2 1

"Register Images" transform setValue 3 0

"Register Images" transform setToggleVisible 3 1

"Register Images" register setValue 1

"Register Images" extendedOptions setValue 0 0

"Register Images" extendedOptions setToggleVisible 0 1

"Register Images" applyTransformToResult 1

"Register Images" fire

"Register Images" setViewerMask 65535

"Register Images" select

"Register Images" setPickable 1

"Register Images" action setValue 2 1

"Register Images" fire


set hideNewModules 0

#### Transform the new image to the subvolume registeration value ####


set scale [filtered.view getScaleFactor]

set trans [filtered.view getTranslation]

set rot [filtered.view getRotation]


set scale_1 [lindex $scale 0]

set scale_2 [lindex $scale 1]

set scale_3 [lindex $scale 2]


set trans_1 [lindex $trans 0]

set trans_2 [lindex $trans 1]

set trans_3 [lindex $trans 2]


set rot_1 [lindex $rot 0]

set rot_2 [lindex $rot 1]

set rot_3 [lindex $rot 2]

set rot_4 [lindex $rot 3]


filtered setScaleFactor $scale_1 $scale_2 $scale_3

filtered setTranslation $trans_1 $trans_2 $trans_3

filtered setRotation $rot_1 $rot_2 $rot_3 $rot_4


filtered save "Avizo binary" E:/hannah/reg/$dirno1.am


set dirno2 [expr $dirno2+1]


remove -all

}
