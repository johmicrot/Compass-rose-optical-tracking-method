function [compass_rose,ang_img,mag_ang] = Comp_r_completed(I2)
% note that b(y , x ,  color map  ,  frame number)
I = (I2(:,:,1)+I2(:,:,2)+I2(:,:,3))/3;
window = 11;
halfWindow = (window-1)/2;
[l,w,~] = size(I);
ang_img = zeros(size(I));
mag_ang = ang_img;
%% generate constants
  corner_cutoff = 50;
  SQRT26 = sqrt(26);
  SQRT10 = sqrt(10);
  SQRT2 = sqrt(2);
  SQRT13 = sqrt(13);
  SQRT5 = sqrt(5);
  
  
  TAN1o5 = atan(1/5);
  TAN1o3 = atan(1/3);
  TAN1o2 = atan(1/2);
  TAN2o3 = atan(2/3);
  TAN1 = atan(1);
  TAN3o2 = atan(3/2);
  TAN2 = atan(2);
  TAN3 = atan(3);
  TAN5 = atan(5);
  TAN1o0 = atan(1/0);  
  %i think this is pi, but i'm not sure
  %%%THIS PART IS PROBABLY WRONG!!! GO OVER AGAIN LATER

  Cx1o5 = cos(TAN1o5);
  Sy1o5 = sin(TAN1o5);
  Cx1o3 = cos(TAN1o3);
  Sy1o3 = sin(TAN1o3);
  Cx1o2 = cos(TAN1o2);
  Sy1o2 = sin(TAN1o2);
  Cx2o3 = cos(TAN2o3);
  Sy2o3 = sin(TAN2o3);
  Cx1 = cos(TAN1);
  Sy1 = sin(TAN1);
  Cx3o2 = cos(TAN3o2); 
  Sy3o2 = sin(TAN3o2);
  Cx2 = cos(TAN2);
  Sy2 = sin(TAN2);
  Cx3 = cos(TAN3);
  Sy3 = sin(TAN3);
  Cx5 = cos(TAN5);
  Sy5 = sin(TAN5);
  
  
  
   counter = 0;
  %generate vector so ang can compare to
% tan0 is rose 1  
% tan1 is rose 4  
% tan2 is rose 2
% tan3 is rose 3
% tan4 is rose 5
% tan5 is rose 1
% tan6 is rose 4
% tan7 is rose 2  ... see the pattern here
  rose_ang = [  TAN1o0  TAN1      0       -TAN1   -TAN1o0     TAN1+pi     0+pi        -TAN1+pi  ... % COMPASS 1
                TAN3    TAN1o2   -TAN1o3  -TAN2    TAN3+pi    TAN1o2+pi   -TAN1o3+pi  -TAN2+pi     ... % COMPASS 2
                TAN2    TAN1o3   -TAN1o2  -TAN3    TAN2+pi    TAN1o3+pi   -TAN1o2+pi  -TAN3+pi      ... % 3
                TAN5    TAN2o3   -TAN1o5  -TAN3o2  TAN5+pi    TAN2o3+pi   -TAN1o5+pi  -TAN3o2+pi     ...
                TAN3o2  TAN1o5   -TAN2o3  -TAN5    TAN3o2+pi  TAN1o5+pi   -TAN2o3+pi  -TAN5+pi ];
% %      rose_ang = [0 TAN1 TAN2 TAN3 TAN4 TAN5 TAN6 TAN7 TAN8 TAN9 ...
% %        TAN11 TAN12 TAN13 TAN14 TAN15 TAN16 TAN17 TAN18 TAN19];
   %length(l) for size is a guess
  compass_rose = zeros(length(l*w),13);
