Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B7C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C62074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tWH0FKiy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCfBlkcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGQUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGQUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:20 -0400
Date:   Fri, 17 Jul 2020 20:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uh+iJAGufNvdwDxNyzfTqpU082+x+VkIhHoVSgZe3RU=;
        b=tWH0FKiy3IASgLOp0zbOPDIyeFjGiBNWwhH19AJdZ8cnsKu4J5BRWJejAspESO7yDbfVHN
        /aoizTlAf4HxWEpF7cWXXvC9fEae/ki6/9eRzwEXtfGagjVVbV6IK7Vd5Cc4CnwJI7E5Xx
        OXk38WNAbGTcCbqdXQjsxIPEKDfo6G/rgMYZ5J6Jx1mmjEibr7fL1SgJeVL79GNdCceY07
        sdjlGRgGwJJHH8qtvjMfVtviN+sPlLoDG3sAi4sK5bk/SN8i3wBYZWJpb4rPlQMPzcB4jY
        dkEvXmfsR4ULKTa44juqImYXntYAQfsrQQSW0bdCr7CyOOcPG2eJIsgg37YlGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uh+iJAGufNvdwDxNyzfTqpU082+x+VkIhHoVSgZe3RU=;
        b=RCfBlkcTcE2giy9P0a+IjoxEt0agSkhGwPipDvfXFbYNbID1tX2aoTm7hlhfh1oqRjoY1G
        XaR4UQho47N/gBDQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Expand clk forward logic beyond nohz
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-10-frederic@kernel.org>
References: <20200717140551.29076-10-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601684.4006.18089332729710334046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1f8a4212dc83f8353843fabf6465fd918372fbbf
Gitweb:        https://git.kernel.org/tip/1f8a4212dc83f8353843fabf6465fd918372fbbf
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:24 +02:00

timers: Expand clk forward logic beyond nohz

As for next_expiry, the base->clk catch up logic will be expanded beyond
NOHZ in order to avoid triggering useless softirqs.

If softirqs should only fire to expire pending timers, periodic base->clk
increments must be skippable for random amounts of time.  Therefore prepare
to catch-up with missing updates whenever an up-to-date base clock is
needed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-10-frederic@kernel.org

---
 kernel/time/timer.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 13f48ee..1be92b5 100644
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
