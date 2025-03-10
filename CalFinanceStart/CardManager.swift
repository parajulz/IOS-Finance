
import SwiftUI
/// A class than manages all of the generation and tracking of cards and transactions as well as their respective logic.
@Observable class CardManager {
    /// All the credit cards that ``CardManager`` manages. An array of ``CFCard``s.
    var cards = [CFCard]()
    /// All the transactions from all cards. An array of ``CFTransaction``.
    /// - This is a `computed property` which is like special variable in the sense that it is derived from some computation from other properties and methods.
    /// - In this case, we are aggregating all the ``CFTransaction``s from `cards` together. Whenever `cards` changes, `allTransactions` will reflect any necessary changes! So cool 😎!
    var allTransactions: [CFTransaction] {
        return cards.flatMap { $0.transactions }
    }
    
    /// The ``CardManager`` initialization method. On instantiation, the `cards` property will be set to an array of 10 randomly generated ``CFCard``s.
    init() {
        cards = generateCards(for: 10)
    }
    
    private var personNames = [
        "Ethan Johnson",
        "Mia Davis",
        "Benjamin Taylor",
        "Abigail Anderson",
        "Samuel White",
        "Harper Martinez",
        "Jackson Wilson",
        "Lily Harris",
        "Aiden Thomas",
        "Grace Robinson",
        "Lucas Moore",
        "Scarlett Martin",
        "Elijah Clark",
        "Chloe Lewis",
        "Henry Turner",
        "Sofia Baker",
        "Jack Hill",
        "Amelia Mitchell",
        "Oliver Perez",
        "Ava Scott"
    ]
    
    
    // MARK: - Generation Logic
    /// Generate a given number of cards.
    /// - Parameter count: Number of cards to generate.
    /// - Returns: An array of ``CFCard``.
    func generateCards(for count: Int) -> [CFCard] {
        var generatedCards = [CFCard]()
        for _ in 0..<count  {
            generatedCards.append(createCard())
        }
        return generatedCards
    }
    
    /// Generate a random date between a given interval.
    /// - Parameters:
    ///   - startDate: The start date (inclusive).
    ///   - endDate: The end date (inclusive)
    /// - Returns: The random ``Date``.
    private func randomDateInRange() -> Date {
        let date10000DaysAgo = Date(timeIntervalSinceNow: -86400 * 10000)
        let now = Date()
        let timeInterval = TimeInterval.random(in: date10000DaysAgo.timeIntervalSince1970...now.timeIntervalSince1970)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    
    // MARK: - Task 1: Feeling Swifty >>>>>>
    
    /// Generate an array of transactions.
    /// - Parameters:
    ///   - maxCount: The maximum number of transactions to generate between 1 to ``maxCount``
    ///   - cardNumber: The associated card number that the transactions belong to.
    /// - Returns: An array of ``CFTransactions``.
    ///
    private func generateTransactions(withMax maxCount: Int, for cardNumber: String) -> [CFTransaction] {
        let count = Int.random(in: 1...maxCount) // generate random number between 1 & maxcount
        
        return (0..<count).map { _ in
            CFTransaction(
                type: CFTransaction.CFTransactionType.allCases.randomElement()!,
                changeAmount: Int.random(in: -10000...10000),

                date: randomDateInRange(),
                associatedCardNumber: cardNumber
            )
        }
    }
    
    /// Create and return a new card.
    /// - Card's `cardNumber` uses a function in ``CardManager`` (already implemented)
    /// - Card's `ownerName` is randomly selected from `personNames` list
    /// - Card's `balance` is a random `Int` ranging between the values -10,000 and 10000 (both inclusive)
    /// - Card's `transactions` uses a function in ``CardManager`` with maximum amount of `10` (already implemented)
    /// - Returns: A ``CFCard``.
    func createCard() -> CFCard {
        let randomName = personNames.randomElement()!
        let randomBalance = Int.random(in: -10000...10000)
        
        let randomTransactions = generateTransactions(withMax: 10, for: createCreditCardNumber())

        return CFCard(
            cardNumber: createCreditCardNumber(),
            ownerName: randomName,
            balance: randomBalance,
            transactions: randomTransactions
            )
    }
    
    /// Calculate the total balance across the given cards. For example, if there are 3 given cards with balances of -100, 50, and 200, `getTotalBalance` returns 150 (-100 + 50 + 200).
    /// - Returns: The total balance across all cards.
    func getTotalBalance(for cards: [CFCard]) -> Int {
        return cards.reduce(0) { $0 + $1.balance }
    }
    
    /// Filters cards into two groups: those with positive and negative balances
    /// - Returns: A ``CFCardBalances`` struct with the appropriate initialized properites (`cardsWithPositiveBalances` & `cardsWithNegativeBalances`)
    func getCardsPositiveAndNegativeBalances() -> CFCardBalances {
        let positiveCards = cards.filter { $0.balance > 0 }
            let negativeCards = cards.filter { $0.balance < 0 }
            
            return CFCardBalances(
                cardsWithPositiveBalances: positiveCards,
                cardsWithNegativeBalances: negativeCards
            )
    }
    
    
    
    
    
    
    
    // MARK: - <<<<<< END Task 1: Feeling Swifty
    
    
    /// Given a card, remove it from CardManager.
    /// - Parameter cardToRemove: The card to be removed.
    func removeCard(for cardToRemove: CFCard) {
        if let index = cards.firstIndex(of: cardToRemove) {
            cards.remove(at: index)
        }
    }
    
    
    // MARK: - Credit Card Number Logic
    // https://gist.github.com/sagaya/1d1be4c7afbca2f681bb2a7d9cb2c882
    
    private func make_random_number(num:Int) -> [Int]{
        var result = [Int]()
        for _ in 0...num {
            result.append(Int(arc4random_uniform(9)))
        }
        return result
    }
    
    /// Creates a new valid credit card number using Luhn's Algorithm (introduced in CS61A!).
    /// - Returns: A `String` of the credit card number.
    func createCreditCardNumber() -> String {
        var card_number = ""
        
        var random_master_int = make_random_number(num: 12)
        //Add random master card numbers here [51,52,53,54]
        random_master_int.insert(5, at: 0)
        random_master_int.insert(4, at: 1)
        print(random_master_int)
        
        for (index, _) in random_master_int.enumerated(){
            if index % 2 != 0 {
                let r = random_master_int[index]  * 2
                let characters = String(r).compactMap{Int(String($0))}
                let sum = characters.reduce(0, +)
                print(sum)
            }
        }
        
        
        let sum = random_master_int.reduce(0, +) * 9
        random_master_int.append(sum % 10)

        let random_master_string = random_master_int.map {String($0)}
        
        let first4 = "\(random_master_string[0...3].compactMap({$0}).joined())"
        let second4 = "\(random_master_string[4...7].compactMap({$0}).joined())"
        let third4 = "\(random_master_string[8...11].compactMap({$0}).joined())"
        let fourth4 = "\(random_master_string[12...15].compactMap({$0}).joined())"
        card_number.append(first4)
        card_number.append(second4)
        card_number.append(third4)
        card_number.append(fourth4)

        return card_number
    }
}
