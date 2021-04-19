package fciencias.bases.practica01;

/**
 * Interfaz que define los métodos de un objeto de tipo
 * TDALista.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public interface TDALista<T>{

    /**
     * Regresa la cantidad de elementos que hay en la lista.
     * @return la cantidad de elementos.
     */
    public int getLongitud();

    /**
     * Agrega un nuevo elemento a la lista.
     * @param elemento el elemento a agregar.
     * @param n la posición de la lista donde agregar.
     * @throws IndexOutOfBoundsException si n está fuera del rango.
     */
    public void agrega(T elemento, int n)
	throws IndexOutOfBoundsException;

    /**
     * Elimina un elemento de la lista.
     * @param n el índice del elemento a eliminar.
     * @throws IndexOutOfBoundsException si n está fuera del rango.
     */
    public void elimina(int n)
	throws IndexOutOfBoundsException;

    /**
     * Limpia la lista.
     */
    public void limpia();

    /**
     * Obtiene el elemento en el índice n de la lista.
     * @param n el índice a donde buscar.
     * @return el elemento en la posición n.
     * @throws IndexOutOfBoundsException si n está fuera del rango.
     */
    public T getElemento(int n)
	throws IndexOutOfBoundsException;
    
}
