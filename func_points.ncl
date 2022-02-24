
function select_point(list_points, area)
begin;;

    select = True
    select@nposlabels = 1
    select@city = list_points@Name

    ; rlpointlabel = (/"Moscow","Kazan"/)
    ; llpointlabel = (/"Tver","Ryazan"/)

    return select

end;;

undef("read_points_coord")
function read_points_coord()
begin;;

    file_point = "$lib_NCL/points/all_point.txt"
    ; if( listPoints .eq. "all" ) then
        ; file_point = "all_point.txt"
    ; else
        ; file_point = "all_point.txt"
    ; end if
    z1 = asciiread(file_point, -1, "string" )

    if (.not. isvar("npoints")) then      ; data from command line
        npoints = dimsizes(z1)-1
    end if

    ; indexX = toint( str_get_field(z1(2:),2," ") )
    ; indexY = toint( str_get_field(z1(2:),3," ") )
    ; pointName = "  " + str_get_field(z1(1:),1," ")
    point = True
    point@Name = str_get_field(z1(1:),1," ")
    point@lat  = tofloat( str_get_field(z1(1:),2," ") )
    point@lon  = tofloat( str_get_field(z1(1:),3," ") )
    point@NameRu = str_get_field(z1(1:),4," ")
    ; print ( point@Name + " " + point@lat + " " + point@lon )

    return point

end;;

undef("get_pointLabels")
function get_pointLabels(listPoints)
begin;;

    if( listPoints .eq. "all" ) then
        file_point_labels = "$lib_NCL/points/ETR.csv"
    else if( listPoints .eq. "Uni_Krs" ) then
        file_point_labels = "$lib_NCL/points/Uni_Krs.csv"
    ; else if( listPoints .eq. "RussiaKr" ) then
        ; file_point_labels = "$lib_NCL/points/RussiaKr.csv"
    else
        file_point_labels = "$lib_NCL/points/" + listPoints + ".csv"
        ; if( .not. ismissing(listPoints) .and. isfilepresent("$lib_NCL/points/listPoints" ) )then
        if( .not.  fileexists( file_point_labels ) )then
            file_point_labels = "$lib_NCL/points/ETR.csv"
        end if

    ; end if
    end if
    end if
    print("file_point_labels: " + file_point_labels)

    z2 = asciiread(file_point_labels, -1, "string" )
    nlabels = dimsizes(z2) - 1
    labels = True
    labels@id    = str_get_field(z2(1:),1," ")
    labels@name  = str_get_field(z2(1:),2," ")
    labels@pos   = str_get_field(z2(1:),3," ")
    labels@type  = str_get_field(z2(1:),4," ")
    labels@size  = str_get_field(z2(1:),5," ")
    labels@color = str_get_field(z2(1:),6," ")
    return labels
end;;

undef("get_selectedPoints")
function get_selectedPoints(listPoints,selPoints)
begin;;
    do i = 0,npoints - 1
        do j = 0,nlabels - 1
            if( labels@id(j) .eq. point@Name(i) )then
                labels@lon(j) = point@lon(i)
                labels@lat(j) = point@lat(i)
            end if
        end do
    end do

    return labels

end;;