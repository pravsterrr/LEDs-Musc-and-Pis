# LEDs-Musc-and-Pis
A short program that uses Processing to allow LEDs to dance to music with a Raspberry Pi.


This project was based of an original Processing project that was meant to work with the Arduino Uno. With a few changes, it now works with the Raspberry Pi.

Please note:
You need to copy your own song in mp3 format inside the data folder with the filename "data.mp3" for the program to run correctly.

You will need three LEDs for this project. They need to be connect to GPIO pins 17, 27 and 22. If your using another model where these pins are not available, feel free to change the code in the BeatWrite.pde file inside of Processing.

You will need to have the latest version of Processing installed on your Raspberry Pi.