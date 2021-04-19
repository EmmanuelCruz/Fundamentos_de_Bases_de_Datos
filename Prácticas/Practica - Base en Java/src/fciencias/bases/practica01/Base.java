package fciencias.bases.practica01;
import java.util.Scanner;

/**
 * Clase que permite la interacción con el usuario.
 * Aquí es donde se simula el menú.
 * @author Cruz Hernández Emmanuel, Montes Incin Sara Doris, Martínez Hernández Luis Eduardo.
 * @version Agosto 2018.
 */
public class Base{

    /** Lista de las casillas válidaz. */
    private Lista<Casilla> lstCas;
    
    /** Lista de los representantes. */
    private Lista<Representante> lstRep;
    
    /** Crea un nueva nueva Base */
    public Base(){
	Buff lec=new Buff();
	lstCas=lec.lee();
	lstRep=lec.leeR();
	lec.leeID();
    }
    
    /**
     * Captura un nuevo representante.
     */
    public void captura(){
	Scanner sc=new Scanner(System.in);
	System.out.print("\nIngresa el nombre del representante preliminar (solo el nombre): ");
	String nombre=sc.nextLine();
	if(nombre.length()==0){
	    System.out.println("\nERROR: No ingresaste texto. Fallo de captura.");
	    return;
	}
	System.out.print("\nIngresa el apellido paterno del representante preliminar: ");
	String paterno=sc.nextLine();
	if(nombre.length()==0){
	    System.out.println("\nERROR: No ingresaste texto. Fallo de captura.");
	    return;
	}
	System.out.print("\nIngresa el apellido materno del representante preliminar: ");
	String materno=sc.nextLine();
	if(nombre.length()==0){
	    System.out.println("\nERROR: No ingresaste texto. Fallo de captura");
	    return;
	}
	System.out.print("\nIngresa la calidad del representante preliminar: ");
	String calidad=sc.nextLine();
	if(nombre.length()==0){
	    System.out.println("\nERROR: No ingresaste texto. Fallo de captura");
	    return;
	}
	System.out.print("\nIngresa el id del estado de casilla a capturar el representante preliminar: ");
	int edo;
        try{
	    int cual=sc.nextInt();
	    edo=cual;
	}catch(Exception e){
	    System.out.println("\nEntrada inválida.");
	    return;
	}
	System.out.print("\nIngresa el id del distrito de casilla a capturar el representante preliminar: ");
	int dst;
        try{
	    int cual2=sc.nextInt();
	    dst=cual2;
	}catch(Exception e){
	    System.out.println("\nEntrada inválida.");
	    return;
	}
	System.out.print("\nIngresa la sección de casilla a capturar el representante preliminar: ");
	int sec;
        try{
	    int cual3=sc.nextInt();
	    sec=cual3;
	}catch(Exception e){
	    System.out.println("\nEntrada inválida.");
	    return;
	}
	System.out.print("\nIngresa el tipo de casilla a capturar el representante preliminar: ");
	sc.nextLine();
	String tipo=sc.nextLine();
	if(nombre.length()==0){
	    System.out.println("\nERROR: No ingresaste texto. Fallo de captura");
	    return;
	}
	Representante ID=new Representante();
	Casilla propia=new Casilla(edo+","+dst+","+sec+","+tipo+",true");
	for(int i=0;i<lstCas.getLongitud();i++){
	    if(propia.esIgual(lstCas.getElemento(i))){
		if(propia.aprobada && lstCas.getElemento(i).aprobada){
		    Representante t=new Representante(ID.ID+","+nombre+","+paterno+","+materno+","+calidad,
						      edo+","+dst+","+sec+","+tipo+",true");
		    t.ID++;
		    lstRep.agrega(t,0);
		    System.out.println("\nSe ha agregado representante preliminar a la base");
		    Buff f=new Buff();
		    f.guardaR(lstRep);
		    return;
		}else{
		    System.out.println("\nImposible capturar, la casilla no está aprobada");
		    return;
		}
	    }
	}
	System.out.println("\nLa casilla no existe");
    }
    
