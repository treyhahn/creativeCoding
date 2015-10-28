//
//  ViewController.swift
//  Talking Calculator
//
//  Created by Trey Hahn on 10/23/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    //MARK: - Variables
    //MARK: Calculator
    var total:Int = 0
    var mode:Int = 0
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    var count:Bool = true
    var daytime:Bool = true
    var edgeCaseEquals = false
    
    //MARK: Speaking
    var myLanguage = ("en-US", "English","United States","American English ","🇺🇸")
    var myRate: Float = 0.37
    var myPitch: Float = 0.85
    var myVolume: Float = 1
    let mySpeechSynth = AVSpeechSynthesizer()
    
    var speakSymbol = ""
    
    //MARK: Dataset
    var langCodeAll38 = [
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Português","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Português","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
    //MARK: Buttons
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nighttime: UIButton!
    @IBOutlet weak var wildcard: UIButton!
    @IBOutlet weak var languagePicker: UIPickerView!
    
    //MARK: Calculator Buttons
    @IBOutlet var numberCollection: [UIButton]!
    @IBOutlet var operationCollection: [UIButton]!
    
    //MARK: - Functions
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.selectRow(5, inComponent: 0, animated: true)
        
        
        label.text = "WELCOME!!!!"
        speakThisPhrase("Welcome to World Calc! Select a language and calculate away.")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Picker View
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLanguage = langCodeAll38[row]
        speakThisString()
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
            languagePicker.backgroundColor = UIColor(white: 1, alpha: 0.5)
            
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
            languagePicker.backgroundColor = UIColor(white: 1, alpha: 0)
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
        
        languagePicker.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    //MARK: Talking
    
    func speakThisPhrase(passedString: String){
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = 0.5
        
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        mySpeechSynth.speakUtterance(myUtterance)
        
    }
    
    func speakThisString(){
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: myLanguage.3)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: myLanguage.0)
        mySpeechSynth.speakUtterance(myUtterance)
        
    }
    
    func speakThisNumber() {
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: label.text!)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: myLanguage.0)
        mySpeechSynth.speakUtterance(myUtterance)
    }
    
    func speakThisEquals() {
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: "Equals " + label.text!)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: myLanguage.0)
        mySpeechSynth.speakUtterance(myUtterance)
    }

    func speakThisSymbol() {
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        let myUtterance = AVSpeechUtterance(string: speakSymbol)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: myLanguage.0)
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
        speakThisNumber()
    }
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
        speakSymbol = "Clear"
        speakThisSymbol()
    }
    @IBAction func tappedPlus(sender: AnyObject) {
        self.doMode(1)
        speakSymbol = "Plus"
        speakThisSymbol()
    }
    @IBAction func tappedMinus(sender: AnyObject) {
        self.doMode(-1)
        speakSymbol = "Minus"
        speakThisSymbol()
    }
    @IBAction func tappedMultiply(sender: UIButton) {
        doMode(2)
        speakSymbol = "Times"
        speakThisSymbol()
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
        speakThisEquals()
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
