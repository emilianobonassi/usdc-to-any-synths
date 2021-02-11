import datetime
import click

from brownie import Wei

def test_swap(user, whale, interface, swapper, delegateApprovals, USDC, sTSLA):

    # Prepare user
    usdcAmount = 10_000 * 1e6
    USDC.transfer(user, usdcAmount, {'from': whale})

    # Delegates    
    delegateApprovals.approveExchangeOnBehalf(swapper, {'from': user})

    # Swap to sTSLA
    USDC.approve(swapper, 2 ** 256 - 1, {'from': user})
    sTSLAKey = 0x7354534c41000000000000000000000000000000000000000000000000000000
    swapper.exchange(usdcAmount, sTSLAKey, 0, {'from': user})

    # Check sTSLA balance
    sTSLABalance = sTSLA.balanceOf(user)

    print ('sTSLA Balance: ', sTSLABalance/1e18)

    assert sTSLABalance > 0