    /**
     * Modifica un representante que exista y si es posible hacerlo.
     */
    public void modifica(){
	System.out.print("\nIngresa el id del representante preliminar a modificar: ");
	Scanner sc=new Scanner(System.in);
	int id;
        try{
	    int ida=sc.nextInt();
	    id=ida;
	}catch(Exception e){
	    System.out.println("\nId inválido.");
	    return;
	}
	for(int i=0; i<lstRep.getLongitud();i++){
	    if(lstRep.getElemento(i).getId()==id){
		System.out.print("\n[0] Modificar calidad."+
				 "\n[1] Modificar casilla asignada."+
				 "\nElige una opción: ");
		try{
		    int op=sc.nextInt();
		    id=op;
		}catch(Exception e){
		    System.out.println("\nOpción inválida. Fallo al modifcar.");
		    return;
		}
		switch(id){
		case 0:
		    System.out.print("\nIngresa la nueva calidad del representante preliminar: ");
		    sc.nextLine();
		    String calidad=sc.nextLine();
		    if(calidad.length()==0){
			System.out.println("\nERROR: No ingresaste texto. Fallo al modificar");
			return;
		    }
		    lstRep.getElemento(i).setCalidad(calidad);
		    System.out.print("\nSe ha modificado la calidad del representante "+lstRep.getElemento(i).getId()+".\n");
		    return;
		case 1:
		    System.out.print("\nIngresa el id del estado de casilla a modificar del representante preliminar: ");
		    int edo;
		    try{
			int cual=sc.nextInt();
			edo=cual;
		    }catch(Exception e){
			System.out.println("\nEntrada inválida.");
			return;
		    }
		    System.out.print("\nIngresa el id del distrito de casilla a modificar del representante preliminar: ");
		    int dst;
		    try{
			int cual2=sc.nextInt();
			dst=cual2;
		    }catch(Exception e){
			System.out.println("\nEntrada inválida.");
			return;
		    }
		    System.out.print("\nIngresa la sección de casilla a modificar del representante preliminar: ");
		    int sec;
		    try{
			int cual3=sc.nextInt();
			sec=cual3;
		    }catch(Exception e){
			System.out.println("\nEntrada inválida.");
			return;
		    }
		    System.out.print("\nIngresa el tipo de casilla a modificar del representante preliminar: ");
		    sc.nextLine();
		    String tipo=sc.nextLine();
		    if(tipo.length()==0){
			System.out.println("\nERROR: No ingresaste texto. Fallo al modificar.");
			return;
		    }
		    System.out.print("\n¿La casilla es aprobada? [S/N]: ");
		    String aprob=sc.nextLine();
		    if(aprob.length()==0){
			System.out.println("\nERROR: No ingresaste texto. Fallo al modificar.");
			return;
		    }
		    boolean ap;
		    switch(aprob.toUpperCase().charAt(0)){
		    case 'S':
			ap=true;
			break;
		    case 'N':
			ap=false;
			break;
		    default:
			System.out.println("\nOpción inválida. Fallo al modificar");
			return;
		    }
		    Casilla c=new Casilla(edo+","+dst+","+sec+","+tipo+","+ap);
		    for(int j=0;j<(lstCas.getLongitud()-1);j++){
			if(c.esIgual(lstCas.getElemento(j))){
			    if(c.aprobada==lstCas.getElemento(j).aprobada){
				lstRep.getElemento(i).setCasilla(c);
				System.out.println("\nSe ha modificado la casilla del representante preliminar");
				Buff f=new Buff();
				f.guardaR(lstRep);
				return;
			    }
			}
		    }
		    System.out.println("\nLa casilla no existe. Imposible modificar.");
		    return;
		default:
		    System.out.println("\nOpción inválida. Fallo al modificar");
		    return;
		}
	    }
	}
	System.out.println("\nId no encontrado.");
    }
    
