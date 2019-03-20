Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1168C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD732073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgC1Qnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:50 -0400
Received: from mx.sdf.org ([205.166.94.20]:50048 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgC1Qnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:31 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhF63006381
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhFb6020546;
        Sat, 28 Mar 2020 16:43:15 GMT
Message-Id: <202003281643.02SGhFb6020546@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 20 Mar 2019 03:58:26 -0400
Subject: [RFC PATCH v1 21/50] lib/random32.c: Change to SFC32 PRNG
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Daniel Borkmann <dborkman@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to lfsr113, this is faster, smaller code, has a full 128 bits
of state, and better statistical properties on its output.

Because it has a (non-invertible) "chaotic" pseudorandom function
component, it has a 2^-k chance of being in a a state
with period less than 2^(128-k), so the average period is 2^127,
and the chance of a period shorter than 2^113 is 1/32768.

It has an absolute minimum worst-case period of 2^32,
which is still plenty to last 80 seconds between reseedings.

An alternative xoshiro128** implementation (similar size and speed,
almost as strong, period 2^128 - 1) is provided as well.  This is
primarily for pre-merge discussion, but could be left in permanently
if people want.

I'm not sure the self-test is worth keeping, as I had to generate the
test vectors myself.  But for now it's there, although simplified: each
test's seed and number of iterations is taken from the previous test.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 include/linux/random.h |  16 +-
 lib/random32.c         | 417 +++++++++++++++++++++--------------------
 2 files changed, 219 insertions(+), 214 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 82dd0d613e75c..9e30f0bb3e50b 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -115,7 +115,7 @@ void prandom_seed(u32 seed);
 void prandom_reseed_late(void);
 
 struct rnd_state {
-	__u32 s1, s2, s3, s4;
+	__u32 s[4];
 };
 
 u32 prandom_u32_state(struct rnd_state *state);
@@ -206,27 +206,19 @@ static inline u32 prandom_u32_max(u32 range)
 	}
 }
 
-/*
- * Handle minimum values for seeds
- */
-static inline u32 __seed(u32 x, u32 m)
-{
-	return (x < m) ? x + m : x;
-}
+void prandom_seed_early(struct rnd_state *state, u32 seed, bool);
 
 /**
  * prandom_seed_state - set seed for prandom_u32_state().
  * @state: pointer to state structure to receive the seed.
  * @seed: arbitrary 64-bit value to use as a seed.
+ *        (only 32 bits are actually used)
  */
 static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 {
 	u32 i = (seed >> 32) ^ (seed << 10) ^ seed;
 
-	state->s1 = __seed(i,   2U);
-	state->s2 = __seed(i,   8U);
-	state->s3 = __seed(i,  16U);
-	state->s4 = __seed(i, 128U);
+	prandom_seed_early(state, i, false);
 }
 
 #ifdef CONFIG_ARCH_RANDOM
diff --git a/lib/random32.c b/lib/random32.c
index 340696decc3bb..5d8483243c410 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -1,38 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This is a maximally equidistributed combined Tausworthe generator
- * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
+ * This is a high-speed 32-bit RNG.
  *
- * lfsr113 version:
+ * The previous lfsr113 was reasonable, but being a simple degree-113
+ * LFSR, it suffers from linear correlations among output bits.
  *
- * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
+ * We've replaced it with a choice of two generators.  Both have the
+ * same 128-bit state size, and are almost twice the speed, half the
+ * code size, and simpler to seed.
  *
- * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
- * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
- * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
- * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
+ * 1) xoshiro128**, by David Blackman and Sebastiano Vigna.
  *
- * The period of this generator is about 2^113 (see erratum paper).
+ *    This is a degree-128 LFSR implemented with xorshift techniques to
+ *    maintain a dense characteristic polynomial, with some simple but
+ *    carefully-thought-out output delinearization.
  *
