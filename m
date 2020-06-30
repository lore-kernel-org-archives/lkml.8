Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA85C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A571B2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QjlwtQ1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgF3Vc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgF3Vcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:32:55 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4BAC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so10073931pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GguPaWoEnckoDJDfsz3nwH8FLKmUCeiAQn7+tgz34ms=;
        b=QjlwtQ1QqmiHeOtJi1OZWdhtdOh1oClZJP676P9JpQga9cEKGn38l+kEss43QyAnUu
         MwBvJJtVTu5PVkdljhQ/Pad9bvrf8a78dRBwINjohgVmZlPSR2fQGdxXF/zCtHSbeSz9
         OsoSwx2VHHnjxTtfghgbF+qn/pWLbtgtmqIQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GguPaWoEnckoDJDfsz3nwH8FLKmUCeiAQn7+tgz34ms=;
        b=USuSvUjDAi4xjXfKw8jMrNMdB94EXgDTk03agubQOSYolhrNW+eDkMzgPUjBDU+yjy
         752nz8BRcu7OTDgRPYQTmtrvGcdGxrZy6ntUJUIjEVCxb/nM2s3gqsquzTpzBGEGI4qw
         NWhiZq/OI6KKBNQ7m+tlcOORnGwhbL8iZxVjY0F56JgaCp8OYuvN3CoDRNT7JtPIB0mV
         4NZtdbSD5XpW/7l+y+7e2ZcosO1ZHccMWXWiGxnStaxxsynJfCtjD/L/ZrHu2k34jsCy
         u9TOA/VlqENXyJcXIlNzZrBcXVqDcHOmfFtXd7jwPY2bzohxrS04ZAKKRfz+2y3pytDa
         Bn4w==
X-Gm-Message-State: AOAM530ppgC9VqMsp5RBkX0CyePvT2Si8yiBHBj907Gm6dz6mCBnfYVv
        sw2r+k2v6Pu/bIbCyv/zKbZoKA==
X-Google-Smtp-Source: ABdhPJye/+blcuu9KIqxjIagc0T+BX51yWzU1Z66iv40nE1bUwC25ZKdRZgS/5hlz3sQ61U0MsorOA==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr19755446plb.45.1593552773015;
        Tue, 30 Jun 2020 14:32:53 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id 125sm3360004pff.130.2020.06.30.14.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:32:51 -0700 (PDT)
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 01/16] sched: Wrap rq::lock access
Date:   Tue, 30 Jun 2020 21:32:22 +0000
Message-Id: <c27c8aa7945dc5e19a553f10576c6a3a4fec1c57.1593530334.git.vpillai@digitalocean.com>
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

In preparation of playing games with rq->lock, abstract the thing
using an accessor.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/core.c     |  46 +++++++++---------
 kernel/sched/cpuacct.c  |  12 ++---
 kernel/sched/deadline.c |  18 +++----
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     |  38 +++++++--------
 kernel/sched/idle.c     |   4 +-
 kernel/sched/pelt.h     |   2 +-
 kernel/sched/rt.c       |   8 +--
 kernel/sched/sched.h    | 105 +++++++++++++++++++++-------------------
 kernel/sched/topology.c |   4 +-
 10 files changed, 122 insertions(+), 119 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5eccfb816d23..ef594ace6ffd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -85,12 +85,12 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 	for (;;) {
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 
 		while (unlikely(task_on_rq_migrating(p)))
 			cpu_relax();
@@ -109,7 +109,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	for (;;) {
 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		/*
 		 *	move_queued_task()		task_rq_lock()
 		 *
@@ -131,7 +131,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 
 		while (unlikely(task_on_rq_migrating(p)))
@@ -201,7 +201,7 @@ void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (rq->clock_update_flags & RQCF_ACT_SKIP)
 		return;
@@ -505,7 +505,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (test_tsk_need_resched(curr))
 		return;
@@ -529,10 +529,10 @@ void resched_cpu(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
 		resched_curr(rq);
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 #ifdef CONFIG_SMP
@@ -947,7 +947,7 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/* Update task effective clamp */
 	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
@@ -987,7 +987,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	SCHED_WARN_ON(!bucket->tasks);
@@ -1472,7 +1472,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
@@ -1586,7 +1586,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		 * Because __kthread_bind() calls this on blocked tasks without
 		 * holding rq->lock.
 		 */
-		lockdep_assert_held(&rq->lock);
+		lockdep_assert_held(rq_lockp(rq));
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	}
 	if (running)
@@ -1723,7 +1723,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(&task_rq(p)->lock)));
+				      lockdep_is_held(rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -2234,7 +2234,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 #ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
@@ -3088,10 +3088,10 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, _THIS_IP_);
+	spin_release(&rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = next;
+	rq_lockp(rq)->owner = next;
 #endif
 }
 
