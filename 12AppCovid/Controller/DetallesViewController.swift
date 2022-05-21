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
    
    @IBOutlet weak var labelFechaCasos: UILabel!
    @IBOutlet weak var labelFechaMuertes: UILabel!
    @IBOutlet weak var labelFechaRecuperados: UILabel!
    
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
        
        //    Variable para la fecha
            let accessDateClass = Date.now
            var fecha = ""
            fecha = accessDateClass.formatted(.dateTime
                                                .day()
                                                .month()
                                                .year(.defaultDigits))
        
        
//        Llenado de los campos con el objeto que viene de la otra pantalla y esta guardado
//        en el objeto de aqui
        labelPais.text = recibeDatos?.country
        labelCasosTotales.text = "Casos totales: \(recibeDatos?.cases ?? 0)"
        labelCasosDiarios.text = "Casos hoy: \(recibeDatos?.todayCases ?? 0)"
        labelFechaCasos.text = fecha
        labelMuertesTotales.text = "Muertes totales: \(recibeDatos?.deaths ?? 0)"
        labelMuertesDiarias.text = "Muertes hoy: \(recibeDatos?.todayDeaths ?? 0)"
        labelFechaMuertes.text = fecha
        labelRecuperadosTotales.text = "Recuperados totales: \(recibeDatos?.recovered ?? 0)"
        labelRecuperadosDiarios.text = "Recuperados hoy: \(recibeDatos?.todayRecovered ?? 0)"
        labelFechaRecuperados.text = fecha
    
    }//view did load

}//VC
