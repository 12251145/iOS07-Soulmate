//
//  DefaultLoadChattingsUseCase.swift
//  Soulmate
//
//  Created by Hoen on 2022/11/21.
//

import Combine

final class DefaultLoadChattingsUseCase: LoadChattingsUseCase {
    
    private var data: [Chat] = [
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!"),
        Chat(isMe: true, text: "VI?"),
        Chat(isMe: false, text: "Cupcake!\nCupcake!"),
        Chat(isMe: true, text: "VI?")
    ]
    
    var loadedNewChattings = PassthroughSubject<Bool, Never>()
    var loadedChattings = CurrentValueSubject<[Chat], Never>([])
    
    func loadChattings() {
        loadedChattings.send(data)
        loadedNewChattings.send(true)
    }
    
    func testLoad() {
        var current = loadedChattings.value
        let new = current + [Chat(isMe: false, text: "Cupcake!")]
        
        loadedChattings.send(new)
        loadedNewChattings.send(true)
    }
}
