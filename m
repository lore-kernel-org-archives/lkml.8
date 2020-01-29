Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4EFC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052262468F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgA2Lds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51115 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgA2LdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlah-0007o9-NS; Wed, 29 Jan 2020 12:33:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A3751C1C1D;
        Wed, 29 Jan 2020 12:33:00 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:33:00 -0000
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] timers/nohz: Update NOHZ load in remote tick
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Scott Wood <swood@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578736419-14628-3-git-send-email-swood@redhat.com>
References: <1578736419-14628-3-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Message-ID: <158029758015.396.8419469539001860762.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ebc0f83c78a2d26384401ecf2d2fa48063c0ee27
Gitweb:        https://git.kernel.org/tip/ebc0f83c78a2d26384401ecf2d2fa48063c0ee27
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Sat, 11 Jan 2020 04:53:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:36:44 +01:00

timers/nohz: Update NOHZ load in remote tick

The way loadavg is tracked during nohz only pays attention to the load
upon entering nohz.  This can be particularly noticeable if full nohz is
entered while non-idle, and then the cpu goes idle and stays that way for
a long time.

Use the remote tick to ensure that full nohz cpus report their deltas
within a reasonable time.

[ swood: Added changelog and removed recheck of stopped tick. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/1578736419-14628-3-git-send-email-swood@redhat.com
---
 include/linux/sched/nohz.h |  2 ++
 kernel/sched/core.c        |  4 +++-
 kernel/sched/loadavg.c     | 33 +++++++++++++++++++++++----------
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91f..6d67e9a 100644
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
index cf8b33d..4ff03c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3677,6 +3677,7 @@ static void sched_tick_remote(struct work_struct *work)
 	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	curr = rq->curr;
 	update_rq_clock(rq);
 
 	if (!is_idle_task(curr)) {
@@ -3689,10 +3690,11 @@ static void sched_tick_remote(struct work_struct *work)
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
index 28a5165..de22da6 100644
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
 
