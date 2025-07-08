% Solar Energy Harvesting Simulation
clear all;
close all;

% Parameters
irradiance = 1000; % W/m^2 (standard test condition)
temp = 25:5:50; % Temperature range in Celsius
efficiency = 0.18; % PV panel efficiency (18%)
area = 2; % Panel area in m^2
Voc = 40; % Open-circuit voltage (V)
Isc = 8; % Short-circuit current (A)

% Temperature effect on efficiency
temp_coeff = -0.004; % Efficiency temperature coefficient (%/°C)
eff_adj = efficiency * (1 + temp_coeff * (temp - 25));

% Power output calculation
power = irradiance * area * eff_adj;

% Plotting
figure;
plot(temp, power, 'b-o', 'LineWidth', 2);
xlabel('Temperature (°C)');
ylabel('Power Output (W)');
title('Solar Panel Power Output vs Temperature');
grid on;

% Data for analysis
disp('Power Output (W) at different temperatures:');
disp(power);