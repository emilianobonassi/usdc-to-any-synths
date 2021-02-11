// SPDX-License-Identifier: AGPL-3.0

pragma solidity >=0.6.0 <0.7.0;

interface ISynthetix {
    function exchangeOnBehalfWithTracking(
        address exchangeForAddress,
        bytes32 sourceCurrencyKey,
        uint sourceAmount,
        bytes32 destinationCurrencyKey,
        address originator,
        bytes32 trackingCode
    ) external returns (uint amountReceived);
}