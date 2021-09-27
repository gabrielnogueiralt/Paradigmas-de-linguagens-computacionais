-- Importando módulos necessários
-- Um MVar t é um local mutável que está vazio ou contém um valor do tipo t.
-- Tem duas operações fundamentais: putMVar que preenche um MVar se estiver vazio
-- e bloqueia caso contrário, e takeMVar que esvazia um MVar se estiver cheio e bloqueia caso contrário.
-- Eles podem ser usados de várias maneiras diferentes.

import Control.Concurrent
    (MVar, takeMVar, readMVar, putMVar, newMVar, forkIO, threadDelay)
import Control.Monad


-- Recebe a quantidade de ml das três reservas (2000,2000,200), o índice do cliente e o refrigerante escolhido
abastecer :: MVar (Integer, Integer, Integer) -> Integer -> String -> IO ()
abastecer reserva indiceCliente refri  = do
        (refri1, refri2, refri3) <- takeMVar reserva
        if refri == "P-Cola" then
                if refri1 > 1000 then
                        do
                        putStrLn ("O cliente " ++ show indiceCliente ++ " do refrigerante " ++ refri ++ " está enchendo seu copo")
                        threadDelay 1000000 -- Tempo de espera
                        putMVar reserva (refri1 - 300, refri2 , refri3)
                else
                        do
                        threadDelay 1500000 -- Tempo de reabastecimento
                        putStrLn ("O refrigerante " ++ refri ++ " foi reabastecido com 1000 ml, e agora possui " ++ show(refri1 + 1000) ++ " ml")
                        putMVar reserva (refri1 + 1000, refri2, refri3)
                        abastecer reserva indiceCliente refri

        else if refri == "Guaraná Polo Norte" then
                if refri2 > 1000 then
                        do
                        putStrLn ("O cliente " ++ show indiceCliente ++ " do refrigerante " ++ refri ++ " está enchendo seu copo")
                        threadDelay 1000000 -- Tempo de espera
                        putMVar reserva (refri1 , refri2-300, refri3)
                else
                        do
                        threadDelay 1500000 -- Tempo de reabastecimento
                        putStrLn ("O refrigerante " ++ refri ++ " foi reabastecido com 1000 ml, e agora possui " ++ show(refri2+1000) ++ " ml")
                        putMVar reserva (refri1 , refri2+1000, refri3)
                        abastecer reserva indiceCliente refri

        else
                if refri3 > 1000 then
                        do
                        putStrLn ("O cliente " ++ show indiceCliente ++ " do refrigerante " ++ refri ++ " está enchendo seu copo")
                        threadDelay 1000000 -- Tempo de espera
                        putMVar reserva (refri1 , refri2 ,refri3-300)
                else
                        do
                        threadDelay 1500000 -- Tempo de reabastecimento
                        putStrLn ("O refrigerante " ++ refri ++ " foi reabastecido com 1000 ml, e agora possui " ++ show(refri3+1000) ++ " ml")
                        putMVar reserva (refri1 , refri2 ,refri3+1000)
                        abastecer reserva indiceCliente refri

        abastecer reserva (indiceCliente+1) refri -- passa para o próximo cliente

-- Itera infinitamente
iterar:: MVar Int -> IO()
iterar inf = do
        f <- readMVar inf
        Control.Monad.when (f > 0) $ iterar inf


reiDoHamburguer :: IO ()
reiDoHamburguer = do
        inf <- newMVar 1
        reserva <- newMVar (2000,2000,2000)
        forkIO(abastecer reserva 1 "P-Cola")
        forkIO(abastecer reserva 1 "Guaraná Polo Norte")
        forkIO(abastecer reserva 1 "Guaraná Quate")
        iterar inf

