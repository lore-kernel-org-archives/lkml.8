Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F39C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6194207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994772;
	bh=IH+FDGmDFGcWuRH0MCpBERkFvfGZaOlUTpUIn4sdVQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=omZrWGZEyZfwCBICPTk539ZL/NeJ6e9qiW4228ZVdpBTIVjTYeBvIJckUGCRLzv/S
	 9+sSq7BnW4wJTLjFCd4LuvlIv+t8xmgh2nASWf+T2kOgfzLFoxobM6F3wHpwcizM0J
	 MPYIxHVw/4Zkrow8r1J9GboGDqlvzPq3ZbSxgUtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGQOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgGQOGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:09 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2F722B48;
        Fri, 17 Jul 2020 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994768;
        bh=IH+FDGmDFGcWuRH0MCpBERkFvfGZaOlUTpUIn4sdVQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wip2HdgUmK9CdSvcaZyYu/bDvg5sJO9FZqPkKZSyC0kPKAMI/JXqjKEf4JETRom7L
         ePBHgbazn6U1wLSeCRoYNpiRNgLo5ao5FrdzGh+RfpL/oPQyqw6Dh67QA1+aVZoBUM
         GYqHqBAklFNEkqV4rxJTbzRWJlIIRjV321/wQeWM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 07/12] timers: Always keep track of next expiry
Date:   Fri, 17 Jul 2020 16:05:46 +0200
Message-Id: <20200717140551.29076-8-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
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

Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9abc41715fd2..76fd9644638b 100644
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
-- 
2.26.2

