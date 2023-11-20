function x = rob(y, Fc, Fs)
%%  Based on frequency modulation 

%Init
N = length(y);
t = (0:N-1)/Fs;
x_robot = zeros(size(N));

%For each sample
for i=1:N
    e = exp(-1i*2*pi*Fc*t(i));
    x_robot(i) = real(y(i)*e);
end 

x = real(x_robot);



