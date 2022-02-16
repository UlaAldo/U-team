//
//  DataManager.swift
//  U-team
//
//  Created by Юрий Скворцов on 13.02.2022.
//

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
