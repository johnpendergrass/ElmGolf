module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL

type alias Cell =
    { row : Int
    , col : Int
    , icon : String
    , color : String
    }


type alias Model =
    List (List Cell)


init : () -> ( Model, Cmd Msg )
init _ =
    ( generateGrid 3 3, Cmd.none )


generateGrid : Int -> Int -> Model
generateGrid rows cols =
    List.range 0 (rows - 1)
        |> List.map (\r ->
            List.range 0 (cols - 1)
                |> List.map (\c ->
                    { row = r, col = c, icon = "⛳", color = "green" }
                )
           )


-- UPDATE

type Msg
    = CellClicked Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CellClicked r c ->
            let
                updateCell cell =
                    if cell.row == r && cell.col == c then
                        { cell | icon = "⚪", color = "yellow" }
                    else
                        cell
            in
            ( List.map (List.map updateCell) model, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    div
        [ style "display" "grid"
        , style "grid-template-columns" "repeat(3, 50px)"
        , style "gap" "4px"
        , style "padding" "20px"
        ]
        (List.concatMap (List.map viewCell) model)


viewCell : Cell -> Html Msg
viewCell cell =
    div
        [ style "width" "50px"
        , style "height" "50px"
        , style "background-color" cell.color
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        , style "font-size" "24px"
        , style "border" "1px solid black"
        , onClick (CellClicked cell.row cell.col)
        ]
        [ text cell.icon ]


-- MAIN

main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
