function fofK = Fun3(alpha, z, t, D)
    %this is the f(K)
    %alpha(1) = K
    %alpha(2) = V
    fofK = sum((z - (D/alpha(2))*exp(-alpha(1)*t)).^2);
end