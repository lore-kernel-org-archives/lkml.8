Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E2C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A05020748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKul93iZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRwJOlDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGJPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:46:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316EC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:46:39 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594395997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sIS/2RRBcfFqLgnnVqNnkF4t3ZMMdRA1nNxO67jYgI8=;
        b=xKul93iZauddBwhqMRmWACfcliOkQpvg37QoOm3mSBbStkqj+HpnZyu+YKnESJnztfIsMe
        W7b9Y/uZusaXSw8uCe5U3KupEoi2NBGRe9zCovaZMjOEZ5mJt8F2ibiFIZWU+GcFqCE5RT
        JJOSpjCCCD9MZXICTIY63B1uYDrosI+IPSvpUgU9hPsw8yn3xcB/bGeUZNSyyDk0sJeME5
        B+WesHdl360qoinyfvbu7KYZTf6SXn6k3ZIWARK5gxOnQqUrB72Vx2hHr36EJgk3V/j9Fo
        JdWdC31edeZncM9NvLMT+9A4qWgy1k7ls4t6YJqtXvNhwjC1ry9VNGdMdkFqAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594395997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sIS/2RRBcfFqLgnnVqNnkF4t3ZMMdRA1nNxO67jYgI8=;
        b=vRwJOlDfgpiEvC4dI4I6m/eirl3JfuAOio/bxf713pGN19Gbk3RlFcgExZZREB8QojupJq
        Uv/83N0aWU/PprCw==
To:     linux-kernel@vger.kernel.org
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] timers: Use only bucket expiry for base->next_expiry value
Date:   Fri, 10 Jul 2020 17:46:22 +0200
Message-Id: <20200710154622.14989-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bucket expiry time is the effective expriy time of timers and is
greater than or equal to the requested timer expiry time. This is due
to the guarantee that timers never expire early and the reduced expiry
granularity in the secondary wheel levels.

When a timer is enqueued, trigger_dyntick_cpu() checks whether the
timer is the new first timer. This check compares next_expiry with
the requested timer expiry value and not with the effective expiry
value of the bucket into which the timer was queued.

