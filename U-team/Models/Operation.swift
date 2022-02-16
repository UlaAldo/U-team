//
//  Operation.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//


struct Operation {
    var sum: Int
    let type: OperationType
    let category: String
}
enum OperationType: String {
    case income
    case expense
}
