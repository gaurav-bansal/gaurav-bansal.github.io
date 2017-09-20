#! /bin/sh
echo "Test text"

#compiling sensor files
gcc /home/pi/Desktop/camr.c -o magnet.out -l wiringPi
gcc /home/pi/Desktop/light.c -o light.out -l wiringPi
gcc /home/pi/Desktop/pressure.c -o pressure.out -l wiringPi
echo "Sensor programs compilation successful"

#removing any previous junk log file
rm /home/pi/gaurav-bansal.github.io/templog.txt
rm /home/pi/gaurav-bansal.github.io/magnetlog.txt
rm /home/pi/gaurav-bansal.github.io/lightlog.txt
rm /home/pi/gaurav-bansal.github.io/pressurelog.txt
echo "Removed junk log-files"

#declaring a variable
x=0

#magnet sensor running in the background
cd /home/pi/Desktop
./magnet.out &
echo "Magnet sensor ready"

#backup html file
#cat /home/pi/Documents/index.html

while [ 1 ]
do
	#sensors
	cd /home/pi/Desktop
	./light.out
	./pressure.out
	x=$((x+1))
	echo -n $x": " >> /home/pi/gaurav-bansal.github.io/templog.txt
	sudo ./temphum.py 22 22 >> /home/pi/gaurav-bansal.github.io/templog.txt
	sudo ./temphum.py 22 22
	
	#html file update
	cp /home/pi/Documents/index.html /home/pi/gaurav-bansal.github.io/index.html
	echo "<!-- comment number:" $x"-->" >> /home/pi/gaurav-bansal.github.io/index.html
	#cat /home/pi/gaurav-bansal.github.io/index.html 
	
	#git update
	cd /home/pi/gaurav-bansal.github.io/
	#git status
	git add --all
	#git status
	git commit -am 'log update'
	#git status
	git push origin master

	echo "--------------------------------------"
	sleep 1
done
