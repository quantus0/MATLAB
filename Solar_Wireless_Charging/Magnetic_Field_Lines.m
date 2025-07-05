clc; clear; close all;

% Coil parameters
N = 20;              % Number of turns
I = 10;              % Current (A)
R = 0.1;             % Radius of coil (m)
mu0 = 4*pi*1e-7;     % Permeability of free space

% Grid setup
[x, y, z] = meshgrid(-0.2:0.02:0.2, -0.2:0.02:0.2, -0.2:0.02:0.2);
Bx = zeros(size(x));
By = zeros(size(y));
Bz = zeros(size(z));

% Loop over coil segments
theta = linspace(0, 2*pi, 100);
for k = 1:length(theta)
    % Coil segment position
    xp = R * cos(theta(k));
    yp = R * sin(theta(k));
    zp = 0;

    % Vector from segment to field point
    Rx = x - xp;
    Ry = y - yp;
    Rz = z - zp;
    Rmag = sqrt(Rx.^2 + Ry.^2 + Rz.^2);

    % Biot-Savart Law
    dL = [-sin(theta(k)), cos(theta(k)), 0] * R * (2*pi/100);
    dB = mu0 * I / (4*pi) * cross(repmat(dL, numel(x), 1), [Rx(:), Ry(:), Rz(:)]) ./ (Rmag(:).^3);

    % Accumulate field
    Bx = Bx + reshape(dB(:,1), size(x));
    By = By + reshape(dB(:,2), size(y));
    Bz = Bz + reshape(dB(:,3), size(z));
end

% Normalize for streamlines
Bmag = sqrt(Bx.^2 + By.^2 + Bz.^2);
Bx = Bx ./ Bmag;
By = By ./ Bmag;
Bz = Bz ./ Bmag;

% Plot streamlines
figure;
streamline(stream3(x, y, z, Bx, By, Bz, x, y, z));
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Magnetic Field Lines of Circular Coil');
axis equal;
view(3);