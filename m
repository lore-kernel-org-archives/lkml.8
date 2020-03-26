Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33FFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BD120748
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgC1QqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:46:00 -0400
Received: from mx.sdf.org ([205.166.94.20]:50062 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgC1Qn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:28 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhORm020709
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:24 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhO7l028286;
        Sat, 28 Mar 2020 16:43:24 GMT
Message-Id: <202003281643.02SGhO7l028286@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 26 Mar 2020 07:53:50 -0400
Subject: [RFC PATCH v1 45/50] random: add get_random_max() function
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got annoyed that randomize_page() wasn't exactly uniform,
and used (slow) modulo-based range reduction rather than the
(fast) multiplicative algorithm, so I fixed it.

I figure, if you're going to the trouble of using cryptographic
random numbers, you don't want biased outputs, even if it's slight.

This includes optimized code for compile-time constant ranges,
even though randomize_page() can't use it; later patches will
add more callers.

The multiple implementation cases make the code bulky, but each
call site uses only one (chosen at compile time) and they are
individually quite small.

The SPARC64 implementation of _get_random_max64(), the inline
function which handles constant ranges, is particularly large.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 155 ++++++++++++++++++++++++++++++++--
 include/linux/random.h | 183 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 325 insertions(+), 13 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8c2f8b0be6f6..67bdfb51eb25c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2569,6 +2569,143 @@ u32 get_random_u32(void)
 }
 EXPORT_SYMBOL(get_random_u32);
 
