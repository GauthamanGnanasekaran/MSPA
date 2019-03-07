% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  
clear
clc
% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = linspace(0.325,1.0,10);           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.1;        % grid size (horizontal)
dy = 0.1;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

% epsList = [];
% xList = [];
% yList = [];

for i = 1:10
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw(i),side,dx,dy); 
xList{i} = x;
yList{i} = y;
epsList{i} = eps;
% First consider the fundamental TE mode:

[Hx{i},Hy{i},neff{i}] = wgmodes(lambda,n2,nmodes,dx,dy,epsList{i},'000A');


fprintf(1,'neff = %.6f\n',neff{i});





figure(1);
subplot(4,5,i);
contourmode(xList{i},yList{i},Hx{i});
title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

subplot(4,5,i+10);
contourmode(xList{i},yList{i},Hy{i});
title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end


% % Next consider the fundamental TM mode
% % (same calculation, but with opposite symmetry)
% 
% [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');
% 
% fprintf(1,'neff = %.6f\n',neff);
% 
% figure(2);
% subplot(4,5,num_modes);
% contourmode(x,y,Hx(:,:,num_modes));
% 
% title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end
% 
% subplot(4,5,num_modes+10);
% contourmode(x,y,Hy(:,:,num_modes));
% title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end

end