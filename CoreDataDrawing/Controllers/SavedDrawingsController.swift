//
//  SavedDrawingsController.swift
//  CoreDataDrawing
//
//  Created by Anant Patni on 1/23/23.
//

import Foundation
import UIKit

class SavedDrawingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var savedDrawings = [Drawing]()
    let notificationCenter = NotificationCenter.default
        
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemGray6
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        
        savedDrawings = DataManager.shared.fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SavedDrawingCell.self, forCellReuseIdentifier: SavedDrawingCell.identifier)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedDrawingCell.identifier, for: indexPath) as! SavedDrawingCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white
                
        if let drawingImageData = savedDrawings[indexPath.row].imageData {
            cell.playImageView.image = UIImage(data: drawingImageData)
        }
        cell.playNameLabel.text = String(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedDrawings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let savedDrawing = savedDrawings[indexPath.row]

        var data = [String: Any]()
        data["savedDrawing"] = savedDrawing.drawingData
        notificationCenter.post(name: Notification.Name(Constants.selectedDrawingNotificationCenterKey), object: nil, userInfo: data)

        dismiss(animated: true)
    }
}
