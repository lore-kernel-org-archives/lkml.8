Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D85C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331FC20768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436669AbgDNPHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:07:14 -0400
Received: from foss.arm.com ([217.140.110.172]:57662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgDNPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB45DC14;
        Tue, 14 Apr 2020 08:06:45 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B026F3F73D;
        Tue, 14 Apr 2020 08:06:43 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpumask: Make cpumask_any() truly random
Date:   Tue, 14 Apr 2020 16:05:54 +0100
Message-Id: <20200414150556.10920-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414150556.10920-1-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
added a new cpumask_any_and_distribute() which truly returns a random
cpu within the mask.

Previous patch renamed the function to cpumask_any_and(), so that old
users can take advantage of the new randomness behavior.

Build up on that, and let cpumask_any() truly random too by re-using the
logic from cpumask_any_and().

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Yury Norov <yury.norov@gmail.com>
CC: Paul Turner <pjt@google.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Josh Don <joshdon@google.com>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-kernel@vger.kernel.org
---
 include/linux/cpumask.h | 14 ++++++--------
 lib/cpumask.c           | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index e4d6d140a67c..7fb25d256043 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -194,6 +194,11 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	return 0;
 }
 
+static inline int cpumask_any(const struct cpumask *src1p)
+{
+	return 0;
+}
+
 static inline int cpumask_any_and(const struct cpumask *src1p,
 				  const struct cpumask *src2p)
 {
@@ -251,6 +256,7 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
+int cpumask_any(const struct cpumask *srcp);
 int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p);
 
 /**
@@ -600,14 +606,6 @@ static inline void cpumask_copy(struct cpumask *dstp,
 	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-/**
- * cpumask_any - pick a "random" cpu from *srcp
- * @srcp: the input cpumask
- *
- * Returns >= nr_cpu_ids if no cpus set.
- */
-#define cpumask_any(srcp) cpumask_first(srcp)
-
 /**
  * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
  * @src1p: the first input
diff --git a/lib/cpumask.c b/lib/cpumask.c
index b527a153b023..bcac63e45374 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -259,3 +259,27 @@ int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and);
+
+/**
+ * cpumask_any - pick a "random" cpu from *srcp
+ * @srcp: the input cpumask
+ *
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+int cpumask_any(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any);
-- 
2.17.1

