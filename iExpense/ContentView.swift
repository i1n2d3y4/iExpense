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
                // removing this to replace with sections for business and personal below
//                ForEach(expenses.items, id: \.id) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(item.name)
//                                .font(.headline)
//                            Text(item.type)
//                                .foregroundColor(.gray)
//                        }
//                        Spacer()
//                        Text(item.currency)
//                            .foregroundColor(.gray)
//                        Text(item.amount, format: .currency(code: item.currency))
//                            .setStyleOfAmount(item.amount)
//                    }
//
                    ExpenseSection(title: "Business", expenses: expenses.businessExpenses)
                }
// removing as onDelete will be called from section                .onDelete(perform: removeItems)
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
