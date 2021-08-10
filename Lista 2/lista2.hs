-- Soma das raízes quadradas
maiorQueZero :: Double -> Double
maiorQueZero x
    | x < 0 = 0
    | otherwise = x

somaSqrt :: [Double] -> Double
somaSqrt [] = 0.0
somaSqrt (x:xs) = (+) (sqrt  (maiorQueZero x)) (somaSqrt (filter (> 0) xs))

-- Números Perfeitos

factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n]

primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]

fatores :: Int -> [Int] -> [Int]
fatores n = filter (resto n)
   where resto n x = mod n x == 0

somaQuadrados :: [Int] -> Int
somaQuadrados [] = 0
somaQuadrados [x] = x*x
somaQuadrados (x:xs) = (x*x) + somaQuadrados xs

verificaIgualdade :: Int -> Int -> [Int]
verificaIgualdade n x
    | n == x = [x]
    | otherwise = []

conc :: [Int] -> [Int]
conc [x]     = verificaIgualdade (somaQuadrados (fatores x (primes x))) x
conc (x:xs)  = conc xs ++ (verificaIgualdade (somaQuadrados (fatores x (primes x))) x) 

perfeitos:: Int -> [Int]
perfeitos n = teste [1..n]
    where
        teste [x]    = verificaIgualdade (somaQuadrados (fatores x (primes x))) x ++ [1]
        teste (x:xs) = conc xs ++ (verificaIgualdade (somaQuadrados (fatores x (primes x))) x) ++ [1]