+/**
+ * __get_random_max32 - Generate a uniform random number 0 <= x < range < 2^32
+ * @range:	Modulus for random number; must not be zero!
+ *
+ * This generates an exactly uniform distribution over [0, range), where
+ * range is *not* a compile-time constant.
+ *
+ * This uses Lemire's multiplicative algorithm, from
+ *	Fast Random Integer Generation in an Interval
+ *	https://arxiv.org/abs/1805.10941
+ *
+ * The standard mutiplicative range technique is (rand32() * range) >> 32.
+ * However, there are either floor((1<<32) / range) or ceil((1<<32) / range)
+ * random values that will result in each output value.  More specifically,
+ * lim = (1 << 32) % range values will be generated one extra time.
+ *
+ * Lemire proves (Lemma 4.1) that those extra values can be identified
+ * by the lsbits of the product.  If you discard and retry whenever the
+ * lsbits are less than lim, you get the floor option always.
+ */
+u32 __get_random_max32(u32 range)
+{
+	u64 prod = mul_u32_u32(get_random_u32(), range);
+
+	/*
+	 * Fast-path check: lim < range, so lsbits >= range-1
+	 * implies lsbits >= lim.
+	 */
+	if (unlikely((u32)prod < range - 1)) {
+		/* Slow path; we need to divide to check exactly */
+		u32 lim = -range % range;	/* = (1<<32) % range */
+
+		while (unlikely((u32)prod < lim))
+			prod = mul_u32_u32(get_random_u32(), range);
+	}
+	return prod >> 32;
+}
+EXPORT_SYMBOL(__get_random_max32);
+
+#ifdef CONFIG_64BIT
+/**
+ * __get_random_max64 - Generate a uniform random number 0 <= x < range < 2^64
+ * @range:	Modulus for random number; must not be zero!
+ *
+ * Like get_random_max32, but for larger ranges.  There are two
+ * implementations, depending on CONFIG_ARCH_SUPPORTS_INT128.
+ */
+u64 __get_random_max64(u64 range)
+{
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+	/* Same as get_random_max32(), with larger data types. */
+	unsigned __int128 prod;
+
+	if (range >> 32 == 0)
+		return __get_random_max32(range);
+
+	prod = (unsigned __int128)get_random_u64() * range;
+
+	if (likely((u64)prod < range - 1)) {
+		/* Slow path; we need to divide to check exactly */
+		u64 lim = -range % range;	/* = (1<<64) % range */
+
+		while ((u64)prod < lim)
+			prod = (unsigned __int128)get_random_u64() * range;
+	}
+	return prod >> 64;
+#else
+	/*
+	 * We don't have efficient 128-bit products (e.g. SPARCv9), so
+	 * break it into two halves: generate the high bits in
+	 * the desired range (rounding up), append some uniform low
+	 * bits, and retry in the rare case that the rounding up
+	 * produces a result exceeding the range.
+	 */
+	u32 msbits;
+	u64 result;
+
+	if (range >> 32 == 0)
+		return __get_random_max32(range);
+
+	/*
+	 * If the range has less than 64 significant bits, there is
+	 * more than one way to split it into msbits and lsbits.
+	 * A very large msbits causes retries within __get_random_max32.
+	 * A very small msbits causes retries here, with
+	 * probability about 1/(2*msbits).
+	 *
+	 * While we could use a fixed split of 32 lsbits, that results
+	 * in an average of 2.75 calls to get_random_u32() when the range
+	 * has 33 significant bits, which is 0.75 more than necessary.
+	 * And unfortunately, we expect ranges comparable to
+	 * physical memory size, which is often just over 32 bits.
+	 *
+	 * Generally, the best split is 17 significant msbits and the rest
+	 * as lsbits.  *But* this code path is primarily for SPARCv9,
+	 * which lacks a count-leading-zeros operation, so using fls()
+	 * at runtime probably isn't worth it.
+	 *
+	 * The cost (in extra random words) approximately doubles per
+	 * bit distant from that optimum.  The best single split handles
+	 * 44+ bits with 32 lsbits (5 bits from the optimum of 44-17 =
+	 * 27 lsbits), and 33..43 bits with 21 lsbits (5 bits from the
+	 * optima of 16..26 lsbits).
+	 *
+	 * As mentioned above, using 32 lsbits rather than 16 lsbits
+	 * results in an additional 0.75 random words per call.  5 bits
+	 * from optimum rather than 16 bits is a factor of 2^11 = 2048
+	 * better, using an additional 0.75/2048 = 3.6e-4 random words
+	 * per call.  Spending one cycle for a more sophisticated split
+	 * is only worth it if a word of CRNG output costs 2048/0.75 =
+	 * 2730 cycles, which it doesn't.
+	 */
+	if (range >> 43 == 0) {
+		msbits = (range + 0x1fffff) >> 21;
+		do {
+			u32 t = __get_random_max32(msbits);
+			result = (u64)t << 21 | get_random_u32() >> 11;
+		} while (unlikely(result >= range));
+	} else {
+		msbits = (range + 0xffffffff) >> 32;
+		/* If range >= 0xffffffff00000001, msbits will wrap to 0 */
+		do {
+			u32 t;
+
+			if (likely(msbits))
+				t = __get_random_max32(msbits);
+			else
+				t = get_random_u32();
+			result = (u64)t << 32 | get_random_u32();
+		} while (unlikely(result >= range));
+	}
+	return result;
+#endif
+}
+EXPORT_SYMBOL(__get_random_max64);
+#endif /* CONFIG_64BIT */
+
 /**
  * randomize_page - Generate a random, page aligned address
  * @start:	The smallest acceptable address the caller will take.
@@ -2586,20 +2723,24 @@ EXPORT_SYMBOL(get_random_u32);
 unsigned long
 randomize_page(unsigned long start, unsigned long range)
 {
-	if (!PAGE_ALIGNED(start)) {
-		range -= PAGE_ALIGN(start) - start;
-		start = PAGE_ALIGN(start);
-	}
+	/* How much to round up to make start page-aligned */
+	unsigned long align = -start & (PAGE_SIZE - 1);
 
-	if (start > ULONG_MAX - range)
-		range = ULONG_MAX - start;
+	if (range < align)
+		return start;
+
+	start += align;
+	range -= align;
+
+	if (range > -start)
+		range = -start;
 
 	range >>= PAGE_SHIFT;
 
 	if (range == 0)
 		return start;
 
-	return start + (get_random_long() % range << PAGE_SHIFT);
+	return start + (get_random_max(range) << PAGE_SHIFT);
 }
 
 /* Interface for in-kernel drivers of true hardware RNGs.
diff --git a/include/linux/random.h b/include/linux/random.h
index 7956063253261..97d3469f3aad8 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -63,6 +63,182 @@ static inline unsigned long get_random_long(void)
 #endif
 }
 
+/**
+ * get_random_max32 - return a 32-bit random number in interval [0, range)
+ * @range: Size of random interval [0,range); the first value not included.
+ *
+ * This uses Lemire's algorithm; see drivers/char/random.c for details.
+ *
+ * The expensive part of this is the "(1ull<<32) % range" computation.
+ * If that's a compile-time constant, things get simple enough to inline.
+ */
+/* When the range is a compile-time constant, so is lim, and it's simple. */
+static __always_inline u32 _get_random_max32(u32 range)
+{
+	u32 lim = -range % range;
+	u64 prod;
+
+	do
+		prod = mul_u32_u32(get_random_u32(), range);
+	while (unlikely((u32)prod < lim));
+	return prod >> 32;
+}
+/* Non-constant ranges are done out of line. */
+u32 __get_random_max32(u32 range);
+
+/* Decide between the two.  (Case #3 is power of two.) */
+static __always_inline u32 get_random_max32(u32 range)
+{
+	if (!__builtin_constant_p(range))
+		return __get_random_max32(range);
+	else if (range & (range - 1))
+		return _get_random_max32(range);
+	else
+		return get_random_u32() / (u32)(0x100000000 / range);
+}
+
+#ifdef CONFIG_64BIT
+/*
+ * If we have 64x64->128-bit multiply, the same algorithm works.
+ * If we don't (*cough* SPARCv9 *cough*), it's trickier.  Basically,
+ * we do it in two halves.  Generate the high bits, append the low
+ * bits, then retry if the concatenation is out of range,
+ */
+
+/*
+ * When the range is a compile-time constant, we can break it
+ * into several cases depending on range.  Note that the
+ * caller has already ensured that range >= 2^32.
+ */
+static __always_inline u64 _get_random_max64(u64 range)
+{
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+	u64 lim = -range % range;
+	unsigned __int128 prod;
+
+	do
+		prod = (__int128)get_random_u64() * range;
+	while (unlikely((u64)prod < lim));
+	return prod >> 64;
+
+#else /* No 128-bit product - this is messy */
+	u32 bit, high;
+	u64 result;
+	/* Easy special case 1: All 32 low-order bits are zero */
+	if (!(u32)range)
+		return (u64)_get_random_max32(range>>32) << 32 |
+			get_random_u32();
+	/* Easy special case 1: At most 32 contiguous non-zero bits */
+	bit = (u32)range & -(u32)range;
+	if (range >> 32 < bit)
+		return _get_random_max32(range/bit) * (u64)bit |
+			get_random_u32() / (u32)(0x10000000/bit);
+	/* Easy special case 3: Bit 63 is set; generate and retry */
+	if (range >> 63) {
+		do {
+			do
+				high = get_random_u32();
+			while (high > (u32)(range >> 32));
+			result = (u64)high << 32 | get_random_u32();
+		} while (unlikely(result >= range));
+		return result;
+	}
+	/*
+	 * Now it gets tricky.	The basic idea is to remove some low-order
+	 * bits from range until it fits into 32 bits, rounding up.
+	 * (I.e. (range >> bits) + 1).  A uniform random number in this
+	 * range, combined with some uniform random low-order bits,
+	 * can then be tested against the 64-bit range and retried in the
+	 * rare case that it exceeds the range.
+	 *
+	 * But how many low-order bits to remove?  As the range is at most
+	 * 63 bits, there are multiple possible choices.  Which requires
+	 * the smallest number of retries?
+	 *
+	 * The formula to compute the expected number of random words is
+	 * complicated, and optimum division requires trying them all,
+	 * but a simple heuristic gets very close:
+	 * 4) For range >= 2^48, use 32 low-order bits and the rest high-order
+	 * 5) For range < 2^49, use 17 high-order bits and the rest low-order
+	 *    (For 2^48 <= range < 2^49, these are equivalent.)
+	 *
+	 * This very close to optimum, always within 1e-4 words (and
+	 * usually much lower), except for a few rare values > 2^50, when
+	 * a different split works out particularly well.
+	 *
+	 * For an extreme example, consider a range of 0x2aaaaaaa00000001.
+	 * A 31-bit split produces a 31-bit high part of 0x55555555, which
+	 * divides 2^32 particularly well, requiring only 1.63e-9 extra words
+	 * (above the minimum of 2), on average.
+	 * A 32-bit split produces a 30-bit high part of 0x2aaaaaab, which
+	 * requires a more typical 0.2 extra words.
+	 */
+	if (range >> 48) {
+		high = (u32)(range >> 32) + 1;
+		do {
+			result = (u64)_get_random_max32(high) << 32 |
+				get_random_u32();
+		} while (unlikely(result >= range));
+	} else {	/* 2^32 < range < 2^49 */
+		bit = fls((u32)(range >> 32)) + 15;
+		high = (u32)(range >> bit) + 1;
+		do {
+			result = (u64)_get_random_max32(high) << bit |
+				(get_random_u32() >> (32 - bit));
+		} while (unlikely(result >= range));
+	}
+	return result;
+#endif
+}
+
+u64 __get_random_max64(u64 range);
+
+static __always_inline u64 get_random_max64(u64 range)
+{
+	/*
+	 * We may know at compile time that range is 32 bits,
+	 * even if we don't know its exact value.
+	 */
+	if (__builtin_constant_p(range <= 0xffffffff) && range <= 0xffffffff)
+		return get_random_max32(range);
+	else if (!__builtin_constant_p(range))
+		return __get_random_max64(range);
+	else if (range & (range - 1))
+		return _get_random_max64(range);
+	else
+		return get_random_u64() / (0x100000000 / (range >> 32));
+}
+#endif
+
+/**
+ * get_random_max - Generate a uniform random number 0 <= x < range
+ * @range:	Modulus for random number; must not be zero!
+ *
+ * This uses a cryptographic random number generator, for safety
+ * against malicious attackers trying to guess the output.
+ *
+ * This generates exactly uniform random numbers in the range, retrying
+ * occasionally if range is not a power of two.  If we're going to
+ * go to the expense of a cryptographic RNG, we may as well get the
+ * distribution right.
+ *
+ * Ref:
+ * 	Fast Random Integer Generation in an Interval
+ * 	Daniel Lemire
+ * 	https://arxiv.org/abs/1805.10941
+ *
+ * For less critical applications (self-tests, error injection, dithered
+ * timers), use prandom_u32_max().
+ */
+static __always_inline unsigned long get_random_max(unsigned long range)
+{
+#if BITS_PER_LONG == 64
+	return get_random_max64(range);
+#else
+	return get_random_max32(range);
+#endif
+}
+
 /*
  * On 64-bit architectures, protect against non-terminated C string overflows
  * by zeroing out the first byte of the canary; this leaves 56 bits of entropy.
@@ -151,12 +327,7 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
  * That's easy to do for constant ranges, so this code does it in that
  * case, but settles for the approimation for variable ranges.  If you
  * need exact uniformity, you might also want to use a stronger generator
- * (like get_random_u32()).
- *
- * Ref:
- * 	Fast Random Integer Generation in an Interval
- * 	Daniel Lemire
- * 	https://arxiv.org/abs/1805.10941
+ * (like get_random_max32()).
  *
  * Return: pseudo-random number in interval [0, @range)
  */
-- 
2.26.0

