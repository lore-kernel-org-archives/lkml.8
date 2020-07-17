Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9AF2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nB2b3//5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tLN2V/jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGQUAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgGQUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:19 -0400
Date:   Fri, 17 Jul 2020 20:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0H4Km+DI3u2+gfmwd37RZxyPdsmOzVkyKEYDnNutJU=;
        b=nB2b3//5t2qxNcM0SN38GyqpfF2DI/uBY3lnsKnO8Zlp2s+7VFRR9S60WENFecqdak4wKd
        CuCHmE0jbSSm5R+c1hC6wj4Or3g7V0SzfncsAlNHV0tmUkrrMl7WLsk3UhPQ0552m+cA3V
        RDeWnUOtbxMe07oTAM+tu+xvOvWCv6tz6MJcm/Es111Q2+KQX/xMqPDdbwscvwNgdy2tYh
        +1INYrKPVQy3nDO2MleVzDRb+/PB/LyPfO8PpRkQ3T0RCtt/Kk0x3vT96hIulY0LQuTrCJ
        7mx4nh7COiy34T5vpc/fzNsDzEGFos3PyOG0pe3L7afw/RCHa5kLQFUSp9FP8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0H4Km+DI3u2+gfmwd37RZxyPdsmOzVkyKEYDnNutJU=;
        b=tLN2V/jCr6PrPhzUJbwGOY3o3oXbTDQ6V6kp66RobOVX4WGlW2VBtrMHUAe1F55g2blaXP
        8Fb/6LTu7Ll7zpBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Remove must_forward_clk
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-12-frederic@kernel.org>
References: <20200717140551.29076-12-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601563.4006.11517295879429949452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0975fb565b8b8f9e0c96d0de39fcb954833ea5e0
Gitweb:        https://git.kernel.org/tip/0975fb565b8b8f9e0c96d0de39fcb954833ea5e0
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:25 +02:00

timers: Remove must_forward_clk

There is no reason to keep this guard around. The code makes sure that
base->clk remains sane and won't be forwarded beyond jiffies nor set
backward.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-12-frederic@kernel.org

---
 kernel/time/timer.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4f78a7b..8b3fb52 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -205,7 +205,6 @@ struct timer_base {
 	unsigned long		next_expiry;
 	unsigned int		cpu;
 	bool			is_idle;
-	bool			must_forward_clk;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -888,12 +887,13 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
 static inline void forward_timer_base(struct timer_base *base)
 {
-	unsigned long jnow;
+	unsigned long jnow = READ_ONCE(jiffies);
 
-	if (!base->must_forward_clk)
-		return;
-
-	jnow = READ_ONCE(jiffies);
+	/*
+	 * No need to forward if we are close enough below jiffies.
+	 * Also while executing timers, base->clk is 1 offset ahead
+	 * of jiffies to avoid endless requeuing to current jffies.
+	 */
 	if ((long)(jnow - base->clk) < 2)
 		return;
 
@@ -1722,16 +1722,8 @@ static inline void __run_timers(struct timer_base *base)
 	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
-	/*
-	 * timer_base::must_forward_clk must be cleared before running
-	 * timers so that any timer functions that call mod_timer() will
-	 * not try to forward the base.
-	 */
-	base->must_forward_clk = false;
-
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
-
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
@@ -1739,7 +1731,6 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->must_forward_clk = true;
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
@@ -1935,7 +1926,6 @@ int timers_prepare_cpu(unsigned int cpu)
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		base->is_idle = false;
-		base->must_forward_clk = true;
 	}
 	return 0;
 }
