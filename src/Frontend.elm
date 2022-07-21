module Frontend exposing (Model, app)

import Html
import Html.Attributes as Attr
import Html.Events
import Lamdera
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = \_ _ -> init
        
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \_ -> Sub.none
        , view = \model -> 
            { title = "v1"
            , body = [ view model]
            }
        , onUrlRequest = \_ -> NoOpFrontendMsg
        , onUrlChange = \_ -> NoOpFrontendMsg
        }


init : ( Model, Cmd FrontendMsg )
init =
    ( { counter = 0, clientId = ""}, Cmd.none)



update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        Increment ->
            ( {model | counter = model.counter + 1 }, Lamdera.sendToBackend CounterIncremented)
        
        Decrement ->
            ( {model | counter = model.counter + 1}, Lamdera.sendToBackend CounterDecremented)

        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        CounterNewValue newValue clientId ->
            ( {model | counter = newValue, clientId = clientId }, Cmd.none )


view : Model -> Html.Html FrontendMsg
view model =
    Html.div [ Attr.style "padding" "30px" ]
        [ Html.button [ Html.Events.onClick Increment ] [ Html.text "+" ]
        , Html.text (String.fromInt model.counter)
        , Html.button [ Html.Events.onClick Decrement ] [ Html.text "-" ]
        , Html.div [] [ Html.text "Click me then refresh me!" ]
        ]