# ydk_screen_container
 Класс предоставляющий доступ к экрану с контейнером для использования в других классах

Довольно часто в программах нужно вывести контейнер на весь экран или контейнер в модальном диалоговом окне опять же в размер окна
Обычно для этого создаётся в программе экран в котором каким-то образом реализуется контейнер, а также в самом этом экране реализуется необходимая PBO и PAI логика
У того подхода есть пара проблем:
* Программист делает фактически одно и тоже, иной раз по нескольку раз в одной и той же программе
* Этот подход плохо/не красиво сочетается с ООП 

По сути класс YDK_CL_SCREEN_CONTAINER является обёрткой над экраном, генерирующей события в ответ на события экранной логики
Имеются следующие события
* INIT - Выполняется только один раз, при открытии экрана, перед PBO
* PBO - Вызывается при выполнении PBO логики экрана 
* PAI - Вызывается при выполнении PAI логики экрана

Класс который реализует программист должен
* Создать экземпляр класса YDK_CL_SCREEN_CONTAINER
* Сделать подписку на соответствующие события, и реализовать их обработчики
* Сделать вызов метода CALL_SCREEN

Метод CALL_SCREEN экземпляра класса YDK_CL_SCREEN_CONTAINER, имеет следующие параметры:
* NO_STATUS_TOOLBAR - для вывода окна в GUI-STATUS которого не будет панели с кнопками
* DIALOG_RECT- не обязательный, содержит координаты и размер диалогового окна


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