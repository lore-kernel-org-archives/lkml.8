Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DABC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DE820848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgCaI5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:57:11 -0400
Received: from mx.sdf.org ([205.166.94.20]:59173 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgCaI5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:57:06 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02V8uxem021803
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 08:57:00 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02V8uxMY024939;
        Tue, 31 Mar 2020 08:56:59 GMT
Date:   Tue, 31 Mar 2020 08:56:59 GMT
Message-Id: <35dd80650fe673c446a5a016b51b6680ce49350d.1585644000.git.lkml@sdf.org>
In-Reply-To: <9916203ec97be0f24886fc8478437d161b56f053.1585644000.git.lkml@sdf.org>
References: <9916203ec97be0f24886fc8478437d161b56f053.1585644000.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Subject: [PATCH 2/3] random: Factor helper calc_entropy_frac() out of
 credit_entropy_bits()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org, lkml@sdf.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper is mathematically complex, with a large comment
explaining it.  credit_entropy_bits() has atomicity complexity.
Breaking them apart makes both easier to read and understand.

No functional change.

Signed-off-by: George Spelvin <lkml@sdf.org>
---
And it makes the approximation easier to change in the next patch.

 drivers/char/random.c | 114 +++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 273dcbb4a790..de90bab5af36 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -653,6 +653,64 @@ static void process_random_ready_list(void)
 	spin_unlock_irqrestore(&random_ready_list_lock, flags);
 }
 
+/*
+ * Add some new entropy to an existing pool with finite capacity.  We have
+ * to account for the possibility of overwriting already present entropy.
+ * Even in the ideal case of pure Shannon entropy, new contributions
+ * approach the pool capacity asymptotically:
+ *
+ * entropy += (capacity - entropy) * (1 - exp(-add/capacity))
+ *
+ * To avoid evaluating an exponential in interrupt context, we use a
+ * simple fixed-point underestimate.
+ *
+ * For add <= capacity/2 then
+ * (1 - exp(-add/capacity)) >= (add/capacity)*0.7869...
+ * so we can approximate the exponential with 3/4*add/capacity and still
+ * be on the safe side by adding at most capacity/2 at a time.
+ */
+static int calc_entropy_frac(int add, int entropy,
+			     struct entropy_store const *r)
+{
+	struct poolinfo const *info = r->poolinfo;
+	const int capacity = info->poolfracbits;
+
+	if (add < 0) {
+		/* Debit */
+		entropy += add;
+	} else {
+		const int s = info->poolbitshift + ENTROPY_SHIFT + 2;
+		/* The +2 corresponds to the denominator of the 3/4 */
+
+		do {
+			unsigned int frac = min(add, capacity/2);
+			unsigned int delta = ((capacity - entropy)*frac*3) >> s;
+
+			entropy += delta;
+			add -= frac;
+		} while (unlikely(add) && entropy < capacity-2);
+		/*
+		 * Because we're careful to always round down, the pool
+		 * will never be completely full.  In fact, the maximum
+		 * delta is 3/8 of the space remaining, which means that 3
+		 * fractional bits remaining will round to +1, but 2 will
+		 * round to +0, so there's no sense continuing.
+		 *
+		 * Stopping at capacity-2 also limits the loop to
+		 * log2(pool_size)/log2(5/8) = 1.475*log2(pool_size)
+		 * iterations no matter how large add is.
+		 */
+	}
+
+	if (WARN_ON(entropy < 0)) {
+		pr_warn("negative entropy/overflow: pool %s count %d\n",
+			r->name, entropy);
+		entropy = 0;
+	} else if (unlikely(entropy > capacity))
+		entropy = capacity;
+	return entropy;
+}
+
 /*
  * Credit (or debit) the entropy store with n bits of entropy.
  * Use credit_entropy_bits_safe() if the value comes from userspace
@@ -661,61 +719,15 @@ static void process_random_ready_list(void)
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
 	int entropy_count, orig;
-	const int pool_size = r->poolinfo->poolfracbits;
-	int nfrac = nbits << ENTROPY_SHIFT;
 
 	if (!nbits)
 		return;
 
-retry:
-	entropy_count = orig = READ_ONCE(r->entropy_count);
-	if (nfrac < 0) {
-		/* Debit */
-		entropy_count += nfrac;
-	} else {
-		/*
-		 * Credit: we have to account for the possibility of
-		 * overwriting already present entropy.	 Even in the
-		 * ideal case of pure Shannon entropy, new contributions
-		 * approach the full value asymptotically:
-		 *
-		 * entropy <- entropy + (pool_size - entropy) *
-		 *	(1 - exp(-add_entropy/pool_size))
-		 *
-		 * For add_entropy <= pool_size/2 then
-		 * (1 - exp(-add_entropy/pool_size)) >=
-		 *    (add_entropy/pool_size)*0.7869...
-		 * so we can approximate the exponential with
-		 * 3/4*add_entropy/pool_size and still be on the
-		 * safe side by adding at most pool_size/2 at a time.
-		 *
-		 * The use of pool_size-2 in the while statement is to
-		 * prevent rounding artifacts from making the loop
-		 * arbitrarily long; this limits the loop to log2(pool_size)*2
-		 * turns no matter how large nbits is.
-		 */
-		int pnfrac = nfrac;
-		const int s = r->poolinfo->poolbitshift + ENTROPY_SHIFT + 2;
-		/* The +2 corresponds to the /4 in the denominator */
-
-		do {
-			unsigned int anfrac = min(pnfrac, pool_size/2);
-			unsigned int add =
-				((pool_size - entropy_count)*anfrac*3) >> s;
-
-			entropy_count += add;
-			pnfrac -= anfrac;
-		} while (unlikely(entropy_count < pool_size-2 && pnfrac));
-	}
-
-	if (WARN_ON(entropy_count < 0)) {
-		pr_warn("negative entropy/overflow: pool %s count %d\n",
-			r->name, entropy_count);
-		entropy_count = 0;
-	} else if (entropy_count > pool_size)
-		entropy_count = pool_size;
-	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
-		goto retry;
+	do {
+		orig = READ_ONCE(r->entropy_count);
+		entropy_count = calc_entropy_frac(nbits << ENTROPY_SHIFT,
+						  orig, r);
+	} while (cmpxchg(&r->entropy_count, orig, entropy_count) != orig);
 
 	entropy_count >>= ENTROPY_SHIFT;	/* Convert to bits */
 	trace_credit_entropy_bits(r->name, nbits, entropy_count, _RET_IP_);
-- 
2.26.0

