//
//  ViewModelType.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
//    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