%% calculate gradient lambda compass rose and fy and fx
% a(~,~,2) = y            a(~,~,3) = x;
point_gradient = zeros(40,3);
% l*w/2 is estimate on upper limit of it's size
% (1...) lambdaY, (.1..) lambdaX,(..1) Y, then last is X
tic
counter = 0;
for y = 1+halfWindow:l-halfWindow
  for x = 1+halfWindow:w-halfWindow
       point_gradient = zeros(40,3);
        %% quadrant 4
        point_gradient(11,1) = (I(y,x) - I(y,x+1));
        point_gradient(12,1) = (I(y,x) - I(y+1,x+5))*SQRT26;
        point_gradient(13,1) = (I(y,x) - I(y+1,x+3))*SQRT10;
        point_gradient(14,1) = (I(y,x) - I(y+1,x+2))*SQRT5;                
        point_gradient(15,1) = (I(y,x) - I(y+2,x+3))*SQRT13;                
        point_gradient(16,1) = (I(y,x) - I(y+1,x+1))*SQRT2;                
        point_gradient(17,1) = (I(y,x) - I(y+3,x+2))*SQRT13;                
        point_gradient(18,1) = (I(y,x) - I(y+2,x+1))*SQRT5;                
        point_gradient(19,1) = (I(y,x) - I(y+3,x+1))*SQRT10;               
        point_gradient(20,1)= (I(y,x) - I(y+5,x+1))*SQRT26;
        %%
        point_gradient(11,3) =  point_gradient(11,1) ;
        point_gradient(12,3) =  point_gradient(12,1)*Cx1o5; 
        point_gradient(12,2) =  -point_gradient(12,1)*Sy1o5;
        point_gradient(13,3) =  point_gradient(13,1)*Cx1o3; 
        point_gradient(13,2) =  -point_gradient(13,1)*Sy1o3;
        point_gradient(14,3) =  point_gradient(14,1)*Cx1o2; 
        point_gradient(14,2) =  -point_gradient(14,1)*Sy1o2;
        point_gradient(15,3) =  point_gradient(15,1)*Cx2o3; 
        point_gradient(15,2) =  -point_gradient(15,1)*Sy2o3;
        point_gradient(16,3) =  point_gradient(16,1)*Cx1; 
        point_gradient(16,2) =  -point_gradient(16,1)*Sy1;
        point_gradient(17,3) =  point_gradient(17,1)*Cx3o2; 
        point_gradient(17,2) =  -point_gradient(17,1)*Sy3o2;
        point_gradient(18,3) =  point_gradient(18,1)*Cx2; 
        point_gradient(18,2) =  -point_gradient(18,1)*Sy2;
        point_gradient(19,3) =  point_gradient(19,1)*Cx3; 
        point_gradient(19,2) =  -point_gradient(19,1)*Sy3;
        point_gradient(20,3)=  point_gradient(20,1)*Cx5; 
        point_gradient(20,2)=  -point_gradient(20,1)*Sy5;
        %% q2
        
        %%%did this section
        point_gradient(1,1) = (I(y,x) - I(y-1,x));
        point_gradient(2,1) = (I(y,x) - I(y-5,x+1))*SQRT26;
        point_gradient(3,1) = (I(y,x) - I(y-3,x+1))*SQRT10;
        point_gradient(4,1) = (I(y,x) - I(y-2,x+1))*SQRT5;
        point_gradient(5,1) = (I(y,x) - I(y-3,x+2))*SQRT13;
        point_gradient(6,1) = (I(y,x) - I(y-1,x+1))*SQRT2;
        point_gradient(7,1) = (I(y,x) - I(y-2,x+3))*SQRT13;
        point_gradient(8,1) = (I(y,x) - I(y-1,x+2))*SQRT5;
        point_gradient(9,1) = (I(y,x) - I(y-1,x+3))*SQRT10;
        point_gradient(10,1)= (I(y,x) - I(y-1,x+5))*SQRT26;
%%                
        point_gradient(1,2) = point_gradient(1,1);
        point_gradient(2,3) = point_gradient(2,1)*Cx5; 
        point_gradient(2,2) = point_gradient(2,1)*Sy5;
        point_gradient(3,3) = point_gradient(3,1)*Cx3; 
        point_gradient(3,2) = point_gradient(3,1)*Sy3;
        point_gradient(4,3) = point_gradient(4,1)*Cx2; 
        point_gradient(4,2) = point_gradient(4,1)*Sy2;
        point_gradient(5,3) = point_gradient(5,1)*Cx3o2; 
        point_gradient(5,2) = point_gradient(5,1)*Sy3o2;
        point_gradient(6,3) = point_gradient(6,1)*Cx1; 
        point_gradient(6,2) = point_gradient(6,1)*Sy1;
        point_gradient(7,3) = point_gradient(7,1)*Cx2o3; 
        point_gradient(7,2) = point_gradient(7,1)*Sy2o3;
        point_gradient(8,3) = point_gradient(8,1)*Cx1o2; 
        point_gradient(8,2) = point_gradient(8,1)*Sy1o2;
        point_gradient(9,3) = point_gradient(9,1)*Cx1o3; 
        point_gradient(9,2) = point_gradient(9,1)*Sy1o3;
        point_gradient(10,3) = point_gradient(10,1)*Cx1o5; 
        point_gradient(10,2) = point_gradient(10,1)*Sy1o5;
        %% q3
        point_gradient(21,1) = (I(y,x) - I(y+1,x));
        point_gradient(22,1) = (I(y,x) - I(y+5,x-1))*SQRT26;
        point_gradient(23,1) = (I(y,x) - I(y+3,x-1))*SQRT10;
        point_gradient(24,1) = (I(y,x) - I(y+2,x-1))*SQRT5;
        point_gradient(25,1) = (I(y,x) - I(y+3,x-2))*SQRT13;
        point_gradient(26,1) = (I(y,x) - I(y+1,x-1))*SQRT2;
        point_gradient(27,1) = (I(y,x) - I(y+2,x-3))*SQRT13;
        point_gradient(28,1) = (I(y,x) - I(y+1,x-2))*SQRT5;
        point_gradient(29,1) = (I(y,x) - I(y+1,x-3))*SQRT10;
        point_gradient(30,1) = (I(y,x) - I(y+1,x-5))*SQRT26;
