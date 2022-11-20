//
//  ViewController.swift
//  GridViewDemo
//
//  Created by Aaron on 2022/11/19.
//

import UIKit

class GridViewDemoViewController: UIViewController {
    let frameworks: [AppleFrameworkModel] = AppleFrameworkModel.list
    
    // Datasource
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = AppleFrameworkModel
    enum Section {
        case main
    }
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCollectionViewCell", for: indexPath) as? GridViewCollectionViewCell else {
                return nil
            }
            cell.configigure(item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(frameworks, toSection: .main)
        
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
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
        let framework = frameworks[indexPath.item]
        print(">>> Selected: \(framework.name)")
    }
}
