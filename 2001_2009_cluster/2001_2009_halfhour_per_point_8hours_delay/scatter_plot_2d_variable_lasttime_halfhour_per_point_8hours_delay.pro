
pro scatter_plot_2d_variable_lasttime_halfhour_per_point_8hours_delay
  h_Factor=1.0/(6.371^2*1.0e3)
  
  ;1W/m^2=6.371^2*1.0e3(1.0e16*erg/(Re^2*s))
  
  region_str='_dawnflank'
  namestr='full_'
    
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_halfhour_per_point_8hours_delay\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_halfhour_per_point_8hours_delay\'
    
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_halfhour_per_point_8hours_delay'+region_str+'.sav'
  vari=H_re
  vari_str='H_x'
  
  title_char=namestr+'scatter_plot_2d_'+vari_str+'_lasttime_halfhour_per_point_8hours_delay'+region_str
  x=0.5*(indgen(16))+0.25  
  median_vari_north=dblarr(16)
  average_vari_north=dblarr(16)
  median_vari_south=dblarr(16)
  average_vari_south=dblarr(16)
  
  
  
  xrange=[0.0,8.0]
  if (vari_str eq 'density' eq 1b)  then begin
    yrange=[-2.0,1.0] & ytickname=['10!u-2!n','10!u-1!n','10!u0!n','10!u1!n'] ;n
  endif
  if (vari_str eq 'pressure' eq 1b)  then begin
    yrange=[-3.0,1.0] & ytickname=['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n'] ;p
  endif
  if (vari_str eq 'temperature' eq 1b)  then begin
    yrange=[-2.0,2.0] & ytickname=['10!u-2!n','10!u-1!n','10!u0!n','10!u1!n','10!u2!n'];t
  endif
  if (vari_str eq 'e_gsm_y' eq 1b)  then begin
    yrange=[-8,4] ; ey
  endif
  
  if (vari_str eq 'H_x' eq 1b)  then begin
    yrange=[-4,2] ; hx
  endif

  for i=0,15 do begin
    t_last[i]=t_last[i]/60.0
    t_last[i+16]=t_last[i+16]/60.0 
   
    
    if ( (size(vari[i]))[0] eq 1)  then begin
      vari1=vari[i]   
      vari2=vari[i+16]
    endif
    
    if ( (size(vari[i]))[0] eq 2)  then begin
      vari1=(vari[i])[*,0]
      vari2=(vari[i+16])[*,0]
    endif
                                    ;  into hours
    median_vari_north[i]=median(vari1)
    average_vari_north[i]=average(vari1,/nan)

    median_vari_south[i]=median(vari2)
    average_vari_south[i]=average(vari2,/nan)
    
    
    append_array,tt_north,t_last[i]
    append_Array,vari_north,vari1

    append_array,tt_south,t_last[i+16]
    append_Array,vari_south,vari2
  endfor  
   
    
   cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   pos=set_plot_position(1,2,left=0.07,right=0.95,xgap=0.1,ygap=0.1,low=0.05,high=0.5)
   cgdisplay
   
   str_element,opt_plot,'ytickname',ytickname,/add
   
   idx_north_gt0=where(vari_north gt 0 )
   t_north_gt0=tt_north[idx_north_gt0]
   vari_north_gt0=vari_north[idx_north_gt0]   
   cgplot,t_north_gt0,alog10(vari_north_gt0),pos=pos[0,0,*],psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot
   
   idx_north_lt0=where(vari_north lt 0 )
   t_north_lt0=tt_north[idx_north_lt0]
   vari_north_lt0=vari_north[idx_north_lt0]   
   cgoplot,t_north_lt0,alog10(-vari_north_lt0),psym=3,ylog=ylog,color='royal blue'
  
   cgoplot,x,alog10(median_vari_north),xrange=xrange,ylog=ylog,yrange=yrange,color='red',/normal,/noerase
   
  ; myLine = LINFIT(t_north_gt0, vari_north_gt0, CHISQR=chisqr, COVAR=covar,MEASURE_ERRORS=measures, PROB=prob, SIGMA=sigma,YFIT=yfit)
   
   ;plot southward
   
   idx_south_gt0=where(vari_south gt 0 )
   t_south_gt0=tt_south[idx_south_gt0]
   vari_south_gt0=vari_south[idx_south_gt0]
   cgplot,t_south_gt0,alog10(vari_south_gt0),pos=pos[0,1,*],psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot

   idx_south_lt0=where(vari_south lt 0 )
   t_south_lt0=tt_south[idx_south_lt0]
   vari_south_lt0=vari_south[idx_south_lt0]
   cgoplot,t_south_lt0,alog10(-vari_south_lt0),psym=3,ylog=ylog,color='royal blue'

   cgoplot,x,alog10(median_vari_south),xrange=xrange,ylog=ylog,yrange=yrange,color='red'

     
 ;  cgscatter2d,tt,vari,xtitle='last time',ytitle='vari',psym=3
 ;   labels_stamp,title0[i],charsize=0.7,/left_right_center,/up_out
  ;stop
  print,'a'
  cgps_close
  


  stop


end