    /**
     * Permite al usuario eliminar a un representante de la base a través de su Id
     */
    public void elimina(){
	System.out.print("\nIngresa el id del representante preliminar a eliminar: ");
	Scanner sc=new Scanner(System.in);
	int id;
        try{
	    int ida=sc.nextInt();
	    id=ida;
	}catch(Exception e){
	    System.out.println("\nId inválido.");
	    return;
	}
	for(int i=0; i<lstRep.getLongitud();i++){
	    if(lstRep.getElemento(i).getId()==id){
		lstRep.elimina(i);
		System.out.println("\nSe ha eliminado el representante con Id "+id+" de la base.");
		Buff f=new Buff();
		f.guardaR(lstRep);
		return;
	    }
	}
	System.out.println("\nId no encontrado.");
    }
    
    /**
     * Regresa la información de un representante de la base, si existe.
     */
    public void buscaDDe(){
	System.out.print("\nIngresa el id del representante preliminar a buscar información: ");
	Scanner sc=new Scanner(System.in);
	int id;
        try{
	    int ida=sc.nextInt();
	    id=ida;
	}catch(Exception e){
	    System.out.println("\nId inválido.");
	    return;
	}
	for(int i=0; i<lstRep.getLongitud();i++){
	    if(lstRep.getElemento(i).getId()==id){
		System.out.println(lstRep.getElemento(i));
	        return;
	    }
	}
	System.out.println("\nId no encontrado.");
    }

    /**
     * Regresa la información de casilla de un representante de la base, si existe.
     */
    public void buscaCDe(){
	System.out.print("\nIngresa el id del representante preliminar a buscar información de su casilla: ");
	Scanner sc=new Scanner(System.in);
	int id;
        try{
	    int ida=sc.nextInt();
	    id=ida;
	}catch(Exception e){
	    System.out.println("\nId inválido.");
	    return;
	}
	for(int i=0; i<lstRep.getLongitud();i++){
	    if(lstRep.getElemento(i).getId()==id){
		System.out.println(lstRep.getElemento(i).getCasilla());
	        return;
	    }
	}
	System.out.println("\nId no encontrado.");
    }

    /**
     * Método que permite la simulación del menú.
     */
    public void menu(){
	Scanner sc=new Scanner(System.in);
	boolean salir=true;
	do{
	    System.out.print("\nOPCIONES DE LA BASE"+
			     "\n[1] Capturar representante"+
			     "\n[2] Buscar representante"+
			     "\n[3] Eliminar representante"+
			     "\n[4] Modificar representante"+
			     "\n[5] Buscar casilla del representante"+
			     "\n[6] Mostrar representantes"+
			     "\n[7] Mostrar casillas válidas"+
			     "\n[8] Salir"+
			     "\nElige una opción: ");
	    int op;
	    try{
		int op1=sc.nextInt();
		op=op1;
	    }catch(Exception e){
		System.out.println("\nOpción inválida\n");
	        menu();
		return;
	    }
	    switch(op){
	    case 1:
		captura();
		break;
	    case 2:
		buscaDDe();
		break;
	    case 3:
		elimina();
		break;
	    case 4:
		modifica();
		break;
	    case 5:
		buscaCDe();
		break;
	    case 6:
		for(int i=0;i<lstRep.getLongitud();i++)
		    System.out.println(lstRep.getElemento(i));
		break;
	    case 7:
		for(int i=0;i<lstCas.getLongitud();i++)
		    System.out.println(lstCas.getElemento(i));
		break;
	    case 8:
		Buff f=new Buff();
		f.guardaID();
		System.out.println("\nSALIENDO DE BASE DE DATOS..............\n");
		salir=false;
	    }
	}while(salir);
    }
    
    
    public static void main(String args[]){
	System.out.println("\nBIENVENIDO A LA BASE DE DATOS DE REPRESENTANTES\n");
	Base b=new Base();
	b.menu();
	//b.captura();
	//Buff c=new Buff();
	//c.guardaR(b.lstRep);
	//b.buscaCDe();
	//b.buscaDDe();
	//b.elimina();
	//b.modifica();
	
    }
}
