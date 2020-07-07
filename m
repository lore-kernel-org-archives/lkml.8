Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1BC206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594085616;
	bh=0Y0CXgWgIGOuqURmwOT7L3TTrVG7g4ZNpBp5WtkSiLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8+LdzmYZAbgiu0HWNSViFEy28NbP6ANAutS6IdvKA1H7xZOU/wWyoAyQU2koONLM
	 /0VqqlxoNy1K9DctGt/wYdioy1RKE9JliEkwqZhs+MveaVU7wMuLpAD+O/yX/m8Ea9
	 F7QOjd2lDBKlg97tK354Herwvdp5bPtWpol8d0Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgGGBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgGGBdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:13 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F35220719;
        Tue,  7 Jul 2020 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085592;
        bh=0Y0CXgWgIGOuqURmwOT7L3TTrVG7g4ZNpBp5WtkSiLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLxw8cBFpzRywhX+mElFUlxLGAkfIPEkqJfhWc24QuS79dsMUuMu70WhrEAgHoFiw
         L/tYtqkn1EDSWXfAwNCjlm7ShIGNh4MVzyAAhuLILfhxZ76kygYS/p2oCoXjYfDWMu
         QtomQElslQ105vgjJ/XXYOyvlbM7TNrXoUXFgxNE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 4/9] timers: Always keep track of next expiry
Date:   Tue,  7 Jul 2020 03:32:48 +0200
Message-Id: <20200707013253.26770-5-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far next expiry was only tracked while the CPU was in nohz_idle mode
in order to cope with missing ticks that can't increment the base->clk
periodically anymore.

We are going to expand that logic beyond nohz in order to spare timers
softirqs so do it unconditionally.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index acf7cb8c09f8..8a4138e47aa4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -558,8 +558,22 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * timer is not deferrable. If the other CPU is on the way to idle
 	 * then it can't set base->is_idle as we hold the base lock:
 	 */
-	if (!base->is_idle)
-		return;
+	if (base->is_idle)
+		wake_up_nohz_cpu(base->cpu);
+}
+
+/*
+ * Enqueue the timer into the hash bucket, mark it pending in
+ * the bitmap and store the index in the timer flags.
+ */
+static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
+			  unsigned int idx)
+{
+	hlist_add_head(&timer->entry, base->vectors + idx);
+	__set_bit(idx, base->pending_map);
+	timer_set_idx(timer, idx);
+
+	trace_timer_start(timer, timer->expires, timer->flags);
 
 	/* Check whether this is the new first expiring timer: */
 	if (time_after_eq(timer->expires, base->next_expiry))
@@ -578,21 +592,7 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	} else {
 		base->next_expiry = timer->expires;
 	}
-	wake_up_nohz_cpu(base->cpu);
-}
 
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
 	trigger_dyntick_cpu(base, timer);
 }
 
@@ -1490,7 +1490,6 @@ static int __collect_expired_timers(struct timer_base *base,
 	return levels;
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Find the next pending bucket of a level. Search from level start (@offset)
  * + @clk upwards and if nothing there, search from start of the level
@@ -1582,6 +1581,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	return next;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Check, if the next hrtimer event is before the next timer wheel
  * event:
@@ -1787,6 +1787,7 @@ static inline void __run_timers(struct timer_base *base)
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
+		base->next_expiry = __next_timer_interrupt(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
@@ -2039,6 +2040,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		timer_base_init_expiry_lock(base);
 	}
 }
-- 
2.26.2

