pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

import "../../pooltogether-pool-contracts/contracts/external/pooltogether/FixedPoint.sol";
import "./ATokenInterface.sol";
import "./LendingPoolInterface.sol";
import "./WhirlpoolPrizePool.sol";
import "./tornado/PoolTornado.sol";

/// @title Prize Pool with Aave's aToken
/// @notice Manages depositing and withdrawing assets from the Prize Pool
contract Whirlpool is WhirlpoolPrizePool {
  using SafeMath for uint256;

  event WhirlpoolPrizePoolInitialized(address indexed aToken);

  /// @notice Interface for the Yield-bearing aToken by aToken
  ATokenInterface public aToken;

  /// @notice Address for Aave LendingPool
  LendingPoolInterface public lendingPool;

  /// @notice Initializes the Prize Pool and Yield Service with the required contract connections
  /// @param _trustedForwarder Address of the Forwarding Contract for GSN Meta-Txs
  /// @param _controlledTokens Array of addresses for the Ticket and Sponsorship Tokens controlled by the Prize Pool
  /// @param _maxExitFeeMantissa The maximum exit fee size, relative to the withdrawal amount
  /// @param _maxTimelockDuration The maximum length of time the withdraw timelock could be
  /// @param _aToken Address of the Aave aToken interface
  /// @param _lendingPool Address of Aave lending pool
  function initialize (
    address _trustedForwarder,
    ReserveInterface _reserve,
    address[] memory _controlledTokens,
    uint256 _maxExitFeeMantissa,
    uint256 _maxTimelockDuration,
    ATokenInterface _aToken,
    LendingPoolInterface _lendingPool
  )
    public
    initializer
  {
    PrizePool.initialize(
      _trustedForwarder,
      _reserve,
      _controlledTokens,
      _maxExitFeeMantissa,
      _maxTimelockDuration
    );
    aToken = _aToken;
    lendingPool = _lendingPool;

    emit WhirlpoolTornadoPrizePoolInitialized(address(aToken));
  }

  /// @dev Gets the balance of the underlying assets held by the Yield Service
  /// @return The underlying balance of asset tokens
  function _balance() internal override returns (uint256) {
    return aToken.balanceOf(address(this));
  }

  /// @dev Allows a user to supply asset tokens in exchange for yield-bearing tokens
  /// to be held in escrow by the Yield Service
  /// @param amount The amount of asset tokens to be supplied
  function _supply(uint256 amount) internal override {
    _token().approve(address(aToken), amount);
    lendingPool.deposit(address(_token()), amount, uint16(0));
  }

  /// @dev Checks with the Prize Pool if a specific token type may be awarded as a prize enhancement
  /// @param _externalToken The address of the token to check
  /// @return True if the token may be awarded, false otherwise
  function _canAwardExternal(address _externalToken) internal override view returns (bool) {
    return _externalToken != address(aToken);
  }

  /// @dev Allows a user to redeem yield-bearing tokens in exchange for the underlying
  /// asset tokens held in escrow by the Yield Service
  /// @param amount The amount of underlying tokens to be redeemed
  /// @return The actual amount of tokens transferred
  function _redeem(uint256 amount) internal override returns (uint256) {
    IERC20 assetToken = _token();
    uint256 before = assetToken.balanceOf(address(this));
    require(aToken.redeemUnderlying(amount) == 0, "AavePrizePool/redeem-failed");
    uint256 diff = assetToken.balanceOf(address(this)).sub(before);
    return diff;
  }

  /// @dev Gets the underlying asset token used by the Yield Service
  /// @return A reference to the interface of the underling asset token
  function _token() internal override view returns (IERC20) {
    return IERC20(aToken.underlyingAssetAddress());
  }
}
