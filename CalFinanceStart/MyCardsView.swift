//
//  MyCardsView.swift
//  CalFinance
//
//  Created by Justin Wong on 1/13/24.
//

import SwiftUI

/// NOT NEEDED IN HW
/// - This is the main view titled `Cards`. From here, we present ``ManageCardsView`` and ``AddNewCardView``. We also display the scrolling list of ``CreditCardView``s at the top and all ``CFCard``'s ``CFTransaction``s at the bottom.
struct MyCardsView: View {
    @State private var cardManager = CardManager()
    @State private var isPresentingManageCardsSheet = false
    @State private var isPresentingAddNewCardView = false
    @State private var isTransactionsListExpanded = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                creditCardsView
                TransactionListView(cardManager: cardManager, isTransactionsListExpanded: $isTransactionsListExpanded)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .navigationTitle("Cards")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        isPresentingManageCardsSheet.toggle()
                    }) {
                        Image(systemName: "rectangle.stack")
                    }
                    
                    Button(action: {
                        isPresentingAddNewCardView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingManageCardsSheet) {
                ManageCardsView(cardManager: cardManager)
            }
            .fullScreenCover(isPresented: $isTransactionsListExpanded) {
                TransactionListView(cardManager: cardManager, isTransactionsListExpanded: $isTransactionsListExpanded)
            }
            .sheet(isPresented: $isPresentingAddNewCardView) {
                AddNewCardView(cardManager: cardManager)
            }
        }
    }
    
    private var creditCardsView: some View {
        TabView {
            ForEach(cardManager.cards, id: \.id) { card in
                CreditCardView(card: card)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode:.always))
        .safeAreaPadding(.horizontal, 10)
        .frame(height: 290)
    }
}

// MARK: - TransactionListView

struct TransactionListView: View {
    var cardManager: CardManager
    
    @Binding var isTransactionsListExpanded: Bool
    
    var body: some View {
        VStack {
            headerView
            
            Spacer()
            
            // TODO: 5A. Implement the Transaction List
            Text("DELETE ME")
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Transactions")
                .font(.title)
                .bold()
                .multilineTextAlignment(.leading)
            Spacer()
            Button(action: {
                withAnimation {
                    isTransactionsListExpanded.toggle()
                }
            }) {
                Image(systemName: "rectangle.expand.vertical")
                    .foregroundStyle(.green)
                    .font(.system(size: 20))
            }
        }
        .padding()
    }
}

#Preview {
    MyCardsView()
}
