#!/bin/csh -f

set input1 = $1
set input2 = $2

awk 'BEGIN { \
    i = 1 \
    lineCount = 0 \
    fre = 0 \
    '$input2' \
} \
{ \
    lineCount++  \
    ele[i] = $0 \
    i++ \
} \
END { \
    printf "%-8s | %-6s | %-6s | %-20s \n", "WNS", "TNS", "NVP", "module2module" \
    printf "%s%s%s%s\n", "----------------", "------", "------", "--------------------" \
    for (i = 1; i <= lineCount; i++) { \
        tempString = ele[i] \
        subStart[i] = substr(ele[i], 0, 2 * '$input2' - 1) \
        subEnd[i] = substr(tempString, index(tempString, " ") + 1, 2 * '$input2' - 1) \
        slack[i] = substr(tempString, index(tempString, "-")) \
        extract[i] = subStart[i] " -> " subEnd[i] \
    } \
    temp = 0 \
    total = 0 \
    min = 999 \
    flag = 0 \
    sumT = 0 \
    sumMin = 999 \
    count = 0 \
    for (i = 1; i <= lineCount; i++) { \
        for (j = i; j <= lineCount; j++) { \
            if (extract[j] == extract[i]) { \
                fre++ \
                total += slack[j] \
                if (min + 0 > slack[j] + 0){ \
                    min = slack[j] \
                } \
                temp = j \
            } \
        } \
        printf "%-8s | %-6s | %-6s | %-20s \n", min, total, fre, extract[temp] \
        sumT += total \
        count += fre \
        if (slack[temp] + 0 < sumMin + 0) sumMin = slack[temp] \
        min = 999 \
        fre = 0 \
        total = 0 \
        i = temp \
    } \
    printf "%s%s%s%s\n", "----------------", "------", "------", "--------------------" \
    printf "%-8s | %-6s | %-6s | %-20s \n", sumMin, sumT, count, "" \
}' $input1
