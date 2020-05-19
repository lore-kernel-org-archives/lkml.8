Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C37C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26B2207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgESSou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgESSoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0030C08C5C2;
        Tue, 19 May 2020 11:44:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Du-0006dL-Vb; Tue, 19 May 2020 20:44:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8848D1C0178;
        Tue, 19 May 2020 20:44:15 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:15 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Sync util/runnable_sum with PELT window
 when propagating
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200506155301.14288-1-vincent.guittot@linaro.org>
References: <20200506155301.14288-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <158991385546.17951.8920600891914020926.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     95d685935a2edf209fc68f52494ede4a382a6c2b
Gitweb:        https://git.kernel.org/tip/95d685935a2edf209fc68f52494ede4a382a6c2b
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 06 May 2020 17:53:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:14 +02:00

sched/pelt: Sync util/runnable_sum with PELT window when propagating

update_tg_cfs_*() propagate the impact of the attach/detach of an entity
down into the cfs_rq hierarchy and must keep the sync with the current pelt
window.

Even if we can't sync child cfs_rq and its group se, we can sync the group
se and its parent cfs_rq with current position in the PELT window. In fact,
we must keep them sync in order to stay also synced with others entities
and group entities that are already attached to the cfs_rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200506155301.14288-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 49 ++++++++++++++++++++++++--------------------
 kernel/sched/pelt.c | 24 ++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e58686..44b0c8e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3441,52 +3441,46 @@ static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
-	se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
+	se->avg.util_sum = se->avg.util_avg * divider;
 
 	/* Update parent cfs_rq utilization */
 	add_positive(&cfs_rq->avg.util_avg, delta);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
+	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
 }
 
 static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
 	/* Set new sched_entity's runnable */
 	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+	se->avg.runnable_sum = se->avg.runnable_avg * divider;
 
 	/* Update parent cfs_rq runnable */
 	add_positive(&cfs_rq->avg.runnable_avg, delta);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 }
 
 static inline void
@@ -3496,19 +3490,26 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	unsigned long load_avg;
 	u64 load_sum = 0;
 	s64 delta_sum;
+	u32 divider;
 
 	if (!runnable_sum)
 		return;
 
 	gcfs_rq->prop_runnable_sum = 0;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+
 	if (runnable_sum >= 0) {
 		/*
 		 * Add runnable; clip at LOAD_AVG_MAX. Reflects that until
 		 * the CPU is saturated running == runnable.
 		 */
 		runnable_sum += se->avg.load_sum;
-		runnable_sum = min(runnable_sum, (long)LOAD_AVG_MAX);
+		runnable_sum = min_t(long, runnable_sum, divider);
 	} else {
 		/*
 		 * Estimate the new unweighted runnable_sum of the gcfs_rq by
@@ -3533,7 +3534,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	runnable_sum = max(runnable_sum, running_sum);
 
 	load_sum = (s64)se_weight(se) * runnable_sum;
-	load_avg = div_s64(load_sum, LOAD_AVG_MAX);
+	load_avg = div_s64(load_sum, divider);
 
 	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
 	delta_avg = load_avg - se->avg.load_avg;
@@ -3697,6 +3698,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  */
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
 	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b647d04..b4b1ff9 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -237,6 +237,30 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	return 1;
 }
 
+/*
+ * When syncing *_avg with *_sum, we must take into account the current
+ * position in the PELT segment otherwise the remaining part of the segment
+ * will be considered as idle time whereas it's not yet elapsed and this will
+ * generate unwanted oscillation in the range [1002..1024[.
+ *
+ * The max value of *_sum varies with the position in the time segment and is
+ * equals to :
+ *
+ *   LOAD_AVG_MAX*y + sa->period_contrib
+ *
+ * which can be simplified into:
+ *
+ *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+ *
+ * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
+ *
+ * The same care must be taken when a sched entity is added, updated or
+ * removed from a cfs_rq and we need to update sched_avg. Scheduler entities
+ * and the cfs rq, to which they are attached, have the same position in the
+ * time segment because they use the same clock. This means that we can use
+ * the period_contrib of cfs_rq when updating the sched_avg of a sched_entity
+ * if it's more convenient.
+ */
 static __always_inline void
 ___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
