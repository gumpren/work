pro plot_line_hx_lasttime_10minute_per_point_2hours_delay
  
  namestr='full_'
  suffix_str='_far_duskflank'
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point_2hours_delay\'
  filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point_2hours_delay'+suffix_str+'.sav'
  
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point_2hours_delay\'
  title_char='line_hx_lasttime_10minute_per_point_2hours_delay'+suffix_str
   
  if (strmatch(filename,'*full*') eq 1b) then begin
    output_dir=output_dir+'full\'
    title_char='full_'+title_char
  endif else begin
    output_dir=output_dir
    title_char=title_char
  endelse
    
  title0=['median_hx_Bz','average_hx_Bz']
  ytitle='H'+cgsymbol('sub')+'x'       
  
  restore,filename=filename
  x=indgen(15)

  median_hx1=dblarr(15)  
  average_hx1=dblarr(15)
  median_hx2=dblarr(15)
  average_hx2=dblarr(15)
         
  for i=0,14 do begin
    median_hx1[i]=median((H_Re[i])[*,0])
    average_hx1[i]=cal_average((H_Re[i])[*,0],/normal_average)   ;fix average

    median_hx2[i]=median((H_Re[i+15])[*,0])
    average_hx2[i]=cal_average((H_Re[i+15])[*,0],/normal_average)    ; 57 58 
    
  endfor
         
  a=[[[1],[2]], $
     [[3],[4]]]
  
  get_Data=[[[median_hx1],[median_hx2]],  $
           [[average_hx1],[average_hx2]]]
;  err_bar=[[[err_median_hx1],[err_median_hx2]],  $
;           [[err_average_hx1],[err_average_hx2]] ]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.05,right=0.80,xgap=0.1,ygap=0.1,low=0.01,high=0.7)

  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add
  


  for i=0,1 do begin
;    for j=0,1 do begin
;      if i ne 1 then begin
;        str_element,opt_plot,'xtickformat','(a1)',/add
;        str_element,opt_plot,'xtitle',/delete
;      endif else begin
;        str_element,opt_plot,'xtickformat',/delete
;        str_element,opt_plot,'xtitle','Time',/add
;      endelse

      ;      if j eq 0 then begin
      ;        str_element,opt_plot,'ytitle',ytitle[0],/add
      ;      endif else begin
      ;        str_element,opt_plot,'ytitle',ytitle[1],/add
      ;      endelse
      ;str_element,opt_plot,'SYM_INCREMENT',3
;      str_element,opt_plot,'xtickname',['[0,0.5]','[0.5,1.0]','[1.0,1.5]','[1.5,2.0]','[2.0,2.5]','[2.5,3.0]',$
;        '[3.0,3.5]','[3.5,4.0]','[4.0,4.5]','[4.5,5.0]','[5.0,5.5]', $
;        '[5.5,6.0]','[6.0,6.5]','[6.5,7.0]','[7.0,7.5]','[7.5, 8.0]'],/add
      str_element,opt_plot,'xtickname',['0','10','20','30','40','50','60','70','80','90', $
      '100','110','120','130','140','150'],/add
      str_element,opt_plot,'xticks',15,/add
      str_element,opt_plot,'charsize',0.7,/add
      str_element,opt_plot,'xtitle',cgsymbol('delta')+'t',/add
      str_element,opt_plot,'ytitle',ytitle,/add

      
      cgplot,x,get_Data[*,0,i],position=pos[i,0,*],xrange=[0.5,14.5],yrange=[0,0.3],_extra=opt_plot,/normal,/noerase
      cgoplot,x,get_Data[*,1,i],color='red',position=pos[i,0,*],_extra=opt_plot,/normal,/noerase
      labels_stamp,pos[i,0,*],title0[i],charsize=0.7,/left_right_center,/up_out
      
      ;      p = ERRORPLOT(x, get_Data[*,i,j], err_bar[*,i,j], XRANGE=[1,15], $
      ;        XTITLE="Day", YTITLE="Distance (miles)", $
      ;        TITLE="Average distance bears walk in a day")
    endfor
      
      cgText, 0.85, 0.68, 'Northward IMF Bz', ALIGNMENT=0, /NORMAL ,charsize=0.7
      cgText, 0.85, 0.66, 'Southward IMF Bz', ALIGNMENT=0, /NORMAL ,COLOR='RED',charsize=0.7

  ;  cgplot,x,aaa,position=pos[0,0,*],xrange=[-20,-10],_extra=opt_plot
  ;
  ;  cgplot,x,aaa,position=pos[0,1,*],xrange=[-20,-10],_extra=opt_plot

  cgps_close


;  stop


end