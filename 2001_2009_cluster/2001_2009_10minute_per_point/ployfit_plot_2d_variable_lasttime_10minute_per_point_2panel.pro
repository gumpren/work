;+
; :Author: Gren
;-

pro ployfit_plot_2d_variable_lasttime_10minute_per_point_2panel
  h_Factor=1.0/(6.371^2*1.0e3)

  ;1W/m^2=6.371^2*1.0e3(1.0e15*erg/(Re^2*s))

  region_strs=['','_dawnflank','_duskflank','_near_dawnflank','_far_dawnflank','_near_duskflank','_far_duskflank']

  ;region_str=region_strs[4]
  namestr=''
  
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\'
  
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[1]+'.sav'
  vari_dawn=H_re 
  tt_dawn=t_last
  
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[2]+'.sav'
  vari_dusk=H_Re
  vari_str='H!dx!n'
  tt_dusk=t_last
  
  title_char=namestr+'1ployfit_2panel_plot_2d_median_'+vari_str+'_dawn_dusk_lasttime_10minute_per_point'

  x=10*(findgen(15))+5
  
  median_vari_dawn_north=dblarr(15)
  median_vari_dawn_south=dblarr(15)
  median_vari_dusk_north=dblarr(15)
  median_vari_dusk_south=dblarr(15)

  average_vari_dawn_north=dblarr(15)
  average_vari_dawn_south=dblarr(15)
  average_vari_dusk_north=dblarr(15)
  average_vari_dusk_south=dblarr(15)


  xrange=[0.0,150.0]
  if (vari_str eq 'density' eq 1b)  then begin
    yrange=[-1,0]
  
    unit_str='(cm!u-3!n)'

    yticks=1
    ytickname=['10!u-1!n','10!u-0!n'] ;n
  endif
  if (vari_str eq 'pressure' eq 1b)  then begin
    yrange=[-2.0,0.0]
    unit_str='(nPa)'
    yticks=2
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n'];['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n'] ;p
  endif
  if (vari_str eq 'temperature' eq 1b)  then begin
    yrange=[0,1]
    unit_str='(KeV)'
    
    yticks=1
    ytickname=['10!u-1!n','10!u0!n']
  endif
  if (vari_str eq 'E!dy!n' eq 1b)  then begin
    yrange=[-0.5,0.5] ; ey
    unit_str='(mV/m)'
  endif

  if (vari_str eq 'H!dx!n' eq 1b)  then begin
   ; yrange=[-0.1,0.15]  ;Hy no log
    
    yrange=[-2,0]
    yticks=2
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n']; hx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif

  if (vari_str eq 'K!dx!n' eq 1b)  then begin
    yrange=[-5,-3]
    yticks=2
    ytickname=['10!u-5!n','10!u-4!n','10!u-3!n']; hx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif

  if (vari_str eq 'H_K_x' eq 1b)  then begin
    yrange=[-2,0]
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n']; hkx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif

  if(vari_str eq 'v_x' eq 1b) then begin
    yrange=[-400,400]
    unit_str='(km/s)'
  endif
  
  
  restore,filename='C:\__Data\Datasave\2001_2009_10minute_per_point\earthward_flow_index.sav'
  
  for i=0,14 do begin

    if ( (size(vari_dusk[i]))[0] eq 1)  then begin
      vari_dawn_north=get_varii(vari_dawn[i],log=0)
      vari_dawn_south=get_varii(vari_dawn[i+15],log=0)
      vari_dusk_north=get_varii(vari_dusk[i],log=0)
      vari_dusk_south=get_varii(vari_dusk[i+15],log=0)      
    endif

    if ( (size(vari_dusk[i]))[0] eq 2)  then begin
      vari_dawn_north=get_varii((vari_dawn[i])[*,0],log=0)
      vari_dawn_south=get_varii((vari_dawn[i+15])[*,0],log=0)
      vari_dusk_north=get_varii((vari_dusk[i])[*,0],log=0)
      vari_dusk_south=get_varii((vari_dusk[i+15])[*,0],log=0)
    endif
    
    
