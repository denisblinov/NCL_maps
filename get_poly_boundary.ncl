
;------------------------------------------------------------------
; Code of for plotting shape-lines.
; Authors: Denis Blinov, denisblinov@ya.ru. 2017 - ...
;------------------------------------------------------------------
begin;;

    ; npoly = max( (/1,dimsizes(cfg_grid@adm_bound)/) )
    ; print( cfg_grid@adm_bound )
    ; print( "before" )
    ; if( isvar(cfg_grid@adm_bound) )then
    ; if( isvar(cfg_grid))then
      if( isatt(cfggrid,"adm_bound") )then
        polylines = cfggrid@adm_bound
        npoly = dimsizes(cfggrid@adm_bound)
        poly = new(npoly, graphic)
        print( polylines + " " + npoly )
      ; end if
    else
        npoly = 0
    end if
    ; print( "after" )

    res_admborder = True
    res_admborder@gsLineColor = "red"
    res_admborder@gsLineColor = "black"
    res_admborder@gsLineThicknessF = 1.5
    ; res_admborder@gsLineThicknessF = 2.5
    ; res_admborder@gsLineThicknessF = 3.5
    ; res_admborder@gsLineThicknessF = 6.5
    res_river = True
    ; res_river@gsLineColor = "blue"
    ; res_river@gsLineColor = "LightBlue"
    res_river@gsLineColor = "LightSkyBlue"
    ; res_river@gsLineColor = "NavyBlue"
    res_river@gsFillColor  = "LightBlue"
    ; res_river@tfPolyDrawOrder = "Draw"
    ; res_river@tfPolyDrawOrder = "PreDraw"

    ; res_boundary             = new(2,logical,True)
    ; res_boundary             = new(2,logical,True)
    res_boundary             = (/True,True/)
    ; res_boundary(0) = True
    ; res_boundary(1) = True
    ; res_boundary(0)@gsLineColor = "black"
    ; res_boundary(1)@gsLineColor = "darkorchid"
    ; res_boundary@gsLineColor = (/"black","darkorchid"/)
    ; res_boundary@gsLineColors = (/"red","blue"/)
    ; print (res_boundary)

    do i = 0,npoly-1
        ; print( "i = " + i )
        ; poly(i) = gsn_add_shapefile_polylines(wks, plot, polylines(i), res_boundary(i))
        pres = res_admborder
        if( i .eq. 0 )then
            pres = res_admborder
        end if
        if( isStrSubset( polylines(i), "hydro") .or. isStrSubset( polylines(i), "_rivers_") )then
            pres = res_river
        end if
        if( isStrSubset( polylines(i), "hydro-inland-water") )then
            poly(i) = gsn_add_shapefile_polygons(wks, plot, polylines(i), pres)
        else
            poly(i) = gsn_add_shapefile_polylines(wks, plot, polylines(i), pres)
        end if
    end do

    ; return plot

end;;