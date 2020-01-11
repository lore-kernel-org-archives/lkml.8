Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55265C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D32077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3WbOO1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgAKJxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:53:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728917AbgAKJxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578736432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=rRx0oxYUmYgrX33kOC4ocpdLEvnNwi616mBkkVOTRWU=;
        b=b3WbOO1Nw7RpJQWLu7l7qSoTHNctWhOMM2WjiCW2/S26GiYIP56jYPXF9cOQZ9X6OkPRif
        0CVy/fBjSUkJ7rg8rX1o//kLyUr8ZJ1NRZxckpB1mYCjXO0QptVf/AY8AcEWBrwuUbY4fV
        ktooM2UCRrbRJl3jbCEsYAexTJFch/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-3HZU6Wq0Mmifg7xM_EVMDg-1; Sat, 11 Jan 2020 04:53:45 -0500
X-MC-Unique: 3HZU6Wq0Mmifg7xM_EVMDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7183C801E78;
        Sat, 11 Jan 2020 09:53:42 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A7F272A3;
        Sat, 11 Jan 2020 09:53:41 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [PATCH v2 2/2] timers/nohz: Update nohz load in remote tick
Date:   Sat, 11 Jan 2020 04:53:39 -0500
Message-Id: <1578736419-14628-3-git-send-email-swood@redhat.com>
In-Reply-To: <1578736419-14628-1-git-send-email-swood@redhat.com>
References: <1578736419-14628-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The way loadavg is tracked during nohz only pays attention to the load
upon entering nohz.  This can be particularly noticeable if full nohz is
entered while non-idle, and then the cpu goes idle and stays that way for
a long time.

Use the remote tick to ensure that full nohz cpus report their deltas
within a reasonable time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[swood: added changelog and removed recheck of stopped tick]
Signed-off-by: Scott Wood <swood@redhat.com>
---
 include/linux/sched/nohz.h |  2 ++
 kernel/sched/core.c        |  4 +++-
 kernel/sched/loadavg.c     | 33 +++++++++++++++++++++++----------
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91ff6e4a..6d67e9a5af6b 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -15,9 +15,11 @@ static inline void nohz_balance_enter_idle(int cpu) { }
 
 #ifdef CONFIG_NO_HZ_COMMON
 void calc_load_nohz_start(void);
+void calc_load_nohz_remote(struct rq *rq);
 void calc_load_nohz_stop(void);
 #else
 static inline void calc_load_nohz_start(void) { }
+static inline void calc_load_nohz_remote(struct rq *rq) { }
 static inline void calc_load_nohz_stop(void) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dfb8ea801700..2e4a505e48af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3676,6 +3676,7 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	curr = rq->curr;
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -3688,10 +3689,11 @@ static void sched_tick_remote(struct work_struct *work)
 	}
 	curr->sched_class->task_tick(rq, curr, 0);
 
+	calc_load_nohz_remote(rq);
 out_unlock:
 	rq_unlock_irq(rq, &rf);
-
 out_requeue:
+
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a516575c18..de22da666ac7 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -231,16 +231,11 @@ static inline int calc_load_read_idx(void)
 	return calc_load_idx & 1;
 }
 
-void calc_load_nohz_start(void)
+static void calc_load_nohz_fold(struct rq *rq)
 {
-	struct rq *this_rq = this_rq();
 	long delta;
 
-	/*
-	 * We're going into NO_HZ mode, if there's any pending delta, fold it
-	 * into the pending NO_HZ delta.
-	 */
-	delta = calc_load_fold_active(this_rq, 0);
+	delta = calc_load_fold_active(rq, 0);
 	if (delta) {
 		int idx = calc_load_write_idx();
 
@@ -248,6 +243,24 @@ void calc_load_nohz_start(void)
 	}
 }
 
+void calc_load_nohz_start(void)
+{
+	/*
+	 * We're going into NO_HZ mode, if there's any pending delta, fold it
+	 * into the pending NO_HZ delta.
+	 */
+	calc_load_nohz_fold(this_rq());
+}
+
+/*
+ * Keep track of the load for NOHZ_FULL, must be called between
+ * calc_load_nohz_{start,stop}().
+ */
+void calc_load_nohz_remote(struct rq *rq)
+{
+	calc_load_nohz_fold(rq);
+}
+
 void calc_load_nohz_stop(void)
 {
 	struct rq *this_rq = this_rq();
@@ -268,7 +281,7 @@ void calc_load_nohz_stop(void)
 		this_rq->calc_load_update += LOAD_FREQ;
 }
 
-static long calc_load_nohz_fold(void)
+static long calc_load_nohz_read(void)
 {
 	int idx = calc_load_read_idx();
 	long delta = 0;
@@ -323,7 +336,7 @@ static void calc_global_nohz(void)
 }
 #else /* !CONFIG_NO_HZ_COMMON */
 
-static inline long calc_load_nohz_fold(void) { return 0; }
+static inline long calc_load_nohz_read(void) { return 0; }
 static inline void calc_global_nohz(void) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
@@ -346,7 +359,7 @@ void calc_global_load(unsigned long ticks)
 	/*
 	 * Fold the 'old' NO_HZ-delta to include all NO_HZ CPUs.
 	 */
-	delta = calc_load_nohz_fold();
+	delta = calc_load_nohz_read();
 	if (delta)
 		atomic_long_add(delta, &calc_load_tasks);
 
-- 
1.8.3.1

