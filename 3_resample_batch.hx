remove -all
set startno {2}
set endno {54}
set ref {1}
set dirno1 "$startno"
set dirno2 "$startno"
for {set dirno1 "$startno"} {$dirno1 <= $endno} {incr dirno1} { 
echo $dirno1
echo $endno
set hideNewModules 0

[ load E:/hannah/est0.5/reg/$ref.am ] setLabel "ref.am"
[ load E:/hannah/est0.5/reg/$dirno1.am ] setLabel "image.am"

"ref.am" master connect 

set hideNewModules 0
create HxApplyTransform "Resample Transformed Image"
"Resample Transformed Image" data connect "image.am"
"Resample Transformed Image" reference connect "ref.am"
"Resample Transformed Image" fire
"Resample Transformed Image" interpolation setIndex 0 2
"Resample Transformed Image" mode setValue 0
"Resample Transformed Image" preserve setValue 0
"Resample Transformed Image" paddingValue setMinMax 0 -3.40282346638529e+038 3.40282346638529e+038
"Resample Transformed Image" paddingValue setValue 0 0
"Resample Transformed Image" applyTransformToResult 0
"Resample Transformed Image" fire
"Resample Transformed Image" setViewerMask 65535
"Resample Transformed Image" setPickable 1

set hideNewModules 0
[ "Resample Transformed Image" create
 ] setLabel "image.Resampled"
"image.Resampled" setIconPosition 177 203
"image.Resampled" master connect "Resample Transformed Image"
"image.Resampled" fire

remove image.am

"image.Resampled" save "Avizo binary" E:/hannah/est0.5/resam/$dirno1.am
set dirno2 [expr $dirno2+1]
remove -all
}