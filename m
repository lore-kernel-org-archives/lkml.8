Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582BAC3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B4A24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBWBtkQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgBNP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:27:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34859 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgBNP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:27:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so11352309wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53ngjg9JhA2q1DD1qwBuU9TKGF91CSQgYHS0UwTt7oY=;
        b=fBWBtkQ3iOVr33tkdY6P11CgyTyYsy82Dx5cJZt9xvwJLq1m/0p9P4X4jD+QGXl3O/
         um26CtpprkNsXDpO2WKoePIWyExFNBqpbIC37vDGFxKTkd6+aGolvmUu3Nvve1btqKED
         IHXBJGbiycsCwEyW9DslYG4VmzkMO0B2BzYn5VvSyGaUXxfSqymwWfzYY7nRghWb7oDc
         /E+aMTD9T27ZUnWt0dHHaEppk4ykw7nCfFq4tVDNjan0I03gPxcGUDexMRq4luKg8XQk
         WMdrmngobufCJX3nvuaMOQpgON9Okwh4WEhzYsC2DXQIZF0FcwSP6lA1UU95cmTSVREM
         ijHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53ngjg9JhA2q1DD1qwBuU9TKGF91CSQgYHS0UwTt7oY=;
        b=OLTHzo/5/EzPnZeDYg0a2E7irFpBtZuN+zIUUkJnvHluB8Vb7lFpfKYpy7XfN0TmXB
         r5l0m2m1Y4jZzj+B32etdh2HFlNGd/csMQi9ErHq3DgeXypetqCW8Mb9t0RYTj/lZGHm
         xjoI7I10wMjtnM2/QXsP4NrRA8HuIVVTGDAx02W0teW0f8mnXf4scfbIQrReO7RSra7c
         H3+fIQWsY5lFDrby2OmCirk9rJj295YFjR33NV0Csv8RRq1DvZaD9LTT6gOyl55rZVjD
         h2bLn6Iv09ObSUi/IjU+Rn9ICOMBKctI4z2vsz7Vs3wn8JcZ8/ipI6UOJR9QO276MNev
         aovg==
X-Gm-Message-State: APjAAAWfUwPUWP2cBaTYRNH1N+/7/0CcIHrnJrpa41hWGJwq5CuypzVp
        uPOW8e7t1sTm7K8ZT5xtU7JKaA==
X-Google-Smtp-Source: APXvYqyJeA05NB3mchyP6uoj7JeU/3p5+GA5TtEODZlwUDV6Zvcnw/ZeQO3454BFNFmJtlWvOpOuqA==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr4861102wrm.150.1581694063110;
        Fri, 14 Feb 2020 07:27:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b5b3:5d19:723a:398f])
        by smtp.gmail.com with ESMTPSA id c13sm7442963wrn.46.2020.02.14.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 07:27:42 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
Date:   Fri, 14 Feb 2020 16:27:26 +0100
Message-Id: <20200214152729.6059-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214152729.6059-1-vincent.guittot@linaro.org>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what has been done for the normal load balancer, we can
replace runnable_load_avg by load_avg in numa load balancing and track the
other statistics like the utilization and the number of running tasks to
get to better view of the current state of a node.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 27450c4ddc81..12266b248f52 100644
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

