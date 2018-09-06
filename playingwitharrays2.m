A = [0 0 1 1 0 0];
B = [0 0 0 1 1 0];

length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , A , padding ];
padded_B = [ padding , B , padding ];

for n=1:length(A)+length(padding);
    moving_A = padded_A(n:length(padding)+n);
    sum_moving_A = sum(moving_A.*B);
    correlation_array(n) = [ sum_moving_A ];
    
end

correlation_array
max_correlation = max(correlation_array(:))
[row,column] = find(ismember(correlation_array, max(correlation_array(:))))
