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

-- Unzip com foldr
unzip' :: [(a,b)] -> ([a],[b])
unzip' = foldr (\x acumulador -> (fst x:fst acumulador, snd x:snd acumulador)) ([],[])

-- Posts & Threads (a)

type Texto = String
type Id = String
type DataHoraPub = Int

data Post = Post (Id , DataHoraPub ) Texto deriving (Show , Eq, Read)
data Thread = Nil | T Post ( Thread ) deriving (Read)

instance Show Thread where
    show Nil = ""
    show (T (Post (i, d) t) (xs)) = "(" ++ i ++ " " ++ show d ++ " " ++ t ++ ")" ++ show xs 

-- Posts & Threads (b)   
inserirPost :: Post -> Thread -> Thread
inserirPost ((Post (newi, newd) newt)) (Nil) = (T (Post (newi, newd) newt) Nil)
inserirPost ((Post (newi, newd) newt)) (T (Post (i, d) t) (xs)) = (T (Post (newi, newd) newt) ((T (Post (i, d) t) (xs))))

-- Posts & Threads (c)
threadToList :: Thread -> [Post]
threadToList (Nil) = []
threadToList (T (Post (i, d) t) Nil) = [(Post (i, d) t)]
threadToList (T (Post (i, d) t) (xs)) = [(Post (i, d) t)] ++ threadToList xs

-- Posts & Threads (d)
listToThread :: [Post] -> Thread
listToThread [] = (Nil)
listToThread [(Post (i, d) t)] = (T (Post (i, d) t) Nil)
listToThread ((Post (i, d) t):xs) = (T (Post (i, d) t) (listToThread xs))

-- Posts & Threads (e)
listToTuple :: [Post] -> ([Char], Int)
listToTuple [] = ("", 0)
listToTuple [(Post (i, d) t)] = (i, d)

tuplaEhIgual :: [Post] -> (Id, DataHoraPub) -> ([Char], Int) -> [Post]
tuplaEhIgual [x] (ri, dhp) (i, d)
    |(ri, dhp) /= (i, d) = [x]
    |otherwise = []

compara :: (Id, DataHoraPub) -> [Post] -> [Post]
compara (ri, dhp) []     = []
compara (ri, dhp) [x]    = tuplaEhIgual [x] (ri, dhp) (listToTuple [x])
compara (ri, dhp) (x:xs) = tuplaEhIgual [x] (ri, dhp) (listToTuple [x]) ++ compara (ri, dhp) xs

removerPost' :: (Id, DataHoraPub) -> Thread -> Thread
removerPost' (ri, dhp) (T (Post (i, d) t) xs) = listToThread (compara (ri, dhp) (threadToList (T (Post (i, d) t) xs)))

removerPost :: (Id, DataHoraPub) -> Thread -> Thread
removerPost (ri, dhp) (thr) = listToThread (filter (\(Post (i, d) t) -> if ((ri /= i) || (dhp /= d)) then True else False) (threadToList (thr)))