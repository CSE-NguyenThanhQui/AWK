#!/bin/csh -f

set input1 = $1
set input2 = $2
set mode = $3
set number1 = $4
set number2 = $5

rm -rf 02_com1.txt 02_com2.txt 02_same.txt 02_diff.txt 02_full.txt

# sort column and lines for 02_input1.txt and 02_input2.txt

awk 'BEGIN{\
   column = "column";\
   line = "line";\
}\
{\
   if ('$mode' == line){\
      if (FNR == NR) {\
         if (NR == '$number1') {\
            for (i = 1; i <= NF; i++) {\
               line1[i] = $i;\
               count1++;\
            }\
         }\
      } else {\
         if (FNR == '$number2') {\
            for (i = 1; i <= NF; i++) {\
               line2[i] = $i;\
               count2++;\
            }\
         }\
      }\
   } else if ($mode == column){\
      if (FNR == NR) {\
         line1[FNR] = $'$number1';\
         count1++;\
      } else {\
         line2[FNR] = $'$number2';\
         count2++;\
      }\
   }\
}\
END {\
   for (i = 1; i <= count1; i++) {\
      print line1[i] >> "02_com1.txt";\
   }\
   for (i = 1; i <= count2; i++) {\
      print line2[i] >> "02_com2.txt";\
   }\
}' $input1 $input2

# combine two files

awk 'BEGIN{ \
   i = 1; \
   n = 1; \
   while ((getline < "02_com2.txt") > 0 ) {\
      a[i] = $1;\
      i++;\
      print $1 >> "02_full.txt";\
   }\
   close ("02_com2.txt");\
   while ((getline < "02_com1.txt") > 0 ) {\
      print $1 >> "02_full.txt";\
   }\
   close ("02_com1.txt");\
}\
{\
   ipt = $1;\
   for (k = 1; k <= i; k ++) {\
      if (ipt == a[k]) {\
         count_same++;\
         print ipt >> "02_same.txt";\
      }\
   }\
}\
END {\
   print "Number of same element:", count_same >> "02_same.txt";\
}' 02_com1.txt

# compare

awk 'BEGIN {\
   while ((getline < "02_same.txt") > 0 ) {\
      n++;\
      a[n] = $1;\
   }\
   close ("02_same.txt");\
}\
{\
   b = $1;\
   for (k = 1; k <= n; k++) {\
      if (a[k] == b) {\
         k = n + 1;\
      } else {\
         if (k == n) {\
            count_diff++;\
            print b >> "02_diff.txt";\
         }\
      }\
   }\
}\
END {\
   print "Number of diff element:", count_diff >> "02_diff.txt";\
}' 02_full.txt
