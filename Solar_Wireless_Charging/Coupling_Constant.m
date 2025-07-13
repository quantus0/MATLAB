clc; clear; close all;

% Coil Parameters
mu0 = 4*pi*1e-7;     % Permeability of free space
r1 = 0.1;            % Radius of primary coil (m)
r2 = 0.1;            % Radius of secondary coil (m)
N1 = 20;             % Turns in primary coil
N2 = 20;             % Turns in secondary coil
d = linspace(0.01, 0.2, 100);  % Distance between coils (m)

% Preallocate
M = zeros(size(d));
k = zeros(size(d));
L1 = mu0 * N1^2 * pi * r1^2 / (2 * r1);  % Approximate self-inductance
L2 = mu0 * N2^2 * pi * r2^2 / (2 * r2);

% Mutual Inductance Calculation (simplified circular loop model)
for i = 1:length(d)
    M(i) = mu0 * N1 * N2 * pi * r1^2 * r2^2 / (2 * (r1^2 + r2^2 + d(i)^2)^(3/2));
    k(i) = M(i) / sqrt(L1 * L2);  % Coupling coefficient
end

% Plotting
figure;
plot(d, k, 'LineWidth', 2);
xlabel('Distance between coils (m)');
ylabel('Coupling Coefficient (k)');
title('Coupling Coefficient vs. Distance');
grid on;

% Display peak values
[maxK, idx] = max(k);
fprintf('Max Coupling Coefficient: %.4f at %.2f m separation