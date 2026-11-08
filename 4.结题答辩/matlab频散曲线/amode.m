function fs=amode(cp,fd,cl,cs)
    p=abs(sqrt((cp/cs)^2-1));
    q=abs(sqrt((cp/cl)^2-1));
    if cp<=cs%p和q都是复数 
        fs=-4*p*q*sinh(pi*fd/cp*p)*cosh(pi*fd/cp*q)+(-p^2-1)^2*sinh(pi*fd/cp*q)*cosh(pi*fd/cp*p); 
    elseif cp>cs&&cp<=cl%p是实数，q是复数 
        fs=4*p*q*sin(pi*fd/cp*p)*cosh(pi*fd/cp*q)+(p^2-1)^2*sinh(pi*fd/cp*q)*cos(pi*fd/cp*p); 
    else 
        fs=4*p*q*sin(pi*fd/cp*p)*cos(pi*fd/cp*q)+(p^2-1)^2*sin(pi*fd/cp*q)*cos(pi*fd/cp*p); 
    end 
end  


