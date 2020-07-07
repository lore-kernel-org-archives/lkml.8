Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E803C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3AD206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594085591;
	bh=X8gtXEPhNZx3ZIBXS6b69iuGP95TvO4abhgwH9+3Tgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=si51Zvv6kK2Bc2vZDVzwGweYBIMLSVt/wBTMnssBZv2+Nhg79zqTNmwj1f9RezlFO
	 sCCO5cjFV/9TmATwGVshhPQbzWC+vPGHorl7LRPmM4wBEZz4nj6jMvWUNOm1Ao6/RX
	 6hQi1jpYAbP+UP/pjBIwIb9T9YDPlZ2ktb0SjiEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGBdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgGGBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:08 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD68720708;
        Tue,  7 Jul 2020 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085587;
        bh=X8gtXEPhNZx3ZIBXS6b69iuGP95TvO4abhgwH9+3Tgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsqONnY3JQ6OgLZHokvQdN5NdaDd5iMs4wt17PqSME9wgg1mi7pD4cgqak3rnJ5VA
         HbAfYod1HWOYMx/tuYFFix1CJkVW0yBVsFJwDc2lqshLmZEfneRtg0TCGgyX0r0Q/s
         SNn0Dem70Dh3Ci5c9vXl0IV77UYfnmZe1b6uXMjU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 1/9] timer: Move trigger_dyntick_cpu() to enqueue_timer()
Date:   Tue,  7 Jul 2020 03:32:45 +0200
Message-Id: <20200707013253.26770-2-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
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

