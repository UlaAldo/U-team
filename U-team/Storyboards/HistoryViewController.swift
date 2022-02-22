//
//  HistoryViewController.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//

import UIKit


class HistoryViewController: UITableViewController {
 
// MARK: - IB Outlets
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var operation: Operation!
    
    var delegate: OperTabBarViewController!
    
    var historyOperations: [Operation] = []
    
    
// MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = 80
        view.backgroundColor = UIColor(red: 0.192, green: 0.208, blue: 0.251, alpha: 1)
        
        balanceLabel.text = "Баланс: \(getSumTest()) ₽"
        balanceLabel.backgroundColor = UIColor(red: 0.424, green: 0.457, blue: 0.55, alpha: 1)
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .white
        
//        белый цвет текста в segmentControl
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.424, green: 0.457, blue: 0.55, alpha: 1)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }


// MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
             return historyOperations.count
        case 1:
           return historyOperations.filter{$0.type == .expense}.count
        default:
            return historyOperations.filter{$0.type == .income}.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        var myCell = historyOperations[indexPath.row]
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            myCell = historyOperations[indexPath.row]
            balanceLabel.text = "Баланс: \(getSumTest()) ₽"
        case 1:
            myCell = historyOperations.filter{$0.type == .expense}[indexPath.row]
            balanceLabel.text = "Расход: \(getSumExpense()) ₽"
        default:
            myCell = historyOperations.filter{$0.type == .income}[indexPath.row]
            balanceLabel.text = "Доход: \(getSumIncome()) ₽"
        }
        
        if myCell.type == .income {
            cell.backgroundColor = UIColor(red: 0.911, green: 1, blue: 0.721, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 0.946, green: 0.907, blue: 0.871, alpha: 1)
        }
        
        content.text = myCell.category
        content.secondaryText = "\(format(for: myCell.sum)) ₽"
        content.secondaryTextProperties.font = .systemFont(ofSize: 35)
        content.secondaryTextProperties.color = .black
        content.image = UIImage(named: myCell.category)
        
        cell.contentConfiguration = content
        return cell
    }
    
    //    функция удаления ячеек
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            historyOperations.remove(at: indexPath.row)
            self.tableView.reloadData()
            balanceLabel.text = "Баланс: \(getSumTest()) ₽"
            
            delegate.getHistoryList(with: historyOperations)
        }
    }
// MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // округление углов ячейки + расстояние между ячейками
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                 y: cell.bounds.origin.y,
                                 width: cell.bounds.width,
                                 height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }

// MARK: - IB Action
    @IBAction func choiceSegment() {
        self.tableView.reloadData()
    }
    
// MARK: - Private Method
    

    //    функция добавления разделителя тысяч в Int
    private func format(for num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: num) ?? "\(num)"
        }
    
    // функции для подсчета баланса
    private func getSumTest() -> String {
        let sum = historyOperations.map{$0.sum}.reduce(0, +)
        return format(for: sum)
        }
    private func getSumExpense() -> String {
        let sum = historyOperations.filter{$0.type == .expense}.map{$0.sum}.reduce(0, +)
        return format(for: sum)
        }
    private func getSumIncome() -> String {
        let sum = historyOperations.filter{$0.type == .income}.map{$0.sum}.reduce(0, +)
        return format(for: sum)
        }

}

