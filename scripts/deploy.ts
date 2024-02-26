import { ethers } from "hardhat";

async function main() {
  const MedicationReminder = await ethers.deployContract(
    "MedicationReminderFactory"
  );

  await MedicationReminder.waitForDeployment();

  console.log(`deployed to ${MedicationReminder.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
