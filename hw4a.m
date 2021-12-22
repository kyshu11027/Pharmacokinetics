clear; clc; close all;

%define male and female constants
maleV = 13; %L
femaleV = 10; %L
k =[10 11000]; %h^-1 male and female are the same
maleVm = 45; %g/h
femaleVm = 40; %g/h
Km = 50; %g male and female are the same

%initial values
dose1 = 14;
dose2 = 28;
alc01 = [dose1 0 0];
alc02 = [dose2 0 0];
tspan = 0:0.001:8;

%options for ode45
tolerance = 1e-5;
options = odeset('RelTol', tolerance, 'AbsTol', tolerance);

%male 14 g dose
[tm14, maleAlc14] = ode45(@AlcoholPK, tspan, alc01, options, k, maleVm, Km);

%female 14 g dose
[tf14, femaleAlc14] = ode45(@AlcoholPK, tspan, alc01, options, k, femaleVm, Km);

%male 28 g dose
[tm28, maleAlc28] = ode45(@AlcoholPK, tspan, alc02, options, k, maleVm, Km);

%female 28 g dose
[tf28, femaleAlc28] = ode45(@AlcoholPK, tspan, alc02, options, k, femaleVm, Km);

figure (1);
subplot(2,1,1);
hold on;
plot(tm14, maleAlc14(:,1), '--g');
plot(tf14, femaleAlc14(:,1), ':r');
plot(tm28, maleAlc28(:,1), '--b');
plot(tf28, femaleAlc28(:,1), ':k');
title('Alcohol Content in Stomach (g) vs. time (h)');
xlabel('time (h)');
ylabel('Alcohol Content in Stomach (g)');
legend('Male 14 g Dose', 'Female 14 g Dose', 'Male 28 g Dose', 'Female 28 g Dose');
subplot(2,1,2);
hold on;
plot(tm14, maleAlc14(:,3)/(10*maleV), '--g');
plot(tf14, femaleAlc14(:,3)/(10*femaleV), ':r');
plot(tm28, maleAlc28(:,3)/(10*maleV), '--b');
plot(tf28, femaleAlc28(:,3)/(10*femaleV), ':k');
title('BAC (%) vs. time (h)');
xlabel('time (h)');
ylabel('BAC (%)');
legend('Male 14 g Dose', 'Female 14 g Dose', 'Male 28 g Dose', 'Female 28 g Dose');

figure (2);
hold on;
plot(tm14, maleAlc14(:,3)/(10*maleV), '--g');
plot(tf14, femaleAlc14(:,3)/(10*femaleV), ':r');
plot(tm28, maleAlc28(:,3)/(10*maleV), '--b');
plot(tf28, femaleAlc28(:,3)/(10*femaleV), ':k');
yline(0.08, 'm');
title('BAC (%) vs. time (h)');
xlabel('time (h)');
ylabel('BAC (%)');
legend('Male 28 g Dose', 'Female 28 g Dose', 'Male 14 g Dose', 'Female 14 g Dose', '0.08 BAC');


