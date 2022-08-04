//
//  UiTableViewCell.swift
//  RSSProject
//
//  Created by Brendon Sambatti on 03/08/22.
//

import UIKit

class UiTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var noticeImage: UIImageView!
    
    static let identifier:String = "UiTableViewCell"
    
    static func nib()->UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    var item:RSSItem?{
        didSet{
            titleLabel.text = item?.title
            pubDateLabel.text = item?.pubDate
            let description = item?.description
            let descriptionSliced = description?.slice(from: "<br />", to: ".")
            self.descriptionLabel.text = descriptionSliced
            let urlImage = item?.description ?? ""
            let sliced  = urlImage.slice(from: "https:", to: ".jpg") ?? ""
            let urlString:String = "https:\(sliced).jpg"
            guard let url = URL(string: urlString) else{
                return
            }
            self.noticeImage.load(url: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: true)
    }
    
}
