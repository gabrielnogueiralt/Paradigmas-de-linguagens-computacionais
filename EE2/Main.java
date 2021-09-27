import java.util.Iterator;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicIntegerArray;

class Main {
    public static void main (String[] args) {
        Scanner in = new Scanner(System.in);
        int qteJogadores = in.nextInt();
        DancaDasCadeiras dancaCadeiras = new DancaDasCadeiras();
        for (int i = 1; i <= qteJogadores; i++) {
            dancaCadeiras.jogadores.add(i);
        }
        while (dancaCadeiras.jogadores.size() > 1) { // Enquanto tiver mais de uma cadeira

            int n = dancaCadeiras.jogadores.size(); // Pega o tamanho do HashSet
            int indice = 0; //  Utilizado para identificar o número de threads

            dancaCadeiras.cadeiras = new AtomicIntegerArray(n-1); // Cria um array de tipos atômicos

            for (int i = 0; i < n-1; i++) { // Inicializa o array com valores negativos iniciais
                dancaCadeiras.cadeiras.set(i, -5);
            }
            
            Thread[] thread = new Thread[n]; // Instância da Thread
            Iterator<Integer> iterador = dancaCadeiras.jogadores.iterator(); // Utilizado para percorrer o HashSet de jogadores

            while (iterador.hasNext()) { // Equanto tiver itens para iterar
                thread[indice] = new Thread(dancaCadeiras.new Thread(iterador.next())); // Adiciona um jogador na Thread
                thread[indice].start(); // Inicializa a Thread
                indice++;
            }
            
            for (int i = 0; i < n; i++) {
                try {
                    thread[i].join(); // Permanece em um estado de espera até que o encadeamento referenciado termine
                } catch (InterruptedException e) {
                    System.out.println(e);
                }
            }
        }
        
        Iterator<Integer> iterador = dancaCadeiras.jogadores.iterator(); //Utilizado para percorrer o HashSet de jogadores
        while (iterador.hasNext()) { 
            System.out.println("O Jogador " + iterador.next() +" foi o vencedor!"); // Imprime o jogador restante, o vencedor
        }
    }
}

