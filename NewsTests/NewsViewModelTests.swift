//
//  NewsViewModelTests.swift
//  NewsTests
//
//  Created by Juan Diego Marin on 4/11/22.
//

import XCTest
@testable import News

class NewsTests: XCTestCase {
    
    // MARK: - Private Properties
    private var requestExpectation: XCTestExpectation?
    // MARK: - Subject under test
    private var viewModel: HackerNewsViewModel!
    // MARK: - Mock
    private var repositoryMock: NewsRepositoryMock!
    
    
    // MARK: - Set up & Tear Down
    override func setUp() {
        super.setUp()
        repositoryMock = NewsRepositoryMock()
        viewModel = HackerNewsViewModel(repository: repositoryMock)

    }

    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        viewModel = nil
    }
    
    // MARK: - Tests getNews
    
    func testGetNews() {
        // Given
        repositoryMock.news = NewsFake.hits
        // When
        getNews()
        // Then
        XCTAssertEqual(requestExpectation?.expectationDescription, ResponseExpectation.ok.rawValue)
    }

}

private extension NewsTests {
    
    func getNews() {
        requestExpectation = expectation(description: ResponseExpectation.go.rawValue)
        viewModel.success = {
            self.requestExpectation?.expectationDescription = ResponseExpectation.ok.rawValue
            self.requestExpectation?.fulfill()
        }
        viewModel.getNews()
        if let requestExpectation = requestExpectation {
            wait(for: [requestExpectation], timeout: 1)
        }
    }
}
