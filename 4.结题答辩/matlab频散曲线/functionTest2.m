%反对称模式 
function [cp0,n]=functionTest2(cp_min,cp_max,fd,cl,cs,mode) 
    cp2=cp_min;
    deter=33; 
    cp0=zeros(mode,2); 
    n=0; 
    while cp2<cp_max&&n<mode    
        cp1=cp2; 
        cp2=cp1+deter; 
        y1=amode(cp1,fd,cl,cs);  
        y2=amode(cp2,fd,cl,cs); 
        while y1*y2>0&&cp2<cp_max     
            cp1=cp2; 
            cp2=cp1+deter; 
            y1=amode(cp1,fd,cl,cs);    
            y2=amode(cp2,fd,cl,cs);   
        end 
        if y1*y2<0      
            n=n+1; 
            cp0(n,:)=[cp1 cp2];    
        elseif y1==0&&y2~=0       
            n=n+1; 
            cp0(n,:)=[cp1 cp1];   
        elseif y2==0&&y1~=0        
            n=n+1; 
            cp0(n,:)=[cp2 cp2];   
            cp2=cp2+1;     
        elseif y1==0&&y2==0     
            n=n+1; 
            cp0(n,:)=[cp1 cp1];    
            n=n+1; 
            cp0(n,:)=[cp2 cp2];   
            cp2=cp2+1;     
        end  
   end
 end



