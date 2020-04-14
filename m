Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD17C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9662E2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436503AbgDNPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:06:58 -0400
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407289AbgDNPGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F17031B;
        Tue, 14 Apr 2020 08:06:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66F823F73D;
        Tue, 14 Apr 2020 08:06:40 -0700 (PDT)
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
Subject: [PATCH 1/4] cpumask: Rename cpumask_any_and_distribute
Date:   Tue, 14 Apr 2020 16:05:53 +0100
Message-Id: <20200414150556.10920-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414150556.10920-1-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is actually an alias of cpumask_any_and(), except that the
new function does the randomization and the old implementation didn't.

Rename the new function to cpumask_any_and() so that old users can take
advantage of its 'enhanced' randomness.

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
 include/linux/cpumask.h | 17 ++++-------------
 kernel/sched/core.c     |  2 +-
 lib/cpumask.c           | 14 ++++++--------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..e4d6d140a67c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -194,8 +194,9 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	return 0;
 }
 
-static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
-					     const struct cpumask *src2p) {
+static inline int cpumask_any_and(const struct cpumask *src1p,
+				  const struct cpumask *src2p)
+{
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
@@ -250,8 +251,7 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
-int cpumask_any_and_distribute(const struct cpumask *src1p,
-			       const struct cpumask *src2p);
+int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
@@ -617,15 +617,6 @@ static inline void cpumask_copy(struct cpumask *dstp,
  */
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
 
-/**
- * cpumask_any_and - pick a "random" cpu from *mask1 & *mask2
- * @mask1: the first input cpumask
- * @mask2: the second input cpumask
- *
- * Returns >= nr_cpu_ids if no cpus set.
- */
-#define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
-
 /**
  * cpumask_of - the cpumask containing just a given cpu
  * @cpu: the cpu (<= nr_cpu_ids)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c1f923d647ee..7942ebc83e6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1655,7 +1655,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	 * for groups of tasks (ie. cpuset), so that load balancing is not
 	 * immediately required to distribute the tasks within their new mask.
 	 */
-	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, new_mask);
+	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
 	if (dest_cpu >= nr_cpu_ids) {
 		ret = -EINVAL;
 		goto out;
diff --git a/lib/cpumask.c b/lib/cpumask.c
index fb22fb266f93..b527a153b023 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -236,15 +236,13 @@ EXPORT_SYMBOL(cpumask_local_spread);
 static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
 
 /**
- * Returns an arbitrary cpu within srcp1 & srcp2.
+ * cpumask_any_and - pick a "random" cpu from *mask1 & *mask2
+ * @mask1: the first input cpumask
+ * @mask2: the second input cpumask
  *
- * Iterated calls using the same srcp1 and srcp2 will be distributed within
- * their intersection.
- *
- * Returns >= nr_cpu_ids if the intersection is empty.
+ * Returns >= nr_cpu_ids if no cpus set.
  */
-int cpumask_any_and_distribute(const struct cpumask *src1p,
-			       const struct cpumask *src2p)
+int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p)
 {
 	int next, prev;
 
@@ -260,4 +258,4 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 
 	return next;
 }
-EXPORT_SYMBOL(cpumask_any_and_distribute);
+EXPORT_SYMBOL(cpumask_any_and);
-- 
2.17.1

