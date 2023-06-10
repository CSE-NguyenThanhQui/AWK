#!/bin/csh -f

set input1 = $1

awk 'BEGIN {\
    # Decoration lines\
    printf "%-12s | %-20s | %-20s | %-10s \n", "Path num", "StartPoint", "EndPoint", "Slack" \
    printf "%s%s%s%s\n", "-----------------------", "--------------------", "--------------------", "----------" \
\
    i = 1 \
    command = "cat 06_input.txt | grep Path" \
    while (command | getline > 0) { \
	num = substr($2, 0, length($2) - 1) \
        path[i] = num \
        i++ \
    } \
    i = 1 \
    command = "cat 06_input.txt | grep StartP" \
    command1 = "cat 06_input.txt | grep -A 1 StartP | grep -v StartP | grep /" \
    while (command | getline > 0) { \
        startP[i] = $2 \
        i++ \
    } \
    i = 1 \
    while (command1 | getline > 0) { \
        temp = startP[i] $0 \
        startP[i] = temp\
        i++ \
    } \
    i = 1 \
    command = "cat 06_input.txt | grep EndP" \
    command1 = "cat 06_input.txt | grep -A 1 EndP | grep -v EndP | grep /" \
    while (command | getline > 0) { \
        endP[i] = $2 \
        i++ \
    } \
    i = 1 \
    while (command1 | getline > 0) { \
        temp = endP[i] $0 \
        endP[i] = temp \
        i++ \
    } \
    i = 1 \
    totalSlack = 0 \
    command = "cat 06_input.txt | grep Slack" \
    while (command | getline > 0) { \
        slack[i] = $2 \
        totalSlack += slack[i] \
        i++ \
    } \
    n = i \
    for (j = 1; j < n; j++) { \
        printf "%-12s | %-20s | %-20s | %-10s \n", path[j], startP[j], endP[j], slack[j] \
    } \
    printf "%s%s%s%s\n", "-----------------------", "--------------------", "--------------------", "----------" \
    printf "%59s| %-10s \n", "Total negative slack", totalSlack \
}\
{\
}\
END {\
}' $input1

