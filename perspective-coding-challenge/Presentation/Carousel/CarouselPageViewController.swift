//
//  CarouselPageViewController.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import UIKit

class CarouselPageViewController: UIViewController {

    // MARK: - Views
    private lazy var viewContent = UIView()

    private lazy var imgPicture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "pokeapi_logo")
        return view
    }()

    private lazy var lblName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    // MARK: - Properties
    let index: Int

    // MARK: - Init
    init(_ index: Int, model: Pokemon) {
        self.index = index
        super.init(nibName: nil, bundle: nil)

        setupViews(with: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
    }

    // MARK: - Setup
    private func setupViews(with model: Pokemon) {
        view.backgroundColor = .systemBackground
        if let imageUrl = model.imageUrl {
            Task {
                let imageData = try await URLSession.shared.data(from: imageUrl).0
                imgPicture.image = UIImage(data: imageData)
            }
        }
        lblName.text = model.name.capitalized
    }

    private func layoutViews() {
        view.addSubview(viewContent)
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewContent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewContent.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        viewContent.addSubview(imgPicture)
        imgPicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgPicture.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            imgPicture.centerYAnchor.constraint(equalTo: viewContent.centerYAnchor),
            imgPicture.heightAnchor.constraint(equalToConstant: 160),
            imgPicture.widthAnchor.constraint(equalToConstant: 160)
        ])

        viewContent.addSubview(lblName)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor),
            lblName.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor),
            lblName.topAnchor.constraint(equalTo: imgPicture.bottomAnchor, constant: 16)
        ])
    }
}
