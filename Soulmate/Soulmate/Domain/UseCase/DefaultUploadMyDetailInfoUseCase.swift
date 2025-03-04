//
//  DefaultUploadDetailInfoUseCase.swift
//  Soulmate
//
//  Created by Sangmin Lee on 2022/11/22.
//

import Foundation
import FirebaseAuth

class DefaultUploadMyDetailInfoUseCase: UploadMyDetailInfoUseCase {
        
    let userDetailInfoRepository: UserDetailInfoRepository
    let authRepository: AuthRepository
    
    init(
        userDetailInfoRepository: UserDetailInfoRepository,
        authRepository: AuthRepository
    ) {
        self.userDetailInfoRepository = userDetailInfoRepository
        self.authRepository = authRepository
    }
    
    func uploadDetailInfo(registerUserInfo: RegisterUserInfo) async throws {
        try await userDetailInfoRepository.uploadDetailInfo(
            userUid: authRepository.currentUid(),
            registerUserInfo: registerUserInfo
        )
    }

}
