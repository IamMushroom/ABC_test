#!/bin/bash
# LOGFILE=$1
# OUTPUTFILE="bot_list.csv"
# BOTSEQ=("user logged in" "user changed password" "user logged off")
# if [ ! -f $OUTPUTFILE ]; then
# 	echo 'address,username' >> $OUTPUTFILE
# fi

LOGFILE='./log'
BOTSEQ=("user logged in" "user changed password" "user logged off")

UNIQS=()
while IFS= read -r line; do
	UNIQS+=( "$line" )
done < <(cat $LOGFILE | cut -f1 -d'-' | uniq -d)


for unique in "${UNIQS[@]}"; do
	TEMP=()
	while IFS= read -r line; do
		TEMP+=( "$line" )
	done < <(grep -e "^$unique*" $LOGFILE | cut -d'-' -f2 | cut -d'|' -f2)
	TEMPLEN=${#TEMP[*]}
	
	if (( TEMPLEN >= 3 )); then
		for ((cursor=0; cursor<=TEMPLEN-3; cursor++));
		do
			if [[ "${TEMP[cursor]}" == "${BOTSEQ[0]}" ]] && [[ "${TEMP[cursor + 1]}" == "${BOTSEQ[1]}" ]] && [[ "${TEMP[cursor + 2]}" == "${BOTSEQ[2]}" ]]; then
				name=$(echo $unique | cut -d'|' -f3)
#				addr=$(echo $unique | cut -d'|' -f2)
#				string="$addr","$name"
#				if ( ! grep -Fxq "$string" $OUTPUTFILE ); then
#					echo $string >> $OUTPUTFILE
#				fi
				echo $name
			fi
		done
	fi
done
