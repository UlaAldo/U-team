//
//  TeamViewController.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//

import UIKit

class TeamViewController: UIViewController {

    @IBOutlet var projectLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectLabel.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 0.946, green: 0.907, blue: 0.871, alpha: 1)

    }
    
}