%%         
        point_gradient(21,2) =  -point_gradient(21,1);
        point_gradient(22,3) =  -point_gradient(22,1)*Cx5; 
        point_gradient(22,2) =  -point_gradient(22,1)*Sy5;
        point_gradient(23,3) =  -point_gradient(23,1)*Cx3; 
        point_gradient(23,2) =  -point_gradient(23,1)*Sy3;
        point_gradient(24,3) =  -point_gradient(24,1)*Cx2; 
        point_gradient(24,2) =  -point_gradient(24,1)*Sy2;
        point_gradient(25,3) =  -point_gradient(25,1)*Cx3o2; 
        point_gradient(25,2) =  -point_gradient(25,1)*Sy3o2;
        point_gradient(26,3) =  -point_gradient(26,1)*Cx1; 
        point_gradient(26,2) =  -point_gradient(26,1)*Sy1;
        point_gradient(27,3) =  -point_gradient(27,1)*Cx2o3; 
        point_gradient(27,2) =  -point_gradient(27,1)*Sy2o3;
        point_gradient(28,3) =  -point_gradient(28,1)*Cx1o2; 
        point_gradient(28,2) =  -point_gradient(28,1)*Sy1o2;
        point_gradient(29,3) =  -point_gradient(29,1)*Cx1o3; 
        point_gradient(29,2) =  -point_gradient(29,1)*Sy1o3;
        point_gradient(30,3) =  -point_gradient(30,1)*Cx1o5; 
        point_gradient(30,2) =  -point_gradient(30,1)*Sy1o5;
        %% q1
        point_gradient(31,1) = (I(y,x) - I(y,x-1));
        point_gradient(32,1) = (I(y,x) - I(y-1,x-5))*SQRT26;
        point_gradient(33,1) = (I(y,x) - I(y-1,x-3))*SQRT10;
        point_gradient(34,1) = (I(y,x) - I(y-1,x-2))*SQRT5;
        point_gradient(35,1) = (I(y,x) - I(y-2,x-3))*SQRT13;
        point_gradient(36,1) = (I(y,x) - I(y-1,x-1))*SQRT2;
        point_gradient(37,1) = (I(y,x) - I(y-3,x-2))*SQRT13;
        point_gradient(38,1) = (I(y,x) - I(y-2,x-1))*SQRT5;
        point_gradient(39,1) = (I(y,x) - I(y-3,x-1))*SQRT10;
        point_gradient(40,1)= (I(y,x) - I(y-5,x-1))*SQRT26;
     %%   
% changed this to negative below here  ()pint_grad...
        point_gradient(31,3) =  -point_gradient(31,1);
        point_gradient(32,3) =  -point_gradient(32,1)*Cx1o5; 
        point_gradient(32,2) =   point_gradient(32,1)*Sy1o5;
        point_gradient(33,3) =  -point_gradient(33,1)*Cx1o3; 
        point_gradient(33,2) =   point_gradient(33,1)*Sy1o3;
        point_gradient(34,3) =  -point_gradient(34,1)*Cx1o2; 
        point_gradient(34,2) =   point_gradient(34,1)*Sy1o2;
        point_gradient(35,3) =  -point_gradient(35,1)*Cx2o3; 
        point_gradient(35,2) =   point_gradient(35,1)*Sy2o3;
        point_gradient(36,3) =  -point_gradient(36,1)*Cx1; 
        point_gradient(36,2) =   point_gradient(36,1)*Sy1;
        point_gradient(37,3) =  -point_gradient(37,1)*Cx3o2; 
        point_gradient(37,2) =   point_gradient(37,1)*Sy3o2;
        point_gradient(38,3) =  -point_gradient(38,1)*Cx2; 
        point_gradient(38,2) =   point_gradient(38,1)*Sy2;
        point_gradient(39,3) =  -point_gradient(39,1)*Cx3; 
        point_gradient(39,2) =   point_gradient(39,1)*Sy3;
        point_gradient(40,3) =  -point_gradient(40,1)*Cx5; 
        point_gradient(40,2) =   point_gradient(40,1)*Sy5;
 
 %% calc lambda y and x fx and fy
    lambda_x = sum(point_gradient(:,3));
    lambda_y = sum(point_gradient(:,2)); 
