//
//  Quote.swift
//  UIKit-Quote-App
//
//  Created by Pavan Mikkilineni on 08/12/21.
//

import Foundation

struct Quotes:Codable{
    let quotes:[Quote]
}

struct Quote:Codable{
    let text:String
    let author:String
}
