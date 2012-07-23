function [imgDet,imgLum,imgRec] = HDRMonitorDriver(img, vMax)
%
%
%       [imgDet,imgLum,imgRec] = HDRMonitorDriver(img, vMax)
%
%
%        Input:
%           -img: an HDR image
%           -vMax: to use a robust maxmimum, which value is vMax in [0,1]
%
%        Output:
%           -imgDet: the detail layer for the HDR monitor that is displayed
%                    by the LCD panel
%           -imgLum: the luminance layer for the HDR monitor that is
%                    displayed by the projector
%           -imgRec: the reconstructed HDR image
%
%     Copyright (C) 2011  Francesco Banterle
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

%Is it a three color channels image?
check3Color(img);

if(~exist('vMax'))
    vMax = -1;
end

%Normalization
if((vMax>0.0)&(vMax<1.0))
    maxImg = MaxQuart(img,vMax);
else
    maxImg = max(max(max(img)));
end

if((maxImg>0.0)&(maxImg>1.0))
    img = img / max(max(max(img)));
end

img = ClampImg(img,0.0,1.0);

%Luminance channel
L=sqrt(lum(img));

%32x32 Gaussian Filter. In the general case the PSF of the projector has to
%be measured and employed to have a precise result.
[r,c] = size(L);
Ltmp = imresize(L,1.0/6.0,'bilinear');
Ltmp = GaussianFilterWindow(Ltmp,2);
L = imresize(Ltmp,[r,c],'bilinear');

%Range reduction and quantization at 8-bit for the luminance layer. In this
%case to model the projector response function is used a gamma 2.2. In the
%general case that is not true and the response function of the projector has to
%be measured and employed to have a precise result.
invGamma = 1.0/2.2;
imgLum = round(255*(L.^invGamma))/255;

%Range reduction and quantization at 8-bit for the detail layer. In this
%case to model the LCD display response function is used a gamma 2.2. In 
%the general case that is not true and the response function of the monitor
%has to be measured and employed to have a precise result.
imgDet = zeros(size(img));
tmpImgLum = imgLum.^2.2;
for i=1:3
    imgDet(:,:,i) = round(255*(img(:,:,i)./tmpImgLum).^invGamma)/255;
end

imgDet = RemoveSpecials(imgDet);

for i=1:3
    imgRec(:,:,i) = (imgDet(:,:,i).^2.2).*(imgLum.^2.2);
end

end