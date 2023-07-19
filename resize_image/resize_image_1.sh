get_file_size() {
	wc -c < $1
}

isBiggerFile() {
	fileSizeString="$(get_file_size $1)"
	fileSize=$((fileSizeString))

	standardFileSize=1000000

	if [ "$fileSize" -gt "$standardFileSize" ]; then
		return 1
	else
		return 0
	fi
}

get_width() {
	identify -format '%w' $1
}

get_height() {
	identify -format '%h' $1
}

isShorterImage() {
	imageWidthString="$(get_width $1)"
	imageWidth=$((imageWidthString))
	imageHeightString="$(get_height $1)"
	imageHeight=$((imageHeightString))

	standardLength=870

	if [ "$imageWidth" -lt "$standardLength" ]; then
		return 1
	elif [ "$imageHeight" -lt "$standardLength" ]; then
		return 1
	else
		return 0
	fi
}

for img in ./*;
do
	isBiggerFile $img
	isBiggerStr=$?
	isBigger=$((isBiggerStr))

	if [ "$isBigger" = "1" ]; then
		convert -resize 30% "$img" ./resi/$img
	
		isShorterImage ./resi/$img
		isShorterStr=$?
		isShorter=$((isShorterStr))

		if [ "$isShorter" = "1" ]; then
			convert -resize 50% $img ./resi/$img

			isShorterImage ./resi/$img
			isShorterStr=$?
			isShorter=$((isShorterStr))
		
			if [ "$isShorter" = "1" ]; then
				convert -resize 70% $img ./resi/$img
				
				isShorterImage ./resi/$img
                        	isShorterStr=$?
                        	isShorter=$((isShorterStr))

				if [ "$isShorter" = "1" ]; then
					cp $img ./resi/$img
				else
					:
				fi
			else
				:
			fi
		else
			:
		fi
	else
		cp $img ./resi/$img
	fi
done
