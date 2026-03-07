// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

/// @notice Minimal interface for BattleChainSafeHarborRegistry.
/// Includes adoptSafeHarbor which is not in the upstream interface.
interface IBCSafeHarborRegistry {
    function adoptSafeHarbor(address agreementAddress) external;

    function getAgreement(address adopter) external view returns (address);

    function isAgreementValid(address agreementAddress) external view returns (bool);

    function getAgreementFactory() external view returns (address);
}
