//
//  ContentView.swift
//  iExpense
//
//  Created by Vikas Bhandari on 8/7/2023.
//

import SwiftUI

struct StyleOfAmount: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        var font = Font.system(size: 22, weight: .heavy, design: .default)
        var foregroundColor = Color.black
        
        if amount <= 10 {
            foregroundColor = .blue
        } else if amount > 10 && amount <= 100 {
            foregroundColor = .purple
            font = Font.system(size: 25, weight: .medium, design: .monospaced)
        } else {
            foregroundColor = .red
            font = Font.system(size: 30, weight: .bold, design: .rounded)
        }
        
        return content
            .foregroundColor(foregroundColor)
            .font(font)
    }
}

extension View {
    func setStyleOfAmount(_ amount: Double) -> some View {
        self.modifier(StyleOfAmount(amount: amount))
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ExpenseSection(title: "Business - \(expenses.businessExpensesTotal)", expenses: expenses.businessExpenses, deleteItems: deleteBusinessItems)
                ExpenseSection(title: "Personal - \(expenses.personalExpensesTotal)", expenses: expenses.personalExpenses, deleteItems: deletePersonalItems)
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddItem(expenses: expenses)
            }
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
//    func deleteItems(_ offset: IndexSet) {
//        expenses.items.remove(atOffsets: offset)
//    }
    func deleteBusinessItems(_ offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    
    func deletePersonalItems(_ offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
