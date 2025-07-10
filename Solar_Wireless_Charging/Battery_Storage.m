% Battery Storage Simulation
clear; clc;

% Parameters
solar_power = 500; % Average power from PV (W)
battery_capacity = 5000; % Battery capacity in Wh
charge_efficiency = 0.9;
dt = 1; % Time step in minutes
time = 0:dt:300; % Simulate 5 hours

% Initialize
charge_level = zeros(size(time));
for i = 2:length(time)
    if charge_level(i-1) < battery_capacity
        charge_level(i) = charge_level(i-1) + solar_power * charge_efficiency * (dt/60);
    else
        charge_level(i) = battery_capacity;
    end
end

% Plot
figure;
plot(time/60, charge_level, '-r','LineWidth',2);
xlabel('Time (hours)');
ylabel('Stored Energy (Wh)');
title('Battery Charging from Solar Power');
grid on;
