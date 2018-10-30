A = [0 0 1 1 0 0];
B = [0 0 0 1 1 0];

mean_A = (max(A) - min(A))/2;
mean_B = (max(B) - min(B))/2;

offset_A = A - min(A) - mean_A;
offset_B = B - min(B) - mean_B;

variance_offset_A = sqrt(((sum(offset_A.^2)))/length(A))
variance_offset_B = sqrt(((sum(offset_B.^2)))/length(B))
variance_overall = variance_offset_A*variance_offset_B

% CROSS CORRELATION:

% Below is the correlation for unnormalised vectors A & B

length(A);
padding = zeros(1,length(A)-1);
padded_norm_offset_A = [ padding , offset_A , padding ];
padded_norm_offset_B = [ padding , offset_B , padding ];

for n=1:length(A)+length(padding);
    moving_offset_A = padded_norm_offset_A(n:length(padding)+n);
    sum_moving_offset_A = sum(moving_offset_A.*offset_B);
    correlation_array(n) = [ sum_moving_offset_A ];
    
end

correlation_array
max_correlation = max(correlation_array(:))
[row,column] = find(ismember(correlation_array, max(correlation_array(:))))

% NORMALISED CROSS CORRELATION:

norm_correlation_array = correlation_array/variance_overall
