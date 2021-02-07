FUNCTION ydk_screen_container.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(CLSCR) TYPE REF TO  YDK_CL_SCREEN_CONTAINER
*"     REFERENCE(NO_STATUS_TOOLBAR) TYPE  ABAP_BOOL DEFAULT ABAP_FALSE
*"     REFERENCE(LEFT) TYPE  I DEFAULT 0
*"     REFERENCE(TOP) TYPE  I DEFAULT 0
*"     REFERENCE(WIDTH) TYPE  I DEFAULT 0
*"     REFERENCE(HEIGHT) TYPE  I DEFAULT 0
*"----------------------------------------------------------------------

  DATA: ls_val LIKE gs_val.

  ls_val = gs_val.

  CLEAR gs_val.
  gs_val-clscr = clscr.

  DATA: dialog TYPE abap_bool.
  dialog = boolc( left IS NOT INITIAL AND top IS NOT INITIAL AND width IS NOT INITIAL AND height IS NOT INITIAL ).
  DATA: right TYPE i.
  DATA: bottom TYPE i.
  IF dialog = abap_true.
    right = left + width.
    bottom = top + height.
  ENDIF.

  IF no_status_toolbar = abap_false.
    IF dialog = abap_false.
      CALL SCREEN 100.
    ELSE.
      CALL SCREEN 101 STARTING AT left top ENDING AT right bottom.
    ENDIF.
  ELSE.
    IF dialog = abap_false.
      CALL SCREEN 200.
    ELSE.
      CALL SCREEN 201 STARTING AT left top ENDING AT right bottom.
    ENDIF.
  ENDIF.

  gs_val = ls_val.
ENDFUNCTION.
