#if canImport(Combine)

import Combine
import OnelightMoya

// This should be already provided in Combine, but it's not.
// Ideally we would like to remove it, in favor of a framework-provided solution, ASAP.

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
internal class MoyaPublisher<Output>: Publisher {

    internal typealias Failure = MoyaError

    private class Subscription: Combine.Subscription {
        private let performCall: () -> OnelightMoya.Cancellable?
        private var cancellable: OnelightMoya.Cancellable?

        init(subscriber: AnySubscriber<Output, MoyaError>, callback: @escaping (AnySubscriber<Output, MoyaError>) -> OnelightMoya.Cancellable?) {
            performCall = { callback(subscriber) }
        }

        func request(_ demand: Subscribers.Demand) {
            guard demand > .none else { return }

            cancellable = performCall()
        }

        func cancel() {
            cancellable?.cancel()
        }
    }

    private let callback: (AnySubscriber<Output, MoyaError>) -> OnelightMoya.Cancellable?

    init(callback: @escaping (AnySubscriber<Output, MoyaError>) -> OnelightMoya.Cancellable?) {
        self.callback = callback
    }

    internal func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: AnySubscriber(subscriber), callback: callback)
        subscriber.receive(subscription: subscription)
    }
}

#endif
