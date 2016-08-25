module Main exposing (..)

import Html exposing (..)

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
    [ header [] []
    , main' [] []
    , footer [] []
    ]
