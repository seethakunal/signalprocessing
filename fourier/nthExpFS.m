%{
This function generates the fourier series up to the Nth exponential (the
value passed in for N in the function). The tau value is the period and the
t value is time. The periodic square wave function is the function that I
am taking the fourier series for, so the Dn value depends only on the N
value after integration over tau.
%}
function eq = nthExpFS(N,t, tau)
syms D(n) D0 n
D0 = tau/(2*pi);
eq = D0;
D(n) = sin(n*tau/2) / (n*pi);
for n = 1:N
    eq = eq + D(n)*exp(1i*n*t) + D(-n)*exp(1i*n*t);
end

end

