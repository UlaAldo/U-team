//
//  Operation.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//


struct Operation {
    var sum: Int
    let type: OperationType
    let categories: [String]
    
    static func getOperationIncome() -> Operation {
            Operation(
                sum: 0,
                type: .income,
                categories: [
                    "Зарплата",
                    "Подарок",
                    "Перевод"
                ]
            )
                }
          
    static func getOperationExpense() -> Operation {
            Operation(
                sum: 0,
                type: .expense,
                categories: [
                    "Продукты",
                    "Рестораны",
                    "Одежда",
                    "Транспорт",
                    "Фитнес",
                    "Здоровье"
                ]
            )
    }
}

enum OperationType: String {
    case income = "Доход"
    case expense = "Расход"
}


