#!/bin/sh
##conter of the lines

CurUser="/home/dever"
Mydroid=$CurUser"/mydroid"
Output=$CurUser

##output
CameraFileList=$Output"/Grep_Camera"

FileCntFiles=$Output"/TMP_CntFiles"
FileCntLines=$Output"/TMP_CntLines"

declare -a AllFilesType=("C" "CPP" "H" "MK" "JAVA")
declare -a CntAllFiles=(0 0 0 0 0)
declare -a CntAllLines=(0 0 0 0 0)

## function statline(_grep,_headMsg,_outputFile,_cntIndex)
## $1 : grep命令用関数
## $2 : head message,ファイルメッセージ
## $3 : outputファイル
## $4 : index
statline()
{
    declare -i CntFiles=0
    declare -i CntLines=0
    echo 0 > $FileCntFiles
    echo 0 > $FileCntLines

    echo "========================================" > $3
    echo "== File List" >> $3
    echo "== " >> $3
    echo "== Android全部のファイルの中に、'camera'を含めるファイルのリスト" >> $3
    echo "== " >> $3
    echo "== "$2 >> $3
    echo "== " >> $3
    echo "========================================" >> $3

    grep $1 $CameraFileList | while read line; do
        EachFilePath=$Mydroid"/"$line

        ##count of files
	    ((CntFiles++))
	    echo $CntFiles > $FileCntFiles

	    ##count of lines
        CntLinesEach=$(echo $(wc -l $EachFilePath) | cut -d ' ' -f 1)
	    ((CntLines=CntLines+CntLinesEach))
	    echo $CntLines > $FileCntLines

        ##output to file
	    wc $EachFilePath -l >> $3
    done

    CntFiles=$(cat $FileCntFiles)
    CntLines=$(cat $FileCntLines)

    echo "" >> $3
    echo "========================================" >> $3
    echo "== 合計：" >> $3
    echo "== " >> $3
    echo "== ALL FILES : "$CntFiles >> $3
    echo "== " >> $3
    echo "== ALL LINES : "$CntLines >> $3
    echo "========================================" >> $3
    
    rm $FileCntFiles
    rm $FileCntLines
    
    ##return count
    ((CntAllFiles[$4]=CntFiles))
    ((CntAllLines[$4]=CntLines))
}

## append message to output file
## $1 : output file
appendstatmessage()
{
    CntAllStatFiles=0
    CntAllStatLines=0
    
    echo "" >> $1
    echo "========================================" >> $1
    echo "== 合計(ファイル数,行数)：" >> $1
    echo "== " >> $1
    for ((i=0;i<5;i++)); do
        echo "== "${AllFilesType[$i]}" ("${CntAllFiles[$i]}", "${CntAllLines[$i]}")" >> $1
        
        ##stat
        CntAllStatFiles=$(($CntAllStatFiles+${CntAllFiles[$i]}))
        CntAllStatLines=$(($CntAllStatLines+${CntAllLines[$i]}))
    done
    echo "== " >> $1
    echo "== 総合計：" >> $1
    echo "==ファイル数： "$CntAllStatFiles >> $1
    echo "==行数： "$CntAllStatLines >> $1
    echo "========================================" >> $1
}


## STEP1
cd $Mydroid
grep -i -r -l 'camera' * > $CameraFileList


## STEP2
CameraFileListC=$Output"/Grep_Camera_C"
CameraFileListCpp=$Output"/Grep_Camera_CPP"
CameraFileListH=$Output"/Grep_Camera_H"
CameraFileListMk=$Output"/Grep_Camera_MK"
CameraFileListJava=$Output"/Grep_Camera_JAVA"

## find out all the head file in $CameraFileList
## function statline(_grep,_headMsg,_outputFile,_cntIndex)
## c file
statline "\.c\>" ".c file" $CameraFileListC 0
## cpp file
statline "\.cpp\>" ".cpp file" $CameraFileListCpp 1 
## head file
statline "\.h\>" ".h file" $CameraFileListH 2
## mk file
statline "\.mk\>" ".mk file" $CameraFileListMk 3
## java file
statline "\.java\>" ".java file" $CameraFileListJava 4

## append message to output file
## $1 : output file
## c file
appendstatmessage $CameraFileListC
## cpp file
appendstatmessage $CameraFileListCpp
## head file
appendstatmessage $CameraFileListH
## mk file
appendstatmessage $CameraFileListMk
## java file
appendstatmessage $CameraFileListJava



