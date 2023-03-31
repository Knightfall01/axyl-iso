#!/bin/bash

set -e

#Phase 1 of the build :
echo "================================"
echo "Phase 1 of the build :"
echo " "
echo "General Variables are being set"
echo " "
echo "================================"
echo
	ArchisoRequiredVersion="archiso 70-1"
	BuildFolder=$HOME"/Open-Source/ISO-Test/BuildFolder"
	OutputFolder=$HOME"/Open-Source/ISO-Test/ISO-result"
	ArchisoVersion=$(sudo pacman -Q archiso)

	echo "================================"
	echo " "
	echo "Your version of archiso = $ArchisoVersion"
	echo " "
	echo "The required version of archiso = $ArchisoRequiredVersion"
	echo " "
	echo "Location of the build folder = $BuildFolder"
	echo " "
	echo "Location of the final ISO folder = $OutputFolder"
	echo " "
	echo "================================"

	if [ "$ArchisoVersion" = "$ArchisoRequiredVersion" ]; then
	echo "================================"
	echo " "
	echo "You have the right version of the archiso ... "
	echo " "
	echo "================================"
	else
	echo "================================"
	echo " "
	echo "You have the older version of the archiso ... "
	echo " "
	echo "Use 'sudo downgrade archiso' to downgrade your version of archiso"
	echo " "
	echo "If you have the latest version of archiso edit it in the line number 11"
	echo " "
	echo "================================"
	fi
echo 

#Phase 2 of the build

echo "================================"
echo " "
echo "Phase 2 of the build :"
echo " "
echo "Checking if the archiso is installed "
echo " "
echo " If it is not installed , we will install it for you"
echo " "
echo "================================"
echo 
	
	if pacman -Qi archiso &> /dev/null; then
		echo "ArchISO is already installed"
	else

		if pacman -Qi yay &> /dev/null; then

			echo "================================"
			echo " Yay will install archiso"
			echo "================================"
			yay -S --noconfirm archsio
		fi

		if pacman -Qi archiso &> /dev/null; then 

			echo "================================"
			echo " "
			echo " archiso is installed successfully"
			echo " "
			echo "================================"
		
		else 
			echo "================================"
			echo " "
			echo " Error while installing archiso"
			echo " "
			echo "================================"
			exit 1
		fi
	
	fi

echo 

#phase 3 of the build
echo "================================"
echo " "
echo "Phase 3 of the build : "
echo " "
echo "Moving build directory to home directory"
echo " "
echo "================================"
echo
	[ -d "$BuildFolder" ] && sudo rm -rf "$BuildFolder"
	echo
	mkdir "$BuildFolder"
	cp -r ../archiso "$BuildFolder"/archiso
	echo "All the files are placed in the build folder"
echo

#phase 4 of the build

echo "================================"
echo " "
echo "Phase 4 of the build : "
echo " "
echo "Cleaning the cache from /var/cache/pacman/pkg"
echo " "
echo "================================"
echo 
	echo "Cleaning the cache from /var/cache/pacman/pkg"
	yes | sudo pacman -Scc
echo

#phase 5 of the build

echo "================================"
echo " "
echo "Phase 5 of the build : "
echo " "
echo "Creating ISO Folder ... and This might take a while , chill and relax"
echo " "
echo "================================"
echo 

 [-d "$OutputFolder" ] || mkdir "$OutputFolder"
 (cd "$BuildFolder"/archiso && sudo mkarchiso -v -W "$BuildFolder" -o "$OutputFolder" "$BuildFolder"/archiso)
echo " "
echo "================================"
rename=$(date +%Y -%m -%d)
cp "$BuildFolder"/iso/arch/pkglist.x86_64.txt "$OutputFolder"/archlinux-"$rename"-pkglist.txt
echo " "
echo

echo "================================"
echo " "
echo "Phase 6 of the build : "
echo " "
echo "Check out your ISO Folder: $OutputFolder"
echo " "
echo "================================"



