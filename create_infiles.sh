#! /bin/bash

if [ $# -ne 5 ]
then
    echo "Wrong number of arguments"
    exit 1
elif [ ! -f "$1" ] || [ ! -f "$2" ] || [ $4 -lt 0  ] || [ $5 -lt 0  ]
then
    echo "Invalid Parameter"
    exit 1
fi

id=1
actions=("ENTER" "ENTER" "EXIT")    # Chance to get Enter -> 2/3
firstNames=("Jon" "Oberyn" "Ned" "Joffrey" "Catelyn" "Tywin" "Sansa" "Jaime" "Cersei" "Theon" "Sandor" "Ramsey" "Daenerys" "Jorah" "Tyrion")            # Possible first names
lastNames=("Stark" "Lannister" "Baratheon" "Targaryen" "Greyjoy" "Clegane" "Baelish" "Tarly" "Bolton" "Mormont" "Tyrel" "Martel" "Frey" "Arryn" "Snow") # Possible last names
# Create input_dir
mkdir -p $3     
# Create subDirectories
while read -r countryDir
do
    subDir=$3/$countryDir   
    mkdir -p $subDir

    files=0
    while [ $files -lt $4 ]
    do
        day=$((1 + RANDOM % 30))        # 1 - 30
        month=$((1 + RANDOM % 12))      # 1 - 12
        year=$((1990 + RANDOM % 30))    # 1990 - 2020
        # Make day always have 2 digits
        if [ $day -lt 10 ]          
        then
            day="0$day"
        fi
        # Make month always have 2 digits
        if [ $month -lt 10 ]        
        then
            month="0$month"
        fi

        dateFile=$subDir/$day-$month-$year
        # date file already exists
        if [ -f $dateFile ]
        then
            continue
        fi
        # input records
        for n in $(seq $5)         
        do
            action=${actions[$RANDOM % ${#actions[@]}]}

            if [ $action == "ENTER" ]        
            then
                patientID=$((id + 1))
                id=$((id + 1))
            else
                patientID=$((id/2 + RANDOM % id))
            fi

            fname=${firstNames[$RANDOM % ${#firstNames[@]}]}
            lname=${lastNames[$RANDOM % ${#lastNames[@]}]}
            disease=$(shuf -n 1 $1)
            age=$((1 + RANDOM % 120))

            echo $patientID $action $fname $lname $disease $age >> $dateFile
        done

        files=$((files + 1))
    done
done < $2
