Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5317C20768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFXRzzYd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1z5PlgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:59:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B28C0619D3;
        Fri, 24 Jul 2020 03:59:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595588380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o1o9WpW2esxHjKTdhQnvedFWXTWqLYXBNVNq7q3OiE=;
        b=EFXRzzYdshIvNvumE97pRVt9mbCcZ0CU3CByu7zxDamfFnccyCo6ao4lIAr2755BwfpfGr
        kst1XE9iujS1j8x/1IXlSxzPWA4ou7aKc+/ySuhhDEBWjrar3OTSFOONhzrzaHiWciEauE
        98+a/5IqF7fWlr7qG6iqwAwKdWLzxI9sWjO8CL1Ls7CNnR1nGRM2uy/nXUVzOxlbIdxgdX
        JDJFxKWi2/ckPT2lYaiBt6mrnhTXVV7FFi1EitIQ/cM6vgTupbodCvJCg0Foi1VbT/nzPh
        UbLvVU0IkqILHIH6SFOmWhEgy4kh2fFexWi6XiZ7tAUliRJjs+5KT73LG9cAqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595588380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o1o9WpW2esxHjKTdhQnvedFWXTWqLYXBNVNq7q3OiE=;
        b=i1z5PlgRIs7GoANShAW12xHuIndfjF7sgbzrbb5FS/+5iecjk48yPmqYdyMw5/vHGe0qYY
        sd/38hlNR7giV1Bw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Recalculate next timer interrupt only when
 necessary
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723151641.12236-1-frederic@kernel.org>
References: <20200723151641.12236-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159558837898.4006.13597592790372222044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     31cd0e119d50cf27ebe214d1a8f7ca36692f13a5
Gitweb:        https://git.kernel.org/tip/31cd0e119d50cf27ebe214d1a8f7ca36692f13a5
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 23 Jul 2020 17:16:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 12:49:40 +02:00

timers: Recalculate next timer interrupt only when necessary

The nohz tick code recalculates the timer wheel's next expiry on each idle
loop iteration.

On the other hand, the base next expiry is now always cached and updated
upon timer enqueue and execution. Only timer dequeue may leave
base->next_expiry out of date (but then its stale value won't ever go past
the actual next expiry to be recalculated).

Since recalculating the next_expiry isn't a free operation, especially when
the last wheel level is reached to find out that no timer has been enqueued
at all, reuse the next expiry cache when it is known to be reliable, which
it is most of the time.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200723151641.12236-1-frederic@kernel.org

---
 kernel/time/timer.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 77e21e9..96d802e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -204,6 +204,7 @@ struct timer_base {
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
+	bool			next_expiry_recalc;
 	bool			is_idle;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
@@ -593,6 +594,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * can reevaluate the wheel:
 		 */
 		base->next_expiry = bucket_expiry;
+		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
 }
@@ -836,8 +838,10 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 	if (!timer_pending(timer))
 		return 0;
 
-	if (hlist_is_singular_node(&timer->entry, base->vectors + idx))
+	if (hlist_is_singular_node(&timer->entry, base->vectors + idx)) {
 		__clear_bit(idx, base->pending_map);
+		base->next_expiry_recalc = true;
+	}
 
 	detach_timer(timer, clear_pending);
 	return 1;
@@ -1571,6 +1575,9 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		clk >>= LVL_CLK_SHIFT;
 		clk += adj;
 	}
+
+	base->next_expiry_recalc = false;
+
 	return next;
 }
 
@@ -1631,9 +1638,11 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		return expires;
 
 	raw_spin_lock(&base->lock);
-	nextevt = __next_timer_interrupt(base);
+	if (base->next_expiry_recalc)
+		base->next_expiry = __next_timer_interrupt(base);
+	nextevt = base->next_expiry;
 	is_max_delta = (nextevt == base->clk + NEXT_TIMER_MAX_DELTA);
-	base->next_expiry = nextevt;
+
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base. We can only do that when @basej is past base->clk
@@ -1725,6 +1734,12 @@ static inline void __run_timers(struct timer_base *base)
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
+		/*
+		 * The only possible reason for not finding any expired
+		 * timer at this clk is that all matching timers have been
+		 * dequeued.
+		 */
+		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 