@@ -3102,8 +3102,8 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	raw_spin_unlock_irq(&rq->lock);
+	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 /*
@@ -3253,7 +3253,7 @@ static void __balance_callback(struct rq *rq)
 	void (*func)(struct rq *rq);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	head = rq->balance_callback;
 	rq->balance_callback = NULL;
 	while (head) {
@@ -3264,7 +3264,7 @@ static void __balance_callback(struct rq *rq)
 
 		func(rq);
 	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 static inline void balance_callback(struct rq *rq)
@@ -6034,7 +6034,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	__sched_fork(0, idle);
 
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
@@ -6071,7 +6071,7 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
 #endif
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
@@ -6634,7 +6634,7 @@ void __init sched_init(void)
 		struct rq *rq;
 
 		rq = cpu_rq(i);
-		raw_spin_lock_init(&rq->lock);
+		raw_spin_lock_init(&rq->__lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb10383434..78de28ebc45d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -111,7 +111,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	/*
 	 * Take rq->lock to make 64-bit read safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	if (index == CPUACCT_STAT_NSTATS) {
@@ -125,7 +125,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	}
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	return data;
@@ -140,14 +140,14 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	/*
 	 * Take rq->lock to make 64-bit write safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
 		cpuusage->usages[i] = val;
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 }
 
@@ -252,13 +252,13 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 			 * Take rq->lock to make 64-bit read safe on 32-bit
 			 * platforms.
 			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 			seq_printf(m, " %llu", cpuusage->usages[index]);
 
 #ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 		}
 		seq_puts(m, "\n");
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..34f95462b838 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -80,7 +80,7 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -93,7 +93,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
@@ -107,7 +107,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->this_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
 }
@@ -117,7 +117,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp(rq_of_dl_rq(dl_rq)));
 	dl_rq->this_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
@@ -927,7 +927,7 @@ static int start_dl_timer(struct task_struct *p)
 	ktime_t now, act;
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/*
 	 * We want the timer to fire at the deadline, but considering
@@ -1037,9 +1037,9 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(&rq->lock, rf.cookie);
+		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(&rq->lock);
+		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
@@ -1654,7 +1654,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	if (p->dl.dl_non_contending) {
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
@@ -1669,7 +1669,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 239970b991c0..339b729b8828 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -497,7 +497,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (rb_first_cached(&cfs_rq->tasks_timeline))
 		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
 	last = __pick_last_entity(cfs_rq);
@@ -505,7 +505,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 		max_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
 	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
 			SPLIT_NS(MIN_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ae7e30ccb33..43ff0e5cf387 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1104,7 +1104,7 @@ struct numa_group {
 static struct numa_group *deref_task_numa_group(struct task_struct *p)
 {
 	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(&task_rq(p)->lock) && !READ_ONCE(p->on_cpu)));
+		(lockdep_is_held(rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
 }
 
 static struct numa_group *deref_curr_numa_group(struct task_struct *p)
@@ -5265,7 +5265,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -5284,7 +5284,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6749,7 +6749,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
 		 * rq->lock and can modify state directly.
 		 */
