import SwiftUI

/// View for a `CFCard` (BLOOOO credit card)
struct CreditCardView: View {
    var card: CFCard
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .stroke(.white, lineWidth: 2)
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    headerSection
                    Spacer()
                    balanceSection
                    visaSection
                    Spacer()
                }
                    .bold()
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 40, leading: 10, bottom: 40, trailing: 20))
            )
            .frame(height: 200)
    }
    
    private var headerSection: some View {
        // TODO: 2A. HeaderSection Walkthrough
        VStack(alignment: .leading, spacing: 10) {
            Text("\(card.ownerName.capitalized)")
              .font(.title2)
          Text(card.cardNumber)
            .font(.headline)
        }
    }
    
    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 1) {            Text("Balance:")
                .font(.headline)
            Spacer()
            Spacer()
            Text("\(card.balance >= 0 ? "+" : "-") $\(abs(card.balance))")
                .font(.title)
                .bold()
        }
    }
    
    private var visaSection: some View {
        HStack {
            Spacer()
            Text("VISA").italic()
                .font(.headline)
        }
    }
    
}
    
    #Preview {
        CreditCardView(card: CFCard(cardNumber: CardManager().createCreditCardNumber(), ownerName: "Johnny Appleseed", balance: 1000, transactions: []))
            .padding()
    }
