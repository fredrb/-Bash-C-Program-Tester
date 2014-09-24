#!/bin/bash
#move problem_nn.c to folder

NN=$1
TO=$2

ls problema_$NN.c 2>/dev/null 1>/dev/null

if [ $? -eq 0 ]; then
	echo "Monvin' this to $2"
	cp problema_$NN.c ../equipe$TO
else
	echo "Not found bro"
fi
