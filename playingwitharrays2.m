A = [1 1 1 1 1 1];
B = [1 2 3 4 5 6];

length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , A , padding ];
padded_B = [ padding , B , padding ];

for n=1:length(A)+length(padding)
    moving_A = padded_A(n:length(padding)+n);
    moving_A.*B;
    sum_moving_A = sum(moving_A.*B);

end

correlation_array(n) = sum_moving_A;
max_correlation = max(correlation_array(:))
[row,column] = find(ismember(correlation_array, max(correlation_array(:))))

if max_correlation < max(correlation_array(:))
    then
