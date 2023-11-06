{-# LANGUAGE OverloadedStrings #-}

module LibWarp
    ( runWarp
    ) where


import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)


app :: Application
app _ respond = do
    putStrLn "I've done some IO here"
    respond $ responseLBS
        status200
        [("Content-Type", "application/json")]
        "{\"message\":\"Hello, world\"}"

runWarp :: IO ()
runWarp = run 8080 app