%% Input Parameters
gamma = 1.35; 
P1 = 110; 
T1 = 400; 
T3 = 2800; 
bore = 0.09; 
stroke = 0.1; 
rod_length = 0.14; 
CR = 8.5; 

%% Engine Geometry
Vswept = (pi / 4) * bore^2 * stroke; 
Vclearance = Vswept / (CR - 1); 
V1 = Vswept + Vclearance; 
V2 = Vclearance; 

%% State 2 (End of Compression)
T2 = T1 * (V1 / V2)^(gamma - 1); 
P2 = P1 * (T2 / T1) * (V1 / V2); 

%% State 3 (Peak temperature)
P3 = P2 * (T3 / T2); 
V3 = V2;

%% State 4 (End of expansion)
T4 = T3 * (V2 / V1)^(gamma - 1); 
P4 = P3 * (T4 / T3) * (V3 / V1); 
V4 = V1; 

%% Thermal Efficiency
efficiency = 1 - (1 / CR^(gamma - 1)); 
%% Generate P-V Diagram Without Piston Kinematics
num_points = 100;
V_comp = linspace(V1, V2, num_points); % Compression volume
P_comp = P1 * (V1 ./ V_comp).^gamma; % Compression pressure
V_exp = linspace(V3, V4, num_points); % Expansion volume
P_exp = P3 * (V3./ V_exp ).^gamma; % Expansion pressure

%% Piston Kinematics
theta_comp = linspace(0, pi, num_points); % Crank angle for compression
V_kin_comp = piston_kinematics(bore, stroke, rod_length, theta_comp, Vclearance);
P_kin_comp = P1 * (V1 ./ V_kin_comp).^gamma; % Compression pressure with kinematics

theta_exp = linspace(pi, 2*pi, num_points); % Crank angle for expansion
V_kin_exp = piston_kinematics(bore, stroke, rod_length, theta_exp, Vclearance);
P_kin_exp = P3 * (V3./ V_kin_exp ).^gamma; % Expansion pressure with kinematics
%% Plot P-V Diagrams
% Without Piston Kinetics
figure;
plot([V2, V3], [P2, P3], 'mo-', 'LineWidth', 1.5) % Heat Addition
hold on;
plot([V4, V1], [P4, P1], 'ro-', 'LineWidth', 1.5) % Heat Rejection
hold on;
plot(V_comp, P_comp, 'b-', 'LineWidth', 1.5); % Compression curve
plot(V_exp, P_exp, 'g-', 'LineWidth', 1.5); % Expansion curve
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('Without Piston Kinetics');
legend('Heat Addition','Heat Rejection','Compression', 'Expansion');
grid on;

% With Piston Kinematics
% Plot P-V Diagram
figure;
plot([V2, V3], [P2, P3], 'mo-', 'LineWidth', 1.5) % Heat Addition
hold on;
plot([V4, V1], [P4, P1], 'ro-', 'LineWidth', 1.5) % Heat Rejection
hold on;
plot(V_kin_comp, P_kin_comp, 'b-', 'LineWidth', 1.5); % Compression curve
plot(V_kin_exp, P_kin_exp, 'g-', 'LineWidth', 1.5); % Expansion curve
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('With Piston Kinematics');
legend('Heat Addition','Heat Rejection','Compression', 'Expansion');
grid on;

%% Impact of Compression Ratio on Efficiency
CR_values = [7, 9, 11];
efficiencies = 1 - (1 ./ CR_values.^(gamma - 1));

figure;
plot(CR_values, efficiencies * 100, 'o-b', 'LineWidth', 1.5);
xlabel('Compression Ratio');
ylabel('Thermal Efficiency (%)');
title('Impact of Compression Ratio on Efficiency');
grid on;

%Inference by plot
disp('Inference on changing compression ratios : As CR increases, efficiency increases too, although the increase is greater between CRs 7 & 9 as compared to CRs 9 & 11. While the thermal efficiency increases with higher compression ratios, the rate of improvement diminishes as CRbecomes very large. This is because the efficiency approaches an asymptotic limit defined by the specific heat ratio')
disp('Inference with and without piston kinetics : With piston kinematics, curves are non-linear which represent the actual behavior of an engine’s piston, as compared to without, where the curves have linear change in volumes.')
%% Function: Piston Kinematics
function V = piston_kinematics(bore, stroke, rod_length, theta, Vclearance)
    r = stroke / 2; % Crank radius
    R = rod_length / r; % Ratio of connecting rod length to crank radius
    Vd = (pi / 4) * bore^2 * stroke; % Displacement volume
    V = Vclearance + Vd / 2 * (1 - cos(theta) + (1 / R) * (1 - sqrt(1 - (sin(theta)).^2)));
end
