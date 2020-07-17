Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE9C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A3C2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994779;
	bh=EDDWXKvWEloZZ0qlv+ipxm9USc1hVYn2fgjl76vVANQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJbnRiM5FBwPjkU7aFqwFEZe6IhHRiTIQn8xBgrOpC90uxBADGWLLCMkiXm+vP8Fs
	 Sx2t2t3DkP3hciRPfY/48U0oc+xJyyTCN8KE7FJPyLNoSZsC4RE2JGWx+sx/i8Ue6m
	 bD2UMKNFzW4db66wQ+CYG06jAousHEE0ZQHcEM8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGQOGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGQOGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:12 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493C522C9C;
        Fri, 17 Jul 2020 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994771;
        bh=EDDWXKvWEloZZ0qlv+ipxm9USc1hVYn2fgjl76vVANQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnpcj7pJaiUkRKq1YL3UEQWnoyldf3Ws+wJ4iw9HC8lR3I4QGBW6g8AFXqbL0k6sd
         TxbAk+fwtTEvxGLYeq56wtj/Q2lTo4x9evDUGq01RcPJLlTpm8gowoWn1Zt3Ubdkzp
         Qxy5b2VlW3inWSNRwqji+L+uSfjD5xX5AJ77fBoE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 09/12] timer: Expand clk forward logic beyond nohz
Date:   Fri, 17 Jul 2020 16:05:48 +0200
Message-Id: <20200717140551.29076-10-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
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

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 13f48ee708aa..1be92b53b75f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -888,19 +888,12 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
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
 
@@ -915,7 +908,6 @@ static inline void forward_timer_base(struct timer_base *base)
 			return;
 		base->clk = base->next_expiry;
 	}
-#endif
 }
 
 
@@ -1667,10 +1659,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -1769,16 +1759,7 @@ static inline void __run_timers(struct timer_base *base)
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
 
@@ -1791,6 +1772,7 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+	base->must_forward_clk = true;
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
-- 
2.26.2

