//
//  DetallesViewController.swift
//  12AppCovid
//
//  Created by djdenielb on 01/05/22.
//

import UIKit

class DetallesViewController: UIViewController {
    
//    variable que recibe los datos, es tipo objeto del coviddata por que asi se codifica
//    como objeto
    var recibeDatos: CovidData?
    
//Variables graficas
    @IBOutlet weak var ivBandera: UIImageView!
    @IBOutlet weak var labelPais: UILabel!
    @IBOutlet weak var labelCasosTotales: UILabel!
    @IBOutlet weak var labelCasosDiarios: UILabel!
    @IBOutlet weak var labelMuertesDiarias: UILabel!
    @IBOutlet weak var labelMuertesTotales: UILabel!
    @IBOutlet weak var labelRecuperadosDiarios: UILabel!
    @IBOutlet weak var labelRecuperadosTotales: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Creacion de la imagen
        if let banderaString = recibeDatos?.countryInfo.flag{
            if let banderaUrl = URL(string: banderaString){
                DispatchQueue.main.async {
                    guard let banderaData = try? Data(contentsOf: banderaUrl) else {return}
                    let bandera = UIImage(data: banderaData)
                    DispatchQueue.main.async {
                        self.ivBandera.image = bandera
                    }//dispatch
                }//bandera data
            }//bandera url
        }//Bandera string
        
        
//        Llenado de los campos con el objeto que viene de la otra pantalla y esta guardado
//        en el objeto de aqui
        labelPais.text = recibeDatos?.country
        labelCasosTotales.text = "Casos totales: \(recibeDatos?.cases ?? 0)"
        labelCasosDiarios.text = "Casos hoy (aqui pones la fecha): \(recibeDatos?.todayCases ?? 0)"
        labelMuertesTotales.text = "Muertes totales: \(recibeDatos?.deaths ?? 0)"
        labelMuertesDiarias.text = "Muertes hoy: (aqui pones la fecha): \(recibeDatos?.todayDeaths ?? 0)"
        labelRecuperadosTotales.text = "Recuperados totales: \(recibeDatos?.recovered ?? 0)"
        labelRecuperadosDiarios.text = "Recuperados hoy: (aqui pones la fecha): \(recibeDatos?.todayRecovered ?? 0)"
    
    }//view did load

}//VC
