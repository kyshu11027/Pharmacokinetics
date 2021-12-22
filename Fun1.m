function fofK = Fun1(z, t, K, D, V)
    %this is the f(K)
    
    pt1 = z.*t.*exp(-K.*t);
    pt2 = (D/V)*t.*exp(-2*K.*t);
    fofK = sum(pt1) - sum(pt2);
end