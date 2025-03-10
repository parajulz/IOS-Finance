import SwiftUI

/// View for a ``CFTransaction``. Shown as a list in ``MyCardsView``.
/// - Each ``CFTransaction`` has three types: transfer, deposit, and purchase. Depending on the type, `TransactionView` will show the appropriate UI.
struct TransactionView: View {
    var transaction: CFTransaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.associatedCardNumber)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .shadow(radius: 4) // Add this line for the shadow effect

                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(getTransactionColor().opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: getTransactionImageName())
                                .foregroundColor(getTransactionColor())
                                .font(.system(size: 24))
                        )
                    
                    Text(String(describing: transaction.type).capitalized)
                        .font(.headline)
                }
            }
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(transaction.changeAmount >= 0 ? "+ " : "- ")$\(abs(transaction.changeAmount))")
                    .font(.headline)
                    .foregroundColor(getTransactionAmountColor())
                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
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
    
    private func getTransactionAmountColor() -> Color {
        switch transaction.type {
        case .transfer:
            return .green
        case .deposit:
            return .gray
        case .purchase:
            return .red
        }
    }
}
