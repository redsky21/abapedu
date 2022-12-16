CLASS zrap_lg04_fill DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrap_lg04_fill IMPLEMENTATION.
  METHOD if_oo_Adt_classrun~main.
    DATA lt_course TYPE TABLE OF zcourse_04.
    lt_course = VALUE #( ( course_uuid = cl_system_uuid=>create_uuid_x16_static( )
                           course_id = 'S4D437'
                           course_name = 'ABAP Restful Programming Model'
                           country = 'KR'
                           price = '1000'
                           currency_code = 'EUR'
                           blocked = space
                           )
                         ( course_uuid = cl_system_uuid=>create_uuid_x16_static( )
                           course_id = 'CLD400'
                           course_name = 'BTP ABAP Enviornment'
                           country = 'KR'
                           price = '900'
                           currency_code = 'EUR'
                           blocked = space
                           )                           ).

    insert zcourse_04 from table @lt_course.

    out->write( 'Inserted' ).
  ENDMETHOD.
ENDCLASS.
