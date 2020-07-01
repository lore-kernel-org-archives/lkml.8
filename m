Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8432720780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565855;
	bh=TkNGgrqX4DuoPRYiKCidraOvpBZ4CbPraEJ/I0LaPyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSLaJVkt74/zHcZO1eZ/GcsYlVYM0Qgk+TL79BMcBlkH57L196KqliajNVpuOGBR5
	 6+GQB6B0V7QTtobNpp+s43pKz729CsnYHBiLIcCiLUbAxOPX+WhRjPvV5fhCBLvJue
	 l5aPnkTSbM7DhgSmnMVNksLBOeBlNMl5wGATXWhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgGABKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgGABKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:51 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB2620781;
        Wed,  1 Jul 2020 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565850;
        bh=TkNGgrqX4DuoPRYiKCidraOvpBZ4CbPraEJ/I0LaPyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRiNtFGLBYAD1ceOu7EAcw7jxUF/h1Ttyyc5IBKihSkH1ccgg0O24b3asC1GfqCxY
         wNCBaM2fjKXE75uxitiaco25IV3Jivdi+V1g7c/hxXz/BE5yh813x81aVVuq6j81EA
         PiuKf+vvm6JLWOkbAJgjrrxFrVhVJahJuTKhLTNM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 09/10] timer: Remove must_forward_clk
Date:   Wed,  1 Jul 2020 03:10:29 +0200
Message-Id: <20200701011030.14324-10-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep this guard around. The code makes sure that
base->clk remains sane and won't be forwarded beyond jiffies nor set
backward.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 95f51b646447..439fee098e76 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -204,7 +204,6 @@ struct timer_base {
 	unsigned long		next_expiry;
 	unsigned int		cpu;
 	bool			is_idle;
-	bool			must_forward_clk;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -877,12 +876,13 @@ get_target_base(struct timer_base *base, unsigned tflags)
 
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
 
@@ -1713,16 +1713,8 @@ static inline void __run_timers(struct timer_base *base)
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
@@ -1730,7 +1722,6 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->must_forward_clk = true;
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
@@ -1926,7 +1917,6 @@ int timers_prepare_cpu(unsigned int cpu)
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		base->is_idle = false;
-		base->must_forward_clk = true;
 	}
 	return 0;
 }
-- 
2.26.2

