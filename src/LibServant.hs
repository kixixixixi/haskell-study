{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module LibServant
    ( runServant
    ) where

import Servant(serve, Proxy(..), Server, JSON, Get, (:>))
import Data.Aeson(ToJSON)
import GHC.Generics(Generic)
import Network.Wai(Application)
import Network.Wai.Handler.Warp(run)

data User = User
  { name :: String
  , age :: Int
  , email :: String
  } deriving (Eq, Show, Generic)

instance ToJSON User


users :: [User]
users =
  [ User "kixixixixi" 33 "kixixixixi@gmail.com" 
  ]
type UserAPI = "users" :> Get '[JSON] [User]

server :: Server UserAPI
server = return users

userAPI :: Proxy UserAPI
userAPI = Proxy

app :: Application
app = serve userAPI server



runServant :: IO ()
runServant = run 8080 app
