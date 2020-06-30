Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD2BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F020780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="LA3iexWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgF3XW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgF3XWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:22:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:22:55 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t198so6383068oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M2AlFniLC0kBVOSqvZsiNJKzo1s4AyhyVTej75b08JQ=;
        b=LA3iexWHGft4HqzQaLw4Iy0oVDcCqp4l0yAn0B4e6+nrsDnBL+4PY9AE1/+9IzjhNO
         UZ58vLJ7q7BcpIlSrI+rkJ0DACI4eS1XyM/X0CSEc972hPjOvbNy7pevazcAv4FUkdCw
         tZxJmMGNPsEP/J5VZ7bmDxeloCo9GS8MesmRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M2AlFniLC0kBVOSqvZsiNJKzo1s4AyhyVTej75b08JQ=;
        b=LeB6tQP15B/72Dt/yitWVKxTqgonM8W0k6CHUdhFezBGE5+1pffI8kUhPbSbkkLW2u
         hXmZ8MIhdBHA3ZB2diRYL2r0mcyu041UXCS7mQ69hAVZKjYaBsRiYaAyjGyeUuW3Q0p3
         53WkWg12RxPHc1XbruFBoJ6KBZVqcJgEqiOSrJXnyUrF+x0g3AQoF+y4H01aho0ejQJh
         hk7JdDZcJDRCjXN83vU5HkjRAITL2JYpYuvSOS8w2x8NKm0sePAvddXF6PUVY1uZQ0L+
         AEdAgn9uqPAt1MWMoiaYpDr/HZ7A+ykP/HEFE6Vt38fBVvrpi/8rTdIKmYv6v/Jwy1jT
         FANg==
X-Gm-Message-State: AOAM5307NsQY8slpTBtOkPoFCtYETcq/PD6GvmkNQzpmDfySrcDJIgvi
        Sg8ihmBKqDKCQFJ9C6gzi9lUje+nz7hzjg==
X-Google-Smtp-Source: ABdhPJw10YIJXH4Pp3Ed59sQx/p5fmJ4ExeHyvqVWy4c+GORCiQqxo+yhETqaiESD3M7Q303e1dW7A==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr24998521pjs.201.1593552818704;
        Tue, 30 Jun 2020 14:33:38 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id q14sm3585152pgk.86.2020.06.30.14.33.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:38 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 11/16] sched: migration changes for core scheduling
Date:   Tue, 30 Jun 2020 21:32:32 +0000
Message-Id: <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
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
 kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h | 29 ++++++++++++++++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d16939766361..33dc4bf01817 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2051,6 +2051,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
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
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -5963,11 +5972,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+#ifdef CONFIG_SCHED_CORE
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+#endif
+
 		if (sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -6224,8 +6239,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			break;
+
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
+#ifdef CONFIG_SCHED_CORE
+			/*
+			 * If Core Scheduling is enabled, select this cpu
+			 * only if the process cookie matches core cookie.
+			 */
+			if (sched_core_enabled(cpu_rq(cpu)) &&
+			    p->core_cookie == cpu_rq(cpu)->core->core_cookie)
+#endif
+				break;
+		}
 	}
 
 	time = cpu_clock(this) - time;
@@ -7609,8 +7634,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
@@ -7645,6 +7671,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
 
@@ -8857,6 +8892,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
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
index 464559676fd2..875796d43fca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1089,6 +1089,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
 void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
 
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
 
 #else /* !CONFIG_SCHED_CORE */
-- 
2.17.1

