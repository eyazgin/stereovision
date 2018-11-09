% NORMALISED 2D CROSS CORRELATION:

% Below is the correlation for normalised matrices M & N, where we are
% trying to find N inside M ....

% The way that the algorith is set up, we begin with the bottom-right
% element of N being compared with the top-left element of M and then
% moving N to the right and down over M. Therefore, the horizontal and
% vertical separation (horsep and versep respectively) reveal how far that
% element has moved---which is the same distance that the whole matrix N
% has moved---in order to get maximum correlation.

M = [0 0 1 1 0 0; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0];
N = [0 0 0 0; 1 1 0 0; 0 1 0 0];

[height_M,length_M]=size(M);
[height_N,length_N]=size(N);

mean_M = (1/numel(M))*sum(M(:))
mean_N = (1/numel(N))*sum(N(:))

offset_M = M-mean_M
offset_N = N-mean_N

std_M = std(M(:))
std_N = std(N(:))

norm_offset_M = offset_M/std_M
norm_offset_N = offset_N/std_N

padding = zeros(height_N-1,length_N-1);
padding_middletb = zeros(height_N-1,length_M);
padding_middlelr = zeros(height_M,length_N-1);
padded_norm_offset_M = [ padding padding_middletb padding ; padding_middlelr norm_offset_M padding_middlelr ; padding padding_middletb padding];

[height_padding,length_padding]=size(padding);
[height_padding_middletb,length_padding_middletb]=size(padding_middletb);
[height_padding_middlelr,length_padding_middlelr]=size(padding_middlelr);

for k=1:length_M+length_padding; %moving sideways
    for l=1:height_M+height_padding; %moving down
            moving_offset_M = padded_norm_offset_M((l:height_padding+l),(k:length_padding+k));
        corellation_at_each_configuration = moving_offset_M.*offset_N;
        sum_moving_offset_M(k,l) = (1/numel(N))*sum(corellation_at_each_configuration(:));
        correlation = sum_moving_offset_M;
        
    end  
end

correlation
max_correlation = max(correlation(:))
[verdist,hordist] = find(ismember(correlation, max(correlation(:))))

norm(correlation)

horsep = hordist - 1
versep = verdist - 1
