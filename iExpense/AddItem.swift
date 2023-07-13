//
//  AddItem.swift
//  iExpense
//
//  Created by Vikas Bhandari on 11/7/2023.
//

import SwiftUI

struct AddItem: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "HKD", "AUD"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id:\.self) {
                        Text($0)
                    }
                }
                HStack {
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                    Spacer()
                    Picker("Currency", selection: $currency) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expenses.items.append(expense)
                    dismiss()
                }
            }
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(expenses: Expenses())
    }
}
