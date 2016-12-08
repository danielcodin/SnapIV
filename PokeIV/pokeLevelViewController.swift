//
//  pokeLevelViewController.swift
//  SnapIV
//
//  Created by Daniel Tseng on 8/19/16.
//  Copyright © 2016 Daniel Tseng. All rights reserved.
//

import UIKit

class pokeLevelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var protractorImageView: UIImageView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var protractorWidth: NSLayoutConstraint!
    @IBOutlet weak var protractorHeight: NSLayoutConstraint!
    @IBOutlet weak var protractorY: NSLayoutConstraint!
    @IBOutlet weak var protractorX: NSLayoutConstraint!
    
    @IBOutlet weak var trainerLevelLabel: UILabel!
    @IBOutlet weak var arcLevelLabel: UILabel!
    @IBOutlet weak var trainerLevelTextField: UITextField!
    @IBOutlet weak var arcLevelTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    // get data
    var data = Data()
    
    // get device
    let deviceName:String = UIDevice.current.modelName
    
    //set up picker view
    var trainerPickerView = UIPickerView()
    var arcPickerView = UIPickerView()
    let trainerOption = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"]
    var arcOption: [String] = []
    
    var trainerLevel: Int!
    var currentTextField:UITextField!
    
    let defaults = UserDefaults.standard
    
    // language
    var language:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set Image
        self.pokemonImageView.image = data.originImage
        
        self.resetProtractorConstraints()
        
        self.updateProtractorConstraints()
        
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
        
        //set delegate
        trainerPickerView.delegate = self
        arcPickerView.delegate = self
        trainerLevelTextField.inputView = trainerPickerView
        arcLevelTextField.inputView = arcPickerView
        
        if defaults.integer(forKey: "trainerLevel") == 0 {
            trainerPickerView.selectRow(19, inComponent: 0, animated: false)
            trainerLevelTextField.text = "20"
            trainerLevel = trainerPickerView.selectedRow(inComponent: 0) + 1
        } else {
            trainerLevel = defaults.integer(forKey: "trainerLevel")
            trainerPickerView.selectRow(trainerLevel-1, inComponent: 0, animated: false)
            trainerLevelTextField.text = "\(trainerLevel!)"
        }
        
        // change protractor image
        self.protractorImageView.image = UIImage(named: "lvl\(trainerLevel!)")
        
        for i in data.possibleLevels as NSArray {
            arcOption.append(i as! String)
        }
        
        arcPickerView.selectRow(0, inComponent: 0, animated: false)
        arcLevelTextField.text = arcOption[0]
        
        // keyboard show hide
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // tool bar
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let negativeSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = 5.0
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.doneButton_Clicked))
        
        toolbarDone.items = [flexSpace, barBtnDone, negativeSpace]
        trainerLevelTextField.inputAccessoryView = toolbarDone
        arcLevelTextField.inputAccessoryView = toolbarDone
        
        // get current language
        self.language = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)! as! String
        if language == "zh" {
            self.language = "zh-Hant"
        } else {
            self.language = "en"
        }
        
        // set title
        self.trainerLevelLabel.text = "trainerLevel_title".localized(self.language!)
        self.arcLevelLabel.text = "arcLevel_title".localized(self.language!)
        self.nextButton.setTitle("next_button".localized(self.language!), for: UIControlState())
        self.cancelButton.setTitle("cancel_button".localized(self.language!), for: UIControlState())
        self.resetButton.setTitle("reset_button".localized(self.language!), for: UIControlState())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func doneButton_Clicked() {
        self.trainerLevelTextField.resignFirstResponder()
        self.arcLevelTextField.resignFirstResponder()
    }
    
    func keyboardWillShow(_ sender: Notification) {
        //let info = sender.userInfo!
        //let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = -130
        })
    }
    
    func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame.origin.y = 0
        })
    }
    
    @IBAction func upButtonPressed(_ sender: AnyObject) {
        protractorY.constant -= 2
        defaults.set(protractorY.constant, forKey: "protractorY")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func downButtonPressed(_ sender: AnyObject) {
        protractorY.constant += 2
        defaults.set(protractorY.constant, forKey: "protractorY")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func leftButtonPressed(_ sender: AnyObject) {
        protractorX.constant -= 2
        defaults.set(protractorX.constant, forKey: "protractorX")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func rightButtonPressed(_ sender: AnyObject) {
        protractorX.constant += 2
        defaults.set(protractorX.constant, forKey: "protractorX")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func increaseButtonPressed(_ sender: AnyObject) {
        protractorWidth.constant += 4
        protractorHeight.constant += 2.25
        defaults.set(protractorWidth.constant, forKey: "protractorWidth")
        defaults.set(protractorHeight.constant, forKey: "protractorHeight")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func decreaseButtonPressed(_ sender: AnyObject) {
        protractorWidth.constant -= 4
        protractorHeight.constant -= 2.25
        defaults.set(protractorWidth.constant, forKey: "protractorWidth")
        defaults.set(protractorHeight.constant, forKey: "protractorHeight")
        self.view.updateConstraintsIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    
    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == trainerPickerView {
            return trainerOption.count
        } else if pickerView == arcPickerView {
            return arcOption.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == trainerPickerView {
            return trainerOption[row]
        } else if pickerView == arcPickerView {
            return arcOption[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == trainerPickerView {
            trainerLevelTextField.text = String(row+1)
            trainerLevel = row + 1
            
            defaults.set(trainerLevel, forKey: "trainerLevel")
            
            // change protractor image
            self.protractorImageView.image = UIImage(named: "lvl\(trainerLevel!)")
        } else if pickerView == arcPickerView {
            arcLevelTextField.text = arcOption[row]
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: AnyObject) {
        // stored value
        data.skipped = false
        data.arcLevel = Double(self.arcLevelTextField.text!)
        data.fromArc = true
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        next.data = data
        let next1 = UINavigationController(rootViewController: next)
        
        self.present(next1, animated: true, completion: nil)
    }
    
    @IBAction func skipButtonPressed(_ sender: AnyObject) {
        // stored value
        data.skipped = true
        data.fromArc = false
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        next.data = data
        let next1 = UINavigationController(rootViewController: next)
        
        self.present(next1, animated: true, completion: nil)
    }
    
    func updateProtractorConstraints() {
        if defaults.object(forKey: "protractorX") != nil {
            self.protractorX.constant = defaults.object(forKey: "protractorX") as! CGFloat
        }
        if defaults.object(forKey: "protractorY") != nil {
            self.protractorY.constant = defaults.object(forKey: "protractorY") as! CGFloat
        }
        if defaults.object(forKey: "protractorWidth") != nil {
            self.protractorWidth.constant = defaults.object(forKey: "protractorWidth") as! CGFloat
        }
        if defaults.object(forKey: "protractorHeight") != nil {
            self.protractorHeight.constant = defaults.object(forKey: "protractorHeight") as! CGFloat
        }
    }
    
    func resetProtractorConstraints() {
        if deviceName == "iPhone 6" || deviceName == "iPhone 6s" {
            protractorX.constant = 0.0
            protractorY.constant = -27.0
            protractorWidth.constant = 383.0
            protractorHeight.constant = 262.5
        } else if deviceName.contains("Plus") {
            // iphone 6 plus
            protractorX.constant = 0.0
            protractorY.constant = -25.0
            protractorWidth.constant = 423.0
            protractorHeight.constant = 284.5
        } else if deviceName.contains("iPad"){
            // iPad
            protractorX.constant = 0.0
            protractorY.constant = -17.0
            protractorWidth.constant = 583.0
            protractorHeight.constant = 374.5
        } else {
            //iphone 5
            protractorX.constant = 0.0
            protractorY.constant = -29.0
            protractorWidth.constant = 323.0
            protractorHeight.constant = 228.25
        }
        defaults.set(protractorX.constant, forKey: "protractorX")
        defaults.set(protractorY.constant, forKey: "protractorY")
        defaults.set(protractorWidth.constant, forKey: "protractorWidth")
        defaults.set(protractorHeight.constant, forKey: "protractorHeight")
    }
    
    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        self.resetProtractorConstraints()
    }
}

