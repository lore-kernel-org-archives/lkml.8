Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7EF208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgIGJRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:17:32 -0400
Received: from foss.arm.com ([217.140.110.172]:58364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgIGJRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:17:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F75113E;
        Mon,  7 Sep 2020 02:17:25 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A620A3F66E;
        Mon,  7 Sep 2020 02:17:23 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 1/3] sched/fair: Remove sched_trace_*() helper functions
Date:   Mon,  7 Sep 2020 11:17:15 +0200
Message-Id: <20200907091717.26116-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907091717.26116-1-dietmar.eggemann@arm.com>
References: <20200907091717.26116-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_trace_*() helper functions provide access to data of
internal scheduler structures, like struct rq. They support built-in
or kernel module builds outside kernel/sched/. But they don't have to
be maintained in the scheduler code.

kernel/sched/ is the natural place for a tp-2-te converter to get
access to data of internal scheduler structures.

In case a kernel module has to be build out-of tree there is an easy
way to make kernel/sched/sched.h visible.

      CFLAGS_foo.o := -I$KERNEL_SRC/kernel/sched

      all:
          make -C $KERNEL_SRC M=$(PWD) modules

The sched_trace_*() helper functions can be coded in a tp-2-te converter.

Remove them from kernel/sched/fair.c.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h | 13 -------
 kernel/sched/fair.c   | 86 -------------------------------------------
 2 files changed, 99 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2bf0af19a62a..23415088967d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2035,17 +2035,4 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
-const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
-char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
-int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
-
-const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq);
-const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
-const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
-
-int sched_trace_rq_cpu(struct rq *rq);
-int sched_trace_rq_nr_running(struct rq *rq);
-
-const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
-
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33699db27ed5..f7640af1dcaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11236,89 +11236,3 @@ __init void init_sched_fair_class(void)
 #endif /* SMP */
 
 }
-
-/*
- * Helper functions to facilitate extracting info from tracepoints.
- */
-
-const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq)
-{
-#ifdef CONFIG_SMP
-	return cfs_rq ? &cfs_rq->avg : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_avg);
-
-char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len)
-{
-	if (!cfs_rq) {
-		if (str)
-			strlcpy(str, "(null)", len);
-		else
-			return NULL;
-	}
-
-	cfs_rq_tg_path(cfs_rq, str, len);
-	return str;
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_path);
-
-int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq ? cpu_of(rq_of(cfs_rq)) : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_cpu);
-
-const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq)
-{
-#ifdef CONFIG_SMP
-	return rq ? &rq->avg_rt : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_rt);
-
-const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq)
-{
-#ifdef CONFIG_SMP
-	return rq ? &rq->avg_dl : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_dl);
-
-const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_SCHED_AVG_IRQ)
-	return rq ? &rq->avg_irq : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_irq);
-
-int sched_trace_rq_cpu(struct rq *rq)
-{
-	return rq ? cpu_of(rq) : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
-
-const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
-{
-#ifdef CONFIG_SMP
-	return rd ? rd->span : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rd_span);
-
-int sched_trace_rq_nr_running(struct rq *rq)
-{
-        return rq ? rq->nr_running : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
-- 
2.17.1

