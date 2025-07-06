
P1 = 100; 
T1 = 30 + 273.15; 
V1 = 0.0038; 
r = 8; T3 = 1200 + 273.15;
gamma = 1.4; 
Cv = 0.718; 

% State 2 (End of compression)
V2 = V1 / r; %
T2 = T1 * (V1 / V2)^(gamma - 1); 
P2 = P1 * (T2 / T1) * (V1 / V2); 

% State 3 (Peak temperature)
P3 = P2 * (T3 / T2); 
V3 = V2; 

% State 4 (End of expansion)
T4 = T3 * (V2 / V1)^(gamma - 1); 
P4 = P3 * (T4 / T3) * (V3 / V1); 
V4 = V1; 

% Calculations
Qin = Cv * (T3 - T2); 
Qout = Cv * (T4 - T1);
Wnet = Qin - Qout; 
efficiency = Wnet / Qin; 
MEP = Wnet / (V1 - V2); 

num_points = 100;
V_comp = linspace(V1, V2, num_points); % Volumes during compression
P_comp = P1 * (V1 ./ V_comp).^gamma; % Pressures during compression
V_exp = linspace(V3, V4, num_points); % Volumes during expansion
P_exp = P3 * (V3./ V_exp).^gamma; % Pressures during expansion

% Plot P-V Diagram
figure;
plot([V2, V3], [P2, P3], 'mo-', 'LineWidth', 1.5) % Heat addition
hold on;
plot([V4, V1], [P4, P1], 'ro-', 'LineWidth', 1.5) % Heat rejection
hold on;
plot(V_comp, P_comp, 'b-', 'LineWidth', 1.5); % Compression curve
plot(V_exp, P_exp, 'g-', 'LineWidth', 1.5); % Expansion curve
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('P-V Diagram of the Otto Cycle');
legend('Heat Addition','Heat Rejection','Compression', 'Expansion');
grid on;

% Display results
fprintf('Heat Rejection (Qout): %.2f kJ\n', Qout);
fprintf('Net Work Output (Wnet): %.2f kJ\n', Wnet);
fprintf('Thermal Efficiency (η): %.2f %%\n', efficiency * 100);
fprintf('Mean Effective Pressure (MEP): %.2f kPa\n', MEP);
fprintf('Intermediate Pressure (P2) : %.2f kPa\n', P2);
fprintf('Intermediate Volume (V2) : %.5f m3\n', V2);