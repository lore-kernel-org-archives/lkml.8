Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F8DC2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F66206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC1QnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:16 -0400
Received: from mx.sdf.org ([205.166.94.20]:50251 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgC1QnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:15 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhAHP029768
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:10 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhAEl008453;
        Sat, 28 Mar 2020 16:43:10 GMT
Message-Id: <202003281643.02SGhAEl008453@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 20 Dec 2019 22:30:32 -0500
Subject: [RFC PATCH v1 10/50] <linux/random.h> Make prandom_u32_max() exact
 for constant ranges
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cute hack I'm not sure should go into the kernel.
Comments very much requested!

Getting rid of the last tiny bit of non-uniformity is quite cheap
*if* the range is known at compile time: a compare with an immediate
and a (rarely taken) conditional branch to retry.

So for hack value, implement this for compile-time constant ranges.

For variable ranges, it involves a division, so just live with the
slight non-uniformity.

The style questions are:
- Is a more accurate result *some* of the time actually worth anything?
- Is the benefit enough to justify the ugly inconsistency?

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
---
 include/linux/random.h | 63 ++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 109772175c833..82dd0d613e75c 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -9,6 +9,7 @@
 
 #include <linux/list.h>
 #include <linux/once.h>
+#include <linux/math64.h>
 
 #include <uapi/linux/random.h>
 
@@ -147,9 +148,11 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
  * a property that is provided by prandom_u32().)
  *
  * It is possible to extend this to avoid all bias and return perfectly
- * uniform pseudorandom numbers by discarding and regenerating sometimes,
- * but if your needs are that stringent, you might want to use a stronger
- * generator (like get_random_u32()).
+ * uniform pseudorandom numbers by discarding and regenerating sometimes.
+ * That's easy to do for constant ranges, so this code does it in that
+ * case, but settles for the approimation for variable ranges.  If you
+ * need exact uniformity, you might also want to use a stronger generator
+ * (like get_random_u32()).
  *
  * Ref:
  * 	Fast Random Integer Generation in an Interval
@@ -160,21 +163,47 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
  */
 static inline u32 prandom_u32_max(u32 range)
 {
-	/*
-	 * If the range is a compile-time constant power of 2, then use
-	 * a simple shift.  This is mathematically equivalent to the
-	 * multiplication, but GCC 8.3 doesn't optimize that perfectly.
-	 *
-	 * We could do an AND with a mask, but
-	 * 1) The shift is the same speed on a decent CPU,
-	 * 2) It's generally smaller code (smaller immediate), and
-	 * 3) Many PRNGs have trouble with their low-order bits;
-	 *    using the msbits is generaly preferred.
-	 */
-	if (__builtin_constant_p(range) && (range & (range - 1)) == 0)
-		return prandom_u32() / (u32)(0x100000000 / range);
-	else
+	if (!__builtin_constant_p(range)) {
+		/*
+		 * If range is a variable, prioritize speed over
+		 * perfect uniformity.
+		 */
 		return reciprocal_scale(prandom_u32(), range);
+	} else if (range & (range - 1)) {
+		/*
+		 * If the range is a compile-time constant, then achieving
+		 * perfect uniformity is one compare with immediate and
+		 * one unlikely branch, so go ahead and do it.
+		 *
+		 * Some 32-bit processors require an additional
+		 * instruction to get the low half of a 64-bit product.
+		 * PowerPC and NIOS have separate "multiply high" and
+		 * "multiply low" instructions.  MIPS32 and ARC need to
+		 * move the result from a special-purpose register to
+		 * a GPR.
+		 */
+		u32 const lim = -range % range;
+		u64 prod;
+
+		do
+			prod = mul_u32_u32(prandom_u32(), range);
+		while (unlikely((u32)prod < lim));
+		return prod >> 32;
+	} else {
+		/*
+		 * If the range is a compile-time constant power of 2,
+		 * then use a simple shift.  This is mathematically
+		 * equivalent to the multiplication, but GCC 8.3 doesn't
+		 * optimize that perfectly.
+		 *
+		 * We could do an AND with a mask, but
+		 * 1) The shift is the same speed on a decent CPU,
+		 * 2) It's generally smaller code (smaller immediate), and
+		 * 3) Many PRNGs have trouble with their low-order bits;
+		 *    using the msbits is generaly preferred.
+		 */
+			return prandom_u32() / (u32)(0x100000000 / range);
+	}
 }
 
 /*
-- 
2.26.0

