A = [0 0 1 1 0 0];
B = [0 0 0 1 1 0];

norm_A = A - mean(A);
norm_B = B - mean(B);

length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , norm_A , padding ];
padded_B = [ padding , norm_B , padding ];

for n=1:length(A)+length(padding);
    moving_A = padded_A(n:length(padding)+n);
    sum_moving_A = sum(moving_A.*norm_B);
    correlation_array(n) = [ sum_moving_A ];
    
end

correlation_array
max_correlation = max(correlation_array(:))
[row,column] = find(ismember(correlation_array, max(correlation_array(:))))

sqrt((norm_A*norm_A')*(norm_B*norm_B'))
