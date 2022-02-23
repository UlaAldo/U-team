//
//  ViewController.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//

import UIKit

class OperationViewController: UIViewController {
    
    // MARK: - IB outlets
    @IBOutlet var operationSegmentedControl: UISegmentedControl!
    
    @IBOutlet var sumView: UIView!
    @IBOutlet var categoryView: UIView!
    @IBOutlet var imageBackgroundView: UIView!
    
    @IBOutlet var categoryImageView: UIImageView!
    
    @IBOutlet var sumTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
    // MARK: - public properties
    var operations: [Operation] = []
    var delegate: OperTabBarViewController!
    
    // MARK: - Private properties
    private var operation: Operation!
    
    private var currentCategories: [String] = []
    private var currentType: OperationType!
    
    private var selectedCategory: String?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumTextField.delegate = self
        categoryTextField.delegate = self
        
        view.backgroundColor = UIColor(red: 0.192, green: 0.208, blue: 0.251, alpha: 1)
        
        sumView.layer.cornerRadius = 8
        categoryImageView.layer.cornerRadius = 8
        categoryView.layer.cornerRadius = 8
        imageBackgroundView.layer.cornerRadius = 8
        addButton.layer.cornerRadius = 30
        
        switchUI()
        choiceCategory()
        setupSegmentedControlTextColor()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let historyVC = navigationVC.topViewController as? HistoryViewController else { return }
        
        historyVC.historyOperations = operations
        historyVC.delegate = delegate
    }
    
    // MARK: - IB Actions
    @IBAction func selectOperationSegment() {
        switchUI()
    }
    
    @IBAction func addButtonPressed() {
        guard let sumText = sumTextField.text else {return}
        guard let category = categoryTextField.text else {return}
        
        if sumText.isEmpty || category.isEmpty {
            showAlert(title: "Неверный ввод!", message: "Проверьте все поля")
            return
        }
        
        guard let sum = Int(sumText) else {return}
        
        switch currentType {
        case .income:
            operation = Operation(sum: sum, type: currentType, category: category)
        case .expense:
            operation = Operation(sum: sum * (-1), type: currentType, category: category)
        case .none:
            showAlert(title: "Что-то пошло не так", message: "Проверьте все поля")
        }
        operations.insert(operation, at: 0)
        delegate.getHistoryList(with: operations)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        sumTextField.text = ""
        categoryTextField.text = ""
        categoryImageView.image = UIImage(named: "")
        
        guard let historyVC = segue.source as? HistoryViewController else { return }
        operations = historyVC.historyOperations
    }
    
    // MARK: - Private methods
    private func choiceCategory() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        categoryTextField.inputView = elementPicker
    }
    
    private func switchUI() {
        categoryImageView.image = UIImage(named: "")
        
        switch operationSegmentedControl.selectedSegmentIndex {
        case 0:
            view.endEditing(true)
            categoryTextField.text = ""
            sumTextField.text = ""
            
            currentCategories = DataManager.share.expenseCategories
            currentType = .expense
            
            setupViewsColor(with: UIColor(red: 0.945, green: 0.906, blue: 0.871, alpha: 1))
            
        default:
            view.endEditing(true)
            categoryTextField.text = ""
            sumTextField.text = ""
            
            currentCategories = DataManager.share.incomeCategories
            currentType = .income
            
            setupViewsColor(with: UIColor(red: 0.910, green: 1, blue: 0.722, alpha: 1))
        }
    }
    
    private func setupSegmentedControlTextColor() {
        let selectedSegmentTextColor = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let unselectedSegmentTextColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        operationSegmentedControl.setTitleTextAttributes(unselectedSegmentTextColor, for: .normal)
        operationSegmentedControl.setTitleTextAttributes(selectedSegmentTextColor, for: .selected)
    }
    
    private func setupViewsColor(with color: UIColor) {
        operationSegmentedControl.selectedSegmentTintColor = color
        sumView.backgroundColor = color
        categoryView.backgroundColor = color
        imageBackgroundView.backgroundColor = color
    }
    
}

// MARK: - Alert Controller
extension OperationViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        present(alert, animated: true)
        alert.addAction(okAction)
    }
}

// MARK: - Extension for PickerView
extension OperationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currentCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currentCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = currentCategories[row]
        categoryTextField.text = selectedCategory
        
        categoryImageView.image = UIImage(named: selectedCategory ?? "")
    }
}
// MARK: - UITextFieldDelegate
extension OperationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        toolbar.items = [flexBarButton, doneButton]
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