-		lockdep_assert_held(&task_rq(p)->lock);
+		lockdep_assert_held(rq_lockp(task_rq(p)));
 		detach_entity_cfs_rq(&p->se);
 
 	} else {
@@ -7377,7 +7377,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 {
 	s64 delta;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (p->sched_class != &fair_sched_class)
 		return 0;
@@ -7471,7 +7471,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
 	int tsk_cache_hot;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	/*
 	 * We do not migrate tasks that are:
@@ -7549,7 +7549,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
  */
 static void detach_task(struct task_struct *p, struct lb_env *env)
 {
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
@@ -7565,7 +7565,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	list_for_each_entry_reverse(p,
 			&env->src_rq->cfs_tasks, se.group_node) {
@@ -7601,7 +7601,7 @@ static int detach_tasks(struct lb_env *env)
 	struct task_struct *p;
 	int detached = 0;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (env->imbalance <= 0)
 		return 0;
@@ -7716,7 +7716,7 @@ static int detach_tasks(struct lb_env *env)
  */
 static void attach_task(struct rq *rq, struct task_struct *p)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	BUG_ON(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
@@ -9649,7 +9649,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if (need_active_balance(&env)) {
 			unsigned long flags;
 
-			raw_spin_lock_irqsave(&busiest->lock, flags);
+			raw_spin_lock_irqsave(rq_lockp(busiest), flags);
 
 			/*
 			 * Don't kick the active_load_balance_cpu_stop,
@@ -9657,7 +9657,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * moved to this_cpu:
 			 */
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
-				raw_spin_unlock_irqrestore(&busiest->lock,
+				raw_spin_unlock_irqrestore(rq_lockp(busiest),
 							    flags);
 				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
@@ -9673,7 +9673,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
+			raw_spin_unlock_irqrestore(rq_lockp(busiest), flags);
 
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
@@ -10418,7 +10418,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
 	 * need to be updated. Run the ilb locally as it is a good
@@ -10427,7 +10427,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 */
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10493,7 +10493,7 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		goto out;
 	}
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10534,7 +10534,7 @@ int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -11010,9 +11010,9 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 		rq = cpu_rq(cpu);
 
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock_irqsave(rq_lockp(rq), flags);
 		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	}
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b743bf38f08f..0106d34f1d8c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -413,10 +413,10 @@ struct task_struct *pick_next_task_idle(struct rq *rq)
 static void
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 }
 
 /*
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index eb034d9f024d..10a9ef0dbfe6 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -136,7 +136,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_pelt - rq->lost_idle_time;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6d60ba21ed29..c054d9c07629 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -887,7 +887,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -925,7 +925,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
@@ -2094,9 +2094,9 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * When it gets updated, a check is made if a push is possible.
 	 */
 	if (has_pushable_tasks(rq)) {
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		push_rt_tasks(rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	raw_spin_lock(&rd->rto_lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f58677a8f23..b15feed95027 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -874,7 +874,7 @@ struct uclamp_rq {
  */
 struct rq {
 	/* runqueue lock: */
-	raw_spinlock_t		lock;
+	raw_spinlock_t		__lock;
 
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
@@ -1055,6 +1055,10 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1122,7 +1126,7 @@ static inline void assert_clock_updated(struct rq *rq)
 
 static inline u64 rq_clock(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock;
@@ -1130,7 +1134,7 @@ static inline u64 rq_clock(struct rq *rq)
 
 static inline u64 rq_clock_task(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_task;
@@ -1156,7 +1160,7 @@ static inline u64 rq_clock_thermal(struct rq *rq)
 
 static inline void rq_clock_skip_update(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags |= RQCF_REQ_SKIP;
 }
 
@@ -1166,7 +1170,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
@@ -1185,7 +1189,7 @@ struct rq_flags {
 
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(&rq->lock);
+	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1200,12 +1204,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(&rq->lock, rf->cookie);
+	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(&rq->lock, rf->cookie);
+	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -1226,7 +1230,7 @@ static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline void
@@ -1235,7 +1239,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(p->pi_lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1243,7 +1247,7 @@ static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), rf->flags);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1251,7 +1255,7 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1259,7 +1263,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1267,7 +1271,7 @@ static inline void
 rq_relock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_repin_lock(rq, rf);
 }
 
@@ -1276,7 +1280,7 @@ rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), rf->flags);
 }
 
 static inline void
@@ -1284,7 +1288,7 @@ rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 static inline void
@@ -1292,7 +1296,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline struct rq *
@@ -1357,7 +1361,7 @@ queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
 		       void (*func)(struct rq *rq))
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (unlikely(head->next))
 		return;
@@ -2047,7 +2051,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	double_rq_lock(this_rq, busiest);
 
 	return 1;
@@ -2066,20 +2070,22 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	int ret = 0;
-
-	if (unlikely(!raw_spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			raw_spin_unlock(&this_rq->lock);
-			raw_spin_lock(&busiest->lock);
-			raw_spin_lock_nested(&this_rq->lock,
-					      SINGLE_DEPTH_NESTING);
-			ret = 1;
-		} else
-			raw_spin_lock_nested(&busiest->lock,
-					      SINGLE_DEPTH_NESTING);
+	if (rq_lockp(this_rq) == rq_lockp(busiest))
+		return 0;
+
+	if (likely(raw_spin_trylock(rq_lockp(busiest))))
+		return 0;
+
+	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+		raw_spin_lock_nested(rq_lockp(busiest), SINGLE_DEPTH_NESTING);
+		return 0;
 	}
-	return ret;
+
+	raw_spin_unlock(rq_lockp(this_rq));
+	raw_spin_lock(rq_lockp(busiest));
+	raw_spin_lock_nested(rq_lockp(this_rq), SINGLE_DEPTH_NESTING);
+
+	return 1;
 }
 
 #endif /* CONFIG_PREEMPTION */
@@ -2089,11 +2095,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
  */
 static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 {
-	if (unlikely(!irqs_disabled())) {
-		/* printk() doesn't work well under rq->lock */
-		raw_spin_unlock(&this_rq->lock);
-		BUG_ON(1);
-	}
+	lockdep_assert_irqs_disabled();
 
 	return _double_lock_balance(this_rq, busiest);
 }
@@ -2101,8 +2103,9 @@ static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	raw_spin_unlock(&busiest->lock);
-	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
+	if (rq_lockp(this_rq) != rq_lockp(busiest))
+		raw_spin_unlock(rq_lockp(busiest));
+	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2143,16 +2146,16 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	__acquires(rq2->lock)
 {
 	BUG_ON(!irqs_disabled());
-	if (rq1 == rq2) {
-		raw_spin_lock(&rq1->lock);
+	if (rq_lockp(rq1) == rq_lockp(rq2)) {
+		raw_spin_lock(rq_lockp(rq1));
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
-			raw_spin_lock(&rq1->lock);
-			raw_spin_lock_nested(&rq2->lock, SINGLE_DEPTH_NESTING);
+		if (rq_lockp(rq1) < rq_lockp(rq2)) {
+			raw_spin_lock(rq_lockp(rq1));
+			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
 		} else {
-			raw_spin_lock(&rq2->lock);
-			raw_spin_lock_nested(&rq1->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock(rq_lockp(rq2));
+			raw_spin_lock_nested(rq_lockp(rq1), SINGLE_DEPTH_NESTING);
 		}
 	}
 }
@@ -2167,9 +2170,9 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_unlock(&rq1->lock);
-	if (rq1 != rq2)
-		raw_spin_unlock(&rq2->lock);
+	raw_spin_unlock(rq_lockp(rq1));
+	if (rq_lockp(rq1) != rq_lockp(rq2))
+		raw_spin_unlock(rq_lockp(rq2));
 	else
 		__release(rq2->lock);
 }
@@ -2192,7 +2195,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 {
 	BUG_ON(!irqs_disabled());
 	BUG_ON(rq1 != rq2);
-	raw_spin_lock(&rq1->lock);
+	raw_spin_lock(rq_lockp(rq1));
 	__acquire(rq2->lock);	/* Fake it out ;) */
 }
 
@@ -2207,7 +2210,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq2->lock)
 {
 	BUG_ON(rq1 != rq2);
-	raw_spin_unlock(&rq1->lock);
+	raw_spin_unlock(rq_lockp(rq1));
 	__release(rq2->lock);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..502db3357504 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -450,7 +450,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	struct root_domain *old_rd = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -476,7 +476,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
-- 
2.17.1

