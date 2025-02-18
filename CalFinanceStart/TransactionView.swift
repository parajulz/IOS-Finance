//
//  TransactionView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View for a ``CFTransaction``. Shown as a list in ``MyCardsView``.
/// - Each ``CFTransaction`` has three types: transfer, deposit, and purchase. Depending on the type, `TransactionView` will show the appropriate UI.
struct TransactionView: View {
    var transaction: CFTransaction
    
    var body: some View {
        // TODO: 4A. Implement TransactionView
        Text("DELETE ME")
    }
    
    // MARK: - Helper Functions
    
    // Don't forget to use these functions!! They are indeed quite handy.
    // 💡 TIP: To view these function's documentation in a more prettier way, <Option> click on the function names.
    
    /// For the current transaction, get the associated color. For example, if the transaction is of type `transfer`, &nbsp; `getTransactionColor()` returns `Color.green`.
    /// - Returns: The associated transaction color.
    private func getTransactionColor() -> Color {
        switch transaction.type {
        case .transfer:
            return .green
        case .deposit:
            return .gray
        case .purchase:
            return .red
        }
    }
    
    /// For the current transaction, get the associated system SF Symbols image name which is a `String`. Use it with `Image`.
    /// - Returns: The associated transaction SF Symbols image name.
    private func getTransactionImageName() -> String {
        switch transaction.type {
        case .transfer:
            return "tray.and.arrow.up.fill"
        case .deposit:
            return "tray.and.arrow.down.fill"
        case .purchase:
            return "dollarsign.square.fill"
        }
    }
}

#Preview {
    let cardManager = CardManager()
    return VStack(alignment: .leading, spacing: 30) {
        VStack(alignment: .leading){
            Text("Purchase Transaction View:")
                .bold()
            TransactionView(transaction: CFTransaction(type: .purchase, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
        }
        
        VStack(alignment: .leading) {
            Text("Transfer Transaction View:")
                .bold()
            TransactionView(transaction: CFTransaction(type: .transfer, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
        }
        
        VStack(alignment: .leading) {
            Text("Deposit Transaction View:")
                .bold()
            TransactionView(transaction: CFTransaction(type: .deposit, changeAmount: -10000, date: Date(), associatedCardNumber: cardManager.createCreditCardNumber()))
        }
    }
    .padding()
}

