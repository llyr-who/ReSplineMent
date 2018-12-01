x = [2 10 76];
y = [1 -12 60];
p = 3;

S = nat_spline(x,y,p);
plot_spline(x,S,p);