-- Soma das raízes quadradas
maiorQueZero :: Double -> Double
maiorQueZero x
    | x < 0 = 0
    | otherwise = x

somaSqrt :: [Double] -> Double
somaSqrt [] = 0.0
somaSqrt (x:xs) = (+) (sqrt  (maiorQueZero x)) (somaSqrt (filter (> 0) xs))

