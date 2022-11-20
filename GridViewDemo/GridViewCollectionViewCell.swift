//
//  GridViewCollectionViewCell.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/20.
//

import UIKit

class GridViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configigure(_ framework: AppleFrameworkModel) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
