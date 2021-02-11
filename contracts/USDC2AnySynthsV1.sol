// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


import "../interfaces/ISynthetix.sol";
import "../interfaces/ICurve.sol";

contract USDC2AnySynthsV1 {

    using SafeERC20 for IERC20;
    using SafeMath for uint256; 

    ISynthetix public constant Synthetix = ISynthetix(0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F);
    ICurve public constant Curve = ICurve(0xA5407eAE9Ba41422680e2e00537571bcC53efBfD);

    IERC20 public constant USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 public constant SUSD = IERC20(0x57Ab1ec28D129707052df4dF418D58a2D46d5f51);

    // Partner program
    bytes32 public constant trackingCode = 0x534e582e4c494e4b000000000000000000000000000000000000000000000000;

    // Custom referral initiative
    address public constant originator = 0x59846C1F45C67FA757438EC1B67bdd72BBe483b7;

    constructor() public {
        // Allow Curve to swap
        USDC.safeApprove(address(Curve), type(uint256).max);
    }

    function exchange(
        uint256 sourceAmount,
        bytes32 destinationCurrencyKey,
        uint256 _min_to_amount
    ) external {

        // Transfer in USDC
        USDC.safeTransferFrom(msg.sender, address(this), sourceAmount);

        // Exchange on curve and transfer back to the user
        Curve.exchange(
            1, // USDC
            3, // SUSD
            sourceAmount,
            _min_to_amount
        );

        uint256 exchangedAmount = SUSD.balanceOf(address(this));
        SUSD.safeTransfer(msg.sender, exchangedAmount);

        // Exchange on behalf to destinationCurrencyKey
        Synthetix.exchangeOnBehalfWithTracking(
            msg.sender,
            "sUSD",
            exchangedAmount,
            destinationCurrencyKey,
            originator,
            trackingCode
        );
    }
}