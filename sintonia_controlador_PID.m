clear
clc

num = [1];
syms s;
den1 = expand((s+1)^3);
den = [1 3 3 1];
Gs = tf(num, den);
t = transpose(0:0.01:12);
yt = step(Gs, t);
plot(t, yt);
axis([0 12 -0.3 1.1]);
grid;

[fit1,gof1]= fit(t,yt,'pchipinterp');
i=1;
for t = 0.00:0.01:4
    a = double(differentiate(fit1, t));
    t;
    round(a,4);
    A(i,1) = [round(a,4)];
    A(i,2) = t;
    if i-1 > 0
        if t>1
            if A(i,1)== A(i-1,1);
                break
            end
        end
    end
    i=i+1;
end
[a1,a2]= size(A);

tem = A(a1,2);
a = double(differentiate(fit1, tem));
b = fit1(tem)-a*tem;
sn = @(x) (a*x + b);
hold on
fplot(sn,[0 10])
y0 = sn(0);
x0 = -b/(a);

%cálculos dos ganhos do PID usando Ziegler-NIchols
K = 1.2/y0;
Ti = 2*x0;
Td = x0/2;
