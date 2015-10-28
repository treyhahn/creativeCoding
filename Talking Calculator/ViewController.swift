//
//  ViewController.swift
//  Talking Calculator
//
//  Created by Trey Hahn on 10/23/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - Variables
    //MARK: General
    var total:Int = 0
    var mode:Int = 0
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    var count:Bool = true
    var daytime:Bool = true
    var edgeCaseEquals = false
    
    
    var myLanguage: String = ""
    let englishLang = "en-US"
    let spanishLang = "es-MX"
    let portugueseLang = "pt-BR"
    
    let mySpeechSynth = AVSpeechSynthesizer()
    //MARK: Buttons
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nighttime: UIButton!
    @IBOutlet weak var wildcard: UIButton!
    
    //MARK: Calculator Buttons
    @IBOutlet var numberCollection: [UIButton]!
    @IBOutlet var operationCollection: [UIButton]!
    
    //MARK: - Functions
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "WELCOME!!!!"
        speakThisPhrase("Welcome to World Calc! Select a language and calculate away.")
        myLanguage = englishLang
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Display Modes
    @IBAction func nighttimePressed(sender: UIButton) {
        if (count) {
            view.backgroundColor = UIColor(white: 0.1, alpha: 0.9)
            
            for index in numberCollection {
                index.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
                index.backgroundColor = UIColor(white: 0.5, alpha: 1)
            }
            for index in operationCollection {
                index.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
                index.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.7, alpha: 1)
            }
            
            label.textColor = UIColor(white: 1, alpha: 1)
            
            nighttime.setTitle("Nighttime", forState: .Normal)
            nighttime.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
            wildcard.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
            myLanguage = spanishLang
            
        } else
        {
            view.backgroundColor = UIColor(white: 1, alpha: 1)
            for index in numberCollection {
                index.setTitleColor(UIColor(white: 0, alpha: 1), forState: .Normal)
                index.backgroundColor = UIColor(white: 0.5, alpha: 1)
            }
            for index in operationCollection {
                index.setTitleColor(UIColor(white: 0, alpha: 1), forState: .Normal)
                index.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.7, alpha: 1)
            }
            label.textColor = UIColor(white: 0, alpha: 1)
            
            nighttime.setTitle("Daytime", forState: .Normal)
            nighttime.setTitleColor(UIColor(white: 0, alpha: 1), forState: .Normal)
            wildcard.setTitleColor(UIColor(white: 0, alpha: 1), forState: .Normal)
            myLanguage = englishLang
        }
        if (count == true) {
            count = false
        } else {
            count = true
        }
        
    }
    
    @IBAction func wildcard(sender: UIButton) {
        view.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1)
        for index in numberCollection {
            index.setTitleColor(UIColor(red: 0.1, green: 0.9, blue: 0.2, alpha: 1), forState: .Normal)
            index.backgroundColor = UIColor(white: 1, alpha: 1)
        }
        for index in operationCollection {
            index.setTitleColor(UIColor(red: 0.9, green: 0.1, blue: 0.2, alpha: 1), forState: .Normal)
            index.backgroundColor = UIColor(white: 1, alpha: 1)
        }
        
        label.textColor = UIColor(white: 1, alpha: 1)
        
        nighttime.setTitle("Nighttime", forState: .Normal)
        nighttime.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
        wildcard.setTitleColor(UIColor(white: 1, alpha: 1), forState: .Normal)
        myLanguage = portugueseLang
    }
    
    //MARK: Talking
    
    func speakThisPhrase(passedString: String){
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = 0.5
        
        myUtterance.voice = AVSpeechSynthesisVoice(language: myLanguage)
        
        
        mySpeechSynth.speakUtterance(myUtterance)
        
    }
    
    //MARK: Calculator Functions
    
    @IBAction func tappedNumber(sender: UIButton) {
        if edgeCaseEquals {
            edgeCaseEquals = false
            valueString = ""
        }
        let str:String! = sender.titleLabel!.text
        let num:Int! = Int(str)!
        if (num == 0 && total == 0)
        {
            return
        }
        if (lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
        }
        valueString = valueString.stringByAppendingString(str)
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        
        if (total == 0)
        {
            total = Int(valueString)!
        }
        speakThisPhrase(label.text!)
    }
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
        if myLanguage == englishLang {
            speakThisPhrase("clear")
        } else if myLanguage == spanishLang {
            speakThisPhrase("borrar")
        } else if myLanguage == portugueseLang {
            speakThisPhrase("deletar")
        }
    }
    @IBAction func tappedPlus(sender: AnyObject) {
        self.doMode(1)
        if myLanguage == englishLang {
            speakThisPhrase("plus")
        } else if myLanguage == spanishLang {
            speakThisPhrase("más")
        } else if myLanguage == portugueseLang {
            speakThisPhrase("mais")
        }
    }
    @IBAction func tappedMinus(sender: AnyObject) {
        self.doMode(-1)
        if myLanguage == englishLang {
            speakThisPhrase("minus")
        } else if myLanguage == spanishLang {
            speakThisPhrase("menos")
        } else if myLanguage == portugueseLang {
            speakThisPhrase("menos")
        }
    }
    @IBAction func tappedMultiply(sender: UIButton) {
        doMode(2)
        if myLanguage == englishLang {
            speakThisPhrase("times")
        } else if myLanguage == spanishLang {
            speakThisPhrase("por")
        } else if myLanguage == portugueseLang {
            speakThisPhrase("por")
        }
    }
    @IBAction func tappedEquals(sender: AnyObject) {
        if (mode == 0)
        {
            return
        }
        let iNum:Int = Int(valueString)!
        if (mode == 1)
        {
            total += iNum
        }
        if (mode == -1)
        {
            total -= iNum
        }
        if (mode == 2)
        {
            total *= iNum
        }
        valueString = "\(total)"
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        mode = 0
        edgeCaseEquals = true
        if myLanguage == englishLang {
            speakThisPhrase("equals")
        } else if myLanguage == spanishLang {
            speakThisPhrase("igual a")
        } else if myLanguage == portugueseLang {
            speakThisPhrase("igual a")
        }
        speakThisPhrase(label.text!)
    }
    
    func doMode (m:Int) {
        if (total == 0)
        {
            return
        }
        mode = m
        lastButtonWasMode = true
        total = Int(valueString)!
    }
    
}
