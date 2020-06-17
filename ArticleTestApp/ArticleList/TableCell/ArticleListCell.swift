//
//  ArticleListCell.swift
//  AtticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleLinkLabel: UILabel!

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setArticleData(_ article: Article) {
        userNameLabel.text = article.user?.first?.name
        userDesignationLabel.text = article.user?.first?.designation
        timeLabel.text = "Time "
        
        articleDescriptionLabel.text = article.content
        articleTitleLabel.text = article.media?.first?.title
        articleLinkLabel.text = article.media?.first?.url
        
        likesLabel.text = formatCounts(article.likes ?? 0) + " Likes"
        commentLabel.text = formatCounts(article.comments ?? 0) + " Comments"
    }
    
    private func formatCounts(_ count: Double) -> String {
        if count < 1000 {
            return "\(count)"
        }
        return String(format: "%.2fk", count/1000)
    }
    
}
