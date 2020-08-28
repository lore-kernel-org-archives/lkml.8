Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40313C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2572F20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgH1JBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:01:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgH1JA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:00:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 657D21FB;
        Fri, 28 Aug 2020 02:00:57 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B0A03F71F;
        Fri, 28 Aug 2020 02:00:56 -0700 (PDT)
From:   vincent.donnefort@arm.com
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Date:   Fri, 28 Aug 2020 10:00:49 +0100
Message-Id: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

rq->cpu_capacity is a key element in several scheduler parts, such as EAS
task placement and load balancing. Tracking this value enables testing
and/or debugging by a toolkit.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 021ad7b..7e19d59 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2055,6 +2055,7 @@ const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
 const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
 
 int sched_trace_rq_cpu(struct rq *rq);
+int sched_trace_rq_cpu_capacity(struct rq *rq);
 int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8ab48b3..f94ddd1 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -630,6 +630,10 @@ DECLARE_TRACE(pelt_se_tp,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
+DECLARE_TRACE(sched_cpu_capacity_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 DECLARE_TRACE(sched_overutilized_tp,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06b0a40..e468271 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44f7a0b..27f4392 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8116,6 +8116,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 		capacity = 1;
 
 	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
 	sdg->sgc->max_capacity = capacity;
@@ -11318,6 +11320,18 @@ int sched_trace_rq_cpu(struct rq *rq)
 }
 EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
 
+int sched_trace_rq_cpu_capacity(struct rq *rq)
+{
+	return rq ?
+#ifdef CONFIG_SMP
+		rq->cpu_capacity
+#else
+		SCHED_CAPACITY_SCALE
+#endif
+		: -1;
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
+
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
 {
 #ifdef CONFIG_SMP
-- 
2.7.4

