//
//  GetFavoriteGamesLocaleDataSource.swift
//
//
//  Created by Naufal Abiyyu on 22/12/23.
//

import Core
import Game
import Combine
import Foundation
import RealmSwift

public struct GetFavoriteGamesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Int
    
    public typealias Response = GameEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        self._realm = realm
    }
    
    public func list(request: Request?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            
            let gameEntities = {
                _realm.objects(GameEntity.self)
                    .filter("isFavorite = \(true)")
                    .sorted(byKeyPath: DomainModelConstant.name)
            }()
            completion(.success(gameEntities.toArray(ofType: GameEntity.self)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            if let gameEntity = {
                _realm.objects(GameEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        gameEntity.setValue(!gameEntity.isFavorite, forKey: DomainModelConstant.isFavorite)
                    }
                    completion(.success(gameEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
