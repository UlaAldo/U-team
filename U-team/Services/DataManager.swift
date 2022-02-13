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
        "Рестораны",
        "Одежда",
        "Транспорт",
        "Фитнес",
        "Здоровье",
        "Кофе"
    ]
}
