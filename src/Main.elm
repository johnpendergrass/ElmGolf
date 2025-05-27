
module Main exposing (main)

import Browser
import Html exposing (Html, div, button, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random


-- MAIN

main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


-- TYPES

type Terrain = Fairway | Rough | Sand | Water | Tree

type alias Model =
    { field : List (List Terrain) }

type Msg
    = NewGame
    | UseMulligan
    | FieldGenerated (List (List Terrain))


-- INIT

init : () -> (Model, Cmd Msg)
init _ =
    ( { field = [] }
    , Random.generate FieldGenerated generateField
    )


-- RANDOM FIELD GENERATION

terrainGenerator : Random.Generator Terrain
terrainGenerator =
    Random.weighted ( 0.25, Fairway )
        [ ( 0.40, Rough )
        , ( 0.07, Sand )
        , ( 0.05, Water )
        , ( 0.23, Tree )
        ]

generateField : Random.Generator (List (List Terrain))
generateField =
    Random.list 26 (Random.list 16 terrainGenerator)


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FieldGenerated grid ->
            ( { model | field = grid }, Cmd.none )

        NewGame ->
            ( model, Random.generate FieldGenerated generateField )

        UseMulligan ->
            ( model, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    div
        [ style "position" "relative"
        , style "width" "320px"
        , style "height" "568px"
        , style "background-color" "#fdd"
        ]
        ([ drawField model.field ] ++ statusBox)


-- FIELD

drawField : List (List Terrain) -> Html Msg
drawField field =
    let
        grid =
            List.concatMap
                (\(y, row) ->
                    List.indexedMap
                        (\x terrain ->
                            let
                                left = String.fromInt (x * 17 + 1) ++ "px"
                                top = String.fromInt (y * 17 + 1) ++ "px"
                                bg = terrainColor terrain
                                icon = terrainIcon terrain
                            in
                            div
                                [ style "position" "absolute"
                                , style "left" left
                                , style "top" top
                                , style "width" "15px"
                                , style "height" "15px"
                                , style "background-color" bg
                                , style "border-radius" "3px"
                                , style "text-align" "center"
                                , style "font-size" "12px"
                                , style "line-height" "15px"
                                ]
                                [ text icon ]
                        )
                        row
                )
                (List.indexedMap Tuple.pair field)
    in
    div
        [ style "position" "absolute"
        , style "top" "24px"
        , style "left" "24px"
        , style "width" "272px"
        , style "height" "442px"
        , style "background-color" "#eee"
        , style "border" "1px solid black"
        ]
        grid


-- STATUS

statusBox : List (Html Msg)
statusBox =
    [ div
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


-- HELPERS

terrainColor : Terrain -> String
terrainColor terrain =
    case terrain of
        Fairway -> "#cceacc"
        Rough -> "#b3d9a3"
        Sand -> "#fce5b2"
        Water -> "#b2dfff"
        Tree -> "#b3d9a3"

terrainIcon : Terrain -> String
terrainIcon terrain =
    case terrain of
        Tree -> "🌲"
        _ -> ""
