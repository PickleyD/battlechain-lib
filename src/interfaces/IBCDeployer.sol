// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

/// @notice Full interface for BattleChainDeployer (CreateX + AttackRegistry registration).
/// Every deploy function automatically registers the new contract with the AttackRegistry.
interface IBCDeployer {
    // -------------------------------------------------------------------------
    // Types (from CreateX)
    // -------------------------------------------------------------------------

    struct Values {
        uint256 constructorAmount;
        uint256 initCallAmount;
    }

    // -------------------------------------------------------------------------
    // CREATE
    // -------------------------------------------------------------------------

    function deployCreate(bytes memory initCode) external payable returns (address newContract);

    function deployCreateAndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values,
        address refundAddress
    )
        external
        payable
        returns (address newContract);

    function deployCreateAndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values
    )
        external
        payable
        returns (address newContract);

    function deployCreateClone(
        address implementation,
        bytes memory data
    )
        external
        payable
        returns (address proxy);

    // -------------------------------------------------------------------------
    // CREATE2
    // -------------------------------------------------------------------------

    function deployCreate2(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate2(bytes memory initCode) external payable returns (address newContract);

    function deployCreate2AndInit(
        bytes32 salt,
        bytes memory initCode,
        bytes memory data,
        Values memory values,
        address refundAddress
    )
        external
        payable
        returns (address newContract);

    function deployCreate2AndInit(
        bytes32 salt,
        bytes memory initCode,
        bytes memory data,
        Values memory values
    )
        external
        payable
        returns (address newContract);

    function deployCreate2AndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values,
        address refundAddress
    )
        external
        payable
        returns (address newContract);

    function deployCreate2AndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values
    )
        external
        payable
        returns (address newContract);

    function deployCreate2Clone(
        bytes32 salt,
        address implementation,
        bytes memory data
    )
        external
        payable
        returns (address proxy);

    function deployCreate2Clone(
        address implementation,
        bytes memory data
    )
        external
        payable
        returns (address proxy);

    // -------------------------------------------------------------------------
    // CREATE3
    // -------------------------------------------------------------------------

    function deployCreate3(bytes32 salt, bytes memory initCode) external payable returns (address newContract);

    function deployCreate3(bytes memory initCode) external payable returns (address newContract);

    function deployCreate3AndInit(
        bytes32 salt,
        bytes memory initCode,
        bytes memory data,
        Values memory values,
        address refundAddress
    )
        external
        payable
        returns (address newContract);

    function deployCreate3AndInit(
        bytes32 salt,
        bytes memory initCode,
        bytes memory data,
        Values memory values
    )
        external
        payable
        returns (address newContract);

    function deployCreate3AndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values,
        address refundAddress
    )
        external
        payable
        returns (address newContract);

    function deployCreate3AndInit(
        bytes memory initCode,
        bytes memory data,
        Values memory values
    )
        external
        payable
        returns (address newContract);

    // -------------------------------------------------------------------------
    // Address computation (from CreateX)
    // -------------------------------------------------------------------------

    function computeCreateAddress(address deployer, uint256 nonce) external view returns (address computedAddress);

    function computeCreateAddress(uint256 nonce) external view returns (address computedAddress);

    function computeCreate2Address(
        bytes32 salt,
        bytes32 initCodeHash,
        address deployer
    )
        external
        pure
        returns (address computedAddress);

    function computeCreate2Address(bytes32 salt, bytes32 initCodeHash) external view returns (address computedAddress);

    function computeCreate3Address(bytes32 salt, address deployer) external pure returns (address computedAddress);

    function computeCreate3Address(bytes32 salt) external view returns (address computedAddress);
}
