module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Lamdera exposing (ClientId, SessionId)


type alias FrontendModel =
    { counter : Int
    , clientId : String
    }


type alias BackendModel =
    { counter : Int
    }


type FrontendMsg
    = Increment
    | Decrement
    | NoOpFrontendMsg


type ToBackend
    = CounterIncremented
    | CounterDecremented
    | NoOpToBackend


type BackendMsg
    = ClientConnected SessionId ClientId
    | NoOpBackendMsg


type ToFrontend
    = CounterNewValue Int String