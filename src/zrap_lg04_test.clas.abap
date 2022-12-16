CLASS zrap_lg04_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zrap_lg04_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    "READ
    DATA lt_import TYPE TABLE FOR READ IMPORT zi_course_04.
    DATA lt_result TYPE TABLE FOR READ RESULT zi_course_04.
    SELECT SINGLE course_uuid
    INTO @DATA(lvuuid)
    FROM zcourse_04
    WHERE course_id = 'S4D437'.
    out->write( lvuuid ).

    READ ENTITY
    zi_course_04 ALL FIELDS WITH VALUE #( ( CourseUuid = lvuuid ) )
    RESULT DATA(lt_result2).

    loop at lt_result2 into data(wa).

    ENDLOOP.


    DATA lt_update TYPE TABLE FOR UPDATE zi_course_04.

    APPEND INITIAL LINE TO lt_update ASSIGNING FIELD-SYMBOL(<fs_data>).
    <fs_data>-%tky-CourseUuid = lvuuid.
    <fs_data>-CourseName = 'AABBCC'.

    MODIFY ENTITY
    zi_course_04 UPDATE  FIELDS ( CourseName ) WITH  lt_update
    FAILED data(lt_failed)
    REPORTED data(lt_report).

    COMMIT ENTITIES.
  ENDMETHOD.

ENDCLASS.
