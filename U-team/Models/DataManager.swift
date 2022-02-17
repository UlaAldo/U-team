//
//  DataManager.swift
//  U-team
//
//  Created by Юлия Алдохина on 17/02/22.
//

import Foundation

class DataManager {
    
    static let share = DataManager()
    
    let incomeCategories = [
        "Зарплата",
        "Подарок",
        "Перевод"
    ]
    
    let expenseCategories = [
        "Продукты",
        "Питомец",
        "Авто",
        "Кофе",
        "Одежда",
        "Рестораны",
        "Образование"
    ]
}
