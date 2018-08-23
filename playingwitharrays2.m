A = [1 1 1 0 0 3];
B = [2 1 1 1 1 1];
    % answer is [0 1 2 1 0 1]
% we want to find the highest cumulative value for the multiplication of the
    % arrays
length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , A , padding ];
padded_B = [ padding , B , padding ];

for n=1:length(A)+length(padding)
    padded_A(1:length(padding)+n)
end
