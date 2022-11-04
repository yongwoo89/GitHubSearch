//
//  ViewModel.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ViewModel: ViewModelType {
    
    private let header: HTTPHeaders = ["Authorization" : "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"]
    
    private let result = PublishRelay<Github>()
    private let isLoading = BehaviorRelay<Bool>(value: false)

    var disposeBag = DisposeBag()
    
    struct Input {
        let searchString: Observable<String> // TextFild Text Change
    }
    
    struct Output {
        let result: PublishRelay<Github> // api result value
        let isLoading: BehaviorRelay<Bool> // loding Animation
    }
    
    func transform(input: Input) -> Output {
        
        input.searchString.subscribe(onNext: {[weak self] str in
            guard let self = self else { return }
            self.searchAction(str: str)
        }).disposed(by: disposeBag)
        
        return Output(result: result,
                      isLoading: isLoading)
    }
    
    private func searchAction(str: String) {
        if str == "" {
            return
        }
        print(str)

        guard let url = "https://api.github.com/search/issues?q=\(str)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        self.cancelAllRequest {
            self.isLoading.accept(true)
            self.requestApi(url: url)
        }
    }
    
    private func requestApi(url: String){
        AF.request(url,
                   method: .get,
                   parameters: [:],
                   headers: header)
        .validate(statusCode: 200..<300) // 200~300 사이 상태코드만 허용
        .validate(contentType:["application/json"]) // JSON 포맷만 허용
        .responseData { response in
            switch response.result {
            case .success(let data):
//                if let data = response.data,
//                   let respStr = String(data: data, encoding: .utf8) {
//                    print(respStr)
//                }
                do {
                    let github = try JSONDecoder().decode(Github.self, from: data)
                    self.result.accept(github)
                } catch {
                    print("decode fail : \(error)")
                }
            case .failure(_):
                print("error ? cancel")
            }
            self.isLoading.accept(false)
        }
    }
    
    private func cancelAllRequest(completion: (()->(Void))?) {
        AF.session.getTasksWithCompletionHandler { dataTasks, _, _ in
            dataTasks.forEach {
                $0.cancel()
            }
            completion?()
        }
    }
}
