// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

interface ISubscription {
    function getSubscription() external payable;
    function renewSubscription(uint256 subscriptionId) external payable;
    function calcleSubscription(uint256 subscriptionId) external;
    function isSubscribed(address subscriber) external view returns (bool);

    // Events
    event SubscriptionCreated(address indexed subscriber, uint256 indexed startedAt, uint256 indexed expiresAt);
    event SubscriptionRenewed(address indexed subscriber, uint256 indexed renewedAt, uint256 indexed expiresAt);
    event SubscriptionCancelled(address indexed subscriber, uint256 indexed cancelledAt);

}