;    vari_dawn_north=vari_dawn_north[(idx_dawn_north_gt0[i])]
;    vari_dawn_south=vari_dawn_south[(idx_dawn_south_gt0[i])]
;    vari_dusk_north=vari_dusk_north[(idx_dusk_north_gt0[i])]
;    vari_dusk_south=vari_dusk_south[(idx_dusk_south_gt0[i])]
    
        
    median_vari_dawn_north[i]=median(vari_dawn_north)
    median_vari_dawn_south[i]=median(vari_dawn_south)
    median_vari_dusk_north[i]=median(vari_dusk_north)   
    median_vari_dusk_south[i]=median(vari_dusk_south)

    average_vari_dawn_north[i]=average(vari_dawn_north,/nan)
    average_vari_dawn_south[i]=average(vari_dawn_south,/nan) 
    average_vari_dusk_north[i]=average(vari_dusk_north,/nan)   
    average_vari_dusk_south[i]=average(vari_dusk_south,/nan)
    
    append_Array,vari_dawn_north1,vari_dawn_north
    append_Array,vari_dawn_south1,vari_dawn_south
    append_Array,vari_dusk_north1,vari_dusk_north
    append_Array,vari_dusk_south1,vari_dusk_south

    append_Array,tt_dawn_north,tt_dawn[i]
    append_Array,tt_dawn_south,tt_dawn[i+15]
    append_Array,tt_dusk_north,tt_dusk[i]
    append_Array,tt_dusk_south,tt_dusk[i+15]

    
  endfor
  
  tt_arr=hash()
  tt_arr[0,0]=tt_dawn_north   &    tt_arr[0,1]=tt_dawn_south
  tt_arr[1,0]=tt_dusk_north   &    tt_arr[1,1]=tt_dusk_south
  
  vari_arr=hash()
  vari_arr[0,0]=vari_dawn_north1   &    vari_arr[0,1]=vari_dawn_south1
  vari_arr[1,0]=vari_dusk_north1   &    vari_arr[1,1]=vari_dusk_south1
  
  ;if ((vari_str eq 'H!dx!n' or vari_str eq 'K!dx!n')eq 1b)  then median_vari_dusk_south[11]=!values.f_nan
  median_arr=hash()
  median_arr[0,0]=median_vari_dawn_north   &    median_arr[0,1]=median_vari_dawn_south
  median_arr[1,0]=median_vari_dusk_north   &    median_arr[1,1]=median_vari_dusk_south

  average_arr=hash()
  average_arr[0,0]=average_vari_dawn_north   &    average_arr[0,1]=average_vari_dawn_south
  average_arr[1,0]=average_vari_dusk_north   &    average_arr[1,1]=average_vari_dusk_south
 
;  title_arr=[['N-IMF Dawnflank','N-IMF Duskflank'],$
;             ['S-IMF Dawnflank','S-IMF Duskflank']]
  title_arr=['Dawnflank','Duskflank']
  
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.07,right=0.48,xgap=0.06,ygap=0.06,low=0.05,high=0.80)

 ;cgdisplay

  str_element,opt_plot,'charsize',1.0,/add
  str_element,opt_plot,'yticks',yticks,/add
  str_element,opt_plot,'ytickname',ytickname,/add
  str_element,opt_plot,'ytitle',vari_str+unit_str,/add
 ; str_element,opt_plot,'xtitle','Time(minutes)',/add                                                     
  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yminor',5,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_Element,opt_plot,'yrange',yrange,/add

  
  
  ;
  for i=0,1 do begin
       
      if i ne 1 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','Time(minutes)',/add
      endelse
     
     
     polynomial_fit,x,alog10(median_arr[i,0]),alog10(median_arr[i,1]),5,measure_errors=measure_errors,plot_vis=1,$
              pos=pos[i,0,*],_extra=opt_plot,/normal,/noerase
;     
;     cgplot,x,alog10(median_arr[i,0]),pos=pos[i,0,*],xrange=xrange,color='black',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange,linestyle=0
;     cgoplot,x,alog10(median_arr[i,1]),pos=pos[i,0,*],xrange=xrange,color='black',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange,linestyle=2

     labels_stamp,pos[i,0,*],title_arr[i],charsize=1.0,/left_right_center,/up_out
     
    endfor         

  
;  cgtext,0.98,0.88,'median',alignment=0,charsize=1.0,font=0,color='red',/normal
;  cgtext,0.98,0.85,'average',alignment=0,charsize=1.0,font=0,color='royal blue',/normal 
  cgLegend, Colors=['black', 'red'], linestyle=[0,0],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.75], $
       Titles=['N-IMF','S-IMF'], Length=0.075, VSpace=1.0, /Background, $
       BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15]
  
  cgLegend, Colors=['black', 'red'], linestyle=[0,0],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.35], $
       Titles=['N-IMF','S-IMF'], Length=0.075, VSpace=1.0, /Background, $
       BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15] 
  cgps_close
 
  
  stop
  

end