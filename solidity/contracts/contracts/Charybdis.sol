pragma solidity 0.5.17;

import "./tornado/ERC20Tornado.sol";

interface AToken {
    function redirectInterestStream(address _to) external;
}

contract Charybdis is ERC20Tornado {
    address public interestRecipient;

    constructor(
        IVerifier _verifier,
        uint256 _denomination,
        uint32 _merkleTreeHeight,
        address _operator,
        address _token,
        address _interestRecipient
    ) ERC20Tornado(_verifier, _denomination, _merkleTreeHeight, _operator) public {
        interestRecipient = _interestRecipient;
        AToken aToken = AToken(token);
        aToken.redirectInterestStream(interestRecipient);
    }
}