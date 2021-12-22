function dxdt = AlcoholPK(t, alc, k, Vm, Km)
    %k is rate constants for stomach (1) and intestine (2)
    %Vm is maximum volume rate
    %Km is Michaelis Constant
    dxdt = [-k(1)*alc(1);
        k(1)*alc(1) - k(2)*alc(2);
        k(2)*alc(2) - Vm*alc(3)/(Km+alc(3))];
end