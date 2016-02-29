function [ dphiu,dphiv,x_m,y_m ] = constructSurface( varargin )
%constructs Surface, especially the matrices dphix and dphiy
%% input parsing
p = inputParser;

p.addParameter('n1',1,@isnumeric);              % starting ref. index
p.addParameter('n2',1.5,@isnumeric);            % end ref. index
p.addParameter('xlim',500,@isnumeric);          % x-size of unit cell
p.addParameter('ylim',50,@isnumeric);           % y-size of unit cell
p.addParameter('numx',50,@isnumeric);
p.addParameter('numy',5,@isnumeric);
p.addParameter('sx',0.9,@isnumeric);            % x-scaling factor
p.addParameter('sy',0.9,@isnumeric);            % y-scaling factor
p.addParameter('safetyFactor',0.9,@isnumeric);  % additional safety factor
p.addParameter('h0',20,@isnumeric);
p.addParameter('k0',1,@isnumeric);
p.addParameter('gamma',90,@isnumeric);


p.parse(varargin{:});


n1 = p.Results.n1;
n2 = p.Results.n2;
xlim = p.Results.xlim;
ylim = p.Results.ylim;
sx = p.Results.sx;
sy = p.Results.sy;
safetyFactor = p.Results.safetyFactor;
numx=p.Results.numx;
numy=p.Results.numy;
h0=p.Results.h0;
k0=p.Results.k0;
gamma=p.Results.gamma;
%%
xmin=-xlim;
ymin=-ylim;
sy=sy*safetyFactor;
sx=sx*safetyFactor;
%% x_m and y_m are the midpoints of the pixels, we have numx*numy pixels
[x_m,y_m]=meshgrid(linspace(xmin+(xlim-xmin)/(2*numx),xlim-(xlim-xmin)/(2*numx),numx),linspace(ymin+(ylim-ymin)/(2*numy),ylim-(ylim-ymin)/(2*numy),numy));
dphix=n2.*k0.*(x_m.*(sx-1)./(sqrt((sy-1)^2*y_m.^2+h0^2)))./sqrt(1+(x_m.*(sx-1)./(sqrt((sy-1)^2*y_m.^2+h0^2))).^2);
dphiy=n2.*k0.*(((sy-1).*y_m/h0)./sqrt(1+((sy-1).*y_m./h0).^2)./sqrt(1+((sx-1).*x_m./sqrt((sy-1).*y_m.^2+h0.^2)).^2));
dphiu=cosd(gamma).*dphix+sind(gamma).*dphiy;
dphiv=-sind(gamma).*dphix+cosd(gamma).*dphiy;
end

