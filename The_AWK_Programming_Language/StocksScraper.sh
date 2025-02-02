#!/bin/bash
curl "https://bigcharts.marketwatch.com/quotes/multi.asp?view=q&msymb=aapl+amzn+fb+goog" 2>/dev/null |
awk '
    BEGIN { 
        header1="STOCK"
        header2="PRICE"
    printf("%6s,%s\n", header1, header2)}
    /<td class="symb-col"/ {
        sub(/.*<td class="symb-col">/, "")
        sub(/<.*/, "")
        symb = $0
        next
    }
    /<td class="last-col"/ {
        sub(/.*<td class="last-col">/, "")
        sub(/<.*/, "")
        price = $0
        gsub(/,/, "", price)
        printf("%6s,%s\n", symb, price)
    }
'