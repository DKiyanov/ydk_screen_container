FUNCTION-POOL ydk_screen_container.         "MESSAGE-ID ..

* INCLUDE LYDK_SCREEN_CONTAINERD...          " Local class definition

DATA: BEGIN OF gs_val,
        clscr     TYPE REF TO ydk_cl_screen_container,
        inited    TYPE abap_bool,
        container TYPE REF TO cl_gui_container,
      END OF gs_val.

MODULE pbo OUTPUT.
  IF gs_val-inited = abap_false.
    CREATE OBJECT gs_val-container TYPE cl_gui_docking_container
      EXPORTING
        side      = cl_gui_docking_container=>dock_at_top
        extension = cl_gui_docking_container=>ws_maximizebox
        metric    = cl_gui_control=>metric_pixel.

    gs_val-inited = abap_true.
    gs_val-clscr->raise_event_init( container = gs_val-container ).
  ENDIF.

  gs_val-clscr->raise_event_pbo( ).
ENDMODULE.                 " PBO  OUTPUT

MODULE pai INPUT.
  gs_val-clscr->raise_event_pai( ).
ENDMODULE.                 " USER_COMMAND  INPUT

MODULE at_exit_command INPUT.
  LEAVE TO SCREEN 0.
ENDMODULE.                 " AT_EXIT_COMMAND  INPUT
