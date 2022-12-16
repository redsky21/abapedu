CLASS lhc_zi_course_04 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS set_block FOR MODIFY
      IMPORTING keys FOR ACTION zi_course_04~set_block.
    METHODS get_authorizations FOR AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_course_04 RESULT result.
    METHODS checkrequired FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_course_04~checkrequired.
    METHODS setcountry FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_course_04~setcountry.

ENDCLASS.

CLASS lhc_zi_course_04 IMPLEMENTATION.

  METHOD set_block.
    LOOP AT  keys ASSIGNING FIELD-SYMBOL(<fs_data>).
**********************************************************************
      READ ENTITIES  OF zi_course_04 IN LOCAL MODE
      ENTITY zi_course_04
      ALL FIELDS WITH VALUE #( ( %tky-CourseUuid = <fs_data>-%tky-CourseUuid ) )
      RESULT DATA(gt_read_result).
      "예외처리

      IF gt_read_result[ 1 ]-Blocked = abap_true.
*        DATA go_message TYPE REF TO zcm_course_04.

        DATA(go_message) = NEW zcm_course_04(
        severity = if_abap_behv_message=>severity-error
        textid   = zcm_course_04=>alread_blocked
     ).
        APPEND INITIAL LINE TO reported-zi_course_04 ASSIGNING FIELD-SYMBOL(<fs_reported>).
        <fs_reported>-%tky = gt_read_result[ 1 ]-%tky.
        <fs_reported>-%msg = go_message.

        MODIFY ENTITIES   OF zi_course_04 IN LOCAL MODE
        ENTITY zi_course_04
        UPDATE FIELDS ( Blocked ) WITH VALUE #( (
        %tky-CourseUuid = <fs_data>-%tky-CourseUuid
        Blocked = abap_false ) ).

        SELECT *
        INTO TABLE @DATA(twwm)
        FROM zi_course_04
        WHERE CourseUuid = @<fs_data>-%tky-CourseUuid.

        DATA(a) = 2.
      ELSE.
**********************************************************************
        LOOP AT gt_read_result ASSIGNING FIELD-SYMBOL(<fs_result>).
          <fs_result>-Blocked = abap_true.
        ENDLOOP.


        MODIFY ENTITIES   OF zi_course_04 IN LOCAL MODE
        ENTITY zi_course_04
        UPDATE FIELDS ( Blocked ) WITH VALUE #( (
        %tky-CourseUuid = <fs_data>-%tky-CourseUuid
        Blocked = abap_true ) ).
**********************************************************************
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_authorizations.
    DATA gt_read_import TYPE TABLE FOR READ IMPORT zi_course_04.
    DATA gs_read_import TYPE STRUCTURE FOR READ IMPORT zi_course_04.

    DATA gt_Read_result TYPE TABLE FOR READ RESULT zi_course_04.
    DATA gs_read_result TYPE STRUCTURE FOR READ RESULT zi_course_04.

    DATA gs_result LIKE LINE OF result.

    MOVE-CORRESPONDING keys TO gt_read_import.

    READ ENTITY IN LOCAL MODE zi_course_04
     ALL FIELDS
     WITH gt_read_import
     RESULT gt_read_result.

    LOOP AT gt_read_result INTO gs_read_result.
      IF gs_read_result-Country <> 'KR'.

        gs_result-%tky    = gs_read_result-%tky.
        gs_result-%update = if_abap_behv=>auth-unauthorized.
        APPEND gs_result TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD checkRequired.
*        failed 에는 잘못된 instance 를 넣고
*       메세지는 메세지를 줘야함
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_key>).
      READ ENTITIES  OF  zi_course_04 IN LOCAL MODE
      ENTITY zi_course_04
      ALL FIELDS WITH VALUE #( ( %tky-CourseUuid = <fs_key>-CourseUuid ) )
      RESULT DATA(lt_resutl).

      LOOP AT  lt_resutl ASSIGNING FIELD-SYMBOL(<fs_result>).
        IF <fs_result>-CourseName IS INITIAL.
          DATA(go_message2) = NEW zcm_course_04(
          severity = if_abap_behv_message=>severity-error
          textid   = zcm_course_04=>fill_requried
       ).
          APPEND INITIAL LINE TO reported-zi_course_04 ASSIGNING FIELD-SYMBOL(<fs_reported>).
          <fs_reported>-%tky = <fs_result>-%tky.
          <fs_reported>-%msg = go_message2.
          <fs_reported>-%element-coursename = if_abap_behv=>mk-on.
        ENDIF.

        IF reported-zi_course_04 IS NOT INITIAL.
          APPEND VALUE #( %tky = <fs_result>-%tky ) TO failed-zi_course_04.
        ENDIF.

      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD setCountry.
    LOOP AT keys  INTO DATA(ls_key).
        MODIFY ENTITIES of zi_course_04 IN LOCAL MODE
        ENTITY zi_course_04
        UPDATE FIELDS ( Country ) WITH VALUE #( ( %tky = ls_key-%tky Country = 'US' ) )
        .
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
