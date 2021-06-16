//
//  CountryModel.swift
//  CountryList
//
//  Created by Jesther Silvestre on 6/16/21.
//

import Foundation

struct CountryModel:Codable{
    let name:String
    let alpha2Code:String
    let alpha3Code:String
    let capital:String
    let region:String
    let population:Int
    let flag:URL?
    let cioc:String?
}
