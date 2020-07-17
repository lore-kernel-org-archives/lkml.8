Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455ABC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1984A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glDD2lPM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPjIp4wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGQUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgGQUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:22 -0400
Date:   Fri, 17 Jul 2020 20:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQLNjIY5e8XB1h6Sghuav04ARn5JWckIJAUY2rWB7Ro=;
        b=glDD2lPM5faD1+OVwxyNUtC4hysh5vKOARDXpMKEgIC1Bmj+D8SGLEndRh3Mf1jjB1Z8Lq
        Sc+Wm6iiTcn/Tr5YYgmt9kIbWqbh9mX1xyu2vwhq1gE4tpw3ijDAtKQwCp0yJGKuWoch73
        A6P46R88wIUmblQx3w8IxWi5WsfLkFjG1SMHGlx4ihtZHEf28ZD8Xc8ueLetKLIAGbg+OT
        x/Qa29/97Hu9H1VEtmPZKXi4JqMjPp2YP+Ek8/MfZCEtoJXhggDgABhdFcYC6LwaIcz1ym
        mI0dvJuUBFSuoxpa3EwN7zC35Un1k/VJ92wBONqqG+LyLBHz3PnSvQwgw5wVEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQLNjIY5e8XB1h6Sghuav04ARn5JWckIJAUY2rWB7Ro=;
        b=lPjIp4wXxA/zlWydVLV7pOct5VM2owA35yoeDwKbH5IsfA7FbTAiSkRroIEoAovKLW82AS
        B3xqABQFxeB+dpDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Move trigger_dyntick_cpu() to enqueue_timer()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-5-frederic@kernel.org>
References: <20200717140551.29076-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601989.4006.16440988766480303346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9a2b764b06c880678416d803d027f575ae40ec99
Gitweb:        https://git.kernel.org/tip/9a2b764b06c880678416d803d027f575ae40ec99
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:22 +02:00

timers: Move trigger_dyntick_cpu() to enqueue_timer()

Consolidate the code by calling trigger_dyntick_cpu() from
enqueue_timer() instead of calling it from all its callers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-5-frederic@kernel.org

---
 kernel/time/timer.c | 61 ++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a7a3cf7..2af08a1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -533,30 +533,6 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
 	return idx;
 }
 
-/*
- * Enqueue the timer into the hash bucket, mark it pending in
- * the bitmap and store the index in the timer flags.
- */
-static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
-			  unsigned int idx)
-{
-	hlist_add_head(&timer->entry, base->vectors + idx);
-	__set_bit(idx, base->pending_map);
-	timer_set_idx(timer, idx);
-
-	trace_timer_start(timer, timer->expires, timer->flags);
-}
-
-static void
-__internal_add_timer(struct timer_base *base, struct timer_list *timer,
-		     unsigned long *bucket_expiry)
-{
-	unsigned int idx;
-
-	idx = calc_wheel_index(timer->expires, base->clk, bucket_expiry);
-	enqueue_timer(base, timer, idx);
-}
-
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
 		    unsigned long bucket_expiry)
@@ -598,15 +574,31 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer,
 	wake_up_nohz_cpu(base->cpu);
 }
 
-static void
-internal_add_timer(struct timer_base *base, struct timer_list *timer)
+/*
+ * Enqueue the timer into the hash bucket, mark it pending in
+ * the bitmap, store the index in the timer flags then wake up
+ * the target CPU if needed.
+ */
+static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
+			  unsigned int idx, unsigned long bucket_expiry)
 {
-	unsigned long bucket_expiry;
+	hlist_add_head(&timer->entry, base->vectors + idx);
+	__set_bit(idx, base->pending_map);
+	timer_set_idx(timer, idx);
 
-	__internal_add_timer(base, timer, &bucket_expiry);
+	trace_timer_start(timer, timer->expires, timer->flags);
 	trigger_dyntick_cpu(base, timer, bucket_expiry);
 }
 
+static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
+{
+	unsigned long bucket_expiry;
+	unsigned int idx;
+
+	idx = calc_wheel_index(timer->expires, base->clk, &bucket_expiry);
+	enqueue_timer(base, timer, idx, bucket_expiry);
+}
+
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
 static struct debug_obj_descr timer_debug_descr;
@@ -1057,16 +1049,13 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	/*
 	 * If 'idx' was calculated above and the base time did not advance
 	 * between calculating 'idx' and possibly switching the base, only
-	 * enqueue_timer() and trigger_dyntick_cpu() is required. Otherwise
-	 * we need to (re)calculate the wheel index via
-	 * internal_add_timer().
+	 * enqueue_timer() is required. Otherwise we need to (re)calculate
+	 * the wheel index via internal_add_timer().
 	 */
-	if (idx != UINT_MAX && clk == base->clk) {
-		enqueue_timer(base, timer, idx);
-		trigger_dyntick_cpu(base, timer, bucket_expiry);
-	} else {
+	if (idx != UINT_MAX && clk == base->clk)
+		enqueue_timer(base, timer, idx, bucket_expiry);
+	else
 		internal_add_timer(base, timer);
-	}
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
