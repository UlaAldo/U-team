//
//  Operation.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//


struct Operation {
    var sum: Int
    let type: OperationType
    let categories: String
}
enum OperationType: String {
    case income = "Доход"
    case expense = "Расход"
}
