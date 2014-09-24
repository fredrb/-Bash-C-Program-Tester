#!/bin/bash

echo "Test dir : $1"
echo "Source dir : $2"
 
test_dir=$1
src_dir=$2

#ORIGINAL PATH 
opath=$(pwd)

#STATUS FINAL
stats=0

#COMPILER FLAGS
CC="gcc"
FLAGS="-o"

function goto_src(){ cd $opath; cd $src_dir; }
function goto_test(){ cd $opath; cd $test_dir; }

function compile(){
	file=$1
	out=$2
	$CC $file $FLAGS $out.out  2>/dev/null 1>/dev/null
}

function exists(){
	PROB=$1
	ls $1* 2>/dev/null 1>/dev/null
	return $?
}

function tests(){
	$program=$1
	$prob=$2
	goto_test
	cd $prob	
	for i in 1000 ; do
		if ((i > 9)) ; then
			if ! $(ls $i*) ; then
				echo "Break"
				break
			fi
		else
			if ! $(ls 0$i*) ; then
				echo "Break"
				break		
			fi
		fi
		if ((i > 9)) ; then
			xin=$(cat $i_INPUT)
			out=$(cat $i_OUTPUT)
		else
			xin=$(cat 0$i_INPUT)
			xout=$(cat 0$i_OUTPUT)
		fi
		$program $xin > result
	done
	goto_src
}

if ! test -d $test_dir ; then
	echo Test directory not valid!
	exit 2
fi

goto_test
for prob in $(ls) ; do
	goto_src
	exists $prob
	if [ $? -ne 0 ] ; then
	 echo "$prob nao foi enviado " 
	 stats=1
	else
	 #echo $prob
	 compile $prob.c $prob
	 if [ $? -ne 0 ] ; then
		echo $prob.c nao compilou com sucesso, veja o log.
		stats=l
	 else	
		wdir=$(pwd)/$prob.out
		tests $wdir $prob
	 fi
	fi
done


	
	