magg = sqrt(lambda_x^2 + lambda_y^2);
%     v = sum(point_gradient(:,2).*point_gradient(:,3));
% 
%        lambda_x = sum(point_gradient(:,3).^2) - v;
%     lambda_y = sum(point_gradient(:,2).^2) - v; 
        

    %I THINK THIS IS AN EFFECTIVE WAY TO TELL IF IT POITNS DOWN OR UP
            %%%%%% this might have to be lamx/lamy, but i'm not sure
%          if lambda_y*lambda_x ~= 0 
                ang = -atan(lambda_y/abs(lambda_x));
                  [~,idx] = min(abs(rose_ang-ang));
                  if lambda_x < 0 && idx ~= 1 && idx ~= 5
                       if ang < 0 
                          ang = pi - ang ;
                       elseif ang > 0
                          ang = pi - ang;
                       else ang = pi;
                       end
                       [~,idx] = min(abs(rose_ang-ang));  
                  end 
               %% COMPASS ROSES
               switch idx
                   case 1  
                    X = [1:5:36];
                   case 2  
                    X = [6:5:36 1];
                   case 3  
                    X = [11:5:36 1 6];
                   case 4
                    X = [16:5:36 1 6 11];   
                   case 5 
                    X = [21:5:36 1 6 11 16];
                   case 6
                    X = [26:5:36 1 6 11 16 21];   
                   case 7
                    X = [31:5:36 1 6 11 16 21 26];    
                   case 8
                    X = [36 1 6 11 16 21 26 31];    
                 %% COMPASS R 2           
                   case 9
                    X = [3:5:38];
                   case 10
                    X = [8:5:38 3];
                   case 11
                    X = [13:5:38 3 8];
                   case 12
                    X = [18:5:38 3 8 13];
                    case 13
                    X = [23:5:38 3 8 13 18];
                    case 14
                    X = [28:5:38 3 8 13 18 23];
                    case 15
                    X = [33:5:38 3 8 13 18 23 28];
                    case 16
                    X = [38 3 8 13 18 23 28 33];
                  % % COMPASS 3
                   case 17   
                    X= [4:5:39];
                   case 18
                    X=[9:5:39 4];
                   case 19  
                    X=[14:5:39 4 9];
                   case 20
                    X=[19:5:39 4 9 14];
                    case 21
                    X=[24:5:39 4 9 14 19];
                   case 22
                    X=[29:5:39 4 9 14 19 24];
                    case 23
                    X=[34:5:39 4 9 14 19 24 29];
                    case 24
                    X=[39 4 9 14 19 24 29 34];
                      % COMPASS 4
                   case 25
                    X= [2:5:37];
                   case 26
                    X=[7:5:37 2];
                   case 27
                    X=[12:5:37 2 7];
                   case 28
                    X=[17:5:37 2 7 12];
                    case 29
                    X=[22:5:37 2 7 12 17];
                    case 30
                    X=[27:5:37 2 7 12 17 22];
                    case 31
                    X=[32:5:37 2 7 12 17 22 27];
                    case 32
                    X=[37 2 7 12 17 22 27 32];
    %COMPASS 5
                   case 33
                    X = [5:5:40];
                   case 34
                    X = [10:5:40 5];
                   case 35
                    X = [15:5:40 5 10];
                   case 36
                    X = [20:5:40 5 10 15];
                    case 37
                    X = [25:5:40 5 10 15 20];
                    case 38
                    X = [30:5:40 5 10 15 20 25];
                    case 39
                    X = [35:5:40 5 10 15 20 25 30];
                    case 40
                    X = [40 5 10 15 20 25 30 35];
               end
                %%
                    zzy = point_gradient(X,2);
                    zzx = point_gradient(X,3);
                    fxC = sum(point_gradient(X,3));   
                    fyC = sum(point_gradient(X,2));
                    counter = counter + 1;
                    compass_rose(counter,:)= [lambda_y point_gradient(X,1)' fyC fxC y x];
                    ang_img(y,x) = ang;
                    mag_ang(y,x) = magg;
%               
%          end
  end
end
 toc

%% this section is for showing the corners on the original image NOT NEEDED!!!
% imshow(uint8(I2))
% % for p = 1:length(slist)
% %        line below only purpose is to view the corners by creating squares
% %      rectangle('Position', [slist(p,13)-1 slist(p,12)-1  2 2]);
% %  end

