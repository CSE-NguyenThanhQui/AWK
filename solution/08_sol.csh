#!/bin/csh -f


set input1 = $1
set input2 = $2
rm -rf finedOutput.txt
awk 'BEGIN {\
command = "cat 08_input.txt | grep /" \
i = 1 \
while (command | getline > 0) { \
	startP[i] = $3 \
	endP[i] = $5 \
	slack[i] = $ 7 \
	print startP[i]" "endP[i] " " slack[i] >> "finedOutput.txt" \
} \
#system(csh"vim finedOutput.txt")  \
} \
{ \
} \
END { \
}' finedOutput.txt
