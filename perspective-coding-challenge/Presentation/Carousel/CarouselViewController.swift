//
//  ViewController.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import UIKit

class CarouselViewController: UIPageViewController {

    // MARK: - Views
    private var pages: [Pokemon: CarouselPageViewController] = [:]

    // MARK: - Properties
    private let viewModel = CarouselViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Setup
    private func setup() {
        dataSource = self
        Task {
            await viewModel.loadData()
            guard let initialPageModel = viewModel.getPokemon(0) else { return }
            setViewControllers([CarouselPageViewController(0, model: initialPageModel)],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

// MARK: - Data source
extension CarouselViewController: UIPageViewControllerDataSource {

    private enum PageChangeEvent: Int {
        case previous = -1
        case next = 1
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return handlePageChangeEvent(.previous, relativeTo: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return handlePageChangeEvent(.next, relativeTo: viewController)
    }

    private func handlePageChangeEvent(_ pageChangeEvent: PageChangeEvent,
                                       relativeTo currentViewController: UIViewController) -> UIViewController? {
        let pageIndex = (currentViewController as? CarouselPageViewController)?.index ?? 0
        let newIndex = pageIndex + pageChangeEvent.rawValue
        guard let model = viewModel.getPokemon(newIndex) else { return nil }
        if let loadedPage = pages[model] {
            return loadedPage
        }
        let newPage = createNewPage(for: newIndex, model: model)
        deallocateOldPage(for: pageChangeEvent, newIndex: newIndex)
        return newPage
    }

    private func createNewPage(for index: Int, model: Pokemon) -> UIViewController {
        let page = CarouselPageViewController(index, model: model)
        pages[model] = page
        return page
    }

    private func deallocateOldPage(for pageChangeEvent: PageChangeEvent, newIndex: Int) {
        let indexToDeallocate = newIndex - pageChangeEvent.rawValue * 3
        if let model = viewModel.getPokemon(indexToDeallocate) {
            pages[model] = nil
        }
    }
}
