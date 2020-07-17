Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C8C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B062207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994785;
	bh=PIOA0gjyrszvf6R8g6piDpXdhxG0l9+8p5XdJHS01jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdmh1rwnn12zqVl15gJrq41hXdyRcpNwTm+Gf7oZB1wHE8ctnQFUmSuom+m+DKHcK
	 uRtO01CNbiCfxREExiwTzEFr0C3G36hcmCeN5aOeFDDL95WogW6u49Kk/8EK4d7YWq
	 VTsaasGBLEYhV2kDyLz1d7yPBK2s5NLqjLn/sFS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGQOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgGQOGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:15 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D6E22BEB;
        Fri, 17 Jul 2020 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994774;
        bh=PIOA0gjyrszvf6R8g6piDpXdhxG0l9+8p5XdJHS01jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMRVej3AXjtsRY4DWBXzmB89+8Fz5zO00CGwdodTvKd3Li4Upd/gwu/m069Kod9Py
         pRvKX+HXwAu1oPdtWeDCyNY/gozH4DhLRKRq+JjIch4JsccUzYjJm6uXKiVImItUyh
         0lqspIP7za97ZMGy4yA0cbJmvX27vVYttlKiqbXE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 11/12] timer: Remove must_forward_clk
Date:   Fri, 17 Jul 2020 16:05:50 +0200
Message-Id: <20200717140551.29076-12-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep this guard around. The code makes sure that
base->clk remains sane and won't be forwarded beyond jiffies nor set
backward.

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4f78a7bff9e1..8b3fb52d8c47 100644
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
-- 
2.26.2

