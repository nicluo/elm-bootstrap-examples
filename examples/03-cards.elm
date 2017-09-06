module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Card as Card
import Bootstrap.Button as Button

main =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ simpleCard
                , cardWithOutline
                , cardWithTitle
                , cardWithHeaderAndFooter
                , cardGroup
                ]
           ]
        ]

simpleCard =
    Card.config [ Card.attrs [ class "mb-3" ] ]
        |> Card.block []
            [ Card.text [] [ text "This is a card block with text." ] ]
        |> Card.view

cardWithOutline =
    Card.config [ Card.outlineSuccess, Card.attrs [ class "mb-3" ] ]
        |> Card.block []
            [ Card.text [] [ text "This is a card with outline." ] ]
        |> Card.view

cardWithTitle =
    Card.config [ Card.attrs [ class "mb-3" ] ]
        |> Card.block []
            [ Card.titleH4 [] [ text "Card Title" ]
            , Card.text [] [ text "Card Text" ]
            , Card.link [ href "#"] [ text "Card link" ]
            , Card.link [ href "#"] [ text "Another link" ]
            ]
        |> Card.view

cardWithHeaderAndFooter =
    Card.config [ Card.attrs [ class "mb-3" ] ]
        |> Card.headerH3 [] [ text "Card Header"]
        |> Card.block []
            [ Card.titleH3 [] [ text "Card Title" ]
            , Card.text [] [ text "Card Text" ]
            , Card.custom <|
                Button.button [ Button.primary ] [ text "Card Link" ]
            ]
        |> Card.footer [] [ text "Card Footer" ]
        |> Card.view

cardGroup =
    Card.group
        [ Card.config []
            |> Card.headerH3 [] [ text "Card Header" ]
            |> Card.block []
                [ Card.text [] [ text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer." ] ]
            |> Card.footer []
                [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
        , Card.config []
            |> Card.headerH3 [] [ text "Card Header" ]
            |> Card.block []
                [ Card.text [] [ text "This card has supporting text below as a natural lead-in to additional content." ] ]
            |> Card.footer []
                [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
        , Card.config []
            |> Card.headerH3 [] [ text "Card Header" ]
            |> Card.block []
                [ Card.text [] [ text "This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action." ] ]
            |> Card.footer []
                [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
        ]
