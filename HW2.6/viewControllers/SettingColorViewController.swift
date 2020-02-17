//
//  ViewController.swift
//  HW2.6
//
//  Created by Алексей Маслобоев on 31.01.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

final class SettingColorViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var redTitleLabel: UILabel!
    @IBOutlet weak var greenTitleLabel: UILabel!
    @IBOutlet weak var blueTitleLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var colorView: UIView!
    
    // MARK: - Public Properties
    
    var delegate: SettingColorDelegate!
    var selectedColor: UIColor = .white
    
    // MARK: - Private Properties
    
    private let digitalFont = UIFont.monospacedDigitSystemFont(
        ofSize: 14,
        weight: .regular
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupSuperView()
        setupColorView()
        setupLabels()
        setupTitleLabels()
        setupTextFields()
        setupSliders()
        
        selectColor()
        changeColor()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func changeColorAction() {
        changeColor()
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        delegate.setColor(colorView.backgroundColor ?? .white)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupSuperView() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0.3352792761, blue: 0.7432041952, alpha: 1)
    }
    
    private func setupColorView() {
        colorView.layer.cornerRadius = 20
    }
    
    private func setupLabels() {
        setupLabel(redLabel)
        setupLabel(greenLabel)
        setupLabel(blueLabel)
    }
    
    private func setupLabel(_ label: UILabel) {
        label.font = digitalFont
        label.textColor = .white
    }
    
    private func setupTitleLabels() {
        redTitleLabel.textColor = .white
        greenTitleLabel.textColor = .white
        blueTitleLabel.textColor = .white
    }
    
    private func setupTextFields() {
        setupTextField(redTextField)
        setupTextField(greenTextField)
        setupTextField(blueTextField)
    }
    
    private func setupTextField(_ textField: UITextField) {
        textField.backgroundColor = .white
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.font = digitalFont
        textField.delegate = self
        textField.doneAccessory = true
    }
    
    private func setupSliders() {
        setupSlider(slider: redSlider, color: .red)
        setupSlider(slider: greenSlider, color: .green)
        setupSlider(slider: blueSlider, color: .blue)
    }
    
    private func setupSlider(slider: UISlider, color: UIColor) {
        slider.minimumTrackTintColor = color
        slider.maximumTrackTintColor = .lightGray
        
    }
    
    private func selectColor() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        selectedColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        redSlider.setValue(Float(red), animated: false)
        greenSlider.setValue(Float(green), animated: false)
        blueSlider.setValue(Float(blue), animated: false)
    }
    
    private func changeColor() {
        changeText()
        
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
    }
    
    private func changeText() {
        changeTextLabel()
        changeTextField()
    }
    
    private func changeTextLabel() {
        let redText = floatString(redSlider.value)
        let greenText = floatString(greenSlider.value)
        let blueText = floatString(blueSlider.value)
        
        redLabel.text = redText
        greenLabel.text = greenText
        blueLabel.text = blueText
    }
    
    private func changeTextField() {
        let redText = floatString(redSlider.value)
        let greenText = floatString(greenSlider.value)
        let blueText = floatString(blueSlider.value)
        
        redTextField.text = redText
        greenTextField.text = greenText
        blueTextField.text = blueText
    }
    
    private func changeSliderValue() {
        guard let redField = redTextField.text else { return }
        guard let greenField = greenTextField.text else { return }
        guard let blueField = blueTextField.text else { return }
        
        if let red = Float(redField), let green = Float(greenField), let blue = Float(blueField)  {
            redSlider.setValue(red, animated: true)
            greenSlider.setValue(green, animated: true)
            blueSlider.setValue(blue, animated: true)
        }
        else{
            showError("Убедитесь, что вы вводите дробное число без ошибок")
        }
        
        changeColor()
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func floatString(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
}

// MARK: - Text Field Delegate

extension SettingColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeSliderValue()
    }
    
}
