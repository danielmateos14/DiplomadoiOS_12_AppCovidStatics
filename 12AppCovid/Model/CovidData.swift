//
//  CovidData.swift
//  12AppCovid
//
//  Created by djdenielb on 30/04/22.
//

import Foundation

//Estructura para parsear API
struct CovidData: Codable{
    let country: String
    let countryInfo: CountryInfo
    let cases: Double?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let todayRecovered: Int?
}

//Estructura para la bandera que este dentro del coyntryInfo
struct CountryInfo: Codable{
    let flag: String?
}


