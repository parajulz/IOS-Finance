import SwiftUI

struct TransactionView: View {
    var transaction: CFTransaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.associatedCardNumber)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .shadow(radius: 4)

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
                    .foregroundColor(Color.gray)
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .overlay( // Hollow effect using the border
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color(UIColor.separator), lineWidth: 1) // The border color
               )
        .shadow(radius: 2)
    }
    
    private func getTransactionColor() -> Color {
        switch transaction.type {
        case .transfer:
            return Color.green
        case .deposit:
            return Color.gray
        case .purchase:
            return Color.red
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
            return Color.green
        case .deposit:
            return Color.gray
        case .purchase:
            return Color.red
        }
    }
}
