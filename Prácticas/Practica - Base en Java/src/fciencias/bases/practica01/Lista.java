package fciencias.bases.practica01;

/**
 * Implementación del TDALista. Implementación con una lista simplemente ligada
 * y genérica.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public class Lista<T> implements TDALista<T>{
    
    /**
     * Clase auxiliar Nodo que sirve como unidad de almacenamiento.
     */
    private class Nodo{

	/** Nodo siguiente. */
	public Nodo siguiente;
	
	/** Elemento que se guarda en el Nodo. */
	public T t;
	
	/**
	 * Construcción de un nuevo nodo.
	 * @param t el elemento que tiene el Nodo.
	 */
	public Nodo(T t){
	    this.t=t;
	}

	/**
	 * Regresa el nodo siguiente.
	 * @return el nodo siguiente.	 
	 */
	public Nodo getNext(){
	    return siguiente;
	}

	/**
	 * Regresa el elemento del nodo.
	 * @return el elemento del nodo.
	 */
	public T getElemento(){
	    return t;
	}

	/**
	 * Asigna otro nodo a el nodo siguiente.
	 * @param siguiente el nuevo nodo a asignar.
	 */
	public void setNext(Nodo siguiente){
	    this.siguiente=siguiente;
	}

	/**
	 * Asigna otro elemento a el elemento del nodo.
	 * @param t el nuevo elemento a asignar.
	 */
	public void setElemento(T t){
	    this.t=t;
	}
    }

    /** Cabeza de la lista. */
    private Nodo cabeza;
    
    /** Tamaño de la lista. */
    private int tam;
    
    @Override
    public int getLongitud(){
	return tam;
    }
    
    /**
     * Permite acceder al Nodo que está en un índice válio de la lista.
     */
    private Nodo encuentra(int n){
	Nodo actual=cabeza;
	int pos=0;
	while(pos<n){
	    pos++;
	    actual=actual.getNext();
	}
	return actual;
    }
    
    @Override
    public void agrega(T elemento, int n)
	throws IndexOutOfBoundsException{
	if(n<0||n>tam)
	    throw new IndexOutOfBoundsException("Índice inválido");
	Nodo nuevo=new Nodo(elemento);
	if(tam==0){
	    nuevo.setNext(cabeza);
	    cabeza=nuevo;
	} else{
	    Nodo actual=encuentra(n-1);
	    nuevo.setNext(actual.getNext());
	    actual.setNext(nuevo);
	}
	tam++;
    }

    @Override
    public void elimina(int n)
	throws IndexOutOfBoundsException{
	if(n<0||n>=tam)
	    throw new IndexOutOfBoundsException("Índice inválido");
	if(n==0){
	    cabeza=cabeza.getNext();
	    tam--;
	    return;
	}
	Nodo actual=encuentra(n-1);
	actual.setNext(actual.getNext().getNext());
	tam--;
    }

    @Override
    public void limpia(){
	cabeza=null;
	tam=0;
    }

    @Override
    public T getElemento(int n)
	throws IndexOutOfBoundsException{
        if(n<0||n>tam)
	    throw new IndexOutOfBoundsException("Índice inválido");
	Nodo actual=encuentra(n);
	return actual.getElemento();
    }
}
