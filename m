Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8854E20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="T3zNLCv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgH1TxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgH1Twp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA44C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:45 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so220523qvw.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rzeia+MMWjRjtmi+BKL7i1nzGmmNSTz3C6JKf6F9oSI=;
        b=T3zNLCv8L/0FecYfuTwnMq5UucSpFPMENbN9KBs5rK8vxCS7inUH5GWu85QYZE/m7Y
         IDfpT2vEhdkvn0IMHWiCnQ5ugmOMoYNtEjTXOtLykwYCqTzlfTpr/hxe7J75f3Rhk0kg
         86931S31t+hcjeH2hBXUpXqpRTCn1gkjtmS98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rzeia+MMWjRjtmi+BKL7i1nzGmmNSTz3C6JKf6F9oSI=;
        b=bzQajHkMTaO8S8Isp6eK1mfc2zpBBIuPBMgb4yAjMbMjm0e7NBFr5fpRcTRgHEjkzo
         +xOR1ClY3GEZW5gSPIC9I7kKmRQhIka87Qy7pvDaeT/bTU+9ToL/r3YcZeNyWqWOiC8s
         twhvW8z7z2Z5tY5AchkWyMio5t5w88u/dCKotgDsHBwJQ7rjy8CueaX4vT99ec9CTjI4
         t6wRYs+M+VKTSn2bMOJf4+emzjAP1syB9GjmlVJUrVqCkwyfSgYGfD2y94vtuYCpa48y
         a1vgdzaLbyDbeXdL5uZCjjkx9bfq7RkTMUSAAdwSjCd3A6Q1c8v8+EQohSQdKOTJWkjw
         +MCQ==
X-Gm-Message-State: AOAM532c1TmJPNb0Qr8m2N8xOT9P/d/c+GOgqPGjXU0QDEEOibmwNCxJ
        bPFwaDxA25rfKiqzBInlXmYGiA==
X-Google-Smtp-Source: ABdhPJz3n2ubMpUXlH7xLhS7Ub2v/+wLAzqt+44+zvjEpMWP60FZUW+YksiPEK/VyV+vjxE0/UA3ew==
X-Received: by 2002:a05:6214:68b:: with SMTP id r11mr167478qvz.226.1598644364380;
        Fri, 28 Aug 2020 12:52:44 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:43 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 12/23] sched: Trivial forced-newidle balancer
Date:   Fri, 28 Aug 2020 15:51:13 -0400
Message-Id: <fc1dd96eb3dcb71025abf85ceb05fb0f9397ffee.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
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
 kernel/sched/core.c   | 130 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +
 kernel/sched/sched.h  |   6 ++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5fe9878502cb..eee53fa7b8d4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -687,6 +687,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 707a56ef0fa3..7e2f310ec0c0 100644
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
@@ -4641,7 +4656,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
+	int i, j, cpu, occ = 0;
 	int smt_weight;
 	bool need_sync;
 
@@ -4750,6 +4765,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -4775,6 +4793,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				} else {
 					/*
@@ -4820,6 +4839,8 @@ next_class:;
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq_i->core_forceidle = true;
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -4837,6 +4858,113 @@ next_class:;
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
+	preempt_disable();
+	rcu_read_lock();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock();
+	preempt_enable();
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
index 8c41b023dd14..9c5637d866fd 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -406,6 +406,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e9346de3f59..be6db45276e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1109,6 +1109,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
 void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1121,6 +1123,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
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

