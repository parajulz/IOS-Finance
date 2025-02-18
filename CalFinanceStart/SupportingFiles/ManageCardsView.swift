//
//  ManageCardsView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/14/24.
//

import SwiftUI

fileprivate enum ManageCardsViewFilterState {
    case positiveBalances
    case negativeBalances
    case all
}

/// NOT NEEDED IN HW: View for managing our credit cards. Presented as a `fullScreenCover` in ``MyCardsView``.
/// - Upon tapping/selecting on a credit card, `SelectedCreditCardView` will be shown.
struct ManageCardsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var cardManager: CardManager
    
    @State private var filteredCards = [CFCard]()
    @State private var selectedCard: CFCard? = nil
    @State private var isShowingSelectedView = false
    @State private var filterState: ManageCardsViewFilterState = .all
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let selectedCard = selectedCard, isShowingSelectedView {
                    SelectedCreditCardView(cardManager: cardManager, selectedCard: selectedCard, isShowingSelectedView: $isShowingSelectedView)
                } else {
                    creditCardsView
                }
            }
            .navigationTitle("Manage Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                backAndCloseButton
                
                if !filteredCards.isEmpty {
                    filterCardsMenu
                }
            }
        }
        .onChange(of: cardManager.cards, initial: true) {
            withAnimation {
                filteredCards = cardManager.cards
            }
        }
    }
    
    @ToolbarContentBuilder
    private var backAndCloseButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                if !isShowingSelectedView {
                    dismiss()
                } else {
                    withAnimation {
                        selectedCard = nil
                        isShowingSelectedView = false
                    }
                }
            }) {
                Image(systemName:
                        selectedCard == nil ? "xmark.circle.fill" : "chevron.left.circle.fill")
                    .foregroundStyle(.gray)
                    .font(.system(size: 25))
            }
        }
    }
    
    @ToolbarContentBuilder
    private var filterCardsMenu: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Button("All", action: { filterCards(forState: .all) })
                Button("Positive Balances", action: { filterCards(forState: .positiveBalances) })
                Button("Negative Balances", action: { filterCards(forState: .negativeBalances) })
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
    
    @ViewBuilder
    private var creditCardsView: some View {
        if filteredCards.isEmpty {
            Text("No Cards Available")
                .font(.title)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        } else {
            VStack {
                HStack {
                    Text("^[\(filteredCards.count) Card](inflect: true)")
                        .contentTransition(.numericText())
                        .applyIndigoBackground()
                    BalanceAmountView(amount: cardManager.getTotalBalance(for: filteredCards))
                        .applyIndigoBackground()
                }
                
                ScrollView(.vertical) {
                    ForEach(filteredCards, id: \.cardNumber) { card in
                        CreditCardView(card: card)
                            .onTapGesture {
                                withAnimation {
                                    selectedCard = card
                                    isShowingSelectedView = true
                                }
                            }
                    }
                    .padding(.top, 40)
                }
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(10)
        }
    }
    
    private func filterCards(forState state: ManageCardsViewFilterState) {
        let cardBalances = cardManager.getCardsPositiveAndNegativeBalances()
        let cardsWithPositiveBalances = cardBalances.cardsWithPositiveBalances
        let cardsWithNegativeBalances = cardBalances.cardsWithNegativeBalances
        
        withAnimation {
            switch state {
            case .positiveBalances:
                filteredCards = cardsWithPositiveBalances
            case .negativeBalances:
                filteredCards = cardsWithNegativeBalances
            case .all:
                filteredCards = cardManager.cards
            }
        }
    }
}

//MARK: - SelectedCreditCardView
/// View that is presented when the user selects a credit card.
/// - Users can delete the credit card upon pressing the delete button.
/// - `fileprivate` is one of the access levels that Swift provides along with `private` and `public`. Here `SelectedCreditCardView` is only accessible or "can be seen" within this current file (`ManageCardsView.swift`).
fileprivate struct SelectedCreditCardView: View {
    var cardManager: CardManager
    var selectedCard: CFCard
    @Binding var isShowingSelectedView: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            creditCardViewWithShadow
            deleteCardButton
            Spacer()
        }
        .padding(10)
    }
    
    private var creditCardViewWithShadow: some View {
        CreditCardView(card: selectedCard)
        .applyCreditCardBottomShadow()
    }
    
    private var deleteCardButton: some View {
        //TODO: Implement deleteCardButton
        Button(action: {
            //Delete card action
            withAnimation {
                cardManager.removeCard(for: selectedCard)
                isShowingSelectedView = false
            }
        }) {
            Circle()
                .fill(.red)
                .frame(width: 60, height: 60)
                .overlay(
                   Image(systemName: "trash")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                )
        }
    }
}

#Preview("ManageCardsView") {
    ManageCardsView(cardManager: CardManager())
}


