Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87046206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594085607;
	bh=jlK/Hyqs9cc0jFdUpMVZ/tN8XrVyN4678rXR90mQi7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdDWhXZYJ19/2h0LD7wg9pY7xal4mgCCCihCKkLHSI4AzpOJ/nbJuiArTLonf4HpY
	 W04GYfqDhskeoCDGd4gBEF/nN4DyIysPzVpNlP6z0i1iW+mH+h3NNQCbXcuQBhKZXH
	 XtMPh5Z1moNQcOh2k7HTdXnWbrHX3pB6MzjkxplU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGGBd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgGGBdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:17 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6072820708;
        Tue,  7 Jul 2020 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085595;
        bh=jlK/Hyqs9cc0jFdUpMVZ/tN8XrVyN4678rXR90mQi7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thqqfQe1/I9DEmjXACbus7OJ8iPFQwSh/NBrJsGjBG307NHDaPENsC0MG7nnxc8b9
         9K/095iAC2q/BfCou5iIGhoSNkhC5Tf1P0/7HjzlSTSqVPzC3L9Gakk2aQ01EOf/p8
         BckFOm8K2Mu2fges6Sdgh4sAg3YFoyD5cCoejz8k=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6/9] timer: Expand clk forward logic beyond nohz
Date:   Tue,  7 Jul 2020 03:32:50 +0200
Message-Id: <20200707013253.26770-7-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
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
index 501d36ef0b75..ffa2c956d968 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -885,19 +885,12 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
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
 
@@ -912,7 +905,6 @@ static inline void forward_timer_base(struct timer_base *base)
 			return;
 		base->clk = base->next_expiry;
 	}
-#endif
 }
 
 
@@ -1666,10 +1658,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -1768,16 +1758,7 @@ static inline void __run_timers(struct timer_base *base)
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
 
@@ -1790,6 +1771,7 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+	base->must_forward_clk = true;
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
-- 
2.26.2

