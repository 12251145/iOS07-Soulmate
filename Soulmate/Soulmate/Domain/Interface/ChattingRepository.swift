//
//  ChattingRepository.swift
//  Soulmate
//
//  Created by Hoen on 2022/12/06.
//

import FirebaseFirestore

protocol ChattingRepository {
    var startDocument: QueryDocumentSnapshot? { get }
    var lastDocument: QueryDocumentSnapshot? { get }
    
    func setStartDocument(_ doc: QueryDocumentSnapshot?)
    func setLastDocument(_ doc: QueryDocumentSnapshot?)
    
    func loadReadChattings(from chatRoomId: String) async -> [MessageInfoDTO]
    func loadUnReadChattings(from chatRoomId: String) async -> [MessageInfoDTO]
    func loadPrevChattings(from chatRoomId: String) async -> [MessageInfoDTO]
    func addMeToReadUsers(of snapshot: QuerySnapshot)
    func updateUnreadCountToZero(of chatRoomId: String, othersId: String)
    func increaseUnreadCount(of id: String, in chatRoomId: String) async
    func addMessage(_ message: MessageToSendDTO, to chatRoomId: String) async -> Bool
    func listenOthersChattingQuery(from chatRoomId: String) -> Query
    func listenOtherIsReading(from chatRoomId: String, userId: String) -> Query
}
