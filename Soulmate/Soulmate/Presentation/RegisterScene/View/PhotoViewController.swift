//
//  PhotoViewController.swift
//  Soulmate
//
//  Created by termblur on 2022/11/17.
//

import UIKit

import SnapKit

final class PhotoViewController: UIViewController {
    let imagePicker = UIImagePickerController()
    
    var viewModel: RegisterPhotoViewModel?
    
    lazy var registerHeaderStackView: RegisterHeaderStackView = {
        let headerView = RegisterHeaderStackView(frame: .zero)
        headerView.setMessage(
            guideText: "회원님의 사진을\n업로드해주세요.",
            descriptionText: "얼굴이 잘 나온 사진을 업로드해주세요."
        )
        view.addSubview(headerView)
        return headerView
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(AddPhotoCell.self, forCellWithReuseIdentifier: "AddPhotoCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.bounces = false
        cv.isPagingEnabled = false
        cv.backgroundColor = .clear
        
        self.view.addSubview(cv)
        return cv
    }()
    
    private lazy var startButton: GradientButton = {
        let button = GradientButton(title: "시작하기")
        self.view.addSubview(button)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(viewModel: RegisterPhotoViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLayout()
        bind()
    }
}

private extension PhotoViewController {
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        let output = viewModel.transform(
            input: RegisterPhotoViewModel.Input (

            )
        )
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
    }
    
    private func configureLayout() {
        registerHeaderStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(184)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(208.5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(33)
            $0.height.equalTo(54)
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath) as? AddPhotoCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        let height: CGFloat
        
        if indexPath.item == 0 || indexPath.item == 1 {
            width = 171.5
            height = 171.5
            collectionView.contentInset = centerItemsInCollectionView(cellWidth: width, numberOfItems: 2, spaceBetweenCell: 10, collectionView: collectionView)
        } else {
            width = 112
            height = 112
            collectionView.contentInset = centerItemsInCollectionView(cellWidth: width, numberOfItems: 3, spaceBetweenCell: 10, collectionView: collectionView)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AddPhotoCell else { return }
        
    }
    
    private func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
    }
}

#if DEBUG
import SwiftUI
struct PhotoViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        PhotoViewController()
    }
    @available(iOS 13.0, *)
    struct SnapKitVCRepresentable_PreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                PhotoViewControllerRepresentable()
                    .ignoresSafeArea()
                    .previewDisplayName("Preview")
                    .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            }
        }
    }
} #endif
