import java.util.HashSet;
import java.util.concurrent.atomic.AtomicIntegerArray;

public class DancaDasCadeiras {
    AtomicIntegerArray cadeiras; // Cada item é um tipo atômico
    HashSet<Integer> jogadores = new HashSet<Integer>(); // Coleção de itens onde cada item é único

    class Thread implements Runnable {
        private int indice;

        public Thread(int numJogador) {
            this.indice = numJogador;
        }

        public synchronized boolean cadeiraLivre() { // Verifica se tem cadeira livre, identificada como -5
            for (int i = 0; i < cadeiras.length(); i++) {
                if (cadeiras.get(i) == -5) {
                    return true;
                }
            }
            return false;
        }

        public synchronized int posicionaJogador(int indice) { // Determina aleatoriamente onde o jogador vai sentar
            int lugar = (int) ((cadeiras.length()) * Math.random());
            if (cadeiras.get(lugar) == -5) { // Caso a cadeira esteja livre
                cadeiras.set(lugar, indice); // Determina o jogador sentado
                return lugar;
            }
            return -5;
        }

        @Override
        public void run() {
            int temCadeira = 0;
            while (cadeiraLivre()) { // Enquanto tiver cadeira livre
                int posiciona = posicionaJogador(this.indice); // Tenta posicionar jogador
                if (posiciona != -5) { // Caso jogador consiga sentar
                    temCadeira = 1;
                    break;
                }
            }
            if (temCadeira == 0) { // Se o jogador não conseguir sentar
                System.out.println("O Jogador " + this.indice + " foi eliminado");
                jogadores.remove(this.indice); // Tira o jogador do jogo
            }
        }

    }
}