Extract Data from Drive Recorder for Smart RecoaTouch HD

Input file : mdr0_20180215_201151_E.mp4

1) Convert MPEG4 to Jpeg
ffmpeg -i mdr0_20180215_201151_E.mp4 -f image2 images/%05d.jpg

2) Extract Drive Data from MPEG4
ruby conv.rb

No , Date Time, Front/Rear G, Left/Right G, Up/Down G, Longitude, Latitude


