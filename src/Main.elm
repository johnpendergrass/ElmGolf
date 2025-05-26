module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

main =
    Browser.sandbox { init = (), update = \_ model -> model, view = view }

view _ =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        , style "justify-content" "space-between"
        , style "width" "320px"
        , style "height" "568px"
        , style "box-sizing" "border-box"
        , style "padding" "0"
        , style "margin" "0"
        ]
        [ fieldRect, statusRect ]

fieldRect : Html msg
fieldRect =
    div
        [ style "width" "272px"
        , style "height" "442px"
        , style "margin-top" "24px"
        , style "background-color" "#eee"
        , style "border" "1px solid black"
        ]
        [ text "FIELD" ]

statusRect : Html msg
statusRect =
    div
        [ style "width" "272px"
        , style "height" "78px"
        , style "margin-bottom" "24px"
        , style "background-color" "#eee"
        , style "border" "1px solid black"
        ]
        [ text "STATUS" ]
