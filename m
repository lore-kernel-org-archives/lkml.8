Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359AAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0167922B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="HXxyQFbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbgCDRAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40697 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbgCDRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id o10so1879349qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iHGWLZVF8jdtLRYACYK4pKqHvrlbxJPu8oMEVlE29fE=;
        b=HXxyQFbLHqoe08CYyyOuGf85h0yOdF6IQaAEjK4Uu+mC9S6nIO213ggfx3XCHTdYfD
         adDitE0z0omPARKpKky4edr3NYo9VC8gNB8Id4loerYfrv2Wr7rYdQvlEh8xWMkPOf20
         x+LCR+57C+TDomUoHkCVtIqBdrEZWibxb4HS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iHGWLZVF8jdtLRYACYK4pKqHvrlbxJPu8oMEVlE29fE=;
        b=Nzxnu90lodOP7LlR6X5ySObsllF+FAoN4c8HgjRjwobPRXtjcbewFA2RqxNLWYqAor
         MS9lc8YA8HRjKlWRcuBR8jcDxhmk8w31AWEmglei11gRFoycmtplR7qe9SyVfdIiSqiQ
         Ybo9Pdb/N/g+++BkjbMdOVuwBdd67JfhuddVnqtNh+tO/T4D2J5c87ZN46lTyXi3y/xJ
         Yubc1SbhONKiUWCMhkMTQOHJeSEE6iAO7FK4yyaRKQVRDCwLyXoLzF20qmAF6hWP73lx
         HCmpPVnMsrSPky2WURDByTWl+91bp3fjO6ONxy55TmlMna9szEO2iewzmsVw8l1w3Q02
         GxBw==
X-Gm-Message-State: ANhLgQ3qlqzt8CCfP3tpK1zHMv1mocj+y9oC9ud3OBtihk+WObDBwIm5
        gVvyadfJBpipVaBQO2qejPv1PA==
X-Google-Smtp-Source: ADFU+vuvgU3xnJZsJfuuQxym+ySdHHNh44TPc9pdouz0fWXt9gbcGQjHKUzvbJu4gs3rkYZUjWw2yA==
X-Received: by 2002:ac8:1bdb:: with SMTP id m27mr3285828qtk.283.1583341218921;
        Wed, 04 Mar 2020 09:00:18 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id n59sm5209979qtd.77.2020.03.04.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:18 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 11/13] sched: migration changes for core scheduling
Date:   Wed,  4 Mar 2020 17:00:01 +0000
Message-Id: <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@intel.com>

 - Don't migrate if there is a cookie mismatch
     Load balance tries to move task from busiest CPU to the
     destination CPU. When core scheduling is enabled, if the
     task's cookie does not match with the destination CPU's
     core cookie, this task will be skipped by this CPU. This
     mitigates the forced idle time on the destination CPU.

 - Select cookie matched idle CPU
     In the fast path of task wakeup, select the first cookie matched
     idle CPU instead of the first idle CPU.

 - Find cookie matched idlest CPU
     In the slow path of task wakeup, find the idlest CPU whose core
     cookie matches with task's cookie

 - Don't migrate task if cookie not match
     For the NUMA load balance, don't migrate task to the CPU whose
     core cookie does not match with task's cookie

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
---
 kernel/sched/fair.c  | 55 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h | 29 +++++++++++++++++++++++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c9a80d8dbb8..f42ceecb749f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1789,6 +1789,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		/*
+		 * Skip this cpu if source task's cookie does not match
+		 * with CPU's core cookie.
+		 */
+		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
+			continue;
+#endif
+
 		env->dst_cpu = cpu;
 		task_numa_compare(env, taskimp, groupimp, maymove);
 	}
@@ -5660,8 +5669,13 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+#ifdef CONFIG_SCHED_CORE
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+#endif
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -5927,8 +5941,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			return si_cpu;
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
+#ifdef CONFIG_SCHED_CORE
+		if (available_idle_cpu(cpu) &&
+		    sched_core_cookie_match(cpu_rq(cpu), p))
+			break;
+#else
 		if (available_idle_cpu(cpu))
 			break;
+#endif
 		if (si_cpu == -1 && sched_idle_cpu(cpu))
 			si_cpu = cpu;
 	}
@@ -7264,8 +7284,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 3) task's cookie does not match with this CPU's core cookie
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
@@ -7300,6 +7321,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * Don't migrate task if the task's cookie does not match
+	 * with the destination CPU's core cookie.
+	 */
+	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+		return 0;
+#endif
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
@@ -8498,6 +8528,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 					p->cpus_ptr))
 			continue;
 
+#ifdef CONFIG_SCHED_CORE
+		if (sched_core_enabled(cpu_rq(this_cpu))) {
+			int i = 0;
+			bool cookie_match = false;
+
+			for_each_cpu(i, sched_group_span(group)) {
+				struct rq *rq = cpu_rq(i);
+
+				if (sched_core_cookie_match(rq, p)) {
+					cookie_match = true;
+					break;
+				}
+			}
+			/* Skip over this group if no cookie matched */
+			if (!cookie_match)
+				continue;
+		}
+#endif
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 552c80b70757..e4019a482f0e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+/*
+ * Helper to check if the CPU's core cookie matches with the task's cookie
+ * when core scheduling is enabled.
+ * A special case is that the task's cookie always matches with CPU's core
+ * cookie if the CPU is in an idle core.
+ */
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	bool idle_core = true;
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
+		if (!available_idle_cpu(cpu)) {
+			idle_core = false;
+			break;
+		}
+	}
+
+	/*
+	 * A CPU in an idle core is always the best choice for tasks with
+	 * cookies.
+	 */
+	return idle_core || rq->core->core_cookie == p->core_cookie;
+}
+
 extern void queue_core_balance(struct rq *rq);
 
 void sched_core_add(struct rq *rq, struct task_struct *p);
-- 
2.17.1

