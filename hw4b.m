clear; close all; clc;

patients = importdata('Student24.txt');

%defining constants and variables
V = 25; %liters
D = 10; %milligrams
t = [1 3 5 14 18 24]; %time points
nonsmoker1 = patients(1,:); %nonsmoker1
nonsmoker2 = patients(2,:); 
smoker1 = patients(3,:);
smoker2 = patients(4,:);

max = 400;
nonsmoke1 = zeros(1,max);
nonsmoke2 = zeros(1,max);
smoke1 = zeros(1,max);
smoke2 = zeros(1,max);

% initial k = ln2/t1/2
nonsmoke1(1) = log(2)/14;
nonsmoke2(1) = log(2)/14;
smoke1(1) = log(2)/18;
smoke2(1) = log(2)/18;

%using the Newton's formula to find the values
i = 2;
while (abs(Fun1(nonsmoker1, t, nonsmoke1(i), D, V))>0.01) && i<max
    nonsmoke1(i) = nonsmoke1(i-1) - Fun1(nonsmoker1, t, nonsmoke1(i-1), D, V)/Fun2(nonsmoker1, t, nonsmoke1(i-1), D, V);
    if (abs(nonsmoke1(i) - nonsmoke1(i-1)) <0.001)
        nonsmoke1K = nonsmoke1(i);
        break;
    end
    nonsmoke1K = nonsmoke1(i);
    i = i+1;
end


i = 2;
while (abs(Fun1(nonsmoker2, t, nonsmoke2(i), D, V))>0.01) && i<max
    nonsmoke2(i) = nonsmoke2(i-1) - Fun1(nonsmoker2, t, nonsmoke2(i-1), D, V)/Fun2(nonsmoker2, t, nonsmoke2(i-1), D, V);
    if (abs(nonsmoke2(i) - nonsmoke2(i-1)) <0.001)
        nonsmoke2K = nonsmoke2(i);
        break;
    end
    nonsmoke2K = nonsmoke2(i);
    i = i+1;
end

i = 2;
while (abs(Fun1(smoker1, t, smoke1(i), D, V)) >0.01) && i<max
    smoke1(i) = smoke1(i-1) - Fun1(smoker1, t, smoke1(i-1), D, V)/Fun2(smoker1, t, smoke1(i-1), D, V);
    if (abs(smoke1(i) - smoke1(i-1)) <0.001)
        smoke1K = smoke1(i);
        break;
    end
    smoke1K = smoke1(i);
    i = i+1;
end

i = 2;
while (abs(Fun1(smoker2, t, nonsmoke2(i), D, V))>0.01)  && i<max
    smoke2(i) = smoke2(i-1) - Fun1(smoker2, t, smoke2(i-1), D, V)/Fun2(smoker2, t, smoke2(i-1), D, V);
    if (abs(smoke2(i) - smoke2(i-1)) <0.001)
        smoke2K = smoke2(i);
        break;
    end
    smoke2K = smoke2(i);
    i = i+1;
end

%inputting k into our differential equation
tRange = 0:0.01:24;
smoker1est = D/V*exp(-smoke1K*tRange);
smoker2est = D/V*exp(-smoke2K*tRange);
nonsmoker1est = D/V*exp(-nonsmoke1K*tRange);
nonsmoker2est = D/V*exp(-nonsmoke2K*tRange);

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
legend('Observations', sprintf('Newton: %g', smoke1K));

subplot(2,2,2);
title('Smoker 2');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, smoker2, 'x');
plot(tRange, smoker2est);
legend('Observations', sprintf('Newton: %g', smoke2K));

subplot(2,2,3);
title('Nonsmoker 1');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, nonsmoker1, 'x');
plot(tRange, nonsmoker1est);
legend('Observations', sprintf('Newton: %g', nonsmoke1K));

subplot(2,2,4);
title('Nonsmoker 2');
hold on;
ylim([0 0.8]);
xlabel('time (hrs)');
ylabel('plasma concentration (mg/L)');
scatter(t, nonsmoker2, 'x');
plot(tRange, nonsmoker2est);
legend('Observations', sprintf('Newton: %g', nonsmoke2K));

