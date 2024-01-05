//
//  FavoriteTransformer.swift
//
//
//  Created by Naufal Abiyyu on 27/12/23.
//

import Core
import Game
import RealmSwift
import Detail

public struct FavoriteTransformer: Mapper {
    public typealias Request = Int
    public typealias Response = GamesDetailResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(request: Int?, response: GamesDetailResponse) -> GameEntity {
        let gameEntity = GameEntity()
        
        gameEntity.id = response.id
        gameEntity.name = response.name
        gameEntity.released = response.released ?? ""
        gameEntity.urlBackground = response.backgroundImage 
        gameEntity.rating = response.rating ?? 0.0
        gameEntity.metacritic = response.metacritic ?? 0
        
        return gameEntity
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameDomainModel {
        return GameDomainModel(
            id: entity.id,
            name: entity.name,
            released: entity.released,
            desc: entity.descriptionGames,
            urlBackground: entity.urlBackground,
            rating: entity.rating,
            metacritic: entity.metacritic,
            isFavorite: entity.isFavorite
        )
    }
}
