//
//  SavedDrawingCell.swift
//  CoreDataDrawing
//
//  Created by Anant Patni on 1/23/23.
//

import UIKit

class SavedDrawingCell: UITableViewCell {
    
    static let identifier = "cellID"
    
    let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.borderWidth = 2.0
        return imageView
    }()
    
    let playNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playImageView)
        contentView.addSubview(playNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 300, height: 180)
        playNameLabel.anchor(top: topAnchor, left: playImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: -10, width: 0, height: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playImageView.image = nil
        playNameLabel.text = nil
    }
}
