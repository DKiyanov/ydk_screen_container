class YDK_CL_SCREEN_CONTAINER definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ty_rect,
        left   TYPE i,
        top    TYPE i,
        width  TYPE i,
        height TYPE i,
      END   OF ty_rect .

  events INIT
    exporting
      value(CONTAINER) type ref to CL_GUI_CONTAINER .
  events PBO .
  events PAI .

  type-pools ABAP .
  methods CALL_SCREEN
    importing
      !NO_STATUS_TOOLBAR type ABAP_BOOL default ABAP_FALSE
      !DIALOG_RECT type TY_RECT optional .
  methods RAISE_EVENT_INIT
    importing
      !CONTAINER type ref to CL_GUI_CONTAINER .
  methods RAISE_EVENT_PBO .
  methods RAISE_EVENT_PAI .
protected section.
private section.
ENDCLASS.



CLASS YDK_CL_SCREEN_CONTAINER IMPLEMENTATION.


  METHOD call_screen.
    CALL FUNCTION 'YDK_SCREEN_CONTAINER'
      EXPORTING
        clscr             = me
        no_status_toolbar = no_status_toolbar
        left              = dialog_rect-left
        top               = dialog_rect-top
        width             = dialog_rect-width
        height            = dialog_rect-height.
  ENDMETHOD.


  METHOD RAISE_EVENT_INIT.
    RAISE EVENT init EXPORTING container = container.
  ENDMETHOD.


  METHOD raise_event_pai.
    RAISE EVENT pai.
  ENDMETHOD.


  METHOD RAISE_EVENT_PBO.
    RAISE EVENT pbo.
  ENDMETHOD.
ENDCLASS.
