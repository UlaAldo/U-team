//
//  OperTabBarViewController.swift
//  U-team
//
//  Created by Юрий Скворцов on 21.02.2022.
//

import UIKit

protocol TabBarViewControllerDelegate {
    func getHistoryList(with operations: [Operation])
}

class OperTabBarViewController: UITabBarController {
    
    var historyList: [Operation] = [] {
        didSet {
            dataTransfer()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataTransfer()
    }
    
    private func dataTransfer() {
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let operationVC = viewController as? OperationViewController {
                operationVC.operations = historyList
                operationVC.delegate = self
            } else if let navigationVC = viewController as? UINavigationController {
                let historyVC = navigationVC.topViewController as! HistoryViewController
                historyVC.historyOperations = historyList
                historyVC.delegate = self
            }
        }
    }
}

extension OperTabBarViewController: TabBarViewControllerDelegate {
    func getHistoryList(with operations: [Operation]) {
        historyList = operations
    }
}

