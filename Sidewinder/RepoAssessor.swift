import Foundation
import SwiftyJSON


public protocol HttpGarçon {
     func Get(url: String) -> NSData?
}


public enum RepoAssessment {
    case Success, Failure, Error, Pending, Unknown, Unavailable
}

public struct GitHubRepo {
    
    public var owner, name: String
    
    public init(owner:String, name: String){
        self.owner = owner
        self.name = name
    }
}

public class RepoAssessor {

    let httpGarçon : HttpGarçon

    public init(_ httpGarçon: HttpGarçon) {
        self.httpGarçon = httpGarçon
    }
    
    public func assessmentOfRepo(repo: GitHubRepo) -> RepoAssessment {
        
        let url = "https://api.github.com/repos/\(repo.owner)/\(repo.name)/statuses/master"
        
        if let data = httpGarçon.Get(url) {
            
            let json = JSON(data: data)
            
            switch json[0]["state"] {
            case "success":
                return .Success
            case "failure":
                return .Failure
            case "error":
                return .Error
            case "pending":
                return .Pending
            default:
                return .Unknown
            }

        } else {
            return .Unavailable
        }
        
        
    }
    
}