function im = imcrop(im, tx, ty)

if ((length(tx) >= 2) && (length(ty) >= 2)),
	tx = [tx(1); tx(end)];
	ty = [ty(1); ty(end)];
end;

tx = round(tx);
ty = round(ty);
im = im(ty(1):ty(2),tx(1):tx(2), :);
