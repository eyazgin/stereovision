% NORMALISED CROSS CORRELATION:

% Below is the correlation for normalised vectors A & B

B = [1 1 2 2 1 1];
A = [1 1 1 2 2 1];

mean_A = sum(A)/length(A);
mean_B = sum(B)/length(B);

std_A = std(A);
std_B = std(B);

offset_A = A - mean_A;
offset_B = B - mean_B;

norm_offset_A = offset_A/std_A;
norm_offset_B = offset_B/std_B;

length(A);
padding = zeros(1,length(A)-1);
padded_A = [ padding , norm_offset_A , padding ];
padded_B = [ padding , norm_offset_B , padding ];


for n=1:length(A)+length(padding)
    n;
    moving_offset_A = padded_A(length(A):length(padding)+n);
    moving_offset_B = padded_B(length(padding)+length(B)+1-n:length(padding)+length(B));
       
    sum_moving_offset_A = (1/(length(B)))*sum(moving_offset_A.*moving_offset_B);
       
    correlation_array(n) = [ sum_moving_offset_A ];    
end

correlation_array
max_correlation = max(correlation_array(:))
distance_moved = find(ismember(correlation_array, max(correlation_array(:))))

norm(correlation_array);

distance_separation = abs(length(B)-distance_moved)
