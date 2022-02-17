//
//  TeamViewController.swift
//  U-team
//
//  Created by Юлия Алдохина on 11/02/22.
//

import UIKit

class TeamViewController: UIViewController {

    
    @IBOutlet var projectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectButton.layer.cornerRadius = 10
    }
}
