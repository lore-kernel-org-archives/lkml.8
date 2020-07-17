Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE8C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E6422B49
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994803;
	bh=Kn5+0H4zt1qLLnHxyowSOCVs51Y7nDbCOEsyxfENm34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9qF2FX18ljnuaGwFDIvjgs62o7MYqe2TB2q5e8nRPzvNv6EkOw1V0IAy5zBq9wId
	 Oe5oEJqtS6Qnmj/2hQzBqqHqzmATpTh22nrVJ4U3CevZeVcbSIn8xxPf6aSTrHY6oq
	 /XnmBX08TzFmPvyYQNmANNGVBAY8hpelPwF+SNRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGQOGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgGQOGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:04 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC9522BEB;
        Fri, 17 Jul 2020 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994763;
        bh=Kn5+0H4zt1qLLnHxyowSOCVs51Y7nDbCOEsyxfENm34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3LXclembE3geOajgRPe2bgJ1vI7KdFZitOa50VzU1vBnDeXxn+DUYuGoegrjfFvJ
         MkyDrNWkNNcc/DnUFVfGHtd1LFpN6cVyBS3jZA48tTSzxQ8Iw2makMwgtenHE5Y4PP
         BQt5yfZoS0nAi7TQPwuYkCTbi+G/LEOODMaBHYQs=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 04/12] timer: Move trigger_dyntick_cpu() to enqueue_timer()
Date:   Fri, 17 Jul 2020 16:05:43 +0200
Message-Id: <20200717140551.29076-5-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the code by calling trigger_dyntick_cpu() from
enqueue_timer() instead of calling it from all its callers.

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 61 +++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a7a3cf737411..2af08a169564 100644
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
-- 
2.26.2

