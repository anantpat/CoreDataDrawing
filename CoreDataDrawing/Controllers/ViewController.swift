//
//  ViewController.swift
//  CoreDataDrawing
//
//  Created by Anant Patni on 1/23/23.
//

import UIKit
import PencilKit
import CoreData

class ViewController: UIViewController {
    
    let toolPicker = PKToolPicker()
    let notificationCenter = NotificationCenter.default
    
    private let drawingView: PKCanvasView = {
        let drawingView = PKCanvasView()
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        drawingView.drawingPolicy = .anyInput
        return drawingView
    }()
    
    private let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        sv.alignment = .center
        return sv
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    private let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fetch", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleFetch), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        
        notificationCenter.addObserver(self, selector: #selector(handleSelectedDrawing), name: Notification.Name(rawValue: Constants.selectedDrawingNotificationCenterKey), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupToolkit()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(drawingView)
        drawingView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(buttonStackView)
        buttonStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, width: 0, height: 100)
        
        buttonStackView.addArrangedSubview(deleteButton)
        buttonStackView.addArrangedSubview(saveButton)
        buttonStackView.addArrangedSubview(fetchButton)
    }
    
    private func setupToolkit() {
        toolPicker.addObserver(drawingView)
        toolPicker.setVisible(true, forFirstResponder: drawingView)
        drawingView.becomeFirstResponder()
    }
}

extension ViewController {
    
    @objc func handleDelete() {
        drawingView.drawing = PKDrawing()
    }
    
    @objc func handleSave() {
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        guard let imageData = image.pngData() else { return }
        
        DataManager.shared.saveData(drawingData: drawingView.drawing.dataRepresentation(), imageData: imageData)
    }
    
    @objc func handleFetch() {
        let savedDrawingsController = SavedDrawingsController()
        present(savedDrawingsController, animated: true)
    }
    
    @objc func handleSelectedDrawing(notification: Notification) {
        if let userInfo = notification.userInfo {
            print("USER INFO:", userInfo)
            if let drawingData = userInfo["savedDrawing"] as? Data {
                do {
                    let drawing = try PKDrawing(data: drawingData)
                    drawingView.drawing = drawing
                } catch {
                    print("Conversion from data to drawing failed.")
                }
            }
        }
    }
}
