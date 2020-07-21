Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD146C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B487921702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595289969;
	bh=fimPynKk7Btfz7kRQwK44jU9if7XdYmhUFN8gYIhqhk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VvivTihr09MiWpsExd0Diy/rsmc1zZhhls53v90FDfjNI2smGlLGDa3tkNhDdl2Jw
	 4MbLAB3IFoJi/LoxiiY2AMmOEyBP4J8AtOSvr9i+LJQohvSp/NgT/ziME0ZiYj0kCM
	 yREQ+Nz2dx9xeQMX+ipAzIqDsLYF5GbZfjiLf/88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGUAGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGUAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:06:08 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118972080D;
        Tue, 21 Jul 2020 00:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595289967;
        bh=fimPynKk7Btfz7kRQwK44jU9if7XdYmhUFN8gYIhqhk=;
        h=From:To:Cc:Subject:Date:From;
        b=rwNQJb8dMB2zIwqbrwNMEOl7pmhdZLvcnWIAfmCe9TzEI7iTplv1ScygC8hCK1GlO
         rpxkByaltRvENZZ2V59G7RDf6SBx821Nc7o9fjDeYLj9J3AFsZ8ws+9T3gFzaDQ5Jg
         kYD1mQXm44EDEX71tFN3NrrZDAFIVkchHH9hXj/s=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] timers: Recalculate next timer interrupt only when necessary
Date:   Tue, 21 Jul 2020 02:05:56 +0200
Message-Id: <20200721000556.4709-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nohz tick code recalculates the timer wheel's next expiry on each
idle loop iteration.

On the other hand, the base next expiry is now always cached and updated
upon timer enqueue and execution. Only timer dequeue may leave
base->next_expiry out of date (but then its stale value won't ever go
past the actual next expiry to be recalculated).

Since recalculating the next_expiry isn't a free operation, especially
when we must climb up the last wheel level to find out that no timer has
been enqueued at all, lets reuse the next expiry cache when it is known
to be reliable, which it is most of the time.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 77e21e98ec32..e8002f86c5bc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -203,6 +203,7 @@ struct timer_base {
 #endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
+	bool			next_expiry_recalc;
 	unsigned int		cpu;
 	bool			is_idle;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
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
 
-- 
2.26.2

