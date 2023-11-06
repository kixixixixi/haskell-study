{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module LibServant
    ( runServant
    ) where

import Servant
import Data.Aeson(ToJSON)
import GHC.Generics(Generic)
import Network.Wai(Application)
import Network.Wai.Handler.Warp(run)

data Message = Message
  { message :: String
  } deriving (Eq, Show, Generic)

-- Eq: 同値判定
-- Show: 文字列変換
-- Generic: DeriveGeneric

instance ToJSON Message

data User = User
  { name :: String
  , age :: Int
  , email :: String
  } deriving (Eq, Show, Generic)

instance ToJSON User

okMessage :: Message
okMessage = Message "ok"

users :: [User]
users =
  [ User "kixixixixi" 33 "kixixixixi@gmail.com" 
  ]


type TestAPI = Get '[JSON] Message
  :<|> "users" :> Get '[JSON] [User]  

server :: Server TestAPI
server = return okMessage
  :<|> return users

testAPI :: Proxy TestAPI
testAPI = Proxy

app :: Application
app = serve testAPI server



runServant :: IO ()
runServant = run 8080 app