- * From: P. L'Ecuyer, "Maximally Equidistributed Combined Tausworthe
- * Generators", Mathematics of Computation, 65, 213 (1996), 203--213:
- * http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme.ps
- * ftp://ftp.iro.umontreal.ca/pub/simulation/lecuyer/papers/tausme.ps
+ *    It's generally very good, but there is a slight linear correlation
+ *    in the low-order bits, which aren't as thoroughly deinearized as
+ *    the high-order bits.
  *
- * There is an erratum in the paper "Tables of Maximally Equidistributed
- * Combined LFSR Generators", Mathematics of Computation, 68, 225 (1999),
- * 261--269: http://www.iro.umontreal.ca/~lecuyer/myftp/papers/tausme2.ps
+ * 2) sfc32 ("small fast counting") by Chris Doty-Humphrey.  (Who is
+ *    also the author of the PractRand state-of-the-art PRNG test
+ *    software.)
  *
- *      ... the k_j most significant bits of z_j must be non-zero,
- *      for each j. (Note: this restriction also applies to the
- *      computer code given in [4], but was mistakenly not mentioned
- *      in that paper.)
+ *    This is a 32-bit counter coupled to a 96-bit "chaotic" generator
+ *    without a well-defined period.  It is even smaller, faster and
+ *    does better on statistical tests than xoshiro128**.
  *
- * This affects the seeding procedure by imposing the requirement
- * s1 > 1, s2 > 7, s3 > 15, s4 > 127.
+ *    It also doesn't require care to avoid all-zero initialization.
+ *
+ *    The counter forces the period to be a multiple of 2^32, so it's
+ *    never too short.  This is mutiplied by the period of the 96-bit
+ *    part, which depends on the seed.  For a b-bit random invertible
+ *    mapping, we expect an average cycle length of 2^(b-1), and there
+ *    are 2^k states on cycles of length < 2^k.  So the chance of hitting
+ *    a cycle shorter than 2^k is 2^(k-b).  The chance of hitting a
+ *    cycle shorter than 2^32 (2^64 including the counter) is 2^-64.
+ *
+ *    Because we reseed every 60 seconds anyway, even a cycle of length
+ *    2^32 is not expected to be a problem, so this is the preferred PRNG.
+ *
+ * Other options exist, such as Bob Jenkins' jsf32; see
+ * http://www.pcg-random.org/posts/bob-jenkins-small-prng-passes-practrand.html
+ * http://www.pcg-random.org/posts/some-prng-implementations.html
+ * https://github.com/dhardy/rand/issues/52  "Shootout: small, fast PRNGs"
+ * https://github.com/dhardy/rand/issues/60  "Requirements for a small fast RNG"
  */
+#define USE_SFC32 1	/* If 0, use xoshiro128** */
 
 #include <linux/types.h>
+#include <linux/bitops.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
@@ -59,13 +76,27 @@ static DEFINE_PER_CPU(struct rnd_state, net_rand_state) __latent_entropy;
  */
 u32 prandom_u32_state(struct rnd_state *state)
 {
-#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
-	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
-	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
-	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
-	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);
+#if USE_SFC32
+	u32 b = state->s[2], c = state->s[3];
+	u32 a = state->s[1] + b + state->s[0]++;
 
-	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
+	/* Another good set of constants is >>8/<<3/<<<15 */
+	state->s[1] = b ^ (b >> 9);
+	state->s[2] = c + (c << 3);
+	state->s[3] = a + rol32(c, 21);
+	return a;
+#else
+	/* xoshiro128** */
+	u32 a = state->s[0],     b = state->s[1];
+	u32 c = state->s[2] ^ a, d = state->s[3] ^ b;
+
+	state->s[0] = a ^ d;
+	state->s[1] = b ^ c;
+	state->s[2] = c ^ (b << 9);
+	state->s[3] = rol32(d, 11);
+
+	return rol32(a * 5, 7) * 9;	/* The "**" non-linear function */
+#endif
 }
 EXPORT_SYMBOL(prandom_u32_state);
 
@@ -136,14 +167,6 @@ void prandom_bytes(void *buf, size_t bytes)
 }
 EXPORT_SYMBOL(prandom_bytes);
 