Storing the requested timer expiry value in base->next_expiry can lead
to base->clk going backwards if the requested timer expiry value is
smaller than base->clk. Commit 30c66fc30ee7 ("timer: Prevent base->clk
from moving backward") worked around this by preventing the store when
timer->expiry is before base->clk, but did not fix the underlying
problem.

Use the expiry value of the bucket into which the timer is queued to
do the new first timer check. This fixes the base->clk going backward
problem and also prevents unnecessary softirq invocations when the
timer->expiry is not equal to the bucket expiry time in case of a new
first timer which is queued in a secondary wheel level.

The workaround of commit 30c66fc30ee7 ("timer: Prevent base->clk from
moving backward")is not longer necessary as the timers bucket expiry is
guaranteed to be greater than or equal base->clk.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---

The patch applies on top of tip: timers/urgent

 kernel/time/timer.c | 63 ++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9a838d38dbe6..ccdf3b73db72 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,33 +487,36 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  * Helper function to calculate the array index for a given expiry
  * time.
  */
-static inline unsigned calc_index(unsigned expires, unsigned lvl)
+static inline unsigned calc_index(unsigned expires, unsigned lvl,
+				  unsigned long *bucket_expiry)
 {
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
 
-static int calc_wheel_index(unsigned long expires, unsigned long clk)
+static int calc_wheel_index(unsigned long expires, unsigned long clk,
+			    unsigned long *bucket_expiry)
 {
 	unsigned long delta = expires - clk;
 	unsigned int idx;
 
 	if (delta < LVL_START(1)) {
-		idx = calc_index(expires, 0);
+		idx = calc_index(expires, 0, bucket_expiry);
 	} else if (delta < LVL_START(2)) {
-		idx = calc_index(expires, 1);
+		idx = calc_index(expires, 1, bucket_expiry);
 	} else if (delta < LVL_START(3)) {
-		idx = calc_index(expires, 2);
+		idx = calc_index(expires, 2, bucket_expiry);
 	} else if (delta < LVL_START(4)) {
-		idx = calc_index(expires, 3);
+		idx = calc_index(expires, 3, bucket_expiry);
 	} else if (delta < LVL_START(5)) {
-		idx = calc_index(expires, 4);
+		idx = calc_index(expires, 4, bucket_expiry);
 	} else if (delta < LVL_START(6)) {
-		idx = calc_index(expires, 5);
+		idx = calc_index(expires, 5, bucket_expiry);
 	} else if (delta < LVL_START(7)) {
-		idx = calc_index(expires, 6);
+		idx = calc_index(expires, 6, bucket_expiry);
 	} else if (LVL_DEPTH > 8 && delta < LVL_START(8)) {
-		idx = calc_index(expires, 7);
+		idx = calc_index(expires, 7, bucket_expiry);
 	} else if ((long) delta < 0) {
 		idx = clk & LVL_MASK;
 	} else {
@@ -524,7 +527,7 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk)
 		if (expires >= WHEEL_TIMEOUT_CUTOFF)
 			expires = WHEEL_TIMEOUT_MAX;
 
-		idx = calc_index(expires, LVL_DEPTH - 1);
+		idx = calc_index(expires, LVL_DEPTH - 1, bucket_expiry);
 	}
 	return idx;
 }
@@ -544,16 +547,18 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 }
 
 static void
-__internal_add_timer(struct timer_base *base, struct timer_list *timer)
+__internal_add_timer(struct timer_base *base, struct timer_list *timer,
+		     unsigned long *bucket_expiry)
 {
 	unsigned int idx;
 
-	idx = calc_wheel_index(timer->expires, base->clk);
+	idx = calc_wheel_index(timer->expires, base->clk, bucket_expiry);
 	enqueue_timer(base, timer, idx);
 }
 
 static void
-trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
+trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
+		    unsigned long bucket_expiry)
 {
 	if (!is_timers_nohz_active())
 		return;
@@ -576,31 +581,29 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	if (!base->is_idle)
 		return;
 
-	/* Check whether this is the new first expiring timer: */
-	if (time_after_eq(timer->expires, base->next_expiry))
+	/*
+	 * Check whether this is the new first expiring timer. The
+	 * effective expiry time of the timer is required here
+	 * (bucket_expiry) instead of timer->expires.
+	 */
+	if (time_after_eq(bucket_expiry, base->next_expiry))
 		return;
 
 	/*
 	 * Set the next expiry time and kick the CPU so it can reevaluate the
 	 * wheel:
 	 */
-	if (time_before(timer->expires, base->clk)) {
-		/*
-		 * Prevent from forward_timer_base() moving the base->clk
-		 * backward
-		 */
-		base->next_expiry = base->clk;
-	} else {
-		base->next_expiry = timer->expires;
-	}
+	base->next_expiry = bucket_expiry;
 	wake_up_nohz_cpu(base->cpu);
 }
 
 static void
 internal_add_timer(struct timer_base *base, struct timer_list *timer)
 {
-	__internal_add_timer(base, timer);
-	trigger_dyntick_cpu(base, timer);
+	unsigned long bucket_expiry;
+
+	__internal_add_timer(base, timer, &bucket_expiry);
+	trigger_dyntick_cpu(base, timer, bucket_expiry);
 }
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
@@ -959,9 +962,9 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
 {
+	unsigned long clk = 0, flags, bucket_expiry;
 	struct timer_base *base, *new_base;
 	unsigned int idx = UINT_MAX;
-	unsigned long clk = 0, flags;
 	int ret = 0;
 
 	BUG_ON(!timer->function);
@@ -1000,7 +1003,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 
 		clk = base->clk;
-		idx = calc_wheel_index(expires, clk);
+		idx = calc_wheel_index(expires, clk, &bucket_expiry);
 
 		/*
 		 * Retrieve and compare the array index of the pending
@@ -1059,7 +1062,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	 */
 	if (idx != UINT_MAX && clk == base->clk) {
 		enqueue_timer(base, timer, idx);
-		trigger_dyntick_cpu(base, timer);
+		trigger_dyntick_cpu(base, timer, bucket_expiry);
 	} else {
 		internal_add_timer(base, timer);
 	}
-- 
2.20.1

