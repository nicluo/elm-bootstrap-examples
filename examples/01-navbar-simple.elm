module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid

main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = subscriptions
        , init = init
        }

view : Model -> Html Msg
view model =
    div []
        [ CDN.stylesheet
        , menu model
        , mainContent
        ]

type alias Model =
    { navState : Navbar.State
    }

init : ( Model, Cmd Msg )
init =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg
    in
        ( { navState = navState }, navCmd )

type Msg
    = NavMsg Navbar.State

subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

menu : Model -> Html Msg
menu model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.container
        |> Navbar.brand [ href "#"] [ text "Elm Bootstrap"]
        |> Navbar.items
            [ Navbar.itemLink [href "#"] [ text "Item 1"]
            , Navbar.itemLink [href "#"] [ text "Item 2"]
            ]
        |> Navbar.view model.navState

mainContent : Html Msg
mainContent =
    Grid.container [] <|
        [ h1 [] [ text "Content" ] ]
