// SPDX-License-Identifier: AGPL-3.0

pragma solidity >=0.6.0 <0.7.0;

interface ICurve {
    function exchange(
        int128 from,
        int128 to,
        uint256 _from_amount,
        uint256 _min_to_amount
    ) external;
}