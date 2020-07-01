Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B8E20771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565853;
	bh=zE2h/KnWqIiQXtP29Ne7oOk1Hqy8nujqCDYW2zkG8Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JxhhGgoa7in1e1BEYWswnGj2Pac2m5bBmQ3sN5z/Q4vKTNO02QI4kfre9xNjsq+Py
	 3MRvyf7v22zkCC+bKjYvEruVLgEr+utyjepiXglCV1W6+aqsJyvvnx0zykmeMREf1Y
	 OsLdjd+AaivQzwHFKnBGXEEo554tsIBEBVZCjz1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGABKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgGABKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:47 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041EE2078B;
        Wed,  1 Jul 2020 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565847;
        bh=zE2h/KnWqIiQXtP29Ne7oOk1Hqy8nujqCDYW2zkG8Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xxu2wmknw4B8rpJJbrcPMXqu7KLq4Ax8+t8yOwbWYhUc6ZD2ZVG4Nr1B39HTU2CRg
         DkiL8dXHfIk+L+2ACM8kRPZdCnkHc7cwJ7MKahQJGh4gH4bXJklRY6R+mw2ZKYqEub
         CdkLokiGrXstlZb31s49e6aga5gbNGgbDsNvQ/v0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 07/10] timer: Expand clk forward logic beyond nohz
Date:   Wed,  1 Jul 2020 03:10:27 +0200
Message-Id: <20200701011030.14324-8-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for next_expiry, we want to expand base->clk catch up logic beyond
nohz in order to avoid triggering useless softirqs.

If we want to fire softirqs only to expire pending timers, periodic
base->clk increments must be skippable for random amounts of time.
Therefore we must prepare to catch-up with missing updates whenever we
need an up-to-date base clock.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4612d26fd09a..6c021be0e76f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -877,19 +877,12 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
 static inline void forward_timer_base(struct timer_base *base)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	unsigned long jnow;
 
-	/*
-	 * We only forward the base when we are idle or have just come out of
-	 * idle (must_forward_clk logic), and have a delta between base clock
-	 * and jiffies. In the common case, run_timers will take care of it.
-	 */
-	if (likely(!base->must_forward_clk))
+	if (!base->must_forward_clk)
 		return;
 
 	jnow = READ_ONCE(jiffies);
-	base->must_forward_clk = base->is_idle;
 	if ((long)(jnow - base->clk) < 2)
 		return;
 
@@ -904,7 +897,6 @@ static inline void forward_timer_base(struct timer_base *base)
 			return;
 		base->clk = base->next_expiry;
 	}
-#endif
 }
 
 
@@ -1658,10 +1650,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		 * logic is only maintained for the BASE_STD base, deferrable
 		 * timers may still see large granularity skew (by design).
 		 */
-		if ((expires - basem) > TICK_NSEC) {
-			base->must_forward_clk = true;
+		if ((expires - basem) > TICK_NSEC)
 			base->is_idle = true;
-		}
 	}
 	raw_spin_unlock(&base->lock);
 
@@ -1760,16 +1750,7 @@ static inline void __run_timers(struct timer_base *base)
 	/*
 	 * timer_base::must_forward_clk must be cleared before running
 	 * timers so that any timer functions that call mod_timer() will
-	 * not try to forward the base. Idle tracking / clock forwarding
-	 * logic is only used with BASE_STD timers.
-	 *
-	 * The must_forward_clk flag is cleared unconditionally also for
-	 * the deferrable base. The deferrable base is not affected by idle
-	 * tracking and never forwarded, so clearing the flag is a NOOP.
-	 *
-	 * The fact that the deferrable base is never forwarded can cause
-	 * large variations in granularity for deferrable timers, but they
-	 * can be deferred for long periods due to idle anyway.
+	 * not try to forward the base.
 	 */
 	base->must_forward_clk = false;
 
@@ -1782,6 +1763,7 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+	base->must_forward_clk = true;
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
-- 
2.26.2

