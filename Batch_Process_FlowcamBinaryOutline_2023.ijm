dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);
setBatchMode(true);
for (i=0; i<list.length; i++) {
 showProgress(i+1, list.length);
 filename = dir1 + list[i];
 if (endsWith(filename, "tif")) {
 open(filename);
 // INSERT MACRO HERE
run("8-bit");
setAutoThreshold("Default");
setThreshold(1, 175);
run("Convert to Mask");
run("Close-");
run("Fill Holes");
run("Dilate");
run("Close-");
run("Fill Holes");
run("Erode");
run("Erode");
run("Set Scale...", "distance=1 known=0.5547 unit=um");
run("Analyze Particles...", "size=10-Infinity show=Outlines display summarize");

//Save files
 saveAs("TIFF", dir2+list[i]);
 close();
 }
}

//Save results
#@ String (label="Please enter file name", description="Name field") nameOfFile
//#@output String saveFile
selectWindow("Results");
saveAs("Results", dir2+nameOfFile + "_Results.csv");
run("Clear Results");

