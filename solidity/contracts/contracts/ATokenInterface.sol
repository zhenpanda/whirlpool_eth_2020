pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

interface ATokenInterface is IERC20 {
    function decimals() external view returns (uint8);
    function totalSupply() external override view returns (uint256);
    function underlyingAssetAddress() external view returns (address);
    function balanceOf(address user) external override view returns (uint256);
    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);
}
