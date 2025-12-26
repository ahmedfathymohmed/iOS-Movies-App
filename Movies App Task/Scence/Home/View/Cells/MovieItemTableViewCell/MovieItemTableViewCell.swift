//
//  MovieItemTableViewCell.swift
//  Movies App Task
//
//  Created by Ayman Fathy on 19/12/2025.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(with movie: Movie) {
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.releaseDate
//        movieImageView.image = UIImage(named: movie.movieImage)
    }
}
