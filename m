Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D03C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508B620717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLge1KFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+vrNoGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgGQUAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgGQUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A461C0619D3;
        Fri, 17 Jul 2020 13:00:20 -0700 (PDT)
Date:   Fri, 17 Jul 2020 20:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8QqEG+PWyeIGUj5BJtNnFr39d87l3yaNX9PcbAJX6Q=;
        b=nLge1KFxpVMwY/jQWfdAq4OnC4Bdb66oj2PGJEinzE1eA26VCxzgJs02U+7/hFH4xX44c1
        szFE0akDGJ1q/52B+Y6GTn8/D1qnfPGwavNCjBV7CwWzX9HIyKMv2x+p6qgZ6MF9K1Xp1H
        +1u+bMFpNV3jOYEt6vwDa8H8UeWIN5i+Th+myK9UTzKCvz3ZIavlC/KII+92wy1EK5NLD2
        yg+9iETsjZhxR9hPN6OpTwCBkJBO5xvoPVNBDizEUajE6I6s5PepOk7wrNrNSCompL80jX
        +CooLHQEN75I68ySnUiIBR6LERJcyCA1MJ6r2xuKZdR3ptryrvOeA9vavKFZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8QqEG+PWyeIGUj5BJtNnFr39d87l3yaNX9PcbAJX6Q=;
        b=I+vrNoGXfNKWZ6NZNLtpHjiCDGpdCigFBznssAXsHdzBOaugbdhqZC6/afLjTAUuj+SmLp
        Eqz8v8z8bZdiUWBg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Always keep track of next expiry
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-8-frederic@kernel.org>
References: <20200717140551.29076-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601807.4006.17647187108834721042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dc2a0f1fb2a06df09f5094f29aea56b763aa7cca
Gitweb:        https://git.kernel.org/tip/dc2a0f1fb2a06df09f5094f29aea56b763aa7cca
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:23 +02:00

timers: Always keep track of next expiry

So far next expiry was only tracked while the CPU was in nohz_idle mode
in order to cope with missing ticks that can't increment the base->clk
periodically anymore.

This logic is going to be expanded beyond nohz in order to spare timer
softirqs so do it unconditionally.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-8-frederic@kernel.org

---
 kernel/time/timer.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9abc417..76fd964 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -544,8 +544,7 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
 }
 
 static void
-trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
-		    unsigned long bucket_expiry)
+trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
 	if (!is_timers_nohz_active())
 		return;
@@ -565,23 +564,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
 	 * timer is not deferrable. If the other CPU is on the way to idle
 	 * then it can't set base->is_idle as we hold the base lock:
 	 */
-	if (!base->is_idle)
-		return;
-
-	/*
-	 * Check whether this is the new first expiring timer. The
-	 * effective expiry time of the timer is required here
-	 * (bucket_expiry) instead of timer->expires.
-	 */
-	if (time_after_eq(bucket_expiry, base->next_expiry))
-		return;
-
-	/*
-	 * Set the next expiry time and kick the CPU so it can reevaluate the
-	 * wheel:
-	 */
-	base->next_expiry = bucket_expiry;
-	wake_up_nohz_cpu(base->cpu);
+	if (base->is_idle)
+		wake_up_nohz_cpu(base->cpu);
 }
 
 /*
@@ -592,12 +576,26 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
 static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 			  unsigned int idx, unsigned long bucket_expiry)
 {
+
 	hlist_add_head(&timer->entry, base->vectors + idx);
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
 
 	trace_timer_start(timer, timer->expires, timer->flags);
-	trigger_dyntick_cpu(base, timer, bucket_expiry);
+
+	/*
+	 * Check whether this is the new first expiring timer. The
+	 * effective expiry time of the timer is required here
+	 * (bucket_expiry) instead of timer->expires.
+	 */
+	if (time_before(bucket_expiry, base->next_expiry)) {
+		/*
+		 * Set the next expiry time and kick the CPU so it
+		 * can reevaluate the wheel:
+		 */
+		base->next_expiry = bucket_expiry;
+		trigger_dyntick_cpu(base, timer);
+	}
 }
 
 static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
@@ -1493,7 +1491,6 @@ static int __collect_expired_timers(struct timer_base *base,
 	return levels;
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Find the next pending bucket of a level. Search from level start (@offset)
  * + @clk upwards and if nothing there, search from start of the level
@@ -1585,6 +1582,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	return next;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Check, if the next hrtimer event is before the next timer wheel
  * event:
@@ -1790,6 +1788,7 @@ static inline void __run_timers(struct timer_base *base)
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
+		base->next_expiry = __next_timer_interrupt(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
@@ -2042,6 +2041,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		timer_base_init_expiry_lock(base);
 	}
 }
