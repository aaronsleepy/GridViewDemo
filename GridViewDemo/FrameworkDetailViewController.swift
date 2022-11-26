//
//  FrameworkDetailViewController.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/24.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
    var framework: AppleFrameworkModel = AppleFrameworkModel(name: "Unknown", imageName: "", urlString: "", description: "")
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let buttonTapped = PassthroughSubject<AppleFrameworkModel, Never>()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
        bind()
    }
    
    private func bind() {
        // input: Button tapped
        // framework -> url -> safari -> present
        buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { framework in
            URL(string: framework.urlString)
        }
        .sink { url in
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true)
        }.store(in: &subscriptions)
        
        // output: Data 설정될 때 UI 업데이트
    }
    
    func updateUI() {
        imageView.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        buttonTapped.send(framework)
    }
    
    
}
