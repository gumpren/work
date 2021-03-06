pro compare_ey_with_vx_cross_bz

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_median_30_pieces\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_30_pieces\'
  title_char='compare_ey_with_vx_cross_bz';

  ee=1
  tt=300
  title0=['median','average']
  ytitle='E'+cgsymbol('sub')+'y'

  restore,filepath('raw_data'+save_str+'_list_32_pieces.sav',root_dir=root_dir)
  


  x=indgen(16)+1
  median_ey1=dblarr(16)
  average_ey1=dblarr(16)
  median_ey2=dblarr(16)
  average_ey2=dblarr(16)
 
 
  median_eyy1=dblarr(16)
  average_eyy1=dblarr(16)
  median_eyy2=dblarr(16)
  average_eyy2=dblarr(16)
  
  ab=findgen(32)
  eyy=list(ab,/ex)
  for ii=0,31 do begin
    eyy[ii]=10e-3*(velocity_gsm[ii])[*,0]*(B_gsm[ii])[*,2]    ;calcuated ey    vx*bz
  endfor
  
  
  
  for i=0,15 do begin

    median_ey1[i]=median(E_gsm_y[i])
    average_ey1[i]=average(E_gsm_y[i],/nan)

    median_ey2[i]=median(E_gsm_y[i+16])
    average_ey2[i]=average(E_gsm_y[i+16],/nan)
    
   
   
    
    median_eyy1[i]=median(eyy[i])
    average_eyy1[i]=average(eyy[i],/nan)

    median_eyy2[i]=median(eyy[i+16])
    average_eyy2[i]=average(eyy[i+16],/nan)

  endfor

  a=[[[1],[2]], $
     [[3],[4]]]

  get_Data=[[[median_ey1],[median_ey2]],  $
            [[average_ey1],[average_ey2]]]
  
  eyy_Data=[[[median_eyy1],[median_eyy2]],  $
            [[average_eyy1],[average_eyy2]]]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.05,right=0.80,xgap=0.1,ygap=0.1,low=0.01,high=0.7)

  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add



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
    str_element,opt_plot,'xtickname',['0','5','15','25','35','45','55','65','75','85','95', $
      '105','115','125','135','145',cgsymbol('infinity')],/add
    str_element,opt_plot,'xticks',16,/add
    str_element,opt_plot,'charsize',0.7,/add
    str_element,opt_plot,'xtitle',cgsymbol('delta')+'t'+' (minutes)',/add
    str_element,opt_plot,'ytitle',ytitle,/add


    cgplot,x,get_Data[*,0,i],position=pos[i,0,*],xrange=[0.5,16.5],yrange=[-1.8,1.8],_extra=opt_plot,/normal,/noerase
    cgoplot,x,eyy_Data[*,0,i],position=pos[i,0,*],xrange=[0.5,16.5],linestyle=2,_extra=opt_plot,/normal,/noerase
    
    
    cgoplot,x,get_Data[*,1,i],color='red',position=pos[i,0,*],xrange=[0.5,16.5],_extra=opt_plot,/normal,/noerase
    cgoplot,x,eyy_Data[*,1,i],color='red',position=pos[i,0,*],xrange=[0.5,16.5],linestyle=2,_extra=opt_plot,/normal,/noerase

    
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



  stop



end