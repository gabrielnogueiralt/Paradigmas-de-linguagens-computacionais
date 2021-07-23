-- Elevado à
potencia :: Integer -> Integer -> Integer
potencia n 0 = 1
potencia n k = n * potencia n (k-1)