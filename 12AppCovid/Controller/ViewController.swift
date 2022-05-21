//
//  ViewController.swift
//  12AppCovid
//
//  Created by djdenielb on 29/04/22.
//

import UIKit

class ViewController: UIViewController{
//    Intancia del manager
    var covidManager = CovidManager()
//    variabel para llenar la tabla del tipo array covid data
    var tablaPaises: [CovidData] = []
//    Variable objeto para enviar el objeto lleno a la segunda pantalla
    var paisAMandar: CovidData?
    
//    Array para la barra de busqueda
    var tablaPaisesBusqueda: [CovidData]!

//    Variable grafica de la tabla
    @IBOutlet weak var tablaPrototipo: UITableView!
//    Variable grafica de la barra de busqueda
    @IBOutlet weak var sbBuscarPais: UISearchBar!
    
//    Funcion de inicio
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Al iniciar la tabla paises busqueda tendra todo lo que trae tabla paises
        tablaPaisesBusqueda = tablaPaises
        
//        MARK: Registrar la celda presonalizada en la tabla
        tablaPrototipo.register(UINib(nibName: "CeldaPersonalizada", bundle: nil), forCellReuseIdentifier: "celdaReutilizada")
        
//        delegado y datasource de la tabla
        tablaPrototipo.dataSource = self
        tablaPrototipo.delegate = self
//        delegado del manager
        covidManager.delegate = self
//        funcion para parsear y la API
        covidManager.funcionUrlSessions()
        
//        Delegado de la search bar
        sbBuscarPais.delegate = self
    }//VDidLoad

    
    
}//VC

//MARK: Extension del VC para la tabla

extension ViewController: UITableViewDataSource, UITableViewDelegate{
//    Numero de secciones con el array de busqueda
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablaPaisesBusqueda.count
    }//Numero de secciones
    
//    Llenado de la celda personalizada
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        variable celda que indica que sera del tipo celda personalizada
        let celda = tablaPrototipo.dequeueReusableCell(withIdentifier: "celdaReutilizada", for: indexPath) as! CeldaPersonalizada
        
//        MARK: Creacion de la imagen para mostrar
//        Variable string donde esta la imagen
        if let banderaString = tablaPaisesBusqueda[indexPath.row].countryInfo.flag{
//            variable url que recibe el string de arriba
            if let banderaUrl = URL(string: banderaString){
//                Dispatch para que carguen mejor las imagenes
                DispatchQueue.main.async {
//                  variable data que contiene la url
                    guard let banderaData = try? Data(contentsOf: banderaUrl) else {return}
//                    variable ya con la imagen decodificada desde el data
                    let bandera = UIImage(data: banderaData)
//                    Dispatch para agregar la imagen al elemento grafico
                    DispatchQueue.main.async {
                        celda.ivBandera.image = bandera
                    }//Dispatch 2
                }//Dispatch
            }//banderaURL
        }//baderaString
        
//        Llenado de los demas campos usando string interpolation
        celda.labelPais.text = tablaPaisesBusqueda[indexPath.row].country
        celda.casosDarios.text = "Casos hoy: \(tablaPaisesBusqueda[indexPath.row].todayCases ?? 0)"
        
//        Poner en rojo las muertes
        if tablaPaises[indexPath.row].todayDeaths != 0{
            celda.labelMuertesEnRojo.text = String(tablaPaisesBusqueda[indexPath.row].todayDeaths ?? 0)
            celda.labelMuertesEnRojo.textColor = UIColor.red
        }else{
            celda.labelMuertesEnRojo.text = String(tablaPaisesBusqueda[indexPath.row].todayDeaths ?? 0)
        }
        
        celda.muertesDiarias.text = "Muertes hoy: "
        celda.recuperadosDiarios.text = "Recuperados hoy: \(tablaPaisesBusqueda[indexPath.row].todayRecovered ?? 0)"
        
//        retorna la celda llena
        return celda
    }//Llenar celda
    
    
//    funcion al seleccionar una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        que se deseleccione la celda
        tablaPrototipo.deselectRow(at: indexPath, animated: true)
//        debug
//        print(tablaPaises[indexPath.row])
        
//        Variable pais del tipo array se llena con la tabla en cada celda
        paisAMandar = tablaPaisesBusqueda[indexPath.row]
//        preparar para enviar los datos al otro VC
        performSegue(withIdentifier: "segueDetalles", sender: self)
        
    }// seleccionar row
    
//    funcion para enviar los datos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetalles"{
            let enviarDatos = segue.destination as! DetallesViewController
            
//            se envia el objeto ya lleno
            enviarDatos.recibeDatos = paisAMandar
        }
    }
    
}//Extension TableView


// MARK: extension del protocolo

extension ViewController: ManagerProtocol{
    
//    manda a llamar a la funcion que llena la tabla con el objeto decodificado
    func actualizarUI(recibeArrayCovidData: [CovidData]) {
//        asiga a la table lo que trae del manager que es el objeto decidificado
        tablaPaises = recibeArrayCovidData
//        Al actualizar el delgado tambien vuelve a llenar la tabla busqueda
        tablaPaisesBusqueda = tablaPaises
        
//        dispatch para actualizar la tabla cada que se ejecute esta funcion
        DispatchQueue.main.async {
            self.tablaPrototipo.reloadData()
        }//Dispatch
    }//Func Actualizar
}//Extension VC protocol



// MARK: extension de la search bar

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        Vaciamos el array de busqueda
        tablaPaisesBusqueda = []
        
//        Hacemos if para saber si esta vacia la barra de busqueda
        if searchText == "" || searchText.isEmpty{
//            Si esta vacia entonces sera busqueda sera igual a tablapaises o sea tendra todos los elementos
            tablaPaisesBusqueda = tablaPaises
        }else{
//            En caso contrario se hace un for
            for pais in tablaPaises{
//                Cada indice del for va buscando en country y pregunta si contiene lo que vamos escribiendo
                if pais.country.lowercased().contains(searchText.lowercased()){
//                    Si lo contiene entonces lo va agregando al array vacio
                    tablaPaisesBusqueda.append(pais)
                }
            }
        }
        
//        Y lo va actualizando cada que lo agrega
        self.tablaPrototipo.reloadData()
    }
    
//    Al presionar el boton busqueda
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        Cerramos el teclado
        sbBuscarPais.resignFirstResponder()
    }
}

