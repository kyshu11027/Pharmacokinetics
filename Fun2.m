function fprimeofK = Fun2(z, t, K, D, V)
    %this is f'(K)
    pt1 = -z.*t.^2.*exp(-K.*t);
    pt2 = 2*D/V*t.^2.*exp(-2*K.*t);
    
    fprimeofK = sum(pt1) + sum(pt2);
end