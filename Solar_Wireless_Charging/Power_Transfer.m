% Wireless Power Transfer Efficiency Simulation
clear all;
close all;

% Parameters
distance = 0:0.1:1; % Distance between coils (m), expanded range
misalignment = 0:5:45; % Misalignment angle (degrees), expanded range
base_efficiency = 0.9; % Base efficiency at perfect alignment (0 distance, 0 misalignment)

% Create 2D grids for distance and misalignment
[dist_grid, angle_grid] = meshgrid(distance, misalignment);

% Enhanced efficiency model
% Distance factor: Exponential decay with distance squared
dist_factor = exp(-2 * (dist_grid .^ 2));
% Angle factor: Cosine of misalignment with a penalty for large angles
angle_factor = cosd(angle_grid) .* exp(-0.02 * angle_grid); % Added penalty term
% Combined efficiency with resonant coupling approximation (simplified)
efficiency = base_efficiency * dist_factor .* angle_factor;
efficiency = min(max(efficiency, 0), 1); % Constrain efficiency between 0 and 1

% Plotting
figure;
mesh(dist_grid, angle_grid, efficiency);
xlabel('Distance (m)');
ylabel('Misalignment Angle (degrees)');
zlabel('Efficiency');
title('WPT Efficiency vs Distance and Misalignment');
colorbar;
grid on;
view(30, 30); % Adjust view angle for better visualization

% Data for analysis
disp('Efficiency Matrix (Distance x Misalignment):');
disp(efficiency);

% Optional: Save data to file for further analysis
writematrix(efficiency, 'wpt_efficiency_data.csv');
disp('Efficiency data saved to wpt_efficiency_data.csv');