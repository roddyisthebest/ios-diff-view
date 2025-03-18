//
//  DiffCode.swift
//  IosDiffView
//
//  Created by 배성연 on 3/18/25.
//

import Foundation


enum DiffStatus {
    case add
    case delete
    case notChange
}

struct DiffCode:Hashable{
    
    let status:DiffStatus;
    let oldLine:Int;
    let newLine:Int;
    
    let content:String;
    let hilightedContent:[String]?
}
