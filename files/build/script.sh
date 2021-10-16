#!/bin/bash
echo "Hi"
firstline=$(head -n 1 source/changelog.md)
echo $firstline
read -a splitfirstline «< $firstline
version=${firstline[1]}
echo "Your version is " $version

# Let’s give the user a chance to exit the script if they need to make a change to the version.
echo "Do you want to exit the script to change the version? (enter '1' for yes, '0' for no)"
read versioncontinue

if [ "$versioncontinue" -eq 1 ]
then
	echo "OK"
	for filename in source/*
	do
		echo $filename
		if [ "$filename" == "source/secretinfo.md"]
		then
			echo "Not copying" $filename
		else
			echo "Copying" $filename
			sed 's/42/XX/g' source/secretinfo.md
			cp $filename build/.
		fi
	done
	else
		echo "Please come back when you are ready."
fi

#The final thing we want to do is list the files in the build directory for the user
echo "Build version $version contains:"
ls

