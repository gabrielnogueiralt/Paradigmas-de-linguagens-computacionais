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

-- Sort & Merge
msort :: Ord a => [a] -> [a]
msort = listaCompleta . map (:[]) 
  where
    listaCompleta [] = []
    listaCompleta [t] = t
    listaCompleta xs  = listaCompleta (subLista xs)

    subLista (x:y:xs) = merge x y:subLista xs
    subLista xs = xs

-- Divida as listas
metade :: [a] -> ([a], [a])
metade [] = ([], [])
metade [x] = ([x], [])
metade (f:g:hs) =
  let (fs, gs) = metade hs 
    in (f : fs, g : gs)

-- Quantas divisões exatas
numDiv :: Integral a => a -> a -> a
numDiv n m = divExata n m 0
  where
    divExata n m c
      | n `mod` m == 0 = divExata (n `div` m)  m (c+1)
      | otherwise = c

-- Quais os únicos
removeElementos :: Int -> [Int] -> [Int]
removeElementos _ []                 = []
removeElementos x (y:ys) | x == y    = removeElementos x ys
                         | otherwise = y : removeElementos x ys

ehIgual :: (Eq a) => [a] -> a -> Bool
ehIgual [] _ = False
ehIgual (x:xs) y
  | x == y    = True
  | otherwise = ehIgual xs y

unicos :: [Int] -> [Int]
unicos [] = []
unicos (x:xs)
  | ehIgual xs x  = unicos (removeElementos x xs)
  | otherwise = x : unicos xs