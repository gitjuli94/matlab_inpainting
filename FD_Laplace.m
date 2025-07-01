% Construct an FD matrix approximating the 2D
% Laplace operator with the infamous "five-point stencil."
% We assume that the difference h=1;
%
% Samuli Siltanen Dec 2015

function A = FD_Laplace(row,col)

% Initialize the result
A = 4*speye(row*col);

% Loop over the rows of A
for iii = 1:row
    % Loop over the columns of A
    for jjj = 1:col
        ind = (jjj-1)*row+iii;
        if iii>1
            A(ind,ind-1) = -1;
        end
        if iii<row
            A(ind,ind+1) = -1;
        end
        if jjj>1
            A(ind,ind-row) = -1;
        end
        if jjj<col
            A(ind,ind+row) = -1;
        end
    end
    if mod(iii,round(row/10))==0
        disp([iii row])
    end
end

end


