//
//  ReadMoreViewController.swift
//  RSSProject
//
//  Created by Brendon Sambatti on 03/08/22.
//

import UIKit

class ReadMoreViewController: UIViewController {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
