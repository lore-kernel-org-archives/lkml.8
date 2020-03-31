Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30E0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgCaI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:57:07 -0400
Received: from mx.sdf.org ([205.166.94.20]:59176 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgCaI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:57:06 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02V8v0Ub009740
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 08:57:00 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02V8v0M2023642;
        Tue, 31 Mar 2020 08:57:00 GMT
Date:   Tue, 31 Mar 2020 08:57:00 GMT
Message-Id: <83ee0c2ed66c1acdc1385514f5aeaba8cd124beb.1585644000.git.lkml@sdf.org>
In-Reply-To: <9916203ec97be0f24886fc8478437d161b56f053.1585644000.git.lkml@sdf.org>
References: <9916203ec97be0f24886fc8478437d161b56f053.1585644000.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Subject: [PATCH 3/3] random: use better approximation in calc_entropy_frac()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org, lkml@sdf.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than a linear approximation to 1-exp(-x) which has 25% error for
small x (the common case), this uses a quadratic approximation which is
best for small x.

Both compute the same approximation 0.375 (-4.7% error) at x=0.5, the
high end of the input range.

If the processor supports it, a 32x32->64-bit multiply is used for greater
accuracy. If not, an intermediate normalizing shift is added to ensure
the product fits into 32 bits.

This also allows ENTROPY_SHIFT to be increased to 4, tracking entropy
in 1/16 bit increments.

Signed-off-by: George Spelvin <lkml@sdf.org>
---
There's a lot of estimated entropy wasted by inaccurate accounting whwn
we add it in small increments.  This improves that.

 drivers/char/random.c | 69 +++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index de90bab5af36..b10962861c5e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -336,6 +336,7 @@
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
+#include <linux/math64.h>
 #include <crypto/chacha.h>
 
 #include <asm/processor.h>
@@ -363,13 +364,16 @@
 
 /*
  * To allow fractional bits to be tracked, the entropy_count field is
- * denominated in units of 1/8th bits.
+ * denominated in units of 1/16 bits.
  *
- * 2*(ENTROPY_SHIFT + poolbitshift) must <= 31, or the multiply in
- * credit_entropy_bits() needs to be 64 bits wide.
+ * 2*(ENTROPY_SHIFT + poolbitshift) must <= 32, or the code in
+ * entropy_frac_add() must be adjusted to use a larger first multiply.
  */
-#define ENTROPY_SHIFT 3
+#define ENTROPY_SHIFT 4
 #define ENTROPY_BITS(r) ((r)->entropy_count >> ENTROPY_SHIFT)
+#if INPUT_POOL_SHIFT + ENTROPY_SHIFT > 16
+#error Those parameters are not going to work.
+#endif
 
 /*
  * If the entropy count falls under this number of bits, then we
@@ -662,12 +666,34 @@ static void process_random_ready_list(void)
  * entropy += (capacity - entropy) * (1 - exp(-add/capacity))
  *
  * To avoid evaluating an exponential in interrupt context, we use a
- * simple fixed-point underestimate.
+ * simple fixed-point underestimate for 1 - exp(-x).  A second-order
+ * Taylor approximation works well:  x * (1 - x/2) <= 1 - exp(-x)
  *
- * For add <= capacity/2 then
- * (1 - exp(-add/capacity)) >= (add/capacity)*0.7869...
- * so we can approximate the exponential with 3/4*add/capacity and still
- * be on the safe side by adding at most capacity/2 at a time.
+ * This approximation is excellent for small x:
+ * x = 0.1 ->  0.17% low
+ * x = 0.2 ->  0.70% low
+ * x = 0.3 ->  1.61% low
+ * x = 0.4 ->  2.94% low
+ * x = 0.5 ->  4.69% low
+ * x = 1.0 -> 58.19% low
+ *
+ * It breaks (100% low) for x = 2.0, so in the rare case that add is
+ * large relative to capacity, we add the entropy a piece at a time.
+ * (We actually let the threshold equal half the pool size, but the
+ * exact value is not critical.)
+ *
+ * We are trying to compute
+ * (capacity - entropy) * (add/capacity) * (1 - add/capacity/2)
+ * using fixed-point, in fractional bits scaled by ENTROPY_SHIFT.
+ *
+ * For maximum accuracy, we'd do all the divisions last:
+ * (capacity - entropy) * add * (2*capacity - add) / (2*capacity^2)
+ * but at the maximum value of add = capacity/2, the intermediate
+ * product is almost capacity^3, which overflows 32 bits.
+ *
+ * If we are on a 64-bit processor OR have an arch-specific mul_u32_u32(),
+ * then use a 64-bit intermediate product.  Otherwise, use a normalizing
+ * shift (the smallest possible) between the two multiplies.
  */
 static int calc_entropy_frac(int add, int entropy,
 			     struct entropy_store const *r)
@@ -679,13 +705,24 @@ static int calc_entropy_frac(int add, int entropy,
 		/* Debit */
 		entropy += add;
 	} else {
-		const int s = info->poolbitshift + ENTROPY_SHIFT + 2;
-		/* The +2 corresponds to the denominator of the 3/4 */
+		const int s = info->poolbitshift + ENTROPY_SHIFT;
 
 		do {
 			unsigned int frac = min(add, capacity/2);
-			unsigned int delta = ((capacity - entropy)*frac*3) >> s;
+			u32 delta = frac * (2*capacity - frac);
 
+#if defined(mul_u32_u32) || BITS_PER_LONG == 64
+			/* Use a 64-bit product */
+			delta = mul_u32_u32(delta, capacity - entropy) >>
+				(2*s + 1);
+#else
+			/* Use only 32-bit products */
+			const int s1 = max(3*s - 32, 0);
+
+			delta >>= s1;
+			delta *= capacity - entropy;
+			delta >>= 2*s + 1 - s1;
+#endif
 			entropy += delta;
 			add -= frac;
 		} while (unlikely(add) && entropy < capacity-2);
@@ -702,12 +739,12 @@ static int calc_entropy_frac(int add, int entropy,
 		 */
 	}
 
-	if (WARN_ON(entropy < 0)) {
+	/* If out of range (should never happen), warn and clamp. */
+	if (WARN_ON(entropy < 0 || entropy > capacity)) {
 		pr_warn("negative entropy/overflow: pool %s count %d\n",
 			r->name, entropy);
-		entropy = 0;
-	} else if (unlikely(entropy > capacity))
-		entropy = capacity;
+		entropy = entropy < 0 ? 0 : capacity;
+	}
 	return entropy;
 }
 
-- 
2.26.0

