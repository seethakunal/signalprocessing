% This function creates a periodic square wave that lasts for tau
function f = periodicSquare(t, tau)
tprime = mod(t+pi,2*pi) - pi;
y = (tprime > -tau/2) & (tprime < tau/2);
f=double(y); %force logical to double
end

