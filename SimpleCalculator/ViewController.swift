import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Enum used to identify the functions
    enum functions: Int {
        case squareRoot = -1
        case squared = -2
        case percentage = -3
        case backspace = -4
        case clearEntry = -5
        case clearAll = -6
        case plusMinus = -7
        case dot = -8
    }
    
    //Enum used to identify the operators
    enum operators: Int {
        case div = -1
        case mult = -2
        case sub = -3
        case add = -4
        case equals = -5
    }
    
    //Instance Variables
    var hasDecimal: Bool = false
    var lastInputWasOperator: Bool = false
    var justUsedEquals: Bool = false
    var startedNewOperation: Bool = false
    var numberOnScreen: String = "0"
    var numberInMemory: String = "0"
    var lastOperatorPressed: Int = 0
    
    //IBOutlets
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    
    //Method used when pressing any of the numbers or the "."
    @IBAction func onNumberButtonPress(_ sender: UIButton) {
        
        if(numberOnScreen == "0") {
            if(sender.tag == functions.dot.rawValue) {
                if(hasDecimal){
                    numberOnScreen = "0"
                }
            }
            else{
                numberOnScreen = ""
            }
        }
        
        if(sender.tag == functions.dot.rawValue) {
            if numberOnScreen != "0." {
                if(!hasDecimal) {
                    numberOnScreen.append(".")
                }
            }
        }
        else if (lastInputWasOperator == true) {
            numberInMemory = numberOnScreen
            numberOnScreen = String(sender.tag)
        }
        else {
            numberOnScreen.append(String(sender.tag))
        }
        
        justUsedEquals = false
        lastInputWasOperator = false
        
        //Variable to check if the number on screen is a decimal number
        hasDecimal = (floor(Double(numberOnScreen)!) != Double(numberOnScreen)!)
        
        //Display the current result on the result area
        resultArea.text = numberOnScreen
        
    }
    
    //Method used when pressing any of the functions
    @IBAction func onFunctionButtonPress(_ sender: UIButton) {
        
        switch sender.tag {
        
        //Function Square Root
        case functions.squareRoot.rawValue:
            let result = Double(numberOnScreen)?.squareRoot()
            numberOnScreen = result!.description
            
        //Function Squared
        case functions.squared.rawValue:
            let result = (Double(numberOnScreen)! * Double(numberOnScreen)!)
            numberOnScreen = result.description
            
        //Function Backspace
        case functions.backspace.rawValue:
            if numberOnScreen.count > 1 {
                numberOnScreen = String(numberOnScreen.prefix(numberOnScreen.count - 1))
            }
            else
            {
                numberOnScreen = "0"
            }
        
        //Function ClearEntry
        case functions.clearEntry.rawValue:
            numberOnScreen = "0"
        
        //Function ClearAll
        case functions.clearAll.rawValue:
            if (numberOnScreen == "0" && numberInMemory == "0") {
                hasDecimal = false
                lastInputWasOperator = false
                justUsedEquals = false
                numberOnScreen = "0"
                numberInMemory = "0"
                lastOperatorPressed = 0
            }
            else if (numberOnScreen == "0") {
                numberInMemory = "0"
            }
            else {
                numberOnScreen = "0"
            }
        
        //Function Plus and Minus
        case functions.plusMinus.rawValue:
            if (Int(numberOnScreen)! > 0) {
                numberOnScreen = "-" + numberOnScreen
            } else if (Int(numberOnScreen)! < 0) {
                numberOnScreen.remove(at: numberOnScreen.startIndex)
            } else {
                numberOnScreen = "0"
            }
            
        //Function Percentage
        case functions.percentage.rawValue:
            if (numberInMemory != "0" && numberOnScreen != "0" && lastOperatorPressed == operators.add.rawValue) {
                numberOnScreen = String(Double(numberInMemory)! * Double(numberOnScreen)! / Double(100))
            }
            else {
                numberOnScreen = String(Double(numberOnScreen)! / (Double(100)))
            }
        
        //Apparently there has to be a default option for the switch case
        default: break
            
        }
        
        lastInputWasOperator = false
        justUsedEquals = false
        
        //Variable to check if the number on screen is a decimal number
        hasDecimal = (rint(Double(numberOnScreen)!) != Double(numberOnScreen)!)
        
        //Remove the decimal number if the result is a complete integer
        if numberOnScreen.suffix(2) == ".0" {
            numberOnScreen = String(numberOnScreen.prefix(numberOnScreen.count - 2))
        }
        
        //Display the current result on the result area
        if (numberOnScreen != "inf") {
            resultArea.text = numberOnScreen
        }
        else {
            resultArea.text = "Not a valid operation!"
        }
        
    }
    
    //Method used when pressing any of the operators
    @IBAction func onOperatorButtonPress(_ sender: UIButton) {
        
        //Case structure to check which function button is being pressed
        switch sender.tag {
            
        //Operator Divide
        case operators.div.rawValue:
            if (numberInMemory != "0" && numberOnScreen != "0" && !justUsedEquals) {
                equals()
            }
            
            lastOperatorPressed = operators.div.rawValue
            
        //Operator Multiply
        case operators.mult.rawValue:
            if (numberInMemory != "0" && numberOnScreen != "0" && !justUsedEquals) {
                equals()
            }
            
            lastOperatorPressed = operators.mult.rawValue
            
        //Operator Subtract
        case operators.sub.rawValue:
            if (numberInMemory != "0" && numberOnScreen != "0" && !justUsedEquals) {
                equals()
            }
            
            lastOperatorPressed = operators.sub.rawValue
            
        //Operator Add
        case operators.add.rawValue:
            if (numberInMemory != "0" && numberOnScreen != "0" && !justUsedEquals) {
                equals()
            }
            
            lastOperatorPressed = operators.add.rawValue
            
        //Operator Equals
        case operators.equals.rawValue:
            equals()
            justUsedEquals = true
        
        //Apparently there has to be a default option for the switch case
        default: break
            
        }
        
        lastInputWasOperator = true
        
    }
    
    func equals() {
        
        let nos: String = numberOnScreen
        
        //The operator Equals needs to consider the previous operator input, so I'm creating a case structure to make this verification
        switch lastOperatorPressed {
            
        //Divide
        case operators.div.rawValue:
            if (justUsedEquals) {
                numberOnScreen = String((Double(numberOnScreen)! / Double(numberInMemory)!))
            }
            else {
                numberOnScreen = String((Double(numberInMemory)! / Double(numberOnScreen)!))
            }
            
        //Multiply
        case operators.mult.rawValue:
            numberOnScreen = String((Double(numberInMemory)! * Double(numberOnScreen)!))
            
        //Subtract
        case operators.sub.rawValue:
            if (justUsedEquals) {
                numberOnScreen = String((Double(numberOnScreen)! - Double(numberInMemory)!))
            }
            else {
                numberOnScreen = String((Double(numberInMemory)! - Double(numberOnScreen)!))
            }
            
        //Add
        case operators.add.rawValue:
            numberOnScreen = String((Double(numberInMemory)! + Double(numberOnScreen)!))
            
        //Apparently there has to be a default option for the switch case
        default: break
        }
        
        if (!justUsedEquals) {
            numberInMemory = nos
        }
        
        justUsedEquals = true
        
        //Variable to check if the number on screen is a decimal number
        hasDecimal = (rint(Double(numberOnScreen)!) != Double(numberOnScreen)!)
        
        //Remove the decimal number if the result is a complete integer
        if numberOnScreen.suffix(2) == ".0" {
            numberOnScreen = String(numberOnScreen.prefix(numberOnScreen.count - 2))
        }
        
        //Display the current result on the result area
        if (numberOnScreen != "inf") {
            resultArea.text = numberOnScreen
        }
        else {
            resultArea.text = "Not a valid operation!"
        }
        
    }
    
    @IBAction func buttonAnimation(_ sender: UIButton) {
        sender.pulsate()
    }
    
}
