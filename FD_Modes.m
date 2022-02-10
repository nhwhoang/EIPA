% Harmonic Wave Equation in 2D FD and Modes
close all; clear all
set(0,'DefaultFigureWindowStyle','docked')

% Constant and parameters
nx = 50;
ny = 50;

% Create G matrix
G = sparse(nx*ny,nx*ny);

for i = 1:nx
    for j = 1:ny
        % Mapping equation
        n = j + (i-1)*ny;   % n --> (i,j)
        
        if (i==1) || (i==nx) || (j==1) || (j==ny)   % Boundary condition nodes
            G(n,:) = 0; % other entries to 0
            G(n,n) = 1; % diagonal to 1
        else    % Bulk nodes
            nxm = j + (i-2)*ny;         % nxm --> (i-1,j)
            nxp = j + (i)*ny;           % nxp --> (i+1,j)
            nym = (j-1) + (i-1)*ny;     % nym --> (i,j-1)
            nyp = (j+1) + (i-1)*ny;     % nyp --> (i,j+1)
            
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1; 
        end
        
%         if (i>10) & (i<20) & (j>10) & (j<20)
%             G(n,n) = -2;
%         end
    end
end

figure(1)
spy(G)
title ('Plot G')

% Eigenvectors & eigenvalues
figure(2)
[E,D] = eigs(G,9,'SM');     % E is vector matrix, D's diagonal is eigenvalues

for i = 1:9
    plot(i,D(i,i),'*')    % plotting eigenvalues
    hold on
end
title('Plot eigenvalues')


figure(3)
x = 1:nx;
y = 1:ny;

for k = 1:9
    for i = 1:nx
        for j = 1:ny
            % Remap E onto nx,ny matrix --> transfrom n into nx,ny
            n = j + (i-1)*ny;
            E_remap(k,i,j) = E(n,k);    % remapped
        end
    end
    
    subplot(3,3,k)
    surf(squeeze(E_remap(k,:,:))); shading interp
    
end



