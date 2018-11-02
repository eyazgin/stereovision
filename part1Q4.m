RGB_rocket_man = imread('wallypuzzle_rocket_man.png');
R_rocket_man = RGB_rocket_man(:,:,1);
G_rocket_man = RGB_rocket_man(:,:,2);
B_rocket_man = RGB_rocket_man(:,:,3);

grey_rocket_man = 0.2989*R_rocket_man + 0.5870*G_rocket_man + 0.1140*B_rocket_man;

% We can test that this has resulted in a greyscale image as we want using
% the following code:

% imagetoshow = mat2gray(grey_rocket_man);
% imshow(imagetoshow);

RGB_puzzle = imread('wallypuzzle_png.png');
R_puzzle = RGB_puzzle(:,:,1);
G_puzzle = RGB_puzzle(:,:,2);
B_puzzle = RGB_puzzle(:,:,3);

grey_puzzle = 0.2989*R_puzzle + 0.5870*G_puzzle + 0.1140*B_puzzle;

% we can use the code developed in Q3 to find the rocket man in the puzzle
% by setting:

M = grey_puzzle;
N = grey_rocket_man;

[height_M,length_M]=size(M);
[height_N,length_N]=size(N);

mean_M = (max(M(:))-min(M(:)))/2;
mean_N = (max(N(:))-min(N(:)))/2;

offset_M = M-min(M(:))-mean_M;
offset_N = N-min(N(:))-mean_N;

offset_Msquared = offset_M.^2;
offset_Nsquared = offset_N.^2;

variance_offset_M = sqrt(((sum(offset_Msquared(:))))/length(M));
variance_offset_N = sqrt(((sum(offset_Nsquared(:))))/length(N));

norm_offset_M = offset_M/variance_offset_M;
norm_offset_N = offset_N/variance_offset_N;

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
            moving_offset_Msquared = moving_offset_M.^2;
            variance_moving_offset_M = sqrt(((sum(moving_offset_Msquared(:))))/length_N);
        norm_moving_offset_M = moving_offset_M/variance_moving_offset_M;
        corellation_at_each_configuration = norm_moving_offset_M.*norm_offset_N;
        sum_moving_offset_M(k,l) = sum(corellation_at_each_configuration(:));
        correlation = sum_moving_offset_M;
        
    end  
end

correlation;
max_correlation = max(correlation(:));
[verdist,hordist] = find(ismember(correlation, max(correlation(:))))

norm(correlation);

horsep = hordist - 1
versep = verdist - 1
