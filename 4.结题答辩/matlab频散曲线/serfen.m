function cp=serfen(cp1,cp2,fd,cl,cs,precision) 
while cp2-cp1>precision    
 y1=smode(cp1,fd,cl,cs);   
 y2=smode(cp2,fd,cl,cs); 
 cp0=(cp1+cp2)/2; 
 y0=smode(cp0,fd,cl,cs);  
 if y1*y0<0       
  cp2=cp0;   
    elseif y2*y0<0      
        cp1=cp0;   
    elseif y0==0 
        break   
    elseif y1==0     
        cp2=cp1;      
        break   
    elseif y2==0      
        cp1=cp2;    
        break   
    end
end 
    cp=(cp2+cp1)/2; 
end  


