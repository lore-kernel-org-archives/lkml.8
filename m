Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB5FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C0620781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565843;
	bh=X8gtXEPhNZx3ZIBXS6b69iuGP95TvO4abhgwH9+3Tgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNqOOD2pL/o9rxA6KMCv1EGeCgpGQhylCCRaBrelbH3sjwWwHwrf5CAFirzeuq+fW
	 sZ5RbnOV45xDskvWN45bm+TEcBzlxF4CxWgtep6+2Eo1dQKtboj86zWwAY/BoM0XpF
	 e4us7TKZnfiBjPC4PKfsU+e42PTBg6tfIhdOkx1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGABKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgGABKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:40 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFB420771;
        Wed,  1 Jul 2020 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565839;
        bh=X8gtXEPhNZx3ZIBXS6b69iuGP95TvO4abhgwH9+3Tgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIVcH5G9TL/6LkQNxuZPFQ0VzmDw3uVrRubV5XDvnR7VuNot99h8HJ0XzyxWLb+dV
         OCWm0NYL5zOvI6sEk4n+wg5+FbPUNbSIaU5yL6sOXZ8+o6EQDDqFxgd4XjVwEctESa
         0zwcrAjKvOkjLvisF7QuHqds9FMPuIdz1urmtLIg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 02/10] timer: Move trigger_dyntick_cpu() to enqueue_timer()
Date:   Wed,  1 Jul 2020 03:10:22 +0200
Message-Id: <20200701011030.14324-3-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the code by calling trigger_dyntick_cpu() from
enqueue_timer() instead of calling it from all its callers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 46 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9a838d38dbe6..4c977df3610b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -529,29 +529,6 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk)
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
-__internal_add_timer(struct timer_base *base, struct timer_list *timer)
-{
-	unsigned int idx;
-
-	idx = calc_wheel_index(timer->expires, base->clk);
-	enqueue_timer(base, timer, idx);
-}
-
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
@@ -596,13 +573,29 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	wake_up_nohz_cpu(base->cpu);
 }
 
-static void
-internal_add_timer(struct timer_base *base, struct timer_list *timer)
+/*
+ * Enqueue the timer into the hash bucket, mark it pending in
+ * the bitmap and store the index in the timer flags.
+ */
+static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
+			  unsigned int idx)
 {
-	__internal_add_timer(base, timer);
+	hlist_add_head(&timer->entry, base->vectors + idx);
+	__set_bit(idx, base->pending_map);
+	timer_set_idx(timer, idx);
+
+	trace_timer_start(timer, timer->expires, timer->flags);
 	trigger_dyntick_cpu(base, timer);
 }
 
+static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
+{
+	unsigned int idx;
+
+	idx = calc_wheel_index(timer->expires, base->clk);
+	enqueue_timer(base, timer, idx);
+}
+
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
 static struct debug_obj_descr timer_debug_descr;
@@ -1059,7 +1052,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	 */
 	if (idx != UINT_MAX && clk == base->clk) {
 		enqueue_timer(base, timer, idx);
-		trigger_dyntick_cpu(base, timer);
 	} else {
 		internal_add_timer(base, timer);
 	}
-- 
2.26.2

