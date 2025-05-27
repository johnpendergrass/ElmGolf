
module Main exposing (main)

import Browser
import Html exposing (Html, div, text, button)
import Html.Attributes as HA
import Html.Events exposing (onClick)
import Random


-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type Terrain = Fairway | Rough | Sand | Water | Tree

type alias Model =
    { field : List (List Terrain) }

init : () -> Model
init _ =
    let
        terrainGenerator : Random.Generator Terrain
        terrainGenerator =
            Random.weighted
                [ ( 0.65, Fairway )
                , ( 0.20, Rough )
                , ( 0.07, Sand )
                , ( 0.05, Water )
                , ( 0.03, Tree )
                ]

        seed = Random.initialSeed 42

        generateRow : Int -> (List Terrain, Random.Seed)
        generateRow rowIndex =
            List.range 0 15
                |> List.foldl
                    (\_ (terrains, s) ->
                        let
                            (terrain, nextSeed) = Random.step terrainGenerator s
                        in
                        (terrain :: terrains, nextSeed)
                    )
                    ([], seed)
                |> Tuple.mapFirst List.reverse

        generateGrid : Int -> Random.Seed -> (List (List Terrain), Random.Seed)
        generateGrid rows s0 =
            List.foldl
                (\_ (acc, s) ->
                    let
                        (row, sNext) = generateRow 0
                    in
                    (acc ++ [row], sNext)
                )
                ([], s0)
                (List.range 0 25)

        (fieldData, _) = generateGrid 26 seed
    in
    { field = fieldData }


-- TERRAIN COLORS & ICONS

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


-- MESSAGES

type Msg
    = NewGame
    | UseMulligan


-- UPDATE

update : Msg -> Model -> Model
update msg model =
    model


-- VIEW

view : Model -> Html Msg
view model =
    div [ HA.style "font-family" "sans-serif" ]
        [ div
            [ HA.style "position" "relative"
            , HA.style "width" "272px"
            , HA.style "height" "442px"
            , HA.style "border" "1px solid black"
            ]
            (drawField model.field)
        , drawStatus
        ]


drawField : List (List Terrain) -> List (Html Msg)
drawField field =
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
                        [ HA.style "position" "absolute"
                        , HA.style "left" left
                        , HA.style "top" top
                        , HA.style "width" "15px"
                        , HA.style "height" "15px"
                        , HA.style "background-color" bg
                        , HA.style "border-radius" "3px"
                        , HA.style "text-align" "center"
                        , HA.style "font-size" "12px"
                        , HA.style "line-height" "15px"
                        ]
                        [ text icon ]
                )
                row
        )
        (List.indexedMap Tuple.pair field)


drawStatus : Html Msg
drawStatus =
    div
        [ HA.style "margin-top" "10px"
        , HA.style "display" "flex"
        , HA.style "gap" "10px"
        ]
        [ button [ onClick NewGame ] [ text "NEW GAME" ]
        , button [ onClick UseMulligan ] [ text "USE MULLIGAN" ]
        , div [] [ text "🎲 4 + 1 = 5" ]
        ]
