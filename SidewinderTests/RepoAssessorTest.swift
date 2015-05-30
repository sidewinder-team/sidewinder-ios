import Foundation

import Quick
import Nimble
import Sidewinder

class RepoAssessorTest: QuickSpec {
    
    override func spec() {
        describe("Get repo status") {
            
            var httpGuy = MockHttpGarçon()
            var assessor = RepoAssessor(httpGuy)
            
            beforeEach {
                httpGuy = MockHttpGarçon()
                assessor = RepoAssessor(httpGuy)
            }
            
            it("when there are no statuses for the repo an Unknown will be returned") {
                let jsonResponse = "[]"
                let repo = GitHubRepo(owner: "sidewinder-team", name: "sidewinder-ios")
                httpGuy.UrlResponses["https://api.github.com/repos/\(repo.owner)/\(repo.name)/statuses/master"] = toData(jsonResponse)

                let status = assessor.assessmentOfRepo(repo)
                expect(status).to(equal(RepoAssessment.Unknown))
            }
            
            it("when no data from http a Unavailable will be returned") {
                let repo = GitHubRepo(owner: "sidewinder-team", name: "sidewinder-server")
                httpGuy.UrlResponses["https://api.github.com/repos/\(repo.owner)/\(repo.name)/statuses/master"] = nil

                let status = assessor.assessmentOfRepo(repo)
                expect(status).to(equal(RepoAssessment.Unavailable))
            }
            
            
            let expectedAssessments : [String: RepoAssessment] = [
                "success": .Success,
                "failure": .Failure,
                "error": .Error,
                "pending": .Pending,
            ]
            
            for (githubState, expectedAssement) in  expectedAssessments {
                
                it("when only status has state \(githubState) a \(expectedAssement) will be returned") {
                    
                    let jsonResponse = "[{\"state\": \"\(githubState)\", \"context\": \"continuous-integration/travis-ci/push\"}]"
                    
                    let repo = GitHubRepo(owner: "sidewinder-team", name: "sidewinder-server")
                    httpGuy.UrlResponses["https://api.github.com/repos/\(repo.owner)/\(repo.name)/statuses/master"] = toData(jsonResponse)
                    
                    let status = assessor.assessmentOfRepo(repo)
                    expect(status).to(equal(expectedAssement))
                }
            }
            
            it("when there are no statuses for that context in the repo an Unknown will be returned") {
                let jsonResponse = "[]"
                
                let repo = GitHubRepo(owner: "sidewinder-team", name: "sidewinder-server")
                httpGuy.UrlResponses["https://api.github.com/repos/\(repo.owner)/\(repo.name)/statuses/master"] = toData(jsonResponse)
                
                let status = assessor.assessmentOfRepo(repo)
                expect(status).to(equal(RepoAssessment.Unknown))
            }
        }
    }

}

func toData(value: String) -> NSData? {
    return value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
}