#!/bin/csh -f

set input1 = $1

awk 'BEGIN {\
}\
{\
        count[$0]++\
}\
END {\
	n = asorti(count, sorted)\
        for (i = 1; i <= n; i++) {\
            line = sorted[i]\
            print line, count[line]\
        }\
    }' $input1



