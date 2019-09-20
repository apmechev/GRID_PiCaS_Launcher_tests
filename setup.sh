#!/bin/env bash
source increment_version.sh

export BASE_DIR=$PWD
git clone https://github.com/apmechev/GRID_LRT.git && \
cd GRID_LRT && \
export LRT_LATEST_TAG=$( git tag -l |tail -1 ) && \
git checkout $LRT_LATEST_TAG && \
cd $BASE_DIR

git clone https://github.com/apmechev/GRID_PiCaS_Launcher.git && \
cd GRID_PiCaS_Launcher && \ # Determines the next tag for the GRID_LRT or GRID_PiCaS_Launcher

if [[ ! -z $( git tag -l |grep $LRT_LATEST_TAG ) ]]; then
	echo "Tag $LRT_LATEST_TAG exists in PiCaS_Launcher"; 
	export LRT_NEXT_TAG=$( increment_version $LRT_LATEST_TAG );
	export LAUNCHER_NEXT_TAG=$LRT_NEXT_TAG; 
else
	echo "New tag $LRT_LATEST_TAG will be added to PiCaS_Launcher";
	export LRT_NEXT_TAG=$LRT_LATEST_TAG;
	export LAUNCHER_NEXT_TAG=$LRT_LATEST_TAG;
fi



