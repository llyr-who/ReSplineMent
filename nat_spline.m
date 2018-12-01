function [mat] = nat_spline(x,y,p)
x(:);
N = length(x);
l = (p+1)/2;
r = x(:).^(0:p);
%here we form the differentiaon matrices
[mm,nn]= size(r);
diffr = zeros(mm,nn,p-1);
diffr(:,:,1) = circshift(r,1,2).*(0:p);
for i = 2:p-1
    diffr(:,:,i) = circshift(diffr(:,:,i-1),1,2).*(0:p);
end
%now we must form the EQUALITY matrix

[m,n] = size(r);
B = [];
for i = 1:m-1
    B = blkdiag(B, r(i:i+1,:));
end

%now we must form the differentiation matrix
%in order to do this I am going to construct blocks
blockD = zeros(p-1,2*(p+1),N-2);
for i = 1:N-2
    blockD(:,1:p+1,i) = permute(diffr(i+1,1:p+1,:),[3 2 1]); 
    blockD(:,p+2:2*(p+1),i) = -permute(diffr(i+1,1:p+1,:),[3 2 1]); 
end
%we must now arrange these blocks such that
%they overlap to form the "internal node differivatives matrix"

DD = zeros((N-2)*(p-1),(N-1)*(p+1));
for i = 1:N-2
    DD(  (p-1)*(i-1)+1 : i*(p-1)  ,  (i-1)*(p+1)+1  :  (i+1)*(p+1)  ) = blockD(:,:,i);
end

%now we have the natural spline conditions
M3 = zeros(l-1,(N-1)*(p+1));
M4 = zeros(l-1,(N-1)*(p+1));
M3(1:l-1,1:p+1) = permute(diffr(1,:,2:l),[3 2 1]);
M4(1:l-1,(N-2)*(p+1)+1:(N-1)*(p+1)) = permute(diffr(end,:,2:l),[3 2 1]);

SSS = [B;DD;M3;M4];
[mmm,nnn] = size(SSS);
% we have to formulate the RHS
z = [];
for i = 1:length(y)
  z = [z y(i)];
  z = [z y(i)];
end

b = [ z(2:end -1)  zeros(1,mmm-length(z) + 2)];


mat = SSS\b';
endfunction
