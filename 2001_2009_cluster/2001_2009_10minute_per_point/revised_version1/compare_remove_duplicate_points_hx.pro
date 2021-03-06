pro compare_remove_duplicate_points_hx

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
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\revised_version2_remove_duplicate_points\'


  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[1]+'.sav'
  vari_dawn=H_Re
  tt_dawn=t_last

  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[2]+'.sav'
  vari_dusk=H_Re
  tt_dusk=t_last

  title_char=namestr+'line_plot_2d_hx'+region_strs[1]+'_remove_duplicate_points'

  x=10*(indgen(15))+5

  median_vari_dawn_north=dblarr(15)
  median_vari_dawn_south=dblarr(15)
  median_vari_dusk_north=dblarr(15)
  median_vari_dusk_south=dblarr(15)

  average_vari_dawn_north=dblarr(15)
  average_vari_dawn_south=dblarr(15)
  average_vari_dusk_north=dblarr(15)
  average_vari_dusk_south=dblarr(15)

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
    ;

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

  ; if ((vari_str eq 'H!dx!n' or vari_str eq 'K!dx!n')eq 1b)  then median_vari_dusk_south[11]=!values.f_nan
  median_arr_remove_d=hash()
  median_arr_remove_d[0,0]=median_vari_dawn_north   &    median_arr_remove_d[0,1]=median_vari_dawn_south
  median_arr_remove_d[1,0]=median_vari_dusk_north   &    median_arr_remove_d[1,1]=median_vari_dusk_south

  average_arr_remove_d=hash()
  average_arr_remove_d[0,0]=average_vari_dawn_north   &    average_arr_remove_d[0,1]=average_vari_dawn_south
  average_arr_remove_d[1,0]=average_vari_dusk_north   &    average_arr_remove_d[1,1]=average_vari_dusk_south

  ;  title_arr=[['N-IMF Dawnflank','N-IMF Duskflank'],$
  ;             ['S-IMF Dawnflank','S-IMF Duskflank']]
  title_arr=['Dawnflank','Duskflank']
  
  
  

  median_smooth_arr_remove_d=smooth_hkx_line_data(median_arr_remove_d) ;,/nan_12
  ; if keywordset nan_12  the 12th vaule in duskflank would be nan
  
  
 ;____________________________________________________________________________ 
  

  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[1]+'.sav'
  vari_dawn=H_Re
  tt_dawn=t_last

  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[2]+'.sav'
  vari_dusk=H_Re
  tt_dusk=t_last

  
  x=10*(indgen(15))+5

  median_vari_dawn_north=dblarr(15)
  median_vari_dawn_south=dblarr(15)
  median_vari_dusk_north=dblarr(15)
  median_vari_dusk_south=dblarr(15)

  average_vari_dawn_north=dblarr(15)
  average_vari_dawn_south=dblarr(15)
  average_vari_dusk_north=dblarr(15)
  average_vari_dusk_south=dblarr(15)

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

  ; if ((vari_str eq 'H!dx!n' or vari_str eq 'K!dx!n')eq 1b)  then median_vari_dusk_south[11]=!values.f_nan
  median_arr=hash()
  median_arr[0,0]=median_vari_dawn_north   &    median_arr[0,1]=median_vari_dawn_south
  median_arr[1,0]=median_vari_dusk_north   &    median_arr[1,1]=median_vari_dusk_south

  average_arr=hash()
  average_arr[0,0]=average_vari_dawn_north   &    average_arr[0,1]=average_vari_dawn_south
  average_arr[1,0]=average_vari_dusk_north   &    average_arr[1,1]=average_vari_dusk_south

  ;  title_arr=[['N-IMF Dawnflank','N-IMF Duskflank'],$
  ;             ['S-IMF Dawnflank','S-IMF Duskflank']]
  title_arr=['Dawnflank','Duskflank']


  median_smooth_arr=smooth_hkx_line_data(median_arr) ;,/nan_12
  
  cgdisplay
  window,1
  cgplot,(median_arr[0,0]-median_arr_remove_d[0,0])/median_arr[0,0]
  window,2
  cgplot,(median_arr[1,0]-median_arr_remove_d[1,0])/median_arr[1,0]
  window,3
  cgplot,(median_arr[0,1]-median_arr_remove_d[0,1])/median_arr[0,1]
  window,4
  cgplot,(median_arr[1,1]-median_arr_remove_d[1,1])/median_arr[1,1]
  
  
  
  stop
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.07,right=0.48,xgap=0.06,ygap=0.06,low=0.05,high=0.60)
  ;cgdisplay

  str_element,opt_plot,'charsize',1.0,/add
  str_element,opt_plot,'color',black,/add
  str_element,opt_plot,'yticks',yticks,/add
  ; str_element,opt_plot,'ytickname',ytickname,/add
  ; str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/add
  str_element,opt_plot,'ytitle','H'+cgsymbol('down')+'x'+'!n (10!u16!n!xergs!u-1!n!xRe!u2!n!x)',/add
  str_element,opt_plot,'xtickformat','(a1)',/add

  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yminor',9,/add
  str_element,opt_plot,'thick',4,/add

  str_element,opt_plot,'ylog',1,/add
  str_element,opt_plot,'xrange',[0.0,150.0],/add
  str_element,opt_plot,'yrange',[0.01,1.00],/add
  str_element,opt_plot,'xtickformat','(a1)',/add

 









end