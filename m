Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF202087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAQKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55400 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYY-0005RH-82; Fri, 17 Jan 2020 11:08:46 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA2E91C0330;
        Fri, 17 Jan 2020 11:08:40 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:40 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove redundant call to cpufreq_update_util()
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
References: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157925572079.396.15536483908127577384.tip-bot2@tip-bot2>
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

Commit-ID:     a4f9a0e51bbf89cb461b1985a1a570e6b87da3b5
Gitweb:        https://git.kernel.org/tip/a4f9a0e51bbf89cb461b1985a1a570e6b87da3b5
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 15 Jan 2020 11:20:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:22 +01:00

sched/fair: Remove redundant call to cpufreq_update_util()

With commit

  bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")

update_load_avg() has become the central point for calling cpufreq
(not including the update of blocked load). This change helps to
simplify further the number of calls to cpufreq_update_util() and to
remove last redundant ones. With update_load_avg(), we are now sure
that cpufreq_update_util() will be called after every task attachment
to a cfs_rq and especially after propagating this event down to the
util_avg of the root cfs_rq, which is the level that is used by
cpufreq governors like schedutil to set the frequency of a CPU.

The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when
the migration happens in a cgroup whereas util_avg of root cfs_rq is
not yet updated and this call is duplicated with the one that happens
immediately after when the migration event reaches the root cfs_rq.
The dedicated flag SCHED_CPUFREQ_MIGRATION is now useless and can be
removed. The interface of attach_entity_load_avg() can also be
simplified accordingly.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/1579083620-24943-1-git-send-email-vincent.guittot@linaro.org
---
 include/linux/sched/cpufreq.h |  1 -
 kernel/sched/fair.c           | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index cc6bcc1..3ed5aa1 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -9,7 +9,6 @@
  */
 
 #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
-#define SCHED_CPUFREQ_MIGRATION	(1U << 1)
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e84723c..ebf5095 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -801,7 +801,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		 * For !fair tasks do:
 		 *
 		update_cfs_rq_load_avg(now, cfs_rq);
-		attach_entity_load_avg(cfs_rq, se, 0);
+		attach_entity_load_avg(cfs_rq, se);
 		switched_from_fair(rq, p);
 		 *
 		 * such that the next switched_to_fair() has the
@@ -3114,7 +3114,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 {
 	struct rq *rq = rq_of(cfs_rq);
 
-	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
+	if (&rq->cfs == cfs_rq) {
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -3521,7 +3521,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
  */
-static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
@@ -3557,7 +3557,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, flags);
+	cfs_rq_util_change(cfs_rq, 0);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -3615,7 +3615,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 *
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
-		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
+		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq, 0);
 
 	} else if (decayed) {
@@ -3872,7 +3872,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
 
 static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags) {}
+attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
@@ -10436,7 +10436,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se, 0);
+	attach_entity_load_avg(cfs_rq, se);
 	update_tg_load_avg(cfs_rq, false);
 	propagate_entity_cfs_rq(se);
 }
