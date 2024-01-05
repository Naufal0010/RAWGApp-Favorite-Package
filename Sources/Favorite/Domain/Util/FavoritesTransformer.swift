//
//  FavoritesTransformer.swift
//  
//
//  Created by Naufal Abiyyu on 27/12/23.
//

import Core
import Game
import Detail
import RealmSwift

public struct FavoritesTransformer: Mapper {
    
    public typealias Request = Int
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: Int?, response: [GameResponse]) -> [GameEntity] {
        return response.map { result in
            return GameEntity.init()
        }
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameDomainModel] {
        return entity.map { result in
            return GameDomainModel(id: result.id,
                             name: result.name,
                             released: result.released,
                             desc: result.descriptionGames,
                             urlBackground: result.urlBackground,
                             rating: result.rating,
                             metacritic: result.metacritic,
                             isFavorite: result.isFavorite
            )
        }
    }
}
