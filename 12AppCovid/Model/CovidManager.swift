//
//  CovidManager.swift
//  12AppCovid
//
//  Created by djdenielb on 30/04/22.
//

import Foundation

//Protocolo para actualizar UI
protocol ManagerProtocol{
    func actualizarUI(recibeArrayCovidData: [CovidData])
}//Protocol

//Struct manager
struct CovidManager{
    
//    Delegado del protocolo
    var delegate: ManagerProtocol?
    
//    Funcion para extraer los datos de la API
    func funcionUrlSessions(){
//        Variable String
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries/"
//        Variable URL que recibe string
        if let urlCodificada = URL(string: urlString){
//            Variable URLSession
            let variableUrlSessions = URLSession(configuration: .default)
//            Variable tarea que contiene datos, respuesta y error
            let tarea = variableUrlSessions.dataTask(with: urlCodificada) { datos, respuesta, error in
//                Closure cuando hay un error
                if error != nil{
                    print("Error groso \(error?.localizedDescription ?? "Error desconocido")")
                }//if error
//                Closure cuando no hay error, variable con los datos
                if let datosSeguros = datos{
//                    Variable con la funcion que parsea los datos
                    if let listaPaises = parseaJson(recibeData: datosSeguros){
//                        Delegado que ya contiene los datos parseados y como objeto decodificado
                        delegate?.actualizarUI(recibeArrayCovidData: listaPaises)
                    }// if let lista paises
                }//if let datos seguros
            }//let tarea
//            Se pone en marcha la tarea que esta en segundo plano
            tarea.resume()
        }//if let url codificada
    }// funcion url Sessions
    
    
    
//    Funcion que parsea el json y lo convierte en objeto, devuelve array del coviddata
    func parseaJson(recibeData: Data) -> [CovidData]? {
//        Variable decodificador
        let deco = JSONDecoder()
//        Hacemos do para intentar decodificar los datos en el array
        do{
//            variable array que contendra los datos decodificados que recibe desde URLSessions
            let datosDecodificados: [CovidData] = try deco.decode([CovidData].self, from: recibeData)
//            Debug
//            print("Datos decodificados, cuantos?")
//            print(datosDecodificados[0].cases!)
//            Variable paises del tipo array coviddata que guarda los datos decodificados
            let paises:[CovidData] = datosDecodificados
            
//            Retorna el objeto ya creado del tipo array
            return paises
//            En caso de que haya error
        }catch{
//            imprime el error
            print("Error \(error.localizedDescription)")
//            termina la ejecucion del do catch
            return nil
        }//catch
    }//func parseaJson
    
}//struct CovidManager

