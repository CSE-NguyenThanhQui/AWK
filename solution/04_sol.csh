#!/bin/csh -f  

set input1 = $1
set input2 = $2

awk 'BEGIN  {\
        i = 1 \
        lineCount = 0 \
        fre = 0 \
	'$input2' \
} \
{ \
        lineCount++  \
        arr[i] = substr($0, 0, 2 * '$input2' - 1) \
        i++ \
} \
END { \
        n = asort(arr) \
        temp = 0 \
        for (i = 1; i <= lineCount; i++) { \
                #print arr[i] \
        } \
        for (i = 1; i <= lineCount; i++) { \
                for (j = i; j <= lineCount; j++) { \
                        if (arr[j] == arr[i]) { \
                                fre++; \
                                temp = j \
                        } \
                } \
                print arr[i]" " fre \
                fre = 0 \
                i = temp \
        } \
}' $input1

