#!/bin/sh
##conter of the lines

CurUser="/home/dever"
Mydroid=$CurUser"/mydroid"
Output=$CurUser

##output
CameraFileList=$Output"/Grep_Camera"

CameraFileListC=$Output"/_all_c"
CameraFileListCpp=$Output"/_all_cpp"
CameraFileListH=$Output"/_all_h"
CameraFileListMk=$Output"/_all_mk"
CameraFileListJava=$Output"/_all_java"

OutCameraFileListC=$Output"/all_c"
OutCameraFileListCpp=$Output"/all_cpp"
OutCameraFileListH=$Output"/all_h"
OutCameraFileListMk=$Output"/all_mk"
OutCameraFileListJava=$Output"/all_java"

## STEP1
cd $Mydroid

## STEP2
## c
echo '' > $OutCameraFileListC
grep '\.c\>' $CameraFileListC | while read line; do
    EachFilePath=$Mydroid"/"$line
	wc $EachFilePath -l >> $OutCameraFileListC
done

## cpp
echo '' > $OutCameraFileListCpp
grep '\.cpp\>' $CameraFileListCpp | while read line; do
    EachFilePath=$Mydroid"/"$line
	wc $EachFilePath -l >> $OutCameraFileListCpp
done

## h
echo '' > $OutCameraFileListH
grep '\.h\>' $CameraFileListH | while read line; do
    EachFilePath=$Mydroid"/"$line
	wc $EachFilePath -l >> $OutCameraFileListH
done


## mk
echo '' > $OutCameraFileListMk
grep '\.mk\>' $CameraFileListMk | while read line; do
    EachFilePath=$Mydroid"/"$line
	wc $EachFilePath -l >> $OutCameraFileListMk
done


## java
echo '' > $OutCameraFileListJava
grep '\.java\>' $CameraFileListJava | while read line; do
    EachFilePath=$Mydroid"/"$line
	wc $EachFilePath -l >> $OutCameraFileListJava
done

