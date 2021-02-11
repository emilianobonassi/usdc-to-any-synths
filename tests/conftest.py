import pytest


@pytest.fixture
def deployer(accounts):
    return accounts[0]

@pytest.fixture
def user(accounts):
    return accounts[1]

@pytest.fixture
def whale(accounts):
    return accounts.at('0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8', force=True) #binance

@pytest.fixture
def sUSD(Token):
    return Token.at('0x57Ab1ec28D129707052df4dF418D58a2D46d5f51')

@pytest.fixture
def sTSLA(Token):
    return Token.at('0x918dA91Ccbc32B7a6A0cc4eCd5987bbab6E31e6D')
    
@pytest.fixture
def USDC(Token):
    return Token.at('0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48')

@pytest.fixture
def swapper(deployer, USDC2AnySynthsV1):
    return deployer.deploy(USDC2AnySynthsV1)


@pytest.fixture
def delegateApprovals(interface):
    return interface.IDelegateApprovals('0x15fd6e554874B9e70F832Ed37f231Ac5E142362f')

