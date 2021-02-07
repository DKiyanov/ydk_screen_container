# ydk_screen_container
 A class that provides access to a screen with a container for use in other classes

Quite often in programs you need to display the container in full screen or container in modal dialog in the window size.
Usually, for this, a screen is created in the program in which the container is somehow implemented, and also in this screen itself the necessary PBO and PAI logic is implemented
That approach has a couple of problems:
* The programmer does practically the same thing, sometimes several times in the same program
* This approach is not good for OOP

In fact, the YDK_CL_SCREEN_CONTAINER class is a wrapper over the screen that generates events in response to events of the screen logic.
The following events are available:
* INIT - Executed only once, when opening the screen, before PBO
* PBO - Called when PBO screen logic is executed 
* PAI - Called when PAI screen logic is executed

The class that the programmer implements must 
* Create an instance of the class YDK_CL_SCREEN_CONTAINER
* Subscribe to relevant events, and implement their handlers
* Make a call to the CALL_SCREEN method

The instance method CALL_SCREEN of the class YDK_CL_SCREEN_CONTAINER, has the following parameters:
* NO_STATUS_TOOLBAR - to display a window in GUI-STATUS which will not have a button bar
* DIALOG_RECT - optional, contains the coordinates and size of the dialog box

```ABAP
CLASS zcl_test_screen_container DEFINITION.
  PUBLIC SECTION.
    METHODS display_report .
  PRIVATE SECTION.
    DATA screen TYPE REF TO ydk_cl_screen_container .
    DATA alvg TYPE REF TO cl_gui_alv_grid .

    METHODS alv_create
      IMPORTING
        !container TYPE REF TO cl_gui_container .
    METHODS on_screen_init
          FOR EVENT init OF ydk_cl_screen_container
      IMPORTING
          !container .
ENDCLASS.

CLASS zcl_test_screen_container IMPLEMENTATION.
  METHOD display_report.
    CREATE OBJECT screen.
    SET HANDLER on_screen_init FOR screen.
    screen->call_screen( ).
  ENDMETHOD.
  METHOD on_screen_init.
    alv_create( container ).
  ENDMETHOD.
  METHOD alv_create.
    CREATE OBJECT alvg
      EXPORTING
        i_parent = container.

    CALL METHOD alvg->set_table_for_first_display...
  ENDMETHOD.
ENDCLASS.
```