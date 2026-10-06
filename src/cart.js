/**
 * Throwaway sample used as a review target. Baseline version:
 * intentionally unremarkable, so that a later pull request can
 * introduce something worth commenting on.
 */

/** Sum the line totals of the given items. */
export function totalItems(items) {
  let total = 0;
  for (const item of items) {
    total += item.price * item.quantity;
  }
  return total;
}

/** Apply a percentage discount to an amount. */
export function applyDiscount(amount, percent) {
  if (percent < 0 || percent > 100) {
    throw new RangeError('percent must be between 0 and 100');
  }
  return amount - (amount * percent) / 100;
}

/** Count the units across the given items. */
export function countUnits(items) {
  return items.reduce((units, item) => units + item.quantity, 0);
}
