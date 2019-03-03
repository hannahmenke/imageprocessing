remove -all
set startno {2}
set endno {54}
set dirno1 "$startno"
set dirno2 "$startno"
for {set dirno1 "$startno"} {$dirno1 <= $endno} {incr dirno1} { 
echo $dirno1
echo $endno
set hideNewModules 0
[ load D:/hannah/est0.5/difffilt/$dirno1.am ] setLabel "diff"

"diff" master connect 

create HxImageFilters "Non-Local Means Filter"
"Non-Local Means Filter" setFilter 15
"Non-Local Means Filter" setFilterOrientation 2
"Non-Local Means Filter" fire
"Non-Local Means Filter" searchWindow setMinMax 0 1 2147483648
"Non-Local Means Filter" searchWindow setValue 0 21
"Non-Local Means Filter" neighborhood setMinMax 0 1 2147483648
"Non-Local Means Filter" neighborhood setValue 0 5
"Non-Local Means Filter" similarityValue setMinMax 0 9.99999974737875e-005 3.40282346638529e+038
"Non-Local Means Filter" similarityValue setValue 0 1.4
"Non-Local Means Filter" adaptive setValue 1
"Non-Local Means Filter" device setValue 0
"Non-Local Means Filter" cudaDevice setIndex 0 0
"Non-Local Means Filter" options setValue 0 0
"Non-Local Means Filter" options setToggleVisible 0 1
"Non-Local Means Filter" partitionSize setMinMax 0 9.99999997475243e-007 100
"Non-Local Means Filter" partitionSize setValue 0 100
"Non-Local Means Filter" data connect "diff"
"Non-Local Means Filter" applyTransformToResult 1
"Non-Local Means Filter" fire
"Non-Local Means Filter" setViewerMask 65535
"Non-Local Means Filter" setPickable 1

set hideNewModules 0
[ "Non-Local Means Filter" doIt hit; "Non-Local Means Filter"  fire;  "Non-Local Means Filter" getResult
 ] setLabel "filtered"

"filtered" master connect "Non-Local Means Filter"
"filtered" fire
"filtered" setViewerMask 65535

remove "diff"

"filtered" save "Avizo binary" D:/hannah/est0.5/diffrefilt/$dirno1.am

set dirno2 [expr $dirno2+1]
remove -all
}