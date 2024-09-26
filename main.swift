import Swift
import Foundation

// Struct to represent an item in the store
struct Item {
    let name: String
    var price: Double
    var quantity: Int
}

// Class to manage the store
class GroceryStore {
    var items: [String: Item] = [:]
    
    // Function to add new items to the store
    func addItem(name: String, price: Double, quantity: Int) {
        let newItem = Item(name: name, price: price, quantity: quantity)
        items[name] = newItem
    }
    
    // Function to update existing item's quantity
    func updateItemQuantity(name: String, newQuantity: Int) {
        guard var item = items[name] else {
            print("Item \(name) not found in the store.")
            return
        }
        item.quantity = newQuantity
        items[name] = item
        print("\(name) quantity updated.")
    }
    
    // Function to update existing item's price
    func updateItemPrice(name: String, newPrice: Double) {
        guard var item = items[name] else {
            print("Item \(name) not found in the store.")
            return
        }
        item.price = newPrice
        items[name] = item
        print("\(name) price updated.")
    }
    
    // Function to process purchase
    func processPurchase(itemName: String, quantity: Int, money: Double) {
        guard let item = items[itemName] else {
            print("Sorry, \(itemName) is not available.")
            return
        }
        
        if item.quantity >= quantity {
            let totalCost = item.price * Double(quantity)
            if money >= totalCost {
                items[itemName]?.quantity -= quantity
                let change = money - totalCost
                print("Purchase successful! Thank you for shopping with us.")
                print("Your change is $\(change)")
            } else {
                print("Sorry, you don't have enough money to buy \(quantity) \(itemName)s.")
            }
        } else {
            print("Sorry, only \(item.quantity) \(itemName)s are available.")
        }
    }
    
    // Function to display available items in the store
    func displayItems() {
        print("Available Items:")
        for (itemName, item) in items {
            print("\(itemName) - Price: $\(item.price) - Quantity: \(item.quantity)")
        }
    }
    
    // Function to search for an item by name
    func searchItem(name: String) {
        if let item = items[name] {
            print("Item found:")
            print("Name: \(item.name)")
            print("Price: $\(item.price)")
            print("Quantity: \(item.quantity)")
        } else {
            print("Item \(name) not found in the store.")
        }
    }
}

// Main program
func main() {
    let store = GroceryStore()
    
    // Adding initial items to the store
    store.addItem(name: "Apple", price: 1.00, quantity: 10)
    store.addItem(name: "Banana", price: 0.5, quantity: 20)
    store.addItem(name: "Orange", price: 0.75, quantity: 15)
    
    var choice = 0
    while choice != 5 {
        print("\nWelcome to the Grocery Store!")
        print("1. Shop for items")
        print("2. Manage store inventory")
        print("3. Display available items")
        print("4. Search for an item")
        print("5. Exit")
        print("Enter your choice (1-5):", terminator: " ")
        
        if let input = readLine(), let intInput = Int(input) {
            choice = intInput
            switch choice {
            case 1:
                store.displayItems()
                shop(store: store)
            case 2:
                manageInventory(store: store)
            case 3:
                store.displayItems()
            case 4:
                searchItem(store: store)
            case 5:
                print("Exiting...")
                
            default:
                print("Invalid choice. Please enter a number between 1 and 5.")
            }
        } else {
            print("Invalid input. Please enter a number.")
        }
    }
}

// Function for customer shopping
func shop(store: GroceryStore) {
    print("Enter the item you want to purchase:", terminator: " ")
    if let itemName = readLine()?.capitalized {
        print("Enter the quantity:", terminator: " ")
        if let quantityInput = readLine(), let quantity = Int(quantityInput) {
            print("Enter your money:", terminator: " ")
            if let moneyInput = readLine(), let money = Double(moneyInput) {
                store.processPurchase(itemName: itemName, quantity: quantity, money: money)
            } else {
                print("Invalid input for money.")
            }
        } else {
            print("Invalid input for quantity.")
        }
    } else {
        print("Invalid input for item name.")
    }
}

// Function for managing store inventory
func manageInventory(store: GroceryStore) {
    var choice = 0
    while choice != 4 {
        print("\nManage Inventory:")
        print("1. Add new item")
        print("2. Update item quantity")
        print("3. Update item price")
        print("4. Back to main menu")
        print("Enter your choice (1-4):", terminator: " ")
        
        if let input = readLine(), let intInput = Int(input) {
            choice = intInput
            switch choice {
            case 1:
                addItemToInventory(store: store)
            case 2:
                updateItemQuantity(store: store)
            case 3:
                updateItemPrice(store: store)
            case 4:
                print("Returning to main menu...")
            default:
                print("Invalid choice. Please enter a number between 1 and 4.")
            }
        } else {
            print("Invalid input. Please enter a number.")
        }
    }
}

// Function to add new item to inventory
func addItemToInventory(store: GroceryStore) {
    print("Enter the name of the new item:", terminator: " ")
    if let name = readLine() {
        print("Enter the price:", terminator: " ")
        if let priceInput = readLine(), let price = Double(priceInput) {
            print("Enter the quantity:", terminator: " ")
            if let quantityInput = readLine(), let quantity = Int(quantityInput) {
                store.addItem(name: name, price: price, quantity: quantity)
                print("\(name) added to inventory.")
            } else {
                print("Invalid input for quantity.")
            }
        } else {
            print("Invalid input for price.")
        }
    } else {
        print("Invalid input for item name.")
    }
}

// Function to update item quantity
func updateItemQuantity(store: GroceryStore) {
    print("Enter the name of the item you want to update:", terminator: " ")
    if let name = readLine() {
        print("Enter the new quantity:", terminator: " ")
        if let quantityInput = readLine(), let quantity = Int(quantityInput) {
            store.updateItemQuantity(name: name, newQuantity: quantity)
        } else {
            print("Invalid input for quantity.")
        }
    } else {
        print("Invalid input for item name.")
    }
}

// Function to update item price
func updateItemPrice(store: GroceryStore) {
    print("Enter the name of the item you want to update:", terminator: " ")
    if let name = readLine() {
        print("Enter the new price:", terminator: " ")
        if let priceInput = readLine(), let price = Double(priceInput) {
            store.updateItemPrice(name: name, newPrice: price)
        } else {
            print("Invalid input for price.")
        }
    } else {
        print("Invalid input for item name.")
    }
}

// Function to search for an item
func searchItem(store: GroceryStore) {
    print("Enter the name of the item you want to search for:", terminator: " ")
    if let itemName = readLine()?.capitalized {
        store.searchItem(name: itemName)
    } else {
        print("Invalid input for item name.")
    }
}

// Run the program
main()