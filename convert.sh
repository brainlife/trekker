#!/bin/bash

holder=(*track*.vtk)

for tractograms in ${holder[*]}; do
	tckconvert ${tractograms} ${tractograms::-4}.tck
done
	
tcks=(*track*.tck)
output=./track/track.tck

if [ ${#tcks[@]} == 1 ]; then
	mv ${tcks[0]} ${output}
else
	tckedit ${tcks[*]} $output
fi
tckinfo $output > ./track/track_info.txt

# clean up
if [ -f ./track/track.tck ]; then
	rm -rf *.mif *.b* ./tmp *.nii.gz*
else
	echo "tracking failed"
	exit 1;
fi

