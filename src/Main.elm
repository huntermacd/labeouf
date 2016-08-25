module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)


-- main

main : Program Never
main =
  App.beginnerProgram
    { model = emptyModel
    , view = view
    , update = \msg model -> model
    }

-- Model

type alias Model =
  { entries : List Entry }

type alias Entry =
  { description : String
  , id : Int
  }

emptyModel : Model
emptyModel = { entries = [] }


-- Update

type Msg =
  NoOp


-- View

view : Model -> Html Msg
view model =
  div
    []
    [ header [] [ h1 [] [ text "PRIORITIES" ] ]
    , main'
        []
        [ div
            [ id "add" ]
            [ p [class "description"] [text "+ Add Priority"] ]
        , div
            [ id "todos" ]
            []
        , div
            [ class "instructions" ]
            [ p [] [ text "Tap to prioritize." ]
            , p [] [ text "Tap-hold to remove priority." ]
            ]
        ]
    , footer [] []
    ]
