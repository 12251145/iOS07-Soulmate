//
//  ReceivedChatRequestCell.swift
//  Soulmate
//
//  Created by Hoen on 2022/11/24.
//

import UIKit

final class ReceivedChatRequestCell: UITableViewCell {
    
    static let id = String(describing: ReceivedChatRequestCell.self)
    
    private lazy var receivedChatRequestView: ReceivedChatRequestView = {
        let requestView = ReceivedChatRequestView()
        contentView.addSubview(requestView)
        requestView.translatesAutoresizingMaskIntoConstraints = false
        
        return requestView
    }()
    
    private lazy var separator: UIView = {
        let line = UIView()
        contentView.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .labelGrey
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightPurple
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with request: ReceivedRequest) {
        receivedChatRequestView.configure(with: request)
        
    }
}

private extension ReceivedChatRequestCell {
    func configureLayout() {
        receivedChatRequestView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(14)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-14)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
        
        separator.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
        }
    }
}
