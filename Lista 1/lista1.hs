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