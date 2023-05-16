// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./interface/ISubscription.sol";

contract Subscription is ISubscription {
    struct Subscribers {
        uint256 subscribtionId;
        address subscriber;
        uint256 startedAt;
        uint256 expiresAt;
    }
    mapping(address => Subscribers) internal _subscribers;

    function getSubscription() external payable override {
        require(
            _subscribers[msg.sender].subscriber != msg.sender,
            "Subscription: SubscriptionAlreadyExists"
        );
        require(
            _subscribers[msg.sender].expiresAt < block.timestamp,
            "Subscription: RenewSubscription"
        );
        require(msg.value == 0.01 ether, "Subscription: InvalidAmount");
        uint256 subscritonId = uint256((block.timestamp * 4) / block.timestamp);

        _subscribers[msg.sender] = Subscribers(
            subscritonId,
            msg.sender,
            block.timestamp,
            block.timestamp + 30 days
        );
    }

    function renewSubscription(
        uint256 subscriptionId
    ) external payable override {
        require(
            _subscribers[msg.sender].subscriber == msg.sender,
            "Subscription: OnlySubscribers"
        );
        require(
            _subscribers[msg.sender].expiresAt < block.timestamp,
            "Subscription: SubscriptionNotExpired"
        );
        require(msg.value == 0.01 ether, "Subscription: InvalidAmount");
        require(
            _subscribers[msg.sender].subscribtionId == subscriptionId,
            "Subscription: InvalidSubscriptionId"
        );
        _subscribers[msg.sender].expiresAt = block.timestamp + 30 days;
    }

    function calcleSubscription(uint256 subscriptionId) external override {
        require(
            _subscribers[msg.sender].subscriber == msg.sender,
            "Subscription: OnlySubscribers"
        );
        require(
            _subscribers[msg.sender].subscribtionId == subscriptionId,
            "Subscription: InvalidSubscriptionId"
        );
        delete _subscribers[msg.sender];
    }

    function subscriptionData(
        address subscriber
    ) external view returns (Subscribers memory) {
        require(
            _subscribers[subscriber].subscriber == subscriber,
            "Subscription: InvalidSubscriber"
        );
        return _subscribers[subscriber];
    }

    function isSubscribed(
        address subscriber
    ) external view override returns (bool) {
        require(
            _subscribers[subscriber].subscriber == subscriber,
            "Subscription: InvalidSubscriber"
        );
        if (
            _subscribers[subscriber].expiresAt > block.timestamp
        ) {
            return true;
        } else {
            return false;
        }
    }
}
