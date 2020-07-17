Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33561C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118282173E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994796;
	bh=Fl2lR7WbYLe47qb5l7WESN/wbmLy7CKCRvNeBhBlpZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJOYFMvpqn12Zr6NNM5YHvQK2kmiLkL1hIvjjMGvf1j9GVFbFt9vVN3YqSR4JJw+6
	 86N8OHAmnvzPftgfK8gy/D14gHqBs7vXyyLsuaCBF2vvl/du7yAL6T9qgpqiWmzzr5
	 eqMSafUGKFFaPRYQBwV+ndsNMYsBKsVeLjgvMUiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGQOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgGQOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:13 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A6022B4E;
        Fri, 17 Jul 2020 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994773;
        bh=Fl2lR7WbYLe47qb5l7WESN/wbmLy7CKCRvNeBhBlpZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ip9Xznm3IerK46dEC4VEgJl0LRzElbBZJYj/9qbgAuB25D0Hn7u9WMheAR9JxY7HZ
         TiGuaWKm+8cDgrAWwOKA/emmJR+t7hGPnODGdjLMdA1ts4kddUlZ7Wm0yZcMH6PZnt
         Z/OXhP8aW1QJQ1WT5hKls4Bf7mGCzAWCse8qwhXM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 10/12] timer: Spare timer softirq until next expiry
Date:   Fri, 17 Jul 2020 16:05:49 +0200
Message-Id: <20200717140551.29076-11-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core timer infrastructure doesn't depend anymore on
periodic base->clk increments, even when the CPU is not in NO_HZ mode,
we can delay the timer softirqs until we have actual timers to expire.

Some spurious softirqs can still remain since base->next_expiry doesn't
keep track of canceled timers but we are still way ahead of the
unconditional periodic softirqs (~15 times less of them with 1000 Hz
and ~5 times less with 100 Hz).

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 49 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1be92b53b75f..4f78a7bff9e1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1458,10 +1458,10 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static int collect_expired_timers(struct timer_base *base,
+				  struct hlist_head *heads)
 {
-	unsigned long clk = base->clk;
+	unsigned long clk = base->clk = base->next_expiry;
 	struct hlist_head *vec;
 	int i, levels = 0;
 	unsigned int idx;
@@ -1684,40 +1684,6 @@ void timer_clear_idle(void)
 	 */
 	base->is_idle = false;
 }
-
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
-{
-	unsigned long now = READ_ONCE(jiffies);
-
-	/*
-	 * NOHZ optimization. After a long idle sleep we need to forward the
-	 * base to current jiffies. Avoid a loop by searching the bitfield for
-	 * the next expiring timer.
-	 */
-	if ((long)(now - base->clk) > 2) {
-		/*
-		 * If the next timer is ahead of time forward to current
-		 * jiffies, otherwise forward to the next expiry time:
-		 */
-		if (time_after(base->next_expiry, now)) {
-			/*
-			 * The call site will increment base->clk and then
-			 * terminate the expiry loop immediately.
-			 */
-			base->clk = now;
-			return 0;
-		}
-		base->clk = base->next_expiry;
-	}
-	return __collect_expired_timers(base, heads);
-}
-#else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
-{
-	return __collect_expired_timers(base, heads);
-}
 #endif
 
 /*
@@ -1750,7 +1716,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (!time_after_eq(jiffies, base->clk))
+	if (time_before(jiffies, base->next_expiry))
 		return;
 
 	timer_base_lock_expiry(base);
@@ -1763,7 +1729,8 @@ static inline void __run_timers(struct timer_base *base)
 	 */
 	base->must_forward_clk = false;
 
-	while (time_after_eq(jiffies, base->clk)) {
+	while (time_after_eq(jiffies, base->clk) &&
+	       time_after_eq(jiffies, base->next_expiry)) {
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
@@ -1798,12 +1765,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->next_expiry)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->next_expiry))
 			return;
 	}
 	raise_softirq(TIMER_SOFTIRQ);
-- 
2.26.2

