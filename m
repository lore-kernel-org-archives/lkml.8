Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D293AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A789720661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAMGo8F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgBKRrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:47:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33838 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgBKRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so13550848wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0Kl4PIc63tNbMSxRHtTfatu+2i8Sl6BRgrV77JMqsM=;
        b=zAMGo8F1uYSYe4b+PEbZ9+cRAbacKy2oQrNPA108rqYCG/Uookfm/NZZJ6npikf5o/
         9c2cjSZ2pYtviX2pujq6mwf9Jb9XJZ1uKj+kLRv97VndALQPC8d8Vsf/7ZZo+Y6l5cUe
         Hnq/sc+Mec2ewS7y+VJ9gA0tsdZPXdyGcx5rr9FFzOCTGJQ4eMq60mtk4/m5cv3Am/uH
         jOShihPCuQB66MB2jziYksTqRDPSWimBr6LnycDC7UsKzyrvXF1mXWYatCqtxMj7RA8F
         dYEWnFlGQYaUUHGATg/4mH1EGZcjEwJECnwFtS8l4o/g+dXMSHU6obk4z5/qEwFgPStw
         1eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y0Kl4PIc63tNbMSxRHtTfatu+2i8Sl6BRgrV77JMqsM=;
        b=eWFR2bYg8bm5Hv6AQ9Aje8EWAedmGCJK9eX0xVH9c3AwFgPQVI2nA5AGUnh3IzF7GH
         hSeRHWRyo8oi0iY2LnEmo1IiVwPMoRBLy6v6c5CrM15lmjaifDUBFpVU4ExkCbyiSO4y
         qqy3k81b8IgfI8PJCyiBW66t8BXFrHExkw9jJZo5sgjGGKR+tRbJZzrYsY+IlyyezBx1
         EhrhSvcPiOSEr3dFmpCsvN7j4TH/QBavTg4+UMfo7o81/5UNgeLUh8f50qafdIMetidg
         eTj0B1INrSxUxtWzetxfRhNlWt0pXeJrPkBIZEHTYr9pqKBrNcP0iF6o3ZutXsf2VE63
         NBpA==
X-Gm-Message-State: APjAAAU2zNbDyg58pu5j1E4f9Fo+VlNFYdhYkPiOwHQO/jkHSvNKmaFV
        uaEQPDs0TpytH3PvwRONtu/B9A==
X-Google-Smtp-Source: APXvYqwtwkl10YaVCthwfFXOMhtciIkJUXwGc4rDKKW2Q+1bOkRDSJWMffucFOeZvYKTZDPyGuZ8oQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr9490760wro.384.1581443225968;
        Tue, 11 Feb 2020 09:47:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39bd:f3e9:9eaa:e898])
        by smtp.gmail.com with ESMTPSA id s12sm6104764wrw.20.2020.02.11.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:47:04 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Date:   Tue, 11 Feb 2020 18:46:49 +0100
Message-Id: <20200211174651.10330-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174651.10330-1-vincent.guittot@linaro.org>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what has been done for the normal load balance, we can
replace runnable_load_avg by load_avg in numa load balancing and track
other statistics like the utilization and the number of running tasks to
get to better view of the current state of a node.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1ea02b5362e..6e4c2b012c48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1473,38 +1473,35 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
-
-static unsigned long cpu_runnable_load(struct rq *rq)
-{
-	return cfs_rq_runnable_load_avg(&rq->cfs);
-}
+/*
+ * 'numa_type' describes the node at the moment of load balancing.
+ */
+enum numa_type {
+	/* The node has spare capacity that can be used to run more tasks.  */
+	node_has_spare = 0,
+	/*
+	 * The node is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
+	node_fully_busy,
+	/*
+	 * The node is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
+	node_overloaded
+};
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
 	unsigned long load;
-
+	unsigned long util;
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
+	unsigned int nr_running;
+	unsigned int weight;
+	enum numa_type node_type;
 };
 
-/*
- * XXX borrowed from update_sg_lb_stats
- */
-static void update_numa_stats(struct numa_stats *ns, int nid)
-{
-	int cpu;
-
-	memset(ns, 0, sizeof(*ns));
-	for_each_cpu(cpu, cpumask_of_node(nid)) {
-		struct rq *rq = cpu_rq(cpu);
-
-		ns->load += cpu_runnable_load(rq);
-		ns->compute_capacity += capacity_of(cpu);
-	}
-
-}
-
 struct task_numa_env {
 	struct task_struct *p;
 
@@ -1521,6 +1518,47 @@ struct task_numa_env {
 	int best_cpu;
 };
 
+static unsigned long cpu_load(struct rq *rq);
+static unsigned long cpu_util(int cpu);
+
+static inline enum
+numa_type numa_classify(unsigned int imbalance_pct,
+			 struct numa_stats *ns)
+{
+	if ((ns->nr_running > ns->weight) &&
+	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
+		return node_overloaded;
+
+	if ((ns->nr_running < ns->weight) ||
+	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
+		return node_has_spare;
+
+	return node_fully_busy;
+}
+
+/*
+ * XXX borrowed from update_sg_lb_stats
+ */
+static void update_numa_stats(struct task_numa_env *env,
+			      struct numa_stats *ns, int nid)
+{
+	int cpu;
+
+	memset(ns, 0, sizeof(*ns));
+	for_each_cpu(cpu, cpumask_of_node(nid)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		ns->load += cpu_load(rq);
+		ns->util += cpu_util(cpu);
+		ns->nr_running += rq->cfs.h_nr_running;
+		ns->compute_capacity += capacity_of(cpu);
+	}
+
+	ns->weight = cpumask_weight(cpumask_of_node(nid));
+
+	ns->node_type = numa_classify(env->imbalance_pct, ns);
+}
+
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
@@ -1556,6 +1594,11 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	long orig_src_load, orig_dst_load;
 	long src_capacity, dst_capacity;
 
+
+	/* If dst node has spare capacity, there is no real load imbalance */
+	if (env->dst_stats.node_type == node_has_spare)
+		return false;
+
 	/*
 	 * The load is corrected for the CPU capacity available on each node.
 	 *
@@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
 	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
 	taskweight = task_weight(p, env.src_nid, dist);
 	groupweight = group_weight(p, env.src_nid, dist);
-	update_numa_stats(&env.src_stats, env.src_nid);
+	update_numa_stats(&env, &env.src_stats, env.src_nid);
 	taskimp = task_weight(p, env.dst_nid, dist) - taskweight;
 	groupimp = group_weight(p, env.dst_nid, dist) - groupweight;
-	update_numa_stats(&env.dst_stats, env.dst_nid);
+	update_numa_stats(&env, &env.dst_stats, env.dst_nid);
 
 	/* Try to find a spot on the preferred nid. */
 	task_numa_find_cpu(&env, taskimp, groupimp);
@@ -1824,7 +1867,7 @@ static int task_numa_migrate(struct task_struct *p)
 
 			env.dist = dist;
 			env.dst_nid = nid;
-			update_numa_stats(&env.dst_stats, env.dst_nid);
+			update_numa_stats(&env, &env.dst_stats, env.dst_nid);
 			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
@@ -5446,6 +5489,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	return load;
 }
 
+static unsigned long cpu_runnable_load(struct rq *rq)
+{
+	return cfs_rq_runnable_load_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
-- 
2.17.1

