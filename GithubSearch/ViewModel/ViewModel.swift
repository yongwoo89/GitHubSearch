//
//  ViewModel.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel: ViewModelType {
    
    private let result = BehaviorRelay<[String]>(value: [])
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchString: Observable<String>
    }
    
    struct Output {
        let result: BehaviorRelay<[String]>
    }
    
    func transform(input: Input) -> Output {
        input.searchString.subscribe(onNext: {[weak self] str in
            guard let self = self else { return }
            self.searchAction(str: str)
        }).disposed(by: disposeBag)
        return Output(result: result)
    }
    
    private func searchAction(str: String) {
        print(str)
        result.accept([str])
    }
}
