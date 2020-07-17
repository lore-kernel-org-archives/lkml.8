Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B3C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9633F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbALnSUb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3RjrgWZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgGQUA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGQUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED32C0619D4;
        Fri, 17 Jul 2020 13:00:22 -0700 (PDT)
Date:   Fri, 17 Jul 2020 20:00:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjss8soWtpPFiXAK90eUEiDIttiCAj2G89/dJgLoTSE=;
        b=DbALnSUb02L4Of1gsyTcIcgRRR4L74+XKP2TPIw4ENaW25BELIOLsMkDj70J3mEyCMMX/l
        TJ3xpykNli0+X8+9LAhdnoGgww+aoHxGDSiTgPphOiBuEas5oT/Jn0UmoshWXOTWEmeoSq
        cSzBLOjRO7RyRotCEQDpDQiS4t9hRz/YKDiatVgBBwRdbV5dL/sEWnKI3XroGE9aWC06h0
        pDkW+hFXTha6rLItHTEiLqiidZRNS3bLBWLiLOxirZelg39IrD13X/VkfHM4N1nE0X2tBh
        epl35d137SdUdTaLR77b/D7w1kQz4MsNNmMRqn3WEVcVAJ2Fc6ecaxb395z2Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjss8soWtpPFiXAK90eUEiDIttiCAj2G89/dJgLoTSE=;
        b=3RjrgWZQjRa6w35ZhzTD0RsGYaXcKCPXlZjvVy4SSBgt7M0Vyf03jpkhuinAOakjXC5bKW
        U71xWjPzNUlSJmCA==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Use only bucket expiry for base->next_expiry value
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-4-frederic@kernel.org>
References: <20200717140551.29076-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501602049.4006.7427302632129124222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1f32cab0db4bdf6491eb4a60838f278e01c31698
Gitweb:        https://git.kernel.org/tip/1f32cab0db4bdf6491eb4a60838f278e01c31698
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 17 Jul 2020 16:05:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:21 +02:00

timers: Use only bucket expiry for base->next_expiry value

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
problem.

The workaround of commit 30c66fc30ee7 ("timer: Prevent base->clk from
moving backward") in trigger_dyntick_cpu() is not longer necessary as the
timers bucket expiry is guaranteed to be greater than or equal base->clk.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200717140551.29076-4-frederic@kernel.org

---
 kernel/time/timer.c | 64 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index bcdc304..a7a3cf7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -487,35 +487,39 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  * Helper function to calculate the array index for a given expiry
  * time.
  */
-static inline unsigned calc_index(unsigned long expires, unsigned lvl)
+static inline unsigned calc_index(unsigned long expires, unsigned lvl,
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
+		*bucket_expiry = clk;
 	} else {
 		/*
 		 * Force expire obscene large timeouts to expire at the
@@ -524,7 +528,7 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk)
 		if (delta >= WHEEL_TIMEOUT_CUTOFF)
 			expires = clk + WHEEL_TIMEOUT_MAX;
 
-		idx = calc_index(expires, LVL_DEPTH - 1);
+		idx = calc_index(expires, LVL_DEPTH - 1, bucket_expiry);
 	}
 	return idx;
 }
@@ -544,16 +548,18 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
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
@@ -576,31 +582,29 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
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
@@ -959,9 +963,9 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
 {
+	unsigned long clk = 0, flags, bucket_expiry;
 	struct timer_base *base, *new_base;
 	unsigned int idx = UINT_MAX;
-	unsigned long clk = 0, flags;
 	int ret = 0;
 
 	BUG_ON(!timer->function);
@@ -1000,7 +1004,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 
 		clk = base->clk;
-		idx = calc_wheel_index(expires, clk);
+		idx = calc_wheel_index(expires, clk, &bucket_expiry);
 
 		/*
 		 * Retrieve and compare the array index of the pending
@@ -1059,7 +1063,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	 */
 	if (idx != UINT_MAX && clk == base->clk) {
 		enqueue_timer(base, timer, idx);
-		trigger_dyntick_cpu(base, timer);
+		trigger_dyntick_cpu(base, timer, bucket_expiry);
 	} else {
 		internal_add_timer(base, timer);
 	}
