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
clf;
format long;

%% Commutative Property does not Apply for Quaternions
% This section demonstrates that quaternion multiplication is not
% commutative. Neither is it anti-commutative (i.e. A x B = -B x A).
% Reversing the order changes the output drastically.

q1 = quaternion(3, 5, 1, 4);
q2 = quaternion(2, 1, 5, 1);

q_12 = q1 * q2;
q_21 = q2 * q1;
fprintf('QUATERNIONS MULTIPLICATION IS NOT COMMUTATIVE\n\n');
fprintf('q1 = ');
disp(q1);
fprintf('q2 = ');
disp(q2);
fprintf('q1 * q2 = ');
disp(q_12);
fprintf('q2 * q1 = ');
disp(q_21);


%% Quaternion Rotation of Points
% We will build a quaternion rotation system. We need to define the unit
% vector which will describe the axis of rotation and an angle which will
% describe the angle by which we rotate around such a defined axis.

% Define a rotation axis and normalize it to a unit vector
fprintf('ROTATION AXIS VECTOR\n');
rot_axis = [1, 1, 1];
rot_axis = rot_axis/norm(rot_axis);
fprintf('%2.4fi + %2.4fj + %2.4fk\n\n', ...
    rot_axis(1), rot_axis(2), rot_axis(3));

% Define our angle of rotation in degrees
rot_angle = 10;
fprintf('ROTATION ANGLE: %2.4f\n\n', rot_angle);

% Compute the resulting quaternion associated with this rotation
q_rot = quaternion(cosd(rot_angle/2), ...
    rot_axis(1) * sind(rot_angle/2), ...
    rot_axis(2) * sind(rot_angle/2), ...
    rot_axis(3) * sind(rot_angle/2));
fprintf('ROTATION QUATERNION:\n');
disp(q_rot);


%% Define a Flat Polygon to Rotate
% In this section we will define a simple polygon shape to show how
% quaternion rotation works

solid_verts = 0.4 * [1, 1, 1; -1, 1, 1; 1, 1, -1; -1, 1, -1; ...
       1, -1, 1; -1, -1, 1; 1, -1, -1; -1, -1, -1];
solid_faces = [1, 2, 4, 3; 5, 6, 8, 7; ...
    1, 5, 7, 3; 2, 6, 8, 4; ...
    1, 5, 6, 2; 3, 7, 8, 4];



figure(1)
grid on
hold on
quiver3(0, 0, 0, rot_axis(1), rot_axis(2), rot_axis(3), 'LineWidth', 1.5);
text(rot_axis(1), rot_axis(2), rot_axis(3), 'Rotation Axis');
patch('Vertices', solid_verts, 'Faces', solid_faces, ...
      'FaceVertexCData', hsv(6), 'FaceColor', 'flat', ...
      'FaceAlpha', 0.2)
axis([-1, 1, -1, 1, -1, 1]);
title('Cube in Original Position', 'interpreter', 'latex');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
view(3)
axis vis3d
rotate3d


% Now using the rotation quaternion we defined, rotate all the solid
% figures vertices.

rot_verts = zeros(8, 3);
rot_faces = [1, 2, 4, 3; 5, 6, 8, 7; ...
    1, 5, 7, 3; 2, 6, 8, 4; ...
    1, 5, 6, 2; 3, 7, 8, 4];

% We could go the long way and multiply our vectors as q_rot * r *
% conj(q_rot). However MATLAB has built in routines for dealing with
% quaternions quite efficiently. It would be a waste to re-derive known and
% compiled code

for i = 1:8
    rot_verts(i, :) = quatrotate(compact(q_rot), solid_verts(i, :));
end

figure(2)
grid on
hold on
quiver3(0, 0, 0, rot_axis(1), rot_axis(2), rot_axis(3), 'LineWidth', 1.5);
text(rot_axis(1), rot_axis(2), rot_axis(3), 'Rotation Axis');
patch('Vertices', rot_verts, 'Faces', rot_faces, ...
      'FaceVertexCData', hsv(6), 'FaceColor', 'flat', ...
      'FaceAlpha', 0.2)
axis([-1, 1, -1, 1, -1, 1]);
title({'Cube Rotated around Vector by ', ...
    sprintf('%2.2f degrees', rot_angle)}, 'interpreter', 'latex');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
view(3)
axis vis3d
rotate3d


% Verify the quaternion rotation function built into MATLAB performs as
% expected by comparing it to the mathematical definition of quaternion
% rotation

r = [3, 4, 5];
q = quaternion([0, r]);

r_rot1 = quatrotate(compact(q_rot), r);
r_rot2 = compact(q_rot * q * conj(q_rot));
