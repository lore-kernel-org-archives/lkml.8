Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D832920C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgFPMWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgFPMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07CC08C5C2;
        Tue, 16 Jun 2020 05:22:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbM-0004ko-SP; Tue, 16 Jun 2020 14:22:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B8C41C0852;
        Tue, 16 Jun 2020 14:21:55 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:55 -0000
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Add new tracepoints to track util_est
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
References: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <159231011535.16989.4063331664061599328.tip-bot2@tip-bot2>
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

Commit-ID:     4581bea8b4ec4de353369775dfef921191e393b3
Gitweb:        https://git.kernel.org/tip/4581bea8b4ec4de353369775dfef921191e393b3
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Wed, 27 May 2020 17:39:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:02 +02:00

sched/debug: Add new tracepoints to track util_est

The util_est signals are key elements for EAS task placement and
frequency selection. Having tracepoints to track these signals enables
load-tracking and schedutil testing and/or debugging by a toolkit.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/1590597554-370150-1-git-send-email-vincent.donnefort@arm.com
---
 include/trace/events/sched.h | 8 ++++++++
 kernel/sched/core.c          | 2 ++
 kernel/sched/fair.c          | 6 ++++++
 3 files changed, 16 insertions(+)

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
index 9c89b0e..0208b71 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69da576..a785a9b 100644
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
