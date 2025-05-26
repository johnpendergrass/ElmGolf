module Main exposing (main)

import Browser
import Html exposing (Html, div, button, text)
import Html.Attributes exposing (style)
import List exposing (range)

main =
    Browser.sandbox { init = (), update = \_ model -> model, view = view }

-- Constants
cols = 16
rows = 26
cellSize = 17

view _ =
    div
        [ style "position" "relative"
        , style "width" "320px"
        , style "height" "568px"
        , style "background-color" "#fdd"
        ]
        [ -- FIELD
          div
            [ style "position" "absolute"
            , style "top" "24px"
            , style "left" "24px"
            , style "width" "272px"
            , style "height" "442px"
            , style "background-color" "#eee"
            , style "border" "1px solid black"
            , style "display" "grid"
            , style "grid-template-columns" ("repeat(" ++ String.fromInt cols ++ ", " ++ String.fromInt cellSize ++ "px)")
            , style "grid-template-rows" ("repeat(" ++ String.fromInt rows ++ ", " ++ String.fromInt cellSize ++ "px)")
            ]
            (List.map cellView (range 1 (cols * rows)))
        , -- STATUS + DIE BOX
          div
            [ style "position" "absolute"
            , style "bottom" "0px"
            , style "left" "24px"
            , style "width" "272px"
            , style "height" "96px"
            , style "display" "flex"
            , style "flex-direction" "row"
            , style "border" "1px solid black"
            , style "background-color" "#fff"
            ]
            [ div
                [ style "width" "200px"
                , style "height" "96px"
                , style "display" "flex"
                , style "flex-direction" "column"
                ]
                [ div
                    [ style "height" "48px"
                    , style "padding" "6px"
                    , style "box-sizing" "border-box"
                    , style "display" "flex"
                    , style "flex-direction" "column"
                    , style "justify-content" "space-between"
                    ]
                    [ div
                        [ style "display" "flex"
                        , style "justify-content" "space-between"
                        , style "align-items" "center"
                        ]
                        [ div
                            [ style "font-size" "14px"
                            , style "font-weight" "bold"
                            ]
                            [ text "Hole #18 4/6 (65/70)" ]
                        , div
                            [ style "display" "flex"
                            , style "gap" "0px"
                            , style "margin-left" "8px"
                            ]
                            [ div
                                [ style "font-size" "16px"
                                , style "transform" "scale(0.5, 1.4)"
                                , style "cursor" "pointer"
                                ]
                                [ text "◀" ]
                            , div
                                [ style "font-size" "16px"
                                , style "transform" "scale(0.5, 1.4)"
                                , style "cursor" "pointer"
                                ]
                                [ text "▶" ]
                            ]
                        ]
                    , div
                        [ style "font-size" "12px" ]
                        [ text "Ball on - SAND (-1)" ]
                    ]
                , div
                    [ style "height" "48px"
                    , style "display" "flex"
                    , style "flex-direction" "row"
                    , style "justify-content" "space-around"
                    , style "align-items" "center"
                    , style "padding" "4px"
                    ]
                    [ button
                        [ style "font-size" "11px"
                        , style "padding" "2px 4px"
                        ]
                        [ div [] [ text "NEW" ]
                        , div [] [ text "GAME" ]
                        ]
                    , button
                        [ style "font-size" "11px"
                        , style "padding" "2px 4px"
                        ]
                        [ div [] [ text "USE" ]
                        , div [] [ text "MULLIGAN (4/6 left)" ]
                        ]
                    ]
                ]
            , div
                [ style "width" "72px"
                , style "height" "96px"
                , style "display" "flex"
                , style "flex-direction" "column"
                , style "align-items" "center"
                , style "justify-content" "center"
                ]
                [ div
                    [ style "width" "56px"
                    , style "height" "56px"
                    , style "border" "1px solid black"
                    , style "display" "flex"
                    , style "align-items" "center"
                    , style "justify-content" "center"
                    , style "font-size" "30px"
                    ]
                    [ text "🎲" ]
                , div
                    [ style "font-size" "13px"
                    , style "margin-top" "4px"
                    ]
                    [ text "4 + 1 = 5" ]
                ]
            ]
        ]

cellView _ =
    div
        [ style "width" (String.fromInt cellSize ++ "px")
        , style "height" (String.fromInt cellSize ++ "px")
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        , style "font-size" "12px"
        , style "border" "1px solid #ccc"
        ]
        [ text "." ]
