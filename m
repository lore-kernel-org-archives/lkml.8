Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E568C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A65120771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565849;
	bh=aKRhwVhN7D8SHkrFiRvmf9rY8fNYZH19eSfLROUGcbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LuPN/0/bOaFIREtdscRYn5DDAXMogTgivoS03BgV1i/OgE6c01q1HP2QuEeNcBmSF
	 WVGSk/A6/duBDv9xwFTi3liQUXqq6yrYbY4588M5QR+IHSLmlbcswX+3VI7hsmkB/g
	 d/wLrBfnV/G9N4cTRZ259T+7ADTvicKRMFtkwi88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGABKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgGABKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:44 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D219E20771;
        Wed,  1 Jul 2020 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565844;
        bh=aKRhwVhN7D8SHkrFiRvmf9rY8fNYZH19eSfLROUGcbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09UUC61gkhq5rEKjTfs+RwysTLq4sInzpV11pLSKNJulkblx0pDm4w6m22QTlhOR0
         GgZu7+4YbRyhtHD4a0y6LYoRMtJJe5D10FBS3NjK9lFo+UHKAE0Vu1wIxzNNfoxoAU
         tTM5V1QG4V5RUoBXWDpsfW5IofMVL0So0RTEZzI4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 05/10] timers: Always keep track of next expiry
Date:   Wed,  1 Jul 2020 03:10:25 +0200
Message-Id: <20200701011030.14324-6-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
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
 kernel/time/timer.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4aa74aafdd33..30f491ec875a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -550,8 +550,22 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
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
@@ -570,21 +584,7 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
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
 
@@ -1482,7 +1482,6 @@ static int __collect_expired_timers(struct timer_base *base,
 	return levels;
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Find the next pending bucket of a level. Search from level start (@offset)
  * + @clk upwards and if nothing there, search from start of the level
@@ -1574,6 +1573,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	return next;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 /*
  * Check, if the next hrtimer event is before the next timer wheel
  * event:
@@ -1779,6 +1779,7 @@ static inline void __run_timers(struct timer_base *base)
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
+		base->next_expiry = __next_timer_interrupt(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);
-- 
2.26.2

