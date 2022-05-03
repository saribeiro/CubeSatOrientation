%% ECE 580 Project, Mathematical Model for Cubesat Attitude Sensors
%
% -------------------------------------------------------------------------
%
% Authors:  Sergio Ribeiro, Rohith Yerrabelli
% Date:     26-APR-2022
% Class:    ECE 580 Small Satellite Design
%
% -------------------------------------------------------------------------
%
% The purpose of this project is to provide a mathematical model for a
% cubesat satellite attitude sensor system. The sensor system is a
% photodiode on each face of the cubesat. There are six sensors in all. The
% purpose of this program is to model the response of the photodiodes to
% the sunlight hitting the cubesat in different orientations. For
% simplicity we will consider a cube of size 2U x 2U x 2U. We are not using
% a unit cube because we would like our vectors for describing the cube
% orientation to be unit vectors.
%
% -------------------------------------------------------------------------
%

clearvars
clc
clf
format long

%% Rotation Matrices for Roll, Pitch and Yaw
% Roll Matrix
x_rot = @(theta)([1, 0, 0; ...
    0, cosd(theta), -sind(theta); ...
    0, sind(theta), cosd(theta)]);

% Pitch Matrix
y_rot = @(theta)([cosd(theta), 0, sind(theta); ...
    0, 1, 0; ...
    -sind(theta), 0, cosd(theta)]);

% Yaw Matrix
z_rot = @(theta)([cosd(theta), -sind(theta), 0; ...
    sind(theta), cosd(theta), 0; ...
   0, 0, 1]);

% Combined Roll, Pitch, Yaw matrix
xyz_rot = @(theta_x, theta_y, theta_z)(x_rot(theta_x) * y_rot (theta_y) * ...
    z_rot(theta_z));


%% Calculating Roll, Pitch and Yaw based on Simulated Diode Response
% In this section we will pull the simulated diode responses from the
% "ComputeDiodeResponse.m" code to attempt to figure out the cubesat
% orientation.

% There are some simplifying assumptions we can make about the cubesat
% orientation. Since only three of the face of the satellite can be
% illumniated at a time, we can at least figure out what octant the cubesat
% is generally oriented in in three dimensional space.

% We will use the following convention to name the octants of the three
% dimensional space.

file_name = 'RollAngleChange.csv';
DataTable = readtable(file_name, 'HeaderLines', 12);
DataTable.Properties.VariableNames = {'Nx', 'Ny', 'Nz', ...
    'Sx', 'Sy', 'Sz', 'Roll', 'Pitch', 'Yaw', ...
    'SunFluxX', 'SunFluxY', 'SunFluxZ'
};

%% Compute Angles

