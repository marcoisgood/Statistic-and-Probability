function Ateam_BestEllipse(image,L,num_components,labels)
    
    roundFood_1 = [];
    roundFood_2 = [];
    figure;
    imshow(image);
    title('Fruits Classified -- Annotated w/ Colors');
    
    [height,width] = size(image);

    %image=double(image);


for c=1:num_components

    m00=0;
    m01=0;
    m10=0;
    m11=0;
    m20=0;
    m02=0;
    
    for i=1:height
        for j=1:width
         
            if(L(i,j) == labels(c))
                m01 = m01 + i.^0 * j.^1;
                m00 = m00 + i.^0 * j.^0;
                m10 = m10 + i.^1 * j.^0;
                m11 = m11 + i.^1 * j.^1;
                m20 = m20 + i.^2 * j.^0;
                m02 = m02 + i.^0 * j.^2;
            end
        end
    end
            
        xc = m10/m00;
        yc = m01/m00;
        
        if(isnan(xc) || isnan(yc))
            break;
        end
    
        u00 = m00;
        u11 = m11 - yc*m10;
        u20 = m20 - xc*m10;
        u02 = m02 - yc*m01;
        
        C = [u20, u11; u11, u02];
        C = (1/u00).*C;
        
        E = eig(C);
        theta = .5*atan2(2*u11,u20-u02);
        ecc = sqrt((E(2)-E(1))/E(2));
        
        major_x = [xc - cos(theta)*sqrt(E(2)), xc, xc + cos(theta)*sqrt(E(2))];
        major_y = [yc - sin(theta)*sqrt(E(2)), yc, yc + sin(theta)*sqrt(E(2))]; 
        hold on;

        minor_x = [xc + cos(-1.5708+theta)*sqrt(E(1)), xc, xc + cos(1.5708+theta)*sqrt(E(1))];
        minor_y = [yc + sin(-1.5708+theta)*sqrt(E(1)), yc, yc + sin(1.5708+theta)*sqrt(E(1))];
        
        len = sqrt(power(major_x(3)-major_x(1),2)+power(major_y(3)-major_y(1),2));
        
        if(ecc >.94 && ecc < .98 && ~isnan(ecc) && len > (width)/5)
        line(major_y,major_x, 'Color', 'y', 'LineWidth', 2);
        line(minor_y,minor_x, 'Color', 'y', 'LineWidth', 2);
        end
    
        if(ecc >0 && ecc <.6 && ~isnan(ecc))
       
        roundFood_1 = cat(1, roundFood_1, [major_x, major_y, minor_x, minor_y]);
        end
end

t_radii = [];
f_sf = [];
n_sf = size(roundFood_1);
radii = [];

for f=1:n_sf(1)
    t_radii = [t_radii sqrt(power(roundFood_1(f,3)-roundFood_1(f,1),2)+power(roundFood_1(f,6)-roundFood_1(f,4),2))];
end

n_rad = size(t_radii);
r_mean = mean(t_radii);
r_std = std(t_radii);

for f=1:n_sf(1)
    if(t_radii(f) >= r_mean-r_std)
        radii = [radii t_radii(f)];

        roundFood_2 = cat(1, roundFood_2, roundFood_1(f,:));
    end
end
n_rad = size(radii);
n_sf = size(roundFood_2);
for f=1:n_sf(1)
    if(radii(f) >= mean(radii)-.01*std(radii))
        
        line([roundFood_2(f,4), roundFood_2(f,5), roundFood_2(f,6)],[roundFood_2(f,1), roundFood_2(f,2), roundFood_2(f,3)], 'Color', 'b' , 'LineWidth', 2);
        line([roundFood_2(f,10), roundFood_2(f,11), roundFood_2(f,12)],[roundFood_2(f,7), roundFood_2(f,8), roundFood_2(f,9)], 'Color', 'b', 'LineWidth', 2);
    else
        line([roundFood_2(f,4), roundFood_2(f,5), roundFood_2(f,6)],[roundFood_2(f,1), roundFood_2(f,2), roundFood_2(f,3)], 'Color', 'r', 'LineWidth', 2);
        line([roundFood_2(f,10), roundFood_2(f,11), roundFood_2(f,12)],[roundFood_2(f,7), roundFood_2(f,8), roundFood_2(f,9)], 'Color', 'r', 'LineWidth', 2);
    end
end



end
        
        

