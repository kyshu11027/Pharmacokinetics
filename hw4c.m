clc; clear; close all;

patients = importdata('Student24.txt');

%defining constants and variables
t = [1 3 5 14 18 24]; %time points
nonsmoker1 = patients(1,:); %nonsmoker1
nonsmoker2 = patients(2,:); 
smoker1 = patients(3,:);
smoker2 = patients(4,:);

V = 25; %liters
D = 10; %milligrams

%initial guesses of K
nonsmoke1 = log(2)/14;
nonsmoke2 = log(2)/14;
smoke1 = log(2)/18;
smoke2 = log(2)/18;

%initial values K and V
alpha1 = [nonsmoke1 V];
alpha2 = [nonsmoke2 V];
alpha3 = [smoke1 V];
alpha4 = [smoke2 V];

options = optimset();

[a1, hval1] = fminsearch(@Fun3, alpha1,options, nonsmoker1, t, D); %nonsmoker1
[a2, hval2] = fminsearch(@Fun3, alpha2,options, nonsmoker2, t, D); %nonsmoker2
[a3, hval3] = fminsearch(@Fun3, alpha3,options, smoker1, t, D); %smoker1
[a4, hval4] = fminsearch(@Fun3, alpha4,options, smoker2, t, D); %smoker2

%inputting k into our differential equation
tRange = 0:0.01:24;
smoker1est = D/a3(2)*exp(-a3(1)*tRange);
smoker2est = D/a4(2)*exp(-a4(1)*tRange);
nonsmoker1est = D/a1(2)*exp(-a1(1)*tRange);
nonsmoker2est = D/a2(2)*exp(-a2(1)*tRange);

%plotting
figure (1)
subplot(2,2,1);
title('Smoker 1');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, smoker1, 'x');
plot(tRange, smoker1est);
legend('Observations', strcat('K: ', num2str(a3(1)), ' V: ', num2str(a3(2))));

subplot(2,2,2);
title('Smoker 2');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, smoker2, 'x');
plot(tRange, smoker2est);
legend('Observations', strcat('K: ', num2str(a4(1)), ' V: ', num2str(a4(2))));

subplot(2,2,3);
title('Nonsmoker 1');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, nonsmoker1, 'x');
plot(tRange, nonsmoker1est);
legend('Observations', strcat('K: ', num2str(a1(1)), ' V: ', num2str(a1(2))));

subplot(2,2,4);
title('Nonsmoker 2');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, nonsmoker2, 'x');
plot(tRange, nonsmoker2est);
legend('Observations', strcat('K: ', num2str(a2(1)), ' V: ', num2str(a2(2))));

