%% ECE 580 Project, Quaternion Examples
%
% -------------------------------------------------------------------------
%
% Authors:  Sergio Ribeiro, Rohith Yerrabelli
% Date:     26-APR-2022
% Class:    ECE 580 Small Satellite Design
%
% -------------------------------------------------------------------------
%
% The purpose of this code is to test out MATLAB quaternion capabilities to
% use for future work on this project. MATLAB has built in quaternion
% capabilities specifically related to rotation problems.
%
% -------------------------------------------------------------------------
%


clearvars;
clc;
format long;

%% Commutative Property does not Apply for Quaternions
% This section demonstrates that quaternion multiplication is not
% commutative. Neither is it anti-commutative (i.e. A x B = -B x A).
% Reversing the order changes the output drastically.

q1 = quaternion(0, 1, 1, 1);
q2 = quaternion(2, 1, 1, 1);

q_12 = q1 * q2;
q_21 = q2 * q1;
disp(q_12);
disp(q_21);


%% Quaternion to Euler Angles
% This code demonstrates the capability of MATLAB's built in quaternion
% library to convert Euler angles to a quaternion

eulerangles_q1 = rad2deg(quat2eul(q1));
eulerangles_q2 = rad2deg(quat2eul(q2));




