Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE01C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0B9222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9EcrTEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgBUN1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:27:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54843 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgBUN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:27:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id n3so1789008wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWElDKCdQ1HujG8ZetqIOuYebagfDqRqggNkdk0NgVE=;
        b=m9EcrTEJwdUArHrj5sDBK0p+tU3rh/pFkN4aJmEPAK8RNjvfXQkftG1FW11JWNnUD+
         IKVwK4OhFJz27vqHyO5SqBzow7eu/HNX1tzwv7+wzeXaMurSMf5ud7vTBaFlkWkLgBAD
         su0bQTzrJdlIzZp7tzhl7awiUmJt8n98ipmd8MmAcyaQu6VZVBQZKkulycnRTCbmRedy
         Dc3bBDeoO7jaiiS2hR4qJrd8AoPDZGDrTC7BfaSPbSkvauX4MgmhFXiZIWS188DiQgw1
         wEjn3iWftUApwRy0arWw5TFzn18Hgdvkfawf/p2o27BjwqNMgQNLIi/KOyN7/vTSKPf+
         uzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kWElDKCdQ1HujG8ZetqIOuYebagfDqRqggNkdk0NgVE=;
        b=KiQRquwkjBtO2O39SDrYLVTd3Y7iFRbLXslnBQZmpjScX3TwffP/WDujJeAD0zMevx
         zDkrAJ841roY7ObumqQ/alQxGXbJ9KUY+JbY9Rsgk8UPOpeSRoFVvUaLjMtSP0CnpvtO
         ySPdMD3PjISpigifDLV83LSeoNWH37rea8SH7imO98EnrAWpM55dzzFiPV135E9WmyLe
         oNrpHyn2GEpgG/ucJ6Ew3MGainR/3acA1ih5MJPv9Q01YfIk7rjkh1IHnfNoHq5l6ymd
         Z82ZEfU1YIeEgY22LROuxo82255xv9yf/rj8M8JsNPjCHFagugnFrPU0l6SAyQOVmPX5
         D7rg==
X-Gm-Message-State: APjAAAXU6tUVaOEcvUuk81W292LZC4LdjEhrL8gOB1h1SH4QbiuUm6m+
        cGD0HNYGS78Ex5w5K1G+kXbrgg==
X-Google-Smtp-Source: APXvYqw+i53Ie7ZggpBynyfzQQTHlMOugUE0v3SwAvjG187dB1Be6JMo0sjvnvA+TI92g4HLwa9YRQ==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr3968988wmc.165.1582291654133;
        Fri, 21 Feb 2020 05:27:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:1c35:eef1:1bd1:92a7])
        by smtp.gmail.com with ESMTPSA id y185sm4058308wmg.2.2020.02.21.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:27:32 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 2/5] sched/numa: Replace runnable_load_avg by load_avg
Date:   Fri, 21 Feb 2020 14:27:12 +0100
Message-Id: <20200221132715.20648-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221132715.20648-1-vincent.guittot@linaro.org>
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what has been done for the normal load balancer, we can
replace runnable_load_avg by load_avg in numa load balancing and track the
other statistics like the utilization and the number of running tasks to
get to better view of the current state of a node.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
---
 kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 27450c4ddc81..637f4eb47889 100644
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
@@ -3685,11 +3728,6 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->avg.runnable_load_avg;
-}
-
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->avg.load_avg;
-- 
2.17.1

