module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button

betaStylesheet =
    node "link"
        [ rel "stylesheet"
        , href "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"
        ]
        []

main =
    Grid.container []
        [ betaStylesheet
        , blockButton
        , radioButton
        ]

blockButton =
    Button.button
        [ Button.primary, Button.block, Button.large, Button.attrs [ href "#" ] ]
        [ text "Block Button" ]

radioButton =
    Button.radioButton False []
        [ text "Radio Button" ]