-static void prandom_warmup(struct rnd_state *state)
-{
-	int i;
-	/* Calling RNG ten times to satisfy recurrence condition */
-	for (i = 0; i < 10; i++)
-		prandom_u32_state(state);
-}
-
 static u32 __extract_hwseed(void)
 {
 	unsigned int val = 0;
@@ -154,23 +177,67 @@ static u32 __extract_hwseed(void)
 	return val;
 }
 
-static void prandom_seed_early(struct rnd_state *state, u32 seed,
-			       bool mix_with_hwseed)
+/*
+ *	This is the 32-bit Murmurhash3 finalization function.
+ *	Sebastiano Vigna recommends the the Java SplitMix64 PRNG to
+ *	seed an LFSR generator.  That uses the 64-bit Murmurhash3
+ *	finalization function, so this adapts the idea to 32 bits.
+ *
+ *	Note that this function is invertible, and mix32(0) == 0.
+ *
+ *	The generator as a whole is
+ *	return mix32(seed += PHI)
+ */
+static u32 mix32(u32 x)
 {
-#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
-#define HWSEED() (mix_with_hwseed ? __extract_hwseed() : 0)
-	state->s1 = __seed(HWSEED() ^ LCG(seed),        2U);
-	state->s2 = __seed(HWSEED() ^ LCG(state->s1),   8U);
-	state->s3 = __seed(HWSEED() ^ LCG(state->s2),  16U);
-	state->s4 = __seed(HWSEED() ^ LCG(state->s3), 128U);
-	prandom_warmup(state);
+	x ^= x >> 16;
+	x *= 0x85ebca6b;
+	x ^= x >> 13;
+	x *= 0xc2b2ae35;
+	x ^= x >> 16;
+	return x;
 }
+#define PHI 0x9e3779b9	/* 2^32 * (sqrt(5)-1)/2, rounded to odd */
+
+/**
+ *	prandom_seed_early - initize rng_state based on the supplied seed.
+ *	@state: the rnd_state to initiaize
+ *	@seed: seed value
+ *	@mix_with_hwseed: flag enabling use of hardware entropy, if avaiable
+ *
+ *	This initializes the state without using the /dev/random pool
+ *	(which is assumed to not be ready yet).  If @mix_with_hwseed is
+ *	%false, the seeding is repeatable.
+ *
+ *	The test for an all-zero state is arguably pointless.  It is
+ *	impossible if @mix_with_hwseed is %false, and has probability of
+ *	2^-128 unless the hwseed generator is actively malicious.
+ */
+void prandom_seed_early(struct rnd_state *state, u32 seed, bool mix_with_hwseed)
+{
+	uint32_t bits;
+
+	do {
+		int i;
+
+		bits = 0;
+		for (i = 0; i < 4; i++) {
+			if (mix_with_hwseed)
+				seed += __extract_hwseed();
+			seed += PHI;
+			bits |= state->s[i] = mix32(seed);
+		}
+	} while (!USE_SFC32 && !likely(bits));
+}
+EXPORT_SYMBOL(prandom_seed_early);
 
 /**
  *	prandom_seed - add entropy to pseudo random number generator
  *	@entropy: entropy value
  *
- *	Add some additional entropy to the prandom pool.
+ *	Add up to 32 bits more entropy to the prandom pool.  This is
+ *	added to the existing state rather than overwriting it.
+ *	The same entropy is used on each CPU.
  */
 void prandom_seed(u32 entropy)
 {
@@ -181,9 +248,34 @@ void prandom_seed(u32 entropy)
 	 */
 	for_each_possible_cpu(i) {
 		struct rnd_state *state = &per_cpu(net_rand_state, i);
+		u32 t;
+#if USE_SFC32
+		/*
+		 * For SFC32, there are no constraints on the state,
+		 * so a race condition is not a problem.
+		 */
+		entropy += i;	/* Tweak each CPU slightly differently */
+		t = READ_ONCE(state->s[0]) + entropy;
+		WRITE_ONCE(state->s[0], t);
+#else
+		int j;
 
-		state->s1 = __seed(state->s1 ^ entropy, 2U);
-		prandom_warmup(state);
+		entropy += i;	/* Tweak each CPU slightly differently */
+		/*
+		 * For xoshiro128, we need to ensure we don't set the
+		 * state to 0.	We can't verify this atomically across
+		 * the multi-word state, so solve it the simple way:
+		 * refuse to write any single word of zero.
+		 */
+		for (j = 0; j < 4; j++) {
+			t = READ_ONCE(state->s[j]) + entropy;
+			if (likely(t)) {
+				WRITE_ONCE(state->s[j], t);
+				break;
+			}
+			/* Else try next word, or skip this generator */
+		}
+#endif
 	}
 }
 EXPORT_SYMBOL(prandom_seed);
