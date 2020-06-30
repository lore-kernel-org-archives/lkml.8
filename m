Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A112072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Nb8qycPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgF3Vdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgF3Vde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD4C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so9663015pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hdQ2xMp70fMLuDoFDFmlbfpgm19jRCSqQFZhLgrcgyM=;
        b=Nb8qycPySLCdz2sjcVEnERSJESpIpybwkbLOnP6sBAjWTK5hfBoW5oUr+e2zQrlnmW
         RD+1YggCWJROo2G6+3D+JLGet32hVW1mb6AbBqngh4EfclDn+Adfk0jDkMK0rZJo00k8
         WR3WF0KizLPviK9XrJxZQnbZy48JjjaAKU8io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hdQ2xMp70fMLuDoFDFmlbfpgm19jRCSqQFZhLgrcgyM=;
        b=pc6PJEx63YxNnIag/JiUe6MbqSxUNIRvJxjZR7xd1K8rxryo1f8R0DdB2sPL8E1BHk
         8FvEqN4Oa1vx4rtrbOVP2IBQqSQw2cC/ousmFg9iJ5hw3ytWZ9qpIGVci+czkkQkdF/7
         T2EbjQKt+wcgmin5rw76UKq/nFsuMRcgQ14dbdBVo+eEPNouFQENdAAvbUyuzOVdKpr7
         9bfWsIGDsqPAMF44MH8W482hBoUr91DCN1cJRKN+l9jODkpsxlEo2xENxBY1L6qggvBm
         8opB27pVzOMeFYY2QfI1NUPq5WuaiiWoZth5L5sohFX9bpIvSmaquJwq4caT6PyMSIEI
         8ssg==
X-Gm-Message-State: AOAM530gJ58X33ArpwsDdqzDAc7LwHD83iePHITotILYvmuHsVfQ8vdX
        Qc9FvpRHKRZ/nxrWeBc7NeRTBw==
X-Google-Smtp-Source: ABdhPJx8QiOEFm6WkTF4aW+TwQxXNpJxIcZLmYITBJ67dFHy0AUEXP7SD34ubX1XCp7vLoERyuOEsQ==
X-Received: by 2002:a62:140f:: with SMTP id 15mr20118719pfu.50.1593552814189;
        Tue, 30 Jun 2020 14:33:34 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id g22sm1054980pgb.82.2020.06.30.14.33.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:33 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [RFC PATCH 10/16] sched: Trivial forced-newidle balancer
Date:   Tue, 30 Jun 2020 21:32:31 +0000
Message-Id: <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using the RCU-sched flavor instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +
 kernel/sched/sched.h  |   6 ++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c8dcc5ff039..4f9edf013df3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -688,6 +688,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d6d6a678013..fb9edb09ead7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -201,6 +201,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -4233,7 +4248,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
+	int i, j, cpu, occ = 0;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -4332,6 +4347,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -4357,6 +4375,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				} else {
 					/*
@@ -4393,6 +4412,8 @@ next_class:;
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq_i->core_forceidle = true;
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -4408,6 +4429,114 @@ next_class:;
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_mask))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	rcu_read_lock_sched();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			break;
+
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock_sched();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static struct task_struct *
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a8d40ffab097..dff6ba220ed7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -395,6 +395,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 293aa1ae0308..464559676fd2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1089,6 +1089,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
 void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1101,6 +1103,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.17.1

