%% ECE 580 Project, Mathematical Model for Cubesat Attitude Sensors
%
% -------------------------------------------------------------------------
%
% Authors:  Sergio Ribeiro
% Date:     07-MAY-2022
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

file_name = 'PitchAngleChange_3.csv';
file_path = [fileparts(pwd), '\Data\', file_name];
DataTable = readtable(file_path, 'HeaderLines', 12);
DataTable.Properties.VariableNames = {'Nx', 'Ny', 'Nz', ...
    'Sx', 'Sy', 'Sz', 'Roll', 'Pitch', 'Yaw', ...
    'SunFluxX', 'SunFluxY', 'SunFluxZ'
};

%% Compute Angles
% This script will attempt to compute the angles based on the data tables
% we are given. Let's read each row of the data table and compute what
% octant our cube is receiving light in.

% Lets program our octant lookup table as a dictionary. Python's built in
% type dictionary in not in MATLAB. MATLAB uses container maps. As
% described in our paper we are using the octant naming convention
% developed.

octant_keys = {'000111', '001110', '010101', '011100', ...
    '100011', '101010', '110001', '111000'};
octant_values = {'000', '001', '010', '011', ...
    '100', '101', '110', '111'};

octantmap = containers.Map(octant_keys, octant_values);

% Next lets read the values from our data table and append the octant in
% which we can. We will need to add some error handling in case the results
% of the simulation produce no known octant, but that can wait for later.


for i = 1:max(size(DataTable))
    faces_lit = num2str(table2array(DataTable(i, 1:6)) > 0);
    faces_lit = faces_lit(find(~isspace(faces_lit)));
    DataTable.Octant(i) = {octantmap(faces_lit)};
end

% Save the data table into the data folder
writetable(DataTable, file_path);