@@ -222,33 +314,39 @@ static void __prandom_timer(struct timer_list *unused)
 	prandom_seed(entropy);
 
 	/* reseed every ~60 seconds, in [40 .. 80) interval with slack */
-	expires = 40 + prandom_u32_max(40);
-	seed_timer.expires = jiffies + msecs_to_jiffies(expires * MSEC_PER_SEC);
+	expires = 40 * HZ + prandom_u32_max(40 * HZ);
+	seed_timer.expires = jiffies + expires;
 
 	add_timer(&seed_timer);
 }
 
 static void __init __prandom_start_seed_timer(void)
 {
-	seed_timer.expires = jiffies + msecs_to_jiffies(40 * MSEC_PER_SEC);
+	seed_timer.expires = jiffies + 40 * HZ;
 	add_timer(&seed_timer);
 }
 
+/**
+ *	prandom_seed_full_state - Reseed PRNG with full entropy
+ *	@pcpu_state: Per-CPU state to update
+ *
+ *	Now that /dev/random is available, generate a full-entropy state.
+ */
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 {
-	int i;
+	int i, j;
 
 	for_each_possible_cpu(i) {
-		struct rnd_state *state = per_cpu_ptr(pcpu_state, i);
-		u32 seeds[4];
+		struct rnd_state state;
+		u32 bits = 0;
 
-		get_random_bytes(&seeds, sizeof(seeds));
-		state->s1 = __seed(seeds[0],   2U);
-		state->s2 = __seed(seeds[1],   8U);
-		state->s3 = __seed(seeds[2],  16U);
-		state->s4 = __seed(seeds[3], 128U);
+		do {
+			bits = 0;
+			for (j = 0; j < 4; j++)
+				bits |= state.s[j] = get_random_u32();
+		} while (!USE_SFC32 && !likely(bits));
 
-		prandom_warmup(state);
+		*(struct rnd_state *)per_cpu_ptr(pcpu_state, i) = state;
 	}
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
@@ -299,161 +397,76 @@ static int __init prandom_reseed(void)
 late_initcall(prandom_reseed);
 
 #ifdef CONFIG_RANDOM32_SELFTEST
-static struct prandom_test1 {
-	u32 seed;
-	u32 result;
-} test1[] = {
-	{ 1U, 3484351685U },
-	{ 2U, 2623130059U },
-	{ 3U, 3125133893U },
-	{ 4U,  984847254U },
-};
-
-static struct prandom_test2 {
-	u32 seed;
-	u32 iteration;
-	u32 result;
-} test2[] = {
-	/* Test cases against taus113 from GSL library. */
-	{  931557656U, 959U, 2975593782U },
-	{ 1339693295U, 876U, 3887776532U },
-	{ 1545556285U, 961U, 1615538833U },
-	{  601730776U, 723U, 1776162651U },
-	{ 1027516047U, 687U,  511983079U },
-	{  416526298U, 700U,  916156552U },
-	{ 1395522032U, 652U, 2222063676U },
-	{  366221443U, 617U, 2992857763U },
-	{ 1539836965U, 714U, 3783265725U },
-	{  556206671U, 994U,  799626459U },
-	{  684907218U, 799U,  367789491U },
-	{ 2121230701U, 931U, 2115467001U },
-	{ 1668516451U, 644U, 3620590685U },
-	{  768046066U, 883U, 2034077390U },
-	{ 1989159136U, 833U, 1195767305U },
-	{  536585145U, 996U, 3577259204U },
-	{ 1008129373U, 642U, 1478080776U },
-	{ 1740775604U, 939U, 1264980372U },
-	{ 1967883163U, 508U,   10734624U },
-	{ 1923019697U, 730U, 3821419629U },
-	{  442079932U, 560U, 3440032343U },
-	{ 1961302714U, 845U,  841962572U },
-	{ 2030205964U, 962U, 1325144227U },
-	{ 1160407529U, 507U,  240940858U },
-	{  635482502U, 779U, 4200489746U },
-	{ 1252788931U, 699U,  867195434U },
-	{ 1961817131U, 719U,  668237657U },
-	{ 1071468216U, 983U,  917876630U },
-	{ 1281848367U, 932U, 1003100039U },
-	{  582537119U, 780U, 1127273778U },
-	{ 1973672777U, 853U, 1071368872U },
-	{ 1896756996U, 762U, 1127851055U },
-	{  847917054U, 500U, 1717499075U },
-	{ 1240520510U, 951U, 2849576657U },
-	{ 1685071682U, 567U, 1961810396U },
-	{ 1516232129U, 557U,    3173877U },
-	{ 1208118903U, 612U, 1613145022U },
-	{ 1817269927U, 693U, 4279122573U },
-	{ 1510091701U, 717U,  638191229U },
-	{  365916850U, 807U,  600424314U },
-	{  399324359U, 702U, 1803598116U },
-	{ 1318480274U, 779U, 2074237022U },
-	{  697758115U, 840U, 1483639402U },
-	{ 1696507773U, 840U,  577415447U },
-	{ 2081979121U, 981U, 3041486449U },
-	{  955646687U, 742U, 3846494357U },
-	{ 1250683506U, 749U,  836419859U },
-	{  595003102U, 534U,  366794109U },
-	{   47485338U, 558U, 3521120834U },
-	{  619433479U, 610U, 3991783875U },
-	{  704096520U, 518U, 4139493852U },
-	{ 1712224984U, 606U, 2393312003U },
-	{ 1318233152U, 922U, 3880361134U },
-	{  855572992U, 761U, 1472974787U },
-	{   64721421U, 703U,  683860550U },
-	{  678931758U, 840U,  380616043U },
-	{  692711973U, 778U, 1382361947U },
-	{  677703619U, 530U, 2826914161U },
-	{   92393223U, 586U, 1522128471U },
-	{ 1222592920U, 743U, 3466726667U },
-	{  358288986U, 695U, 1091956998U },
-	{ 1935056945U, 958U,  514864477U },
-	{  735675993U, 990U, 1294239989U },
-	{ 1560089402U, 897U, 2238551287U },
-	{   70616361U, 829U,   22483098U },
-	{  368234700U, 731U, 2913875084U },
-	{   20221190U, 879U, 1564152970U },
-	{  539444654U, 682U, 1835141259U },
-	{ 1314987297U, 840U, 1801114136U },
-	{ 2019295544U, 645U, 3286438930U },
-	{  469023838U, 716U, 1637918202U },
-	{ 1843754496U, 653U, 2562092152U },
-	{  400672036U, 809U, 4264212785U },
-	{  404722249U, 965U, 2704116999U },
-	{  600702209U, 758U,  584979986U },
-	{  519953954U, 667U, 2574436237U },
-	{ 1658071126U, 694U, 2214569490U },
-	{  420480037U, 749U, 3430010866U },
-	{  690103647U, 969U, 3700758083U },
-	{ 1029424799U, 937U, 3787746841U },
-	{ 2012608669U, 506U, 3362628973U },
-	{ 1535432887U, 998U,   42610943U },
-	{ 1330635533U, 857U, 3040806504U },
-	{ 1223800550U, 539U, 3954229517U },
-	{ 1322411537U, 680U, 3223250324U },
-	{ 1877847898U, 945U, 2915147143U },
-	{ 1646356099U, 874U,  965988280U },
-	{  805687536U, 744U, 4032277920U },
-	{ 1948093210U, 633U, 1346597684U },
-	{  392609744U, 783U, 1636083295U },
-	{  690241304U, 770U, 1201031298U },
-	{ 1360302965U, 696U, 1665394461U },
-	{ 1220090946U, 780U, 1316922812U },
-	{  447092251U, 500U, 3438743375U },
-	{ 1613868791U, 592U,  828546883U },
-	{  523430951U, 548U, 2552392304U },
-	{  726692899U, 810U, 1656872867U },
-	{ 1364340021U, 836U, 3710513486U },
-	{ 1986257729U, 931U,  935013962U },
-	{  407983964U, 921U,  728767059U },
+static __initdata u32 const test[] = {
+#if USE_SFC32
+	0x407c165f, 0x26d64060, 0x360dd67d, 0x8bda9739, 0x09e072e0,
+	0x886ae46c, 0x68c2f971, 0x0d25c05e, 0x4948e74d, 0x33fdb19a,
+	0x88b4b1c4, 0x4bee251d, 0xccad3b64, 0x6acbf134, 0x1f1a56e0,
+	0xdf7672e2, 0x4dd55a89, 0x61eafade, 0x2a9d29cf, 0xfa3e29c6,
+	0xa67a376b, 0x0d542b47, 0xb1d9db30, 0x3c25aefa, 0x17d0939f,
+	0x692ef735, 0xc715a5c7, 0xe94dc7e7, 0xd8a5bfdb, 0x76f8a13c,
+	0xeadb5735, 0x92cfea8c, 0x1bd0005c, 0x76c6904a, 0x22c4cdc5,
+	0x1261e293, 0xf7f84c4c, 0x9f03f8bb, 0x500c89b2, 0x4b4f2ea8,
+	0x8853ba76, 0x1feb559c, 0x14488b03, 0x94f30876, 0x1636a9d6,
+	0x1bf3fed7, 0x9bb1d67a, 0x3f303d02, 0xa098f822, 0x904277bb,
+	0xb959c580, 0x159e8c1a, 0xe6d4cbdd, 0xb69cf144, 0x0c7ed841,
+	0xd27e51a0, 0x2e329e85, 0x97dac24f, 0xfd054b13, 0xed3894f7,
+	0x5e2942c0, 0x1e6bdb16, 0xd24381d1, 0x1ea3c97e, 0xd4aae3b3,
+	0xbd97dea9, 0x5e2d2360, 0x2d9e64d7, 0x0c174436, 0x6bb9c3af,
+	0xeaa7e342, 0x20e93d17, 0xad04122c, 0x9e8be9bf, 0x570e3995,
+	0x2ad35058, 0x98acd44f, 0xe31b8e22, 0xf4941774, 0x5fd2ec0d,
+	0x8a65db0b, 0x9db49f02, 0xbb07a933, 0x9cbec2f8, 0x57062d68,
+	0x5408a093, 0x708e9b3d, 0xecfd5b64, 0x5d8866aa, 0x9e626bca,
+	0x5433a668, 0x6125b24b, 0xcf1b1c04, 0xedbba671, 0x9fc73764,
+	0x6516bf38, 0x9fa794a3, 0xb8a9db6e, 0x1a5bbc62, 0x3bd4bcb5,
+#else
+	0x25ebebb8, 0xdae5c8b0, 0x743366be, 0xc59ea20d, 0x79a64903,
+	0x424d36c5, 0x32577004, 0x9abc1914, 0x023d1d62, 0x857b5688,
+	0xeec24cd1, 0x7b1bd1c8, 0x41f84582, 0x8ffedbd7, 0xfc42746f,
+	0x5df57792, 0x4947bc73, 0x41c34b17, 0x47707cef, 0x37146f37,
+	0x4d450d3d, 0xa1342ea2, 0x2b1f99c5, 0xe5ff31b3, 0x51c03e80,
+	0x668c8bc5, 0xe92c867c, 0xd00f41ba, 0x370603f9, 0x2c19def4,
+	0x74ce1d73, 0x660ec8ad, 0xc3dd0ce8, 0x3e17c799, 0xc6780a37,
+	0x4463a2b1, 0x36c2928c, 0x2551157b, 0xdae1c7cf, 0x66d3ef50,
+	0x00bb5f72, 0xb4072af8, 0x9f5b0c86, 0x840006cf, 0xfb80d203,
+	0x2d572afd, 0x4d1723b2, 0x0de8b8db, 0xd0c955ee, 0xde5630db,
+	0xa36adb5e, 0xc805a0a7, 0x2c326a73, 0x3f557ca7, 0xab0c3c9c,
+	0x5c734e35, 0x38c8cb5a, 0x55fbef10, 0x936c0ee6, 0x88aa9720,
+	0xaffc1697, 0x82996484, 0x4ad8caf2, 0x6dc25bd1, 0x3dc0a146,
+	0xd2a3dec1, 0x1695fe90, 0x1aeeb5ba, 0xce84a0a9, 0x044187d5,
+	0x258f90f7, 0xdec9e55d, 0xd71bc402, 0xcf07ab54, 0x3634ec91,
+	0x9cfd3774, 0x82aefdc3, 0x84a1e597, 0xce69b404, 0xa203fe00,
+	0xf6b4b5f1, 0x281c7bef, 0x5d02d6a2, 0xae8f76b0, 0x767fa406,
+	0x55e3a349, 0xf483a703, 0xf5f0734b, 0xd893fb07, 0x0f5e55fb,
+	0x9ffffcb4, 0x27d8f13f, 0x99a917f3, 0x1ee15e0d, 0xe7ff200d,
+	0xfd8a2ace, 0xd15ad883, 0x7d3821e9, 0xf044aba6, 0xaff4b00b,
+#endif
 };
 
 static void __init prandom_state_selftest(void)
 {
-	int i, j, errors = 0, runs = 0;
-	bool error = false;
+	int i, errors = 0, iter = 1;
+	u32 seed = 1, sum = 0;
 
-	for (i = 0; i < ARRAY_SIZE(test1); i++) {
+	for (i = 0; i < ARRAY_SIZE(test); i++) {
 		struct rnd_state state;
 
-		prandom_seed_early(&state, test1[i].seed, false);
+		prandom_seed_early(&state, seed, false);
 
-		if (test1[i].result != prandom_u32_state(&state))
-			error = true;
-	}
+		do
+			seed = prandom_u32_state(&state);
+		while (--iter);
 
-	if (error)
-		pr_warn("prandom: seed boundary self test failed\n");
-	else
-		pr_info("prandom: seed boundary self test passed\n");
-
-	for (i = 0; i < ARRAY_SIZE(test2); i++) {
-		struct rnd_state state;
-
-		prandom_seed_early(&state, test2[i].seed, false);
-
-		for (j = 0; j < test2[i].iteration - 1; j++)
-			prandom_u32_state(&state);
-
-		if (test2[i].result != prandom_u32_state(&state))
-			errors++;
-
-		runs++;
+		errors += (test[i] != seed);
+		seed = test[i];
+		sum += seed;
+		iter = (int)((uint64_t)500 * sum >> 32) + 500;
 		cond_resched();
 	}
 
 	if (errors)
-		pr_warn("prandom: %d/%d self tests failed\n", errors, runs);
+		pr_warn("prandom: %d/%d self tests failed\n", errors, i);
 	else
-		pr_info("prandom: %d self tests passed\n", runs);
+		pr_info("prandom: %d self tests passed\n", i);
 }
 #endif
-- 
2.26.0

