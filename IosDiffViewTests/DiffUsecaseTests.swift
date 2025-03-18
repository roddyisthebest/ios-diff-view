//
//  DiffUsecaseTests.swift
//  IosDiffViewTests
//
//  Created by 배성연 on 3/14/25.
//

import XCTest
@testable import IosDiffView
final class DiffUsecaseTests: XCTestCase {
    
    
    var diffUsecase:DiffUsecaseProtocol!
    
    override func setUp(){
        super.setUp();
        diffUsecase = DiffUsecase();
    }

    
    override func tearDown(){
        diffUsecase = nil;
        super.tearDown();
    }
    
    
    
    func testSameContent(){
        let oldLines = ["line 1", "line 2", "line 3"]
        let newLines = ["line 1", "line 2", "line 3"]
        
        let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)

        XCTAssertEqual(result.count, 3)
        XCTAssertTrue(result.allSatisfy { $0.status == .notChange })
    }
    
    

    func testSingleLineAdded() {
          let oldLines = ["line 1", "line 2"]
          let newLines = ["line 1", "line 2", "line 3"]
          
          let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
          
          XCTAssertEqual(result.count, 3)
          XCTAssertEqual(result.last?.status, .add)
          XCTAssertEqual(result.last?.content, "line 3")
      }
    
    
    func testSingleLineRemoved() {
          let oldLines = ["line 1", "line 2", "line 3"]
          let newLines = ["line 1", "line 2"]
          
          let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
          
          XCTAssertEqual(result.count, 3)
          XCTAssertEqual(result.last?.status, .delete)
          XCTAssertEqual(result.last?.content, "line 3")
      }
    
    
    func testSingleLineChanged() {
        let oldLines = ["line 1", "line 2"]
        let newLines = ["line 1", "line changed"]
        
        let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
        


        XCTAssertEqual(result[0].content, "line 1")

        XCTAssertEqual(result[1].status, .delete)
        XCTAssertEqual(result[1].content, "line 2")

        XCTAssertEqual(result[2].status, .add)
        XCTAssertEqual(result[2].content, "line changed")
    }
    
    
    func testMultipleLinesAdded() {
        let oldLines = ["line 1"]
        let newLines = ["line 1", "line 2", "line 3"]
            
        let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
            
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[1].status, .add)
        XCTAssertEqual(result[1].content, "line 2")
            
        XCTAssertEqual(result[2].status, .add)
        XCTAssertEqual(result[2].content, "line 3")
    }
        
    
    func testMultipleLinesRemoved() {
        let oldLines = ["line 1", "line 2", "line 3"]
        let newLines = ["line 1"]
        
        let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
        
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[1].status, .delete)
        XCTAssertEqual(result[1].content, "line 2")
        
        XCTAssertEqual(result[2].status, .delete)
        XCTAssertEqual(result[2].content, "line 3")
    }

    
    func testMultipleLinesChanged() {
        let oldLines = ["line 1", "line 2", "line 3"]
        let newLines = ["line 1", "modified 2", "modified 3"]
        
        let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
        
        XCTAssertEqual(result.count, 5)
        XCTAssertEqual(result[1].status, .delete)
        XCTAssertEqual(result[1].content, "line 2")
        
        XCTAssertEqual(result[2].status, .delete)
        XCTAssertEqual(result[2].content, "line 3")
        
        XCTAssertEqual(result[3].status, .add)
        XCTAssertEqual(result[3].content, "modified 2")
        
        XCTAssertEqual(result[4].status, .add)
        XCTAssertEqual(result[4].content, "modified 3")
    }
    
    func testEmptyFileComparison() {
         let oldLines: [String] = []
         let newLines = ["line 1", "line 2"]
         
         let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)
         
         XCTAssertEqual(result.count, 2)
         XCTAssertTrue(result.allSatisfy { $0.status == .add })
     }
    
    
    func testMixedAddAndRemove() {
          let oldLines = ["line 1", "line 2", "line 3"]
          let newLines = ["line 1", "new line 2", "line 3", "new line 4"]

          let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)

          XCTAssertEqual(result.count, 5)

          XCTAssertEqual(result[1].status, .delete)
          XCTAssertEqual(result[1].content, "line 2")

          XCTAssertEqual(result[2].status, .add)
          XCTAssertEqual(result[2].content, "new line 2")

          XCTAssertEqual(result[4].status, .add)
          XCTAssertEqual(result[4].content, "new line 4")
      }
    
    
    func testFileDeleted() {
          let oldLines = ["line 1", "line 2", "line 3"]
          let newLines: [String] = []

          let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)

          XCTAssertEqual(result.count, 3)
          XCTAssertTrue(result.allSatisfy { $0.status == .delete })
      }
    
    
    func testCompletelyDifferentFile() {
            let oldLines = ["old line 1", "old line 2", "old line 3"]
            let newLines = ["new line 1", "new line 2", "new line 3"]

            let result = diffUsecase.computeDiff(oldLines: oldLines, newLines: newLines)

            XCTAssertEqual(result.count, 6)

            XCTAssertEqual(result[0].status, .delete)
            XCTAssertEqual(result[0].content, "old line 1")

            XCTAssertEqual(result[1].status, .delete)
            XCTAssertEqual(result[1].content, "old line 2")

            XCTAssertEqual(result[2].status, .delete)
            XCTAssertEqual(result[2].content, "old line 3")

            XCTAssertEqual(result[3].status, .add)
            XCTAssertEqual(result[3].content, "new line 1")

            XCTAssertEqual(result[4].status, .add)
            XCTAssertEqual(result[4].content, "new line 2")

            XCTAssertEqual(result[5].status, .add)
            XCTAssertEqual(result[5].content, "new line 3")
        }

}
