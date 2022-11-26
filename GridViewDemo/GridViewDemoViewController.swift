//
//  ViewController.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/19.
//

import UIKit
import Combine

class GridViewDemoViewController: UIViewController {
//    @Published var frameworks: [AppleFrameworkModel] = AppleFrameworkModel.list
    let frameworks = CurrentValueSubject<[Item], Never>(AppleFrameworkModel.list)
    
    // Datasource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = AppleFrameworkModel
    enum Section {
        case main
    }
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<Item, Never>()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionView Presentaation, Layout 설정
        configureCollectionView()
        
        // CollectionView 그리는데 필요한 Data 설정
//        applySectionItems(frameworks, to: .main)
        
        bind()
     }
    
    private func bind() {
        // input: 사용자 입력을 받아서 처리해야할 것
        // - item 선택 되었을 때 처리
        didSelect
            .receive(on: RunLoop.main)
            .sink { item in
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
         
                viewController.framework.send(item)
    
            self.present(viewController, animated: true)
        }.store(in: &subscriptions)
        
        // output: data, state 변경에 따라서 UI 업데이트할 것
        // - items(frameworks)가 설정되었을 때 view를 업데이트
        frameworks
            .receive(on: RunLoop.main)
            .sink { list in
            self.applySectionItems(list)
        }.store(in: &subscriptions)
    }
    
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        // data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func configureCollectionView() {
        // presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCollectionViewCell", for: indexPath) as? GridViewCollectionViewCell else {
                return nil
            }
            cell.configigure(item)
            return cell
        })
        
        // layer
        collectionView.collectionViewLayout = layout()
        
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension GridViewDemoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let framework = frameworks[indexPath.item]
        let framework = frameworks.value[indexPath.item]
        print(">>> Selected: \(framework.name)")
        didSelect.send(framework)
    }
}
