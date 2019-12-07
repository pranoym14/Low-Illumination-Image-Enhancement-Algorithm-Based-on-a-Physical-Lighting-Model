%{
Low-Illumination Image Enhancement Algorithm Based on a Physical Lighting Model
Shun-Yuan Yu and Hong Zhu
An implemenatation done by Pranoy Mukherjee[19EC65R12] and Yash
Gupta[19EC65R16]
%}

clc
close all
clear all
a=imread("cloudy (13).jpg");
a=double(a)/255;
l=imgaussfilt(a,10);
lin=l;
iter=0.9/.05;
Nth=0.05*15*15;
up=0;
cou=0;
down=0;
[rows, columns, numberOfColorChannels] = size(a);
for t=1:numberOfColorChannels
   
    for j=1:rows
        for k=1:columns
            T(j,k,t)=0.1;
        end
    end
end
flag1=1;

row1=1;
col1=1;
row2=1;
col2=1;
flag=1;
Nloss=0;
flagr=1;
while(row1<rows && row2<rows && flagr)
    row2=row1+15;
    if row2>rows
            row2=rows;
            flagr=0;
    end
    flag=1;
    col1=1;
    col2=1;
    while(col1<columns && col2<columns && flag)
            flagr=1;
            col2=col1+15;
         if col2>columns
                col2=columns;
                flag=0;
         end
       


   
   
%Nloss=0;
%figure,imshow(T)
up=0;
down=0;
flag1=1;
for i=1:iter
if flag1==0
    break;
end
for t=1:numberOfColorChannels
    
    up=0;
    down=0;
    for j=row1:row2
        for k=col1:col2
            
             pixel=((a(j,k,t))-((l(j,k,t))/255))/T(j,k,t) + (l(j,k,t)/255);
           
           
            if pixel>1
            up=up+1;
            end
            if pixel<0
            down=down+1;
            end
        end
    end

%row1,row2
            Nloss=up+down;
           
           
            if Nloss>Nth
                %cou=cou+1;
               % cou,up,down
               
               
                   for t=1:numberOfColorChannels
                    for j=row1:row2
                        for k=col1:col2
                            T(j,k,t)=T(j,k,t)+0.05;
                            lste=(128-l(j,k,t))/iter;
                            if up>down
                                l(j,k,t)=l(j,k,t)+lste;
                                
                            else
                               l(j,k,t)=l(j,k,t)-lste;
                            end
                        end

                        end
                    end
                   
                
                 
                % figure,imshow(l);
              
                %figure,imshow(T)
                 %figure,imshow(T)
            else
               flag1=0;
               
              break;
            end
end
            
end
   
    col1=col2+1;
    end
   
     row1=row2+1;
     

   

end
     


   
    for j=1:rows
            for k=1:columns
                f(j,k)=min(a(j,k,1),a(j,k,2));
                f(j,k)=min(f(j,k),a(j,k,3));
            end
    end
%f=imread("min image.jpeg");
  bm=imguidedfilter(T,f,'NeighborhoodSize',[15 15],'DegreeOfSmoothing', 0.01*diff(getrangefromclass(f)).^2);           
  ll=imguidedfilter(l,f,'NeighborhoodSize',[15 15],'DegreeOfSmoothing', 0.01*diff(getrangefromclass(f)).^2);
for t=1:numberOfColorChannels
   
    for j=1:rows
            for k=1:columns

                    
                    r(j,k,t)=((a(j,k,t))-((ll(j,k,t))/255))/bm(j,k,t) + (ll(j,k,t)/255);
                    

                    end
    end
end




 imwrite(bm,"C:\Users\User\Documents\MATLAB\WEIGHTED_GUIDED_T_MAP.jpg");  
 imwrite(r,"C:\Users\User\Documents\MATLAB\RESTORED_IMAGE.jpg");  
%figure,imshow(T)


