//
//  NewsTableViewCell.swift
//  News
//
//  Created by Juan Diego Marin on 5/11/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOutlets Properties
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var storyTitleLable: UILabel!
    @IBOutlet weak var storyUrlLabel: UILabel!
    
    var news: Hits? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup() {
        authorLabel.text = news?.author
        storyTitleLable.text = news?.story_title
        storyUrlLabel.text = news?.story_url
        storyUrlLabel.numberOfLines = 1
    }
    
}
