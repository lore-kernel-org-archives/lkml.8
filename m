Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C390C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8411206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1QnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:15 -0400
Received: from mx.sdf.org ([205.166.94.20]:50265 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgC1QnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:14 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh9V0022720
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:09 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh9n2025458;
        Sat, 28 Mar 2020 16:43:09 GMT
Message-Id: <202003281643.02SGh9n2025458@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sat, 16 Mar 2019 02:32:04 -0400
Subject: [RFC PATCH v1 09/50] <linux/random.h> prandom_u32_max() for
 power-of-2 ranges
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add special-case optimization for compile-time constant power-of-2
ranges (as a simple shift) so it's *always* at least as efficient as
"prandom_u32() % range".

This saves all callers from having to worry about the issue.  You
may use "% range" or "& (range - 1)" if you know the range is a
power of 2, but you don't have to.

Rename the parameter from the un-mnemonic "ep_ro" to "range".

Also expand comments, and add to prandom_32() documentation
that "prandom_u32() % range" should ''not'' be used.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 include/linux/random.h | 56 ++++++++++++++++++++++++++++++++++--------
 lib/random32.c         |  9 ++++---
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index f189c927fdea5..109772175c833 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -125,20 +125,56 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
 	DO_ONCE(prandom_seed_full_state, (pcpu_state))
 
 /**
- * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
- * @ep_ro: right open interval endpoint
+ * prandom_u32_max - returns a pseudo-random number in interval [0, @range)
+ * @range: Upper bound on the return value; the first value never returned.
  *
- * Returns a pseudo-random number that is in interval [0, ep_ro). Note
- * that the result depends on PRNG being well distributed in [0, ~0U]
- * u32 space. Here we use maximally equidistributed combined Tausworthe
- * generator, that is, prandom_u32(). This is useful when requesting a
- * random index of an array containing ep_ro elements, for example.
+ * Returns a pseudo-random number 0 <= @x < @range.
+ * This is useful when requesting a random index into an array containing
+ * @range elements, for example.  This is similar to, but more efficient
+ * than, "prandom_u32() % @range".
  *
- * Returns: pseudo-random number in interval [0, ep_ro)
+ * It's also a tiny bit more uniform than the modulo algorithm.  If @range
+ * does not divide 1<<32, then some results will occur ceil((1<<32)/@range)
+ * times, while others will occur floor((1<<32)/range) times.  The modulo
+ * algorithm makes the lowest (1<<32) % @range possible results occur
+ * more often, and the higher values all occur slightly less often.
+ *
+ * A multiplicative algorithm spreads out the over- and underrepresented
+ * outputs evenly across the range.  For example, if @range == 7, then
+ * 2, 4 and 6 occur slighty less often than 0, 1, 3 or 5.
+ *
+ * (This all assumes the PRNG is well distributed in [0, ~0U] u32 space,
+ * a property that is provided by prandom_u32().)
+ *
+ * It is possible to extend this to avoid all bias and return perfectly
+ * uniform pseudorandom numbers by discarding and regenerating sometimes,
+ * but if your needs are that stringent, you might want to use a stronger
+ * generator (like get_random_u32()).
+ *
+ * Ref:
+ * 	Fast Random Integer Generation in an Interval
+ * 	Daniel Lemire
+ * 	https://arxiv.org/abs/1805.10941
+ *
+ * Return: pseudo-random number in interval [0, @range)
  */
-static inline u32 prandom_u32_max(u32 ep_ro)
+static inline u32 prandom_u32_max(u32 range)
 {
-	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
+	/*
+	 * If the range is a compile-time constant power of 2, then use
+	 * a simple shift.  This is mathematically equivalent to the
+	 * multiplication, but GCC 8.3 doesn't optimize that perfectly.
+	 *
+	 * We could do an AND with a mask, but
+	 * 1) The shift is the same speed on a decent CPU,
+	 * 2) It's generally smaller code (smaller immediate), and
+	 * 3) Many PRNGs have trouble with their low-order bits;
+	 *    using the msbits is generaly preferred.
+	 */
+	if (__builtin_constant_p(range) && (range & (range - 1)) == 0)
+		return prandom_u32() / (u32)(0x100000000 / range);
+	else
+		return reciprocal_scale(prandom_u32(), range);
 }
 
 /*
diff --git a/lib/random32.c b/lib/random32.c
index 763b920a6206c..fc369f4e550c2 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -75,15 +75,18 @@ EXPORT_SYMBOL(prandom_u32_state);
  *	A 32 bit pseudo-random number is generated using a fast
  *	algorithm suitable for simulation. This algorithm is NOT
  *	considered safe for cryptographic use.
+ *
+ *	To generate a random number in a specified interval, use
+ *	prandom_u32_max(), which uses reciprocal_scale().  Please do
+ *	NOT use a modulo operation (prandom_u32() % range), which is
+ *	more expensive.
  */
 u32 prandom_u32(void)
 {
 	struct rnd_state *state = &get_cpu_var(net_rand_state);
-	u32 res;
+	u32 res = prandom_u32_state(state);
 
-	res = prandom_u32_state(state);
 	put_cpu_var(net_rand_state);
-
 	return res;
 }
 EXPORT_SYMBOL(prandom_u32);
-- 
2.26.0

