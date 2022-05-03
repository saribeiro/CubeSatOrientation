# CubeSatOrientation
This is a MATLAB project to determine the orientation of a CubeSat based on the light falling on the faces of the CubeSat.
This project is for the fulfillment of course requirements for ECE 580 (Spring 2022) at George Mason University for Dr. Piotr Pachowicz.

Our project is divided into the following directories,

1. Data
2. ECE580_FinalReport
3. Figures
4. MATLAB_Code

All of the code we run is in directory 4. The output results from directory 4 go into directory 1. Any figures that you want to save from the code
results are saved into directory 3. The final LaTeX report submitted for the class is in directory 2. Directory 2 may be useful for a developer to
look at if they would like to understand the mathematical model that was used to model this situation.

# MATLAB Code Descriptions

Currently we have the following four scripts in our GitHub repository,

1. CubeDisplay.m
2. ComputeDiodeResponse.m
3. ProjectMain.m
4. Quaternions.m

Script 1 provides a user friendly way for someone wanting to quickly compute diode response on the faces of a cubesat given a known flux vector that represents the light intensity and direction. It also provides a method to figure out the yaw, pitch and roll based on comparing the maximum flux to the flux falling on  the cube face. 

Script 2 provides a way to compute the diode responses on each cube face and allows us to perterb either the pitch, roll or yaw angle by a specified amount and in discrete steps that are specified.

Script 3 is not fully finished, but will provide a method of computing the yaw, pitch and roll based on the sample generated diode data.

Script 4 is merely a demonstration of the capabilities of using quaternion algebra to describe rotations instead of using yaw, pitch and roll matrices. Perhaps future iterations of this project will either make use of quaternions to determine the cube orientation or perhaps even rebuild the mathematical model from the ground up based on quaternion algebra instead of yaw, pitch and roll matrices.

# HTML Folder in MATLAB

The html folder in the MATLAB_Code directory is the output of the "Publish" option in MATLAB. Nice to include if you want to share a code report quickly but other than that it serves no purpose. Not necessary to modify or update, unless you want to.
