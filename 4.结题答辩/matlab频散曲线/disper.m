function disper  %绘制平板频散曲线 %tic 
clc;
clear; 
cl=5950;%材料纵波波速（钢板） 
cs=3260;%材料横波波速（钢板） 
dfd=0.01*1e3;  
fd0=(0.01:dfd/1e3:20)*1e3;%频厚积（MHz*mm） 
d_Q235=5.7;   
cps_min=2700; 
cpa_min=100; 
cp_max=10000;  
mode=8;%绘制的模式数 
precision=1e-8;   
cpa=zeros(length(fd0),mode); 
cps=zeros(length(fd0),mode); 
for i=1:length(fd0)     
fd=fd0(i);  
[cp12,n] = feval('functionTest1',cps_min,cp_max,fd,cl,cs,mode)
%[cp12]=ss(cps_min,cp_max,fd,cl,cs,mode);     
for j=1:n          
	cp1=cp12(j,1);         
	cp2=cp12(j,2);          
	cps(i,j)=serfen(cp1,cp2,fd,cl,cs,precision);     
end
[cp12,n] = feval('functionTest2',cpa_min,cp_max,fd,cl,cs,mode)
%[cp12, n]=aa(cpa_min,cp_max,fd,cl,cs,mode);
 for j=1:n  
    cp1=cp12(j,1);
    cp2=cp12(j,2);  
    cpa(i,j)=aerfen(cp1,cp2,fd,cl,cs,precision);  
 end 
end   
efgh(:,1)=fd0
efgh(:,2)=cps(:,1)
efgh(:,3)=cpa(:,1)
h=zeros(mode,2); %相速度 
figure(1) 
for j=1:2    
 if j==1  
       cp=cps;  
       color='k'; 
 else     
      cp=cpa;  
      color='k-.';    
 end     
 for i=1:mode       
     cpp=cp(:,i);     
     ind=find(cpp==0);%排除空格ind(end)+1：从空格的下一个开始
     if ~isempty(ind)
         h(i,j)=plot((fd0(ind(end)+1:end)),cpp(ind(end)+1:end),color,'LineWidth',0.5);
     else  
         h(i,j)=plot(fd0,cpp,color);   
     end       
     hold on  
 end 
 
 if j==2
    text(0.5*1e3,1.5*1e3,'A0');
    text(0.5*1e3,6*1e3,'S0');
    text(1.5*1e3,7.5*1e3,'A1');
    text(3.5*1e3,6.5*1e3,'S1');
    text(6.5*1e3,5.5*1e3,'A2');
    text(10.5*1e3,5.5*1e3,'A3');
    text(8.5*1e3,9*1e3,'A4');
    text(11.5*1e3,8*1e3,'A5');
    text(16.5*1e3,7.5*1e3,'A6');
    text(15.5*1e3,9*1e3,'A7');
    text(6.5*1e3,6.5*1e3,'S2');
    text(6.5*1e3,8*1e3,'S3');
    text(10.2*1e3,9*1e3,'S4');
    text(13*1e3,8.5*1e3,'S5');
    text(14*1e3,8*1e3,'S6');
    text(18*1e3,9*1e3,'S7');

    xlabel('f·d/(MHz·mm)')   
    ylabel('C_{p}/(km·s^{-1})')   
%     title('相速度频散曲线')
    set(gca,'xtick',(0:1:20)*1e3,'xticklabel',0:1:20)         
    set(gca,'ylim',[0 cp_max],'ytick',(0:cp_max/1e3)*1e3,...            
        'yticklabel',0:cp_max/1e3)   
    %grid on %网格        
    hSGroup = hggroup;%要在子对象构建之后构建，构建后立即使用，否则将失效
    hAGroup = hggroup; 
    set(h(:,1),'parent',hSGroup)
    set(h(:,2),'parent',hAGroup) 
    set(get(get(hSGroup,'Annotation'),'LegendInformation'),...            
        'IconDisplayStyle','on');         
    set(get(get(hAGroup,'Annotation'),'LegendInformation'),...             
        'IconDisplayStyle','on');  
%     legend('对称模式','反对称模式') 
     
 end 
end
%群速度 
figure(2) 
for j=1:2  
if j==1 
  cp=cps; 
  color='k'; 
else 
  cp=cpa; 
  color='k-.'; 
end 
for i=1:mode  
    cpp=cp(:,i);  
    ind=find(cpp==0);  
    if ~isempty(ind)  
        fd=fd0(ind(end)+1:end)'; 
        cpp=cpp(ind(end)+1:end);  
    else  
        fd=fd0'; 
    end  
    dcdf=diff(cpp)/dfd;  
    cg=cpp(1:end-1).^2./(cpp(1:end-1)-fd(1:end-1).*dcdf);
   
    if i==1&&j==1 
        for m=1:2000-0-1  
          efgh(m,4)=fd(m)%S0  fd
          efgh(m,5)=cg(m);    %S0  
        end
    elseif i==1&&j==2   
        for m=1:2000-0-1  
          efgh(m,6)=fd(m)%A0  fd
          efgh(m,7)=cg(m);    %A0  
        end      
    elseif i==2&&j==2  
         for m=1:1800 
           efgh(m,8)=fd(m)%A1  fd
           efgh(m,9)=cg(m);    %A1
         end

    end
    
    h(i,j)=plot(fd(1:end-1),cg,color);         
    hold on   
end   
if j==2 
  xlabel('f·d/(MHz·mm)')   
  ylabel('C_{g}/(km·s^{-1})') 
%   title('群速度频散曲线') 
  set(gca,'xtick',(0:1:20)*1e3,'xticklabel',0:1:20)        
  set(gca,'ylim',[0 7]*1e3,'ytick',(0:0.5:7)*1e3,'yticklabel',0:0.5:7)        
  %grid on 
  hSGroup = hggroup;%要在子对象构建之后构建，构建后立即使用，否则将失效         
  hAGroup = hggroup; 
  set(h(:,1),'parent',hSGroup)      
  set(h(:,2),'parent',hAGroup) 
  set(get(get(hSGroup,'Annotation'),'LegendInformation'),...            
      'IconDisplayStyle','on'); 
  set(get(get(hAGroup,'Annotation'),'LegendInformation'),...            
      'IconDisplayStyle','on');    
   text(0.5*1e3,2.5*1e3,'A0');   
    text(3.5*1e3,2.25*1e3,'A1');    
    text(5.5*1e3,1.5*1e3,'A2');    
    text(10*1e3,4.25*1e3,'A3');    
    text(13.2*1e3,4.5*1e3,'A4');    
    text(12.5*1e3,1.8*1e3,'A5');    
    text(18*1e3,4.7*1e3,'A6');
    

     text(0.2*1e3,5.8*1e3,'S0');
     text(3.8*1e3,5.5*1e3,'S1');
     text(7.2*1e3,5.5*1e3,'S2');
     text(10.5*1e3,5.5*1e3,'S3');
     text(14*1e3,5.7*1e3,'S4');
     text(18*1e3,5.8*1e3,'S5');
     text(14.2*1e3,2*1e3,'S6');
     text(18*1e3,1.8*1e3,'S7');
xlswrite('d:\\filename', efgh)
%   legend('对称模式','反对称模式')     
end
end %toc 
end


