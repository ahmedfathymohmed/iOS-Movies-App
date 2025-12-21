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
    
    func setUpCell(with movie: MovieItem) {
        movieNameLabel.text = movie.movieName
        movieYearLabel.text = movie.movieYear
        movieImageView.image = UIImage(named: movie.movieImage)
    }
}
