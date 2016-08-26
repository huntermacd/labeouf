module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import String


-- main

main : Program Never
main =
  App.beginnerProgram
    { model = emptyModel
    , view = view
    , update = update
    }

-- Model

type alias Model =
  { entries : List Entry
  , input : String
  , uid : Int
  }

type alias Entry =
  { description : String
  , id : Int
  , taps : Int
  }

emptyModel : Model
emptyModel =
  { entries = []
  , input = ""
  , uid = 0
  }


-- Update

type Msg
  = NoOp
  | UpdateInput String
  | Add
  | Tap Int


update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp -> model

    UpdateInput str ->
      { model | input = str }

    Add ->
      { model
        | input = ""
        , uid = model.uid + 1
        , entries =
            if String.isEmpty model.input then
              model.entries
            else
              model.entries ++ [newEntry model.input model.uid]}

    Tap id ->
      let updateEntry e =
        if e.id == id then { e | taps = e.taps + 1 } else e
      in
        { model | entries = List.map updateEntry model.entries }


newEntry : String -> Int -> Entry
newEntry desc id' =
  { description = desc
  , id = id'
  , taps = 0
  }

onEnter : Msg -> Attribute Msg
onEnter msg =
  let
    tagger code =
      if code == 13 then msg else NoOp
  in
    on "keydown" (Json.map tagger keyCode)


-- View

view : Model -> Html Msg
view model =
  div
    []
    [ header
        []
        [ h1 [] [ text "PRIORITIES" ]
        , div
          [ class "input-container" ]
          [ input
              [ placeholder "What's your idea?"
              , autofocus True
              , value model.input
              , onInput UpdateInput
              , onEnter Add
              ]
              []
          ]
        ]
    , main'
        []
        [ div
            [ id "todos" ] <|
            List.map viewEntry model.entries
        , div
            [ class "instructions" ]
            [ p [] [ text "Tap to prioritize." ]
            -- , p [] [ text "Tap-hold to remove priority." ]
            ]
        ]
    ]

viewEntry : Entry -> Html Msg
viewEntry entry =
  div
    [ class "todo"
    , onClick <| Tap entry.id
    ]
    [ p
        [ class "description" ]
        [ text entry.description ]
    , span
        [ class "taps" ]
        [ text <| toString entry.taps ]
    ]
