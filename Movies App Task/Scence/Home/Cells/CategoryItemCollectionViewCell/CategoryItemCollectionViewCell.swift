//
//  CategoryItemCollectionViewCell.swift
//  Movies App Task
//
//  Created by Ayman Fathy on 19/12/2025.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with title: String) {
        titleLabel.text = title
    }
}
