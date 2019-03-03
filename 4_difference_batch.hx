remove -all

set startno {43}
set endno {54}

set ref {1}

[ load E:/hannah/est0.5/reg/$ref.am ] setLabel "ref"

set dirno1 "$startno"
set dirno2 "$startno"
for {set dirno1 "$startno"} {$dirno1 <= $endno} {incr dirno1} {

echo $dirno1
echo $endno

[ load E:/hannah/est0.5/resam/$dirno1.am ] setLabel "image"

set hideNewModules 0
create HxArithmetic "Arithmetic"
"Arithmetic" inputA connect "ref"
"Arithmetic" inputB connect "image"
"Arithmetic" expr0 setState (A-B)
[ "Arithmetic" create ] setLabel "diff"

remove "image"

diff save "Avizo binary" E:/hannah/est0.5/diff/$dirno1.am

remove "diff" "$dirno1.am"
set dirno2 [expr $dirno2+1]
}

remove -all