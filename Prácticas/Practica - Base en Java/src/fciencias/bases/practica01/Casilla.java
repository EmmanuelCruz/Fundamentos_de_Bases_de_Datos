package fciencias.bases.practica01;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.Writer;
import java.io.IOException;

/**
 * Clase que permite crear objetos de tipo casilla, con sus atributos pertinentes.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public class Casilla{

    /** id-estado. */
    public int id_edo;

    /** id-distrito. */
    public int id_dst;

    /** Sección. */
    public int seccion;

    /** Tipo. */
    public String tipo;

    /** Booleano que no dice si una casilla es aprobada. */
    public boolean aprobada;

    /**
     * Contruye un nuevo objeto de tipo casilla.
     * @param codificado una cadena con la información codificada.
     */
    public Casilla(String codificado){
	int desde=codificado.indexOf(",");
	String aux=codificado.substring(0,desde);
	Integer d=0;
	id_edo=d.valueOf(aux);
	int desde2=codificado.indexOf(",",desde+1);
	aux=codificado.substring(desde+1,desde2);
	id_dst=d.valueOf(aux);
	desde=codificado.indexOf(",",desde2+1);
	aux=codificado.substring(desde2+1,desde);
	seccion=d.valueOf(aux);
	desde2=codificado.indexOf(",",desde+1);
	tipo=codificado.substring(desde+1,desde2);
	Boolean b=false;
	aux=codificado.substring(desde2+1,codificado.length());
	aprobada=b.valueOf(aux);
    }

    /**
     * Verifica si dos casillas están aprobadas sin importar si están aprobadas.
     * @param una casilla a verificar si es igual.
     * @return true si es igual, false en otro caso.
     */
    public boolean esIgual(Casilla c2){
	return
	    ((id_edo==c2.id_edo && id_dst==c2.id_dst && seccion==c2.seccion && tipo.equals(c2.tipo))?true:false);
    }
    
    @Override
    public String toString(){
	return
	    "\n\tId-Estado: "+id_edo+
	    "\n\tId-Distrito: "+id_dst+
	    "\n\tSección: "+seccion+
	    "\n\tTipo: "+tipo+
	    "\n\tAprobada: "+(aprobada?"Sí":"No");
    }

    /**
     * Codifica la información de una casilla.
     * @return una cadena con la información codificada.
     */
    public String codifica(){
	return id_edo+","+id_dst+","+seccion+","+tipo+","+aprobada;
    }
    
    public static void main(String args[]){
	Casilla c=new Casilla("45,32,65,Seccion,true");
	System.out.println(c);
    }
}
