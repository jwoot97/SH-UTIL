#!/bin/bash

# ENTER MONTH AND YEAR AS PARAMETERS
month_num="${1}"
year="${2}"

# CHECK FOR PARAMETERS
if [ $# -eq 0 ]; then
    echo "No parameters provided.  USAGE EXAMPLE FOR DECEMBER 2023: ./montharchive.sh 12 2023"
    exit 1
fi

# DETERMINE LENGTH OF MONTH SELECTED
# AND ADJUST END DATE AS REQUIRED
t=("4" "6" "9" "11")
to=("1" "3" "5" "7" "8" "10" "12")
if [[ ${t[@]} =~ $month_num ]] then
	lastday="30"
elif [[ ${to[@]} =~ $month_num ]] then
	lastday="31"
else
	lastday="28"
fi

start_date="${year}-${month_num}-01 00:00:00"
end_date="${year}-${month_num}-${lastday} 23:59:59"

# PAD THE MONTH NUMBER WITH A ZERO
month_num=$(printf '%02d' ${month_num})

# OUTPUT ZIP FILE PATH
output_path="./Archive${year}/${year}${month_num}.zip"

# Use find to locate files modified between the specified dates
find ./ -maxdepth 1 -type f -newermt "${startdate}" ! -newermt "${enddate}" -print0 | tar --null -czvf "${output_path}" --files-from - --remove-files

echo "Files modified between ${start_date} and ${end_date} have been zipped to ${output_zip}."