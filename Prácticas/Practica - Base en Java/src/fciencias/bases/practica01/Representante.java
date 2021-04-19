package fciencias.bases.practica01;

/**
 * Clase representante que contiene los atributos necesarios
 * de un representante preliminar de casilla.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public class Representante{

    public static int ID=0;
    
    /** Identificador del representante */
    private int id;

    /** Nombre del representante. */
    private String nombre;

    /** Apellido paterno del representante. */
    private String paterno;

    /** Apellido materno del representante. */
    private String materno;

    /** Calidad del representante. */
    private String calidad;

    /** Casilla asignada al representante. */
    private Casilla casilla;

    /**
     * Construye un nuevo objeto de tipo Representante.
     * @param codificado, la información del representante.
     * @param codifCasilla la información de la casilla.
     */
    public Representante(String codificado, String codifCasilla){
	int desde=codificado.indexOf(",");
	String aux=codificado.substring(0,desde);
	Integer d=0;
	id=d.valueOf(aux);
	int hasta=codificado.indexOf(",",desde+1);
	nombre=codificado.substring(desde+1,hasta);
	desde=codificado.indexOf(",",hasta+1);
	paterno=codificado.substring(hasta+1,desde);
	hasta=codificado.indexOf(",",desde+1);
	materno=codificado.substring(desde+1,hasta);
	desde=codificado.indexOf(",",hasta+1);
	calidad=codificado.substring(hasta+1,codificado.length());
	casilla=new Casilla(codifCasilla);
    }

    /**
     * Constructor sin parametros.
     */
    public Representante(){}
    
    /**
     * Devuelve el id del representante.
     * @return el id del representante.
     */
    public int getId(){
	return id;
    }

    /**
     * Devuelve el nombre del representante.
     * @return el nombre del representante.
     */
    public String getNombre(){
	return nombre;
    }

    /**
     * Devuelve el primer apellido del representante.
     * @return el primer apellido del representante.
     */
    public String getPaterno(){
	return paterno;
    }

    /**
     * Devuelve el segundo apellido del representante.
     * @return el segundo apellido del representante.
     */
    public String getMaterno(){
	return materno;
    }

    /**
     * Devuelve la calidad del representante.
     * @return la calidad del representante.
     */
    public String getCalidad(){
	return calidad;
    }
    
    /**
     * Asigna nueva calidad al representante.
     * @param nCalidad la nueva calidad.
     */
    public void setCalidad(String nCalidad){
	calidad=nCalidad;
    }
    
    /**
     * Devuelve la información de la casilla del representante.
     * @return la información de la casilla del representante.
     */
    public String getCasilla(){
	return casilla.toString();
    }

    /**
     * Asgina una nueva casilla al representante.
     * @param nCasilla la nueva casilla a asignar.
     */
    public void setCasilla(Casilla nCasilla){
	casilla=nCasilla;
    }
    
    @Override
    public String toString(){
	return
	    "\nID: "+id+"."+
	    "\nNombre completo: "+nombre+" "+paterno+" "+materno+"."+
	    "\nCalidad: "+calidad+"."+
	    "\nInformación de casilla:"+casilla.toString();
    }

    /**
     * Codifica la información de un representante.
     * Regresa una cadena con la infromación codificada.
     */
    public String codifica(){
	return id+","+nombre+","+paterno+","+materno+","+calidad+","+casilla.codifica();
    }

    public static void main(String args[]){
	Representante r=new Representante("23,Carlos,Perez,Noriega,Terrible","1,3,2345,A,true");
	System.out.println(r);
    }
}
