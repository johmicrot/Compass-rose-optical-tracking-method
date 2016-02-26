close all;clear all; clc;

%length & height of compass rose is 11.  5 represents pixels to the
%left & right of the center
N = 5;
%Taken from Compass rose paper --
% "The parameter ? controls the softness of the weighting effect:
% a large ? treats most neighbors as inliers, whereas a small ?
% treats most neighbors as outliers. "
alpha = 16;

img1 = input('enter the first frame you wish to load\n including the .jpg extension \n','s');
frame1 = double(imread(img1))/100;
img2 = input('enter the second frame name you wish to load\n including the .jpg extension \n','s');
frame2 = double(imread(img2))/100;

figure
imshow(frame1)
 
%%here we calculate the compass rose
[comp_rose1,~] = Comp_r_completed(frame1);
[comp_rose2,~] = Comp_r_completed(frame2);

[img_length,img_width] = size(frame1);
[comp_length,comp_width] = size(comp_rose1);

%%here we are finding the values that will bound our flow computation
firstx = comp_rose2(1,comp_width);
firsty = comp_rose2(1,comp_width-1);
lastx = comp_rose2(comp_length,comp_width); 
lasty = comp_rose2(comp_length,comp_width-1);


X = zeros(comp_length,6);
for LL = 1:5:comp_length
   %here we set the point that we will pivot around
   y = comp_rose1(LL,comp_width-1);
   x = comp_rose1(LL,comp_width);
   A = zeros((2*N)^2,6);
   b = zeros((2*N)^2,1);
   tic1 = 1;

   
   lambda_y = comp_rose1(LL,1);
   lambda_x = comp_rose1(LL,2);
   %set bounds so compass rose doesn't calculate outside of the image
   %last term (lambda_y*lambda_x > 2) is just a threshold
   if y-N > firsty && y+N < lasty ...
          && x-N > firstx && x+N < lastx && abs(lambda_y*lambda_x) < 10 && abs(lambda_y*lambda_x) > 2
                for  dy = y-N:y+N
                    for dx = x-N:x+N
                        %equation 11 (page 4) of "Compass Rose: 
                        %A Rotational Robust Signature for Optical Flow Computation"
                        w_k = exp( -abs ( frame2(dy,dx) - frame1(y,x) ) / alpha );
                        [~,frame1idx,~] = intersect(comp_rose2(:,(comp_width-1):comp_width),[dy dx],'rows');                        
                        delta_x = dx - x; delta_y = dy - y;
    %                                   (compass_rose structure)-> [lambda_y lambda_x point_gradient(X,1)' fyC fxC y x];
    %                                     point_gradient has a length of 8
                        A(tic1,:) =  w_k* [comp_rose2(frame1idx,comp_width-2) comp_rose2(frame1idx,comp_width-3) comp_rose2(frame1idx,comp_width-2)*delta_x ...
                                            comp_rose2(frame1idx,comp_width-2)*delta_y comp_rose2(frame1idx,comp_width-3)*delta_x...
                                            comp_rose2(frame1idx,comp_width-3)*delta_y];
%                         here we have the output  taken from equation 10 (page 4)         
                        b(tic1,1) = -w_k*(frame2(dy,dx)- frame1(dy,dx));
                        tic1 = tic1 + 1;
                    end 
                end
   end
   if tic1 ~= 1
        X(LL,:) = A\b;
        hold on;
        quiver(x,y,X(LL,1)*50, X(LL,2)*50);
   end
end


