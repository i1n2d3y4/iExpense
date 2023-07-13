//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Vikas Bhandari on 11/7/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    var currency: String = "USD"
}
