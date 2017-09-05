module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import UrlParser exposing ((</>))
import Bootstrap.CDN as CDN
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { view = view
        , update = update
        , subscriptions = subscriptions
        , init = init
        }

type alias Model =
    { page : Page
    , navState : Navbar.State
    }

init : Location -> ( Model, Cmd Msg )
init location =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate location { navState = navState, page = Home }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )

type Page
    = Home
    | Page1
    | Page2
    | NotFound

type Msg
    = UrlChange Location
    | NavMsg Navbar.State

subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            urlUpdate location model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

urlUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
urlUpdate location model =
    case decode location of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )



decode : Location -> Maybe Page
decode location =
    UrlParser.parseHash routeParser location


routeParser : UrlParser.Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home UrlParser.top
        , UrlParser.map Page1 (UrlParser.s "page-1")
        , UrlParser.map Page2 (UrlParser.s "page-2")
        ]

view : Model -> Html Msg
view model =
    div []
        [ CDN.stylesheet
        , menu model
        , mainContent model
        ]


menu : Model -> Html Msg
menu model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.container
        |> Navbar.brand [ href "#" ] [ text "Elm Bootstrap" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#page-1" ] [ text "Page 1" ]
            , Navbar.dropdown
                { id = "nav-dropdown"
                , toggle = Navbar.dropdownToggle [] [ text "Dropdown" ]
                , items =
                    [ Navbar.dropdownHeader [ text "Header" ]
                    , Navbar.dropdownDivider
                    , Navbar.dropdownItem [ href "#page-2" ] [ text "Page 2" ]
                    ]
                }
            ]
        |> Navbar.customItems
            [ Navbar.formItem []
                [ Input.text
                    [ Input.small ]
                , Button.button
                    [ Button.success, Button.small ]
                    [ text "Submit"]
                ]
            , Navbar.textItem [ class "ml-2" ] [text "Text" ]
            ]
        |> Navbar.view model.navState


mainContent : Model -> Html Msg
mainContent model =
    Grid.container [] <|
        case model.page of
            Home ->
                pageHome model

            Page1 ->
                page1 model

            Page2 ->
                page2 model

            NotFound ->
                pageNotFound


pageHome : Model -> List (Html Msg)
pageHome model =
    [ h1 [] [ text "Home" ] ]

page1 : Model -> List (Html Msg)
page1 model =
    [ h1 [] [ text "Page 1" ] ]

page2 : Model -> List (Html Msg)
page2 model =
    [ h1 [] [ text "Page 2" ] ]

pageNotFound : List (Html Msg)
pageNotFound =
    [ h1 [] [ text "404 Not Found" ] ]