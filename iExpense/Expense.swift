//
//  Expense.swift
//  iExpense
//
//  Created by Vikas Bhandari on 11/7/2023.
//

import Foundation
import SwiftUI

struct ExpenseSection: View {
    let title: String // header title for the section
    let expenses: [ExpenseItem] // the array of expense items
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: item.currency))
                        .setStyleOfAmount(item.amount)
                }
            }
            .onDelete(perform: deleteItems)
        } header: {
            Text(title)
        }
    }
    
}


class Expenses: ObservableObject {
    var businessExpenses: [ExpenseItem] { //computed variable that returns only business expenses
        items.filter {
            $0.type == "Business"
        }
    }
    
    var personalExpenses: [ExpenseItem] { //computed variable that returns only personal expenses
        items.filter {
            $0.type == "Personal"
        }
    }
    
    var businessExpensesTotal : Double { //computed variable extracts all of the amounts into a new array of amounts and then sums it up
        let businessAmounts = businessExpenses.map( {$0.amount})
        let sumBusinessAmount = businessAmounts.reduce(0, +)
        return sumBusinessAmount
    }
    
    var personalExpensesTotal: Double { //same as above
        let personalAmounts = personalExpenses.map({$0.amount})
        let sumPersonalAmount = personalAmounts.reduce(0, +)
        return sumPersonalAmount
    }
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
                
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}
