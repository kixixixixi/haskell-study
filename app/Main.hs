main :: IO()

fib :: Int -> Integer
fib n = fibs !! n

fibs :: [Integer]
fibs = 0:1:zipWith (+) fibs (tail fibs)

main = do
    print $ fib 11
