R = 8.314; 
Cv = 1.5 * R; 
Cp = 2.5 * R; 
y = Cp / Cv; 

T1 = 70 + 273.15; 
P1 = 1e5;
V1 = (R * T1) / P1;

%Adiabatic Compression
T2 = 150 + 273.15; 
V2 = V1 * (T1 / T2)^(1 / (y - 1)); 
P2 = P1 * (V1 / V2)^y
W1 = R * (T2 - T1) / (1 - y); 
U1 = Cv * (T2 - T1); 
H1 = Cp * (T2 - T1); 
Q1 = 0; 

%Isobaric Cooling
T3 = T1;
V3 = R * T3 / P2; 
W2 = P2 * (V3 - V2); 
U2 = Cv * (T3 - T2);
H2 = Cp * (T3 - T2);
Q2 = H2; 

%Isothermal Expansion
V4 = V1; 
W3 = n * R * T3 * log(V4 / V3); 
U3 = 0;
H3 = 0;
Q3 = W3;

% Total Values for Reversible Process
W_total = W1 + W2 + W3;
Q_total = Q1 + Q2 + Q3;
U_total = U1 + U2 + U3;
H_total = H1 + H2 + H3; 

disp('Reversible Process:');
fprintf('Adiabatic Compression: W1 = %.2f J, Q1 = %.2f J, U1 = %.2f J, H1 = %.2f J\n', W1, Q1, U1, H1);
fprintf('Isobaric Cooling: W2 = %.2f J, Q2 = %.2f J, U2 = %.2f J, H2 = %.2f J\n', W2, Q2, U2, H2);
fprintf('Isothermal Expansion: W3 = %.2f J, Q3 = %.2f J, U3 = %.2f J, H3 = %.2f J\n', W3, Q3, U3, H3);
fprintf('Total Work: W_total = %.2f J, Total Heat: Q_total = %.2f J\n', W_total, Q_total);
fprintf('Total Internal Energy Change: U_total = %.2f J, Total Enthalpy Change: H_total = %.2f J\n\n', U_total, H_total);

% Irreversible Process
e = 0.75;
W1_irrev = e * W1;
W2_irrev = e * W2;
W3_irrev = e * W3;

Q1_irrev = U1 + W1_irrev; 
Q2_irrev = U2 + W2_irrev;
Q3_irrev = W3_irrev; 
W_total_irrev = W1_irrev + W2_irrev + W3_irrev;
Q_total_irrev = Q1_irrev + Q2_irrev + Q3_irrev;

disp('Irreversible Process:');
fprintf('Adiabatic Compression: W1 = %.2f J, Q1 = %.2f J, U1 = %.2f J, H1 = %.2f J\n', W1_irrev, Q1_irrev, U1, H1);
fprintf('Isobaric Cooling: W2 = %.2f J, Q2 = %.2f J, U2 = %.2f J, H2 = %.2f J\n', W2_irrev, Q2_irrev, U2, H2);
fprintf('Isothermal Expansion: W3 = %.2f J, Q3 = %.2f J, U3 = %.2f J, H3 = %.2f J\n', W3_irrev, Q3_irrev, U3, H3);
fprintf('Total Work: W_total = %.2f J, Total Heat: Q_total = %.2f J\n', W_total_irrev, Q_total_irrev);

% Plotting PV, PT, TV
P_vals = [P1, P2, P2, P1];
V_vals = [V1, V2, V3, V4]; 
T_vals = [T1, T2, T3, T1]; 

figure;
subplot(3,1,1);
plot(V_vals, P_vals, '-o');
xlabel('Volume (m^3)');
ylabel('Pressure (Pa)');
title('PV Diagram');

subplot(3,1,2);
plot(T_vals, P_vals, '-o');
xlabel('Temperature (K)');
ylabel('Pressure (Pa)');
title('PT Diagram');

subplot(3,1,3);
plot(V_vals, T_vals, '-o');
xlabel('Volume (m^3)');
ylabel('Temperature (K)');
title('TV Diagram');

