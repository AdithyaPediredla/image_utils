function satuv = getSaturationUv(imIn, colorSpace, whitepoint)

if ((nargin < 2) || isempty(colorSpace)),
	colorSpace = 'sRGB';
end;

if ((nargin < 3) || isempty(whitepoint)),
	whitepoint = 'D65';
end;

if (strcmpi(colorSpace, 'sRGB')),
	imIn = sRGB2RGB(imIn);
elseif (~strcmpi(colorSpace, 'RGB')),
	error('Invalid color space');
end;

[~, satuv] = RGB2Lchuv(imIn, whitepoint);