function imgOut = imWarp(img1, offset_map, bAbs)
%
%     imgOut = imWarp(img1, offset_map, bAbs)
%
%     This functions warps an image, img1, using offset vectors, offset_map.
%
%     Input:
%       -img1: input image to be warped
%       -offset_map: (x,y) vectors for the offset.
%       -bAbs: if true it assumes that offset_map is 
%
%     Output:
%       -imgOut: warped img1 using the offset_map values represent pixel coordinates
%       otherwise they represent local coordinates
%
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

if(~exist('bAbs'))
    bAbs = 0;
end

if(bAbs)
    XI = offset_map(:,:,1);
    YI = offset_map(:,:,2);
else
    [r,c,col] = size(img1);
    [X,Y] = meshgrid(1:c,1:r);
    XI = X+offset_map(:,:,1);
    YI = Y+offset_map(:,:,2);
end

imgOut = zeros(r,c,col);

for i=1:3
    imgOut(:,:,i) = interp2(X,Y,img1(:,:,i),XI,YI);
end

end