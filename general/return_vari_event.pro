
function return_vari_event,x_pos,y_pos,variable,reverse_gap,type
  if n_elements(type) eq 0 then type=1
   event_vari=fltarr(300*reverse_gap^2)
  ; eventimes=reform(eventimes,300,1)
  ii=-20 & jj=-15
  for kk=0,300*reverse_gap^2-1 do begin
    index_ps=where((x_pos ge ii) and (x_pos lt ii+1/reverse_gap) and (y_pos ge jj) and (y_pos lt jj+1/reverse_gap))
    if((index_ps[0] ne -1)) then begin
      if (variable eq []) then begin
       event_vari[kk]=n_elements(index_ps)
      endif else begin
          case type of
            1: event_vari[kk]=median(variable[index_ps]) 
            2: event_vari[kk]=mean(variable[index_ps])  
          endcase
         
      endelse
    endif
    
    ii=ii+1/reverse_gap
    if(ii ge -10) then begin
      ii=-20
      jj=jj+1/reverse_gap
    endif
    ; help,(variable[index_1])
    ; print,index_ps
  endfor
  event_vari=reform(event_vari,10*reverse_gap,30*reverse_gap)
  return,event_vari
  
  
 
end


;function return_vari_event,x_pos,y_pos,variable,reverse_gap
;  event_vari=fltarr(300*reverse_gap^2)
;  ; eventimes=reform(eventimes,300,1)
;  ii=-10 & jj=-15
;  for kk=0,300*reverse_gap^2-1 do begin
;    index_ps=where((x_pos ge ii-1/reverse_gap) and (x_pos lt ii) and (y_pos ge jj) and (y_pos lt jj+1/reverse_gap))
;    if((index_ps[0] ne -1)) then begin
;      if (variable eq []) then begin
;        event_vari[kk]=n_elements(index_ps)
;      endif else begin
;        event_vari[kk]=median(variable[index_ps]) ;/eventimes[kk]
;      endelse
;    endif
;
;    ii=ii-1/reverse_gap
;    if(ii le -20) then begin
;      ii=-10
;      jj=jj+1/reverse_gap
;    endif
;    ; help,(variable[index_1])
;    ; print,index_ps
;  endfor
;  event_vari=reform(event_vari,10*reverse_gap,30*reverse_gap)
;  return,event_vari
;
;
;
;end

