Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CDBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67FC20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgFPMWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DBC08C5C2;
        Tue, 16 Jun 2020 05:21:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbB-0004e6-Ks; Tue, 16 Jun 2020 14:21:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D0C8A1C06FE;
        Tue, 16 Jun 2020 14:21:50 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:50 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Cleanup PELT divider
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200612154703.23555-1-vincent.guittot@linaro.org>
References: <20200612154703.23555-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <159231011058.16989.14137603065539923568.tip-bot2@tip-bot2>
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

Commit-ID:     87e867b4269f29dac8190bca13912d08163a277f
Gitweb:        https://git.kernel.org/tip/87e867b4269f29dac8190bca13912d08163a277f
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 12 Jun 2020 17:47:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:06 +02:00

sched/pelt: Cleanup PELT divider

Factorize in a single place the calculation of the divider to be used to
to compute *_avg from *_sum value

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200612154703.23555-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 32 ++++++++++++++++++--------------
 kernel/sched/pelt.c |  2 +-
 kernel/sched/pelt.h |  5 +++++
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 295c9ff..0424a0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3094,7 +3094,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 #ifdef CONFIG_SMP
 	do {
-		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
+		u32 divider = get_pelt_divider(&se->avg);
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
 	} while (0);
@@ -3440,16 +3440,18 @@ static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
-	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
-	 * See ___update_load_avg() for details.
-	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = get_pelt_divider(&cfs_rq->avg);
+
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
 	se->avg.util_sum = se->avg.util_avg * divider;
@@ -3463,16 +3465,18 @@ static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
-	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
-	 * See ___update_load_avg() for details.
-	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = get_pelt_divider(&cfs_rq->avg);
+
 	/* Set new sched_entity's runnable */
 	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
 	se->avg.runnable_sum = se->avg.runnable_avg * divider;
@@ -3500,7 +3504,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	divider = get_pelt_divider(&cfs_rq->avg);
 
 	if (runnable_sum >= 0) {
 		/*
@@ -3646,7 +3650,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 	if (cfs_rq->removed.nr) {
 		unsigned long r;
-		u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
+		u32 divider = get_pelt_divider(&cfs_rq->avg);
 
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
@@ -3701,7 +3705,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider = get_pelt_divider(&cfs_rq->avg);
 
 	/*
 	 * When we attach the @se to the @cfs_rq, we must align the decay
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index dea5567..11bea3b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -262,7 +262,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 static __always_inline void
 ___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
-	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
+	u32 divider = get_pelt_divider(sa);
 
 	/*
 	 * Step 2: update *_avg.
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index eb034d9..795e43e 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -37,6 +37,11 @@ update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif
 
+static inline u32 get_pelt_divider(struct sched_avg *avg)
+{
+	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
+}
+
 /*
  * When a task is dequeued, its estimated utilization should not be update if
  * its util_avg has not been updated at least once.
