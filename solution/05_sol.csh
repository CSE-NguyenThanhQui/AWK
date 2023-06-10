#!/bin/csh -f
set input1 = $1
set input2 = $2
set wordCount = $0
awk 'BEGIN {\
lineCount = 0 \
charCount = 0 \
wordCount = 0 \
} \
{ \
lineCount = lineCount + 1 \
blankCount = NF \
wordCount += blankCount \
for (i = 1; i <= length($0); i++) { \
if (substr($0, i, 1) == " ") \
continue \
else \
charCount++ \
} \
} \
END { \
print lineCount \
print charCount \
print wordCount \
}' $input1