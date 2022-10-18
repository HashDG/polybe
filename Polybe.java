import java.util.Scanner;

public class Polybe {
	
	final int LARGEUR = 5;
	final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVXYZ";

	String initialiserCarreAvecCle(String cle) {
		int idx = 0, jdx = 0, kdx;
		String carre = "";
		char charc;
		boolean presence = false;
		
		while (carre.length() < LARGEUR * LARGEUR) {
			if (cle.length() > idx) {
				charc = cle.charAt(idx);
				idx += 1;
			} else {
				charc = ALPHABET.charAt(jdx);
				jdx += 1;
			}
			if (charc == 'W') charc = 'V';
			kdx = 0;
			while (kdx < carre.length() && !presence) {
				if (carre.charAt(kdx) == charc) {
					presence = true;
				} else {
					kdx += 1;
				}
			}
			if (!presence) {
				carre += charc;
			} else {
				presence = false;
			}
		}
		return carre;
	}
	
	void afficherCarre(String carre) {
		for (int i = 0; i < LARGEUR; i += 1) {
			for (int j = 0; j < LARGEUR; j += 1) {
				System.out.print(carre.charAt(i * LARGEUR + j) + " ");
			}
			System.out.println();
		}
	}
	
	String coderMessage(String carre, String message) {
		String resultat = "";
		char charc;
		int idx;
	
		for (int i = 0; i < message.length(); i += 1) {
			charc = message.charAt(i);
			if (charc == 'W') charc = 'V';
			
			idx = 0;
			while (idx < carre.length() && carre.charAt(idx) != charc ) {
				idx += 1;
			}
			resultat += "" + idx/LARGEUR + idx%LARGEUR;
		}
		return resultat;
	}
	
	String decoderMessage(String carre, String message) {
		String resultat = "";

		for (int i = 0; i < message.length(); i += 2) {
			int x = Character.getNumericValue(message.charAt(i));
			int y = Character.getNumericValue(message.charAt(i + 1));
			resultat += carre.charAt(y + x * LARGEUR);
		}
        return resultat;
	}
	
	public static void main(String... args) {
		Polybe polybe = new Polybe();
		Scanner scanner = new Scanner(System.in);
		String entree;
		
		System.out.print("Entrez la clé: ");
		entree = scanner.nextLine();
		String carre = polybe.initialiserCarreAvecCle(entree);
		polybe.afficherCarre(carre);
		
		System.out.print("Entrez la chaîne de caractère à chiffrer: ");
		entree = scanner.nextLine();
		System.out.println(polybe.coderMessage(carre, entree));
		
		System.out.print("Entrez la chaîne de caractère à déchiffrer: ");
		entree = scanner.nextLine();
		System.out.println(polybe.decoderMessage(carre, entree));
	}
}
