import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Enum used to identify the functions
    enum functions: Int {
        case dot = -1
        case clear = -2
        case plusMinus = -3
        case percentage = -4
        case div = -5
        case mult = -6
        case sub = -7
        case add = -8
        case equals = -9
    }
    
    //Instance Variables
    var hasDecimal: Bool = false
    var lastInputWasOperator: Bool = false
    var keptPressingEquals: Bool = false
    var numberOnScreen: String = "0"
    var numberInMemory: String = "0"
    var lastOperatorPressed: Int = 0
    
    //IBOutlets
    @IBOutlet weak var resultArea: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    
    //IBActions
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
            if(!hasDecimal) {
                numberOnScreen.append(".")
                hasDecimal = true
            }
        }
        else if (lastInputWasOperator == true) {
            numberInMemory = numberOnScreen
            numberOnScreen = String(sender.tag)
            lastInputWasOperator = false
        }
        else {
            numberOnScreen.append(String(sender.tag))
        }
        
        //Set the Clear button text depending on the number on screen
        if (numberOnScreen != "0") {
            btnClear.setTitle("C", for: .normal)
        }
        else {
            btnClear.setTitle("AC", for: .normal)
        }
        
        keptPressingEquals = false
        
        //Display the current result on the result area
        resultArea.text = numberOnScreen
        
    }
    
    @IBAction func onFunctionButtonPress(_ sender: UIButton) {
        
        //Case structure to check which function button is being pressed
        switch sender.tag {
        
        //Function Clear
        case functions.clear.rawValue:
            if (numberOnScreen == "0" && numberInMemory == "0") {
                hasDecimal = false
                lastInputWasOperator = false
                keptPressingEquals = false
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

            btnClear.setTitle("AC", for: .normal)
            
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
            if (numberInMemory != "0" && numberOnScreen != "0" && lastOperatorPressed == functions.add.rawValue) {
                numberOnScreen = String(Double(numberInMemory)! * Double(numberOnScreen)! / Double(100))
            }
            else {
                numberOnScreen = String(Double(numberOnScreen)! / (Double(100)))
            }
            
        //Operator Divide
        case functions.div.rawValue:
            //numberInMemory = numberOnScreen
            lastInputWasOperator = true
            lastOperatorPressed = functions.div.rawValue
            
        //Operator Multiply
        case functions.mult.rawValue:
            //numberInMemory = numberOnScreen
            lastInputWasOperator = true
            lastOperatorPressed = functions.mult.rawValue
            
        //Operator Subtract
        case functions.sub.rawValue:
            //numberInMemory = numberOnScreen
            lastInputWasOperator = true
            lastOperatorPressed = functions.sub.rawValue
            
        //Operator Add
        case functions.add.rawValue:
            //numberInMemory = numberOnScreen
            lastInputWasOperator = true
            lastOperatorPressed = functions.add.rawValue
            
        //Operator Equals
        case functions.equals.rawValue:
            
            let nos: String = numberOnScreen
            
            //The operator Equals needs to consider the previous operator input, so I'm creating a case structure to make this verification
            switch lastOperatorPressed {
            
            //Divide
            case functions.div.rawValue:
                if (keptPressingEquals) {
                    numberOnScreen = String((Double(numberOnScreen)! / Double(numberInMemory)!))
                }
                else {
                    numberOnScreen = String((Double(numberInMemory)! / Double(numberOnScreen)!))
                }
            
            //Multiply
            case functions.mult.rawValue:
                numberOnScreen = String((Double(numberInMemory)! * Double(numberOnScreen)!))
                
            //Subtract
            case functions.sub.rawValue:
                if (keptPressingEquals) {
                    numberOnScreen = String((Double(numberOnScreen)! - Double(numberInMemory)!))
                }
                else {
                    numberOnScreen = String((Double(numberInMemory)! - Double(numberOnScreen)!))
                }
                
            //Add
            case functions.add.rawValue:
                numberOnScreen = String((Double(numberInMemory)! + Double(numberOnScreen)!))
            
            //Apparently there has to be a default option for the switch case
            default: break
            }
            
            if (!keptPressingEquals) {
                numberInMemory = nos
            }
            
            keptPressingEquals = true
        
        //Apparently there has to be a default option for the switch case
        default: break
            
        }
        
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
    
}
