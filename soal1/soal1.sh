#!/bin/bash

a=$( awk -F '\t' '{if (NR>1) profit[$13]+=$21;}
END{min=10000000; for (i in profit) { 
	if (min > profit[i]){
		min=profit[i]; 
		region=i}
}print region}' Sample-Superstore.tsv )
echo "a) region dengan profit paling sedikit ialah $a"

b=$( awk -F '\t' -v region="$a" '{if (NR>1) {if ($13 ~ region) profit[$11]+=$21;}}
END{min1=1000000; min2=10000000; for (i in profit) {
		if (min1 > profit[i] || min2 > profit[i]){
		if (min2 > profit[i] && min1 < profit[i]){ min2=profit[i]; state2=i}
		else{ min2=min1;
			min1=profit[i]; 
                	state2=state1;
			state1=i}}
}print state1 " & " state2}' Sample-Superstore.tsv )
echo "b) 2 state di region $a dengan profit terendah ialah $b" 

