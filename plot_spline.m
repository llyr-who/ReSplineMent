%produce of AntG
function plot_spline(x,S,p)
x(:);
N = length(x);
inner_points = 20;
XX = zeros(inner_points,N-1);
YY = zeros(inner_points,N-1);
for i = 1:N-1
    XX(:,i) = linspace(x(i),x(i+1),inner_points);
    YY(:,i) = ([ones(inner_points,1) XX(:,i).^(1:p)])*S(    (i-1)*(p+1)+1    :    i*(p+1)    );
end
XXX = reshape(XX,1,(N-1)*inner_points);
YYY = reshape(YY,1,(N-1)*inner_points);
p =plot(XXX,YYY,'b');
end
