Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D54C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256D221D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGcqqP2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgCKBBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:01:40 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40621 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKBBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:01:40 -0400
Received: by mail-pf1-f201.google.com with SMTP id d127so225099pfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 18:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uFju+yiXs54MdHtgioQYAx/aRo0/p25DSWXwTL9KVhU=;
        b=RGcqqP2HhuPpq5mYsqQ1M/+GX4ukKpmw6wJTxII3zvx2Bf104CkLRTUii4yFizR6Bg
         2wg1xwQZBz5v7mn91rdSOig5iFIA8pad9iTMrm9EqHXRC50XxovDweSCklDbYBJlQ2d3
         T8BG94oZMiucIeoDoU5DVQWBfDLDa6mNSXqmBZhFdwHof4avq/PZ3c4vpH4u8TFUFZkX
         bwhJIoZeHDiX9QCUudRaZhuqqUG7RLYxF9D49/SqlQqRxRgA3b027mTdfzZSmIiGwp1g
         COztLez1h6t1oDDuHe2qbuCNyz0ovGiDKTyDCrxZeDCifF50x/oAmDH+zz99mPxXzsRJ
         KIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uFju+yiXs54MdHtgioQYAx/aRo0/p25DSWXwTL9KVhU=;
        b=JYW+gac4yPO8Vk7MaJP4jd0EdAzsuhmDz2RH8n5R5q0dcersXMCbYnAv3NxWWK3XuO
         z0szunVXM8sumdna/627/FU8TNzAGRIpyjJN0ILT7puHgOdRphuNsMWAMxgTK2KlOdE0
         OLtPcRYktoKlWDQ6xa48L5VqMfeWcptZhdrxJAk/ebMVJ71/X7RIcxWavMBlZ2qKGpRm
         67bihgLRS2hrc9JucVxz8mQTIOQXl7ZyZ8f2jxSgsZNRcWIIA+5K84QA/9fERAPkF0M5
         F8DEgUJ6BBe5NJe1qUK6Dm356qhD3Jzs8iGSh1mZiyKa5hZblKzb4i8YqnLU/CvKixYw
         GDTg==
X-Gm-Message-State: ANhLgQ2Bx45CQPRgAN8zoHUjqKAhsFZ7n0zBDtXcvrri7QLv5/t52rqW
        Q1JSp+ZkzzpkQ77VOGZAh7bg8IVibg6S
X-Google-Smtp-Source: ADFU+vtv1JcbFOuxbcyBd07owGiwiL/aoKg6YUYaLuhfUd5CE/FpUdrKIM2Q6j8dUNWjsJCdTgYWsI0mToUt
X-Received: by 2002:a17:90b:238e:: with SMTP id mr14mr686812pjb.146.1583888498905;
 Tue, 10 Mar 2020 18:01:38 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:01:13 -0700
Message-Id: <20200311010113.136465-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Turner <pjt@google.com>

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

Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Paul Turner <pjt@google.com>
---
v2:
- Moved the "distribute" implementation to a new
cpumask_any_and_distribute() function
- No longer move a task if it is already running on an allowed cpu

 include/linux/cpumask.h |  7 +++++++
 kernel/sched/core.c     |  7 ++++++-
 lib/cpumask.c           | 29 +++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d5cc88514aee..f0d895d6ac39 100644
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
index 1a9983da4408..fc6f2bec7d44 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1652,7 +1652,12 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
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
index 0cb672eb107c..fb22fb266f93 100644
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
-- 
2.25.1.481.gfbce0eb801-goog

