package fciencias.bases.practica01;

import java.util.Scanner;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.Writer;
import java.io.Reader;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Clase que nos permite leer texto de un archivo de texto plano
 * con el fin de obtener información de interes.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public class Buff{
    
    /**
     * Método que nos permite regresar una lista de casillas
     * @return una lista de casillas.
     */
    public Lista<Casilla> lee(){
	Lista<Casilla> l=new Lista<>();
	try{
	    BufferedReader lect=new BufferedReader(new FileReader("casillas.csv"));
	    String casInfo;
	    while((casInfo=lect.readLine())!=null){
		Casilla nueva=new Casilla(casInfo);
		l.agrega(nueva,0);
	    }
	}catch(FileNotFoundException e){
	    System.out.println("\nERROR: El archivo Casillas.csv no fue encontrado");
	    return null;
	}catch(IOException e){
	    System.out.println("\nERROR: Algo salió mal al intentar leer archivo.");
	    return null;
	}
	return l;
    }

    /**
     * Método que se encarga de leer el archivo que contiene información de los representantes.
     * @return lista con los representantes leídos del archivo.
     */
    public Lista<Representante> leeR(){
	Lista<Representante> l=new Lista<>();
	try{
	    BufferedReader lect=new BufferedReader(new FileReader("representantes_preliminares.csv"));
	    String repInfo;
	    while((repInfo=lect.readLine())!=null){
	        int a=repInfo.indexOf(",");
		int b=repInfo.indexOf(",",a+1);
		a=repInfo.indexOf(",",b+1);
		b=repInfo.indexOf(",",a+1);
		a=repInfo.indexOf(",",b+1);
		Representante nuevo=new Representante(repInfo.substring(0,a),repInfo.substring(a+1,repInfo.length()));
		l.agrega(nuevo,0);
	    }
	}catch(FileNotFoundException e){
	    System.out.println("\nERROR: El archivo representantes_preliminares.csv no fue encontrado");
	    return null;
	}catch(IOException e){
	    System.out.println("\nERROR: Algo salió mal al intentar leer archivo.");
	    return null;
	}
	return l;
    }

     /**
     * Método que guarda la información de representantes en un archivo de texto.
     * @param la lista de representantes.
     */
    public void guardaR(Lista<Representante> l){
	try{
	    Writer escritor=new FileWriter("representantes_preliminares.csv");
	    BufferedWriter escritorB=new BufferedWriter(escritor);
	    for(int i=0;i<l.getLongitud();i++){
		escritor.write(l.getElemento(i).codifica()+"\n");
	    }
	    escritorB.close();
	}catch(IOException e){
	    System.out.println("\nError al guardar el archivo.");	    
	}
    }

    /**
     * Método que permite preservar el ID de los representantes.
     */
    public void guardaID(){
	try{
	    Writer escritor=new FileWriter("ID.txt");
	    BufferedWriter escritorB=new BufferedWriter(escritor);
	    Representante r=new Representante();
	    escritor.write(r.ID+"\n");
	    escritorB.close();
	}catch(IOException e){
	    System.out.println("\nError al guardar el archivo.");	    
	}
    }

    /**
     * Método que permite la conservación del ID en representantes.
     */
    public void leeID(){
	try{
	    BufferedReader lect=new BufferedReader(new FileReader("ID.txt"));
	    String r=lect.readLine();
	    Integer i=0;
	    int idA=Integer.valueOf(r);
	    Representante rep=new Representante();
	    rep.ID=idA;
	}catch(FileNotFoundException e){
	    System.out.println("\nERROR: El archivo ID.txt no fue encontrado");
	    return;
	}catch(IOException e){
	    System.out.println("\nERROR: Algo salió mal al intentar leer archivo.");
	    return;
	}
    }
    
    public static void main(String args[]){
	Buff lect=new Buff();
	Lista<Casilla> l=lect.lee();
	for(int i=0;i<l.getLongitud();i++){
	    System.out.println(l.getElemento(i));
	}
    }
    
}
