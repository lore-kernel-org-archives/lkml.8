Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383EAC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C85920739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCTM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:59:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgCTM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHE0-0003kY-A9; Fri, 20 Mar 2020 13:58:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6AC251C22C0;
        Fri, 20 Mar 2020 13:58:06 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:06 -0000
From:   "tip-bot2 for Paul Turner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Distribute tasks within affinity masks
Cc:     Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311010113.136465-1-joshdon@google.com>
References: <20200311010113.136465-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <158470908610.28353.9319418052949697237.tip-bot2@tip-bot2>
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

Commit-ID:     46a87b3851f0d6eb05e6d83d5c5a30df0eca8f76
Gitweb:        https://git.kernel.org/tip/46a87b3851f0d6eb05e6d83d5c5a30df0eca8f76
Author:        Paul Turner <pjt@google.com>
AuthorDate:    Tue, 10 Mar 2020 18:01:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:18 +01:00

sched/core: Distribute tasks within affinity masks

Currently, when updating the affinity of tasks via either cpusets.cpus,
or, sched_setaffinity(); tasks not currently running within the newly
specified mask will be arbitrarily assigned to the first CPU within the
mask.

This (particularly in the case that we are restricting masks) can
result in many tasks being assigned to the first CPUs of their new
masks.

This:
 1) Can induce scheduling delays while the load-balancer has a chance to
    spread them between their new CPUs.
 2) Can antogonize a poor load-balancer behavior where it has a
    difficult time recognizing that a cross-socket imbalance has been
    forced by an affinity mask.

This change adds a new cpumask interface to allow iterated calls to
distribute within the intersection of the provided masks.

The cases that this mainly affects are:
 - modifying cpuset.cpus
 - when tasks join a cpuset
 - when modifying a task's affinity via sched_setaffinity(2)

Signed-off-by: Paul Turner <pjt@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Tested-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/20200311010113.136465-1-joshdon@google.com
---
 include/linux/cpumask.h |  7 +++++++
 kernel/sched/core.c     |  7 ++++++-
 lib/cpumask.c           | 29 +++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d5cc885..f0d895d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -194,6 +194,11 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	return 0;
 }
 
+static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
+					     const struct cpumask *src2p) {
+	return cpumask_next_and(-1, src1p, src2p);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -245,6 +250,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
 int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
+int cpumask_any_and_distribute(const struct cpumask *src1p,
+			       const struct cpumask *src2p);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 978bf6f..014d4f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1650,7 +1650,12 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_equal(p->cpus_ptr, new_mask))
 		goto out;
 
-	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
+	/*
+	 * Picking a ~random cpu helps in cases where we are changing affinity
+	 * for groups of tasks (ie. cpuset), so that load balancing is not
+	 * immediately required to distribute the tasks within their new mask.
+	 */
+	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, new_mask);
 	if (dest_cpu >= nr_cpu_ids) {
 		ret = -EINVAL;
 		goto out;
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672e..fb22fb2 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -232,3 +232,32 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	BUG();
 }
 EXPORT_SYMBOL(cpumask_local_spread);
+
+static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
+
+/**
+ * Returns an arbitrary cpu within srcp1 & srcp2.
+ *
+ * Iterated calls using the same srcp1 and srcp2 will be distributed within
+ * their intersection.
+ *
+ * Returns >= nr_cpu_ids if the intersection is empty.
+ */
+int cpumask_any_and_distribute(const struct cpumask *src1p,
+			       const struct cpumask *src2p)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next_and(prev, src1p, src2p);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first_and(src1p, src2p);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_and_distribute);
