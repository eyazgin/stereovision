A = [1 1 1 1 1 1];
B = [1 2 3 4 5 6];

length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , A , padding ];
padded_B = [ padding , B , padding ];

for n=1:length(A)+length(padding)
    moving_A=padded_A(n:length(padding)+n)
    moving_A.*B
end
