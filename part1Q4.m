RGB_rocket_man = single(imread('wallypuzzle_rocket_man.png'));
R_rocket_man = RGB_rocket_man(:,:,1);
G_rocket_man = RGB_rocket_man(:,:,2);
B_rocket_man = RGB_rocket_man(:,:,3);

grey_rocket_man = 0.2989*R_rocket_man + 0.5870*G_rocket_man + 0.1140*B_rocket_man;

% We can test that this has resulted in a greyscale image as we want using
% the following code:

% imagetoshow = mat2gray(grey_rocket_man);
% imshow(imagetoshow);

RGB_puzzle = single(imread('wallypuzzle_small.png'));
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

mean_M = (1/numel(M))*sum(M(:));
mean_N = (1/numel(N))*sum(N(:));

offset_M = M-mean_M;
offset_N = N-mean_N;

std_M = std(M(:));
std_N = std(N(:));

norm_offset_M = offset_M/std_M;
norm_offset_N = offset_N/std_N;

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
        sum_moving_offset_M(k,l) = (1/numel(M))*sum(corellation_at_each_configuration(:));
        correlation = sum_moving_offset_M;
        
    end  
end

% We now find the position of the bottom-right corner of the Rocket Man
% image inside the puzzle image at highest correlation

correlation
max_correlation = max(correlation(:))
[verdist,hordist] = find(ismember(correlation, max(correlation(:))))

% With the information of the position of highest correlation, we now expand out from 
% that corner to generate a matrix of the same dimensions of  the rocket
% man image---this will frame the location of the rocket man inside the
% puzzle image. Showing the result.....

RGB_puzzle_image = imread('wallypuzzle_small.png');
R_puzzle_image = RGB_puzzle_image(:,:,1);
G_puzzle_image = RGB_puzzle_image(:,:,2);
B_puzzle_image = RGB_puzzle_image(:,:,3);

grey_puzzle_image = 0.2989*R_puzzle_image + 0.5870*G_puzzle_image + 0.1140*B_puzzle_image;

RGB_rocket_man_image = imread('wallypuzzle_rocket_man.png');
R_rocket_man_image = RGB_rocket_man_image(:,:,1);
G_rocket_man_image = RGB_rocket_man_image(:,:,2);
B_rocket_man_image = RGB_rocket_man_image(:,:,3);

grey_rocket_man_image = 0.2989*R_rocket_man_image + 0.5870*G_rocket_man_image + 0.1140*B_rocket_man_image;

[rocketman_height,rocketman_width] = size(grey_rocket_man_image)

rocketman_inside = grey_puzzle(vertdist-rocketman_height:verdist,hordist-rocketman_width:verdist)
figure = imshow(rocketman_inside)
