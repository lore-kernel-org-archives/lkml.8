Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A97E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391321AbgE0QkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:40:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbgE0QkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:40:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2E830E;
        Wed, 27 May 2020 09:40:00 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E2EC3F52E;
        Wed, 27 May 2020 09:39:59 -0700 (PDT)
From:   vincent.donnefort@arm.com
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/debug: Add new tracepoints to track util_est
Date:   Wed, 27 May 2020 17:39:14 +0100
Message-Id: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The util_est signals are key elements for EAS task placement and
frequency selection. Having tracepoints to track these signals enables
load-tracking and schedutil testing and/or debugging by a toolkit.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index ed168b0..04f9a4c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -634,6 +634,14 @@ DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
+DECLARE_TRACE(sched_util_est_cfs_tp,
+	TP_PROTO(struct cfs_rq *cfs_rq),
+	TP_ARGS(cfs_rq));
+
+DECLARE_TRACE(sched_util_est_se_tp,
+	TP_PROTO(struct sched_entity *se),
+	TP_ARGS(se));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9228236..ecff02b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -35,6 +35,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 174d2df..cfc0e06 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3922,6 +3922,8 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 	enqueued  = cfs_rq->avg.util_est.enqueued;
 	enqueued += _task_util_est(p);
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+
+	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
 /*
@@ -3952,6 +3954,8 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
+	trace_sched_util_est_cfs_tp(cfs_rq);
+
 	/*
 	 * Skip update of task's estimated utilization when the task has not
 	 * yet completed an activation, e.g. being migrated.
@@ -4017,6 +4021,8 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
 	WRITE_ONCE(p->se.avg.util_est, ue);
+
+	trace_sched_util_est_se_tp(&p->se);
 }
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
-- 
2.7.4

