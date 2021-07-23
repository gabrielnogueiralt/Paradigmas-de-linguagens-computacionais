-- Elevado à
potencia :: Integer -> Integer -> Integer
potencia n 0 = 1
potencia n k = n * potencia n (k-1)

-- Junte as listas
merge :: Ord a => [a] -> [a] -> [a]
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys) | y < x     = y : merge (x:xs) ys
merge (x:xs) (y:ys) | otherwise = x : merge xs (y:ys)