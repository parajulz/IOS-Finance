//
//  AddNewCardView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

/// View that users can add a new credit card. Presented by ``MyCardsView``.
struct AddNewCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var cardManager: CardManager 
    @State private var ownerName = ""
    @State private var cardNumber = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                TitleTextFieldView(title: "Owner Name", contentText: $ownerName)
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextFieldView(title: "Card Number", contentText: $cardNumber)
                    generateCreditCardNumberButton
                    
                }
                Spacer()
                addCreditCardButton
            }
            .navigationTitle("Add New Card")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.system(size: 25))
                    }
                }
            }
        }
    }
    
    private var addCreditCardButton: some View {
        // TODO: 3A. Implement addCreditCardButton
        Button(action: {
                    let newCard = CFCard(cardNumber: cardNumber, ownerName: ownerName, balance: 0, transactions: [])
                    cardManager.cards.insert(newCard, at: 0)
                    dismiss()
                }) {
                    Text("Add Credit Card")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
    }
    
    private var generateCreditCardNumberButton: some View {
        // TODO: 3B. Implement generateCreditCardNumberButton
        Button(action: {
                    generateCreditCardNumber()
                }) {
                    Text("Generate Card Number")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
    }
    
    private func generateCreditCardNumber() {
        cardNumber = cardManager.createCreditCardNumber()
    }
}

/// A helper view that customizes a `TextField` by adding an associated title at the top as well as some UI customization.
struct TitleTextFieldView: View {
    var title: String
    @Binding var contentText: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue.opacity(0.1))
                .stroke(.blue, lineWidth: 1)
                .frame(height: 50)
                .overlay(
                    TextField("Enter \(title)", text: $contentText)
                        .padding(10)
                        .bold()
                )
        }
    }
}

#Preview {
    AddNewCardView(cardManager: CardManager())
}
