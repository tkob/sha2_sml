
(**
 * 3.  Operations on Words
 *
 * The following logical operators will be applied to words in all four
 * hash operations specified herein.  SHA-224 and SHA-256 operate on
 * 32-bit words while SHA-384 and SHA-512 operate on 64-bit words.
 *
 * In the operations below, x<<n is obtained as follows: discard the
 * leftmost n bits of x and then pad the result with n zeroed bits on
 * the right (the result will still be the same number of bits).
 * Similarly, x>>n is obtained as follows: discard the rightmost n bits
 * of x and then prepend the result with n zeroed bits on the left (the
 * result will still be the same number of bits).
 *)
structure Sha224And256Ops =
struct
  infix >>
  infix <<
  val op>> = Word32.>>
  val op<< = Word32.<<
  val w = Word.fromInt Word32.wordSize

  (**
   * a. Bitwise logical word operations
   *       X AND Y  =  bitwise logical "and" of  X and Y.
   *)
  fun AND (x,y) = Word32.andb (x, y)
  (*       X OR Y   =  bitwise logical "inclusive-or" of X and Y. *)
  fun OR  (x,y) = Word32.orb (x, y)
  (*       X XOR Y  =  bitwise logical "exclusive-or" of X and Y. *)
  fun XOR (x,y) = Word32.xorb (x, y)
  (*       NOT X    =  bitwise logical "complement" of X.  *)
  fun NOT x = Word32.notb x

  infix 2 AND
  infix 1 OR XOR

  (**
   * c. The right shift operation SHR^n(x), where x is a w-bit word and n
   * is an integer with 0 <= n < w, is defined by
   *    SHR^n(x) = x>>n
   *)
  fun SHR n x =
    let val n = Word.fromInt n in
      x >> n
    end

  (**
   * d. The rotate right (circular right shift) operation ROTR^n(x), where
   *    x is a w-bit word and n is an integer with 0 <= n < w, is defined
   *    by
   *       ROTR^n(x) = (x>>n) OR (x<<(w-n))
   *)
  fun ROTR n x =
    let val n = Word.fromInt n in
      (x >> n) OR (x << (w-n))
    end
end
