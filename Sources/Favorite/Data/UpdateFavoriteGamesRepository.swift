//
//  UpdateFavoriteGamesRepository.swift
//
//
//  Created by Naufal Abiyyu on 22/12/23.
//

import Core
import Game
import Combine
import Detail

public struct UpdateFavoriteGamesRepository<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    GameLocaleDataSource.Request == Int,
    GameLocaleDataSource.Response == GameEntity,
    Transformer.Request == Int,
    Transformer.Response == GamesDetailResponse,
    Transformer.Entity == GameEntity,
    Transformer.Domain == GameDomainModel {
    
    public typealias Request = Int
    public typealias Response = GameDomainModel
        
    private let _localeDataSource: GameLocaleDataSource
    private let _mapper: Transformer
        
    public init(
        localeDataSource: GameLocaleDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
    public func execute(request: Int?) -> AnyPublisher<GameDomainModel, Error> {
        return _localeDataSource.get(id: request ?? 0)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
