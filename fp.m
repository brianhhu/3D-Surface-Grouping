function imageLR = fp(d, s)

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
imageL(1:12:25, [9:2:13 16:2:20 23:2:27]-d(1)+s) = 1;
imageL(5:12:29, [9:2:13 16:2:20 23:2:27]-d(2)+s) = 1;
imageL(9:12:33, [9:2:13 16:2:20 23:2:27]-d(3)+s) = 1;
imageL(2:12:26, [9 13 16 20 23 27]-d(1)) = 1;
imageL(6:12:30, [9 13 16 20 23 27]-d(2)) = 1;
imageL(10:12:34, [9 13 16 20 23 27]-d(3)) = 1;
imageL(3:12:27, [9:2:13 16:2:20 23:2:27]-d(1)-s) = 1;
imageL(7:12:31, [9:2:13 16:2:20 23:2:27]-d(2)-s) = 1;
imageL(11:12:35, [9:2:13 16:2:20 23:2:27]-d(3)-s) = 1;
% right image
imageR(1:12:25, [9:2:13 16:2:20 23:2:27]+d(1)-s) = 1;
imageR(5:12:29, [9:2:13 16:2:20 23:2:27]+d(2)-s) = 1;
imageR(9:12:33, [9:2:13 16:2:20 23:2:27]+d(3)-s) = 1;
imageR(2:12:26, [9 13 16 20 23 27]+d(1)) = 1;
imageR(6:12:30, [9 13 16 20 23 27]+d(2)) = 1;
imageR(10:12:34, [9 13 16 20 23 27]+d(3)) = 1;
imageR(3:12:27, [9:2:13 16:2:20 23:2:27]+d(1)+s) = 1;
imageR(7:12:31, [9:2:13 16:2:20 23:2:27]+d(2)+s) = 1;
imageR(11:12:35, [9:2:13 16:2:20 23:2:27]+d(3)+s) = 1;

% Convert L/R image into single vector
imageLR = zeros(p.N1, 1);
a = fliplr(imageL');
b = fliplr(imageR');
imageLR(1:2:end) = a(:);
imageLR(2:2:end) = b(:);

end

