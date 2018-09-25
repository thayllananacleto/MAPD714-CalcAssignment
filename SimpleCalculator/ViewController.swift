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
    var hasDecimal:Bool = false
    var hasPressedOperator:Bool = false
    var numberOnScreen:String = "0"
    var numberOnMemory:String = "0"
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
        else if hasPressedOperator {
            numberOnScreen = String(sender.tag)
            hasPressedOperator = false
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
        
        //Display the current result on the result area
        resultArea.text = numberOnScreen
        
    }
    
    @IBAction func onFunctionButtonPress(_ sender: UIButton) {
        
        //Case structure to check which function button is being pressed
        switch sender.tag {
        
        //Function Clear
        case functions.clear.rawValue:
            numberOnScreen = "0"
            
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
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
            
        //Operator Divide
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
            
        //Operator Multiply
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
            
        //Operator Subtract
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
        //IMPLEMENT
            
        //Operator Add
        case functions.add.rawValue:
            numberOnMemory = numberOnScreen
            hasPressedOperator = true
            lastOperatorPressed = functions.add.rawValue
            
        //Operator Equals
        case functions.equals.rawValue:
            
            switch lastOperatorPressed {
                
            //Add
            case functions.add.rawValue:
                numberOnScreen = String((Double(numberOnMemory)! + Double(numberOnScreen)!))
                
                if numberOnScreen.suffix(2) == ".0" {
                        numberOnScreen = String(numberOnScreen.prefix(numberOnScreen.count - 2))
                }
            
            //Apparently there has to be a default option for the switch case
            default: break
            }
        
        //Apparently there has to be a default option for the switch case
        default: break
            
        }
        
        //Display the current result on the result area
        resultArea.text = numberOnScreen
        
    }
    
}
