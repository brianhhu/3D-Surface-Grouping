function imageLR = bs(d, s)

% Create the stereo images that serve as input stimuli
% d: start with uncrossed (+) disparity
% s: gives slant of elements
% -1: back slant
%  0: no slant
%  1: front slant

global p;

imageL = zeros(p.N1Y, p.N1X/2);
imageR = zeros(p.N1Y, p.N1X/2);

%35x35
% left image
imageL(2:9:20, [9:2:13 16:2:20 23:2:27]-d(1)+s) = 1;
imageL(8:9:26, [9:2:13 16:2:20 23:2:27]-d(2)+s) = 1;
imageL(14:9:32, [9:2:13 16:2:20 23:2:27]-d(3)+s) = 1;
imageL(3:9:21, [9 13 16 20 23 27]-d(1)) = 1;
imageL(9:9:27, [9 13 16 20 23 27]-d(2)) = 1;
imageL(15:9:33, [9 13 16 20 23 27]-d(3)) = 1;
imageL(4:9:22, [9:2:13 16:2:20 23:2:27]-d(1)-s) = 1;
imageL(10:9:28, [9:2:13 16:2:20 23:2:27]-d(2)-s) = 1;
imageL(16:9:34, [9:2:13 16:2:20 23:2:27]-d(3)-s) = 1;
% right image
imageR(2:9:20, [9:2:13 16:2:20 23:2:27]+d(1)-s) = 1;
imageR(8:9:26, [9:2:13 16:2:20 23:2:27]+d(2)-s) = 1;
imageR(14:9:32, [9:2:13 16:2:20 23:2:27]+d(3)-s) = 1;
imageR(3:9:21, [9 13 16 20 23 27]+d(1)) = 1;
imageR(9:9:27, [9 13 16 20 23 27]+d(2)) = 1;
imageR(15:9:33, [9 13 16 20 23 27]+d(3)) = 1;
imageR(4:9:22, [9:2:13 16:2:20 23:2:27]+d(1)+s) = 1;
imageR(10:9:28, [9:2:13 16:2:20 23:2:27]+d(2)+s) = 1;
imageR(16:9:34, [9:2:13 16:2:20 23:2:27]+d(3)+s) = 1;

% Convert L/R image into single vector
imageLR = zeros(p.N1, 1);
a = fliplr(imageL');
b = fliplr(imageR');
imageLR(1:2:end) = a(:);
imageLR(2:2:end) = b(:);

end

