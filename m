Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FC9C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9736E20659
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581759866;
	bh=VHuBZ7au9cLDvxG2y3ghbD0va1JB8gLIRE0Cae+Lzcc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Vd8PD2rv3vGu/yy/fApaMkxVdJobdNQj2TSjM29orowg5ths6RX52OXHOLFUNgPo1
	 Ps3H8NjJgcH090GYRxpY5PklKLJwf5EXBdRr+RBx5fnEYOSj3QEQJJLiettOFZkp5x
	 7vkhV/3nhUSdnnVUhanXZfT92G8bm765Z83WMv0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgBOJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 04:44:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38931 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgBOJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 04:44:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so13441573wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qdw/BX1zBFpaDZXDUir6MPP5LPznm7t8/XkMvbdddbQ=;
        b=DNmy5S8WDspYakVxrbuqJvxUszTd7JALjDis6H3DVYWV42wGbzFOA4rkzjNbZYylck
         dLm7jmHAoYrJqlfgsTkE8s009Q8jQ3cUg8Fe6xDbxA80dagAXBo3qJspWwFBeEFssRpI
         IN2HFyaj4SFa3RE8x9zbkWpGG29KrZrvM/UYnWG0IrJDqzvyzLgrkRSNyiSLPO5lmfrh
         wufrhaM6GWWCDNrOUtYTc0l92COXTsMfVyOAedlVhcE/aZcZp1kkngWSBPXKVxeVTZgd
         onct3uAZIF9M/hedgSDYYdDn1lWsO/JkQw9ChiAIFYXTyyjNc39pRPF92K2sIFjEvnnh
         DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=qdw/BX1zBFpaDZXDUir6MPP5LPznm7t8/XkMvbdddbQ=;
        b=HqFTS1bfuQBxGKcGqv8SDoB6saakAQIDvLcTC+/711gJQxne4/FYbET8+4Zbc9gfyK
         nbzYH0h/Rt+cTsRvDWvXvtVMHDb1h0cX3P/60AoEYHERNxhBGBMUueDP1RjKnUNvQQxI
         hH4SsF7NqQr1sigC7a2pyvFy0orl1PRfeDMwNSgulfie5Rk2VxZD955ENB25lmpa5xgv
         OHUeNjwNDYCKfQZTFzI+8yvuAhQUya7dyY9SW5PpRXDRfA06MiaPt+PmYHTDVg0nGsTH
         M/apgdccbB49OkjnVCg3XtQwA619wfFT254owKb9pCclXFab2Sm4exD5U0fNyWKN5PvI
         eTEQ==
X-Gm-Message-State: APjAAAXrzmZV7BW8eB/Pe/6Wyn40hyttnU0/wmWvZWp7zT4wLGhZPYFJ
        UaeOivdGmivyvD6eD8maPs4=
X-Google-Smtp-Source: APXvYqxBYIyo7r0XpEjTIKT6h4VNXI/hy+1p4SLCPAKzb5wSpK4klq9o9fZLOgA1uLiQE1/TtywfmA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr10379945wmd.102.1581759860255;
        Sat, 15 Feb 2020 01:44:20 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 133sm11567232wme.32.2020.02.15.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 01:44:19 -0800 (PST)
Date:   Sat, 15 Feb 2020 10:44:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20200215094417.GA102800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e9f5490c3574b435ce7fe7a71724aa3866babc7f sched/fair: Fix kernel-doc warning in attach_entity_load_avg()

Misc fixes all over the place:

 - Fix NUMA over-balancing between lightly loaded nodes. This is fallout
   of the big load-balancer rewrite.

 - Fix the NOHZ remote loadavg update logic, which fixes anomalies
   like reported 150 loadavg on mostly idle CPUs.

 - Fix XFS performance/scalability

 - Fix throttled groups unbound task-execution bug

 - Fix PSI procfs boundary condition

 - Fix the cpu.uclamp.{min,max} cgroup configuration write checks

 - Fix DocBook annotations

 - Fix RCU annotations

 - Fix overly CPU-intensive housekeeper CPU logic loop on large CPU counts

 Thanks,

	Ingo

------------------>
Madhuparna Bhowmik (1):
      sched/core: Annotate curr pointer in rq with __rcu

Mel Gorman (2):
      sched/fair: Allow a small load imbalance between low utilisation SD_NUMA domains
      sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression

Peter Zijlstra (Intel) (1):
      timers/nohz: Update NOHZ load in remote tick

Qais Yousef (1):
      sched/uclamp: Reject negative values in cpu_uclamp_write()

Randy Dunlap (1):
      sched/fair: Fix kernel-doc warning in attach_entity_load_avg()

Scott Wood (1):
      sched/core: Don't skip remote tick for idle CPUs

Suren Baghdasaryan (1):
      sched/psi: Fix OOB write when writing 0 bytes to PSI files

Vincent Guittot (1):
      sched/fair: Prevent unlimited runtime on throttled group

Wanpeng Li (1):
      sched/nohz: Optimize get_nohz_timer_target()


 include/linux/sched/nohz.h |  2 ++
 kernel/sched/core.c        | 63 +++++++++++++++++++++++++---------------------
 kernel/sched/fair.c        | 56 +++++++++++++++++++++++++++++++----------
 kernel/sched/loadavg.c     | 33 ++++++++++++++++--------
 kernel/sched/psi.c         |  3 +++
 kernel/sched/sched.h       | 15 ++++++++++-
 6 files changed, 119 insertions(+), 53 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 1abe91ff6e4a..6d67e9a5af6b 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -15,9 +15,11 @@ static inline void nohz_balance_enter_idle(int cpu) { }
 
 #ifdef CONFIG_NO_HZ_COMMON
 void calc_load_nohz_start(void);
+void calc_load_nohz_remote(struct rq *rq);
 void calc_load_nohz_stop(void);
 #else
 static inline void calc_load_nohz_start(void) { }
+static inline void calc_load_nohz_remote(struct rq *rq) { }
 static inline void calc_load_nohz_stop(void) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc007604..1a9983da4408 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -552,27 +552,32 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu = smp_processor_id();
+	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
-	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		return cpu;
+	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+		if (!idle_cpu(cpu))
+			return cpu;
+		default_cpu = cpu;
+	}
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+			housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
 		}
 	}
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	if (default_cpu == -1)
+		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
 	return cpu;
@@ -1442,17 +1447,6 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-static inline bool is_per_cpu_kthread(struct task_struct *p)
-{
-	if (!(p->flags & PF_KTHREAD))
-		return false;
-
-	if (p->nr_cpus_allowed != 1)
-		return false;
-
-	return true;
-}
-
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -3669,28 +3663,32 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+	if (!tick_nohz_tick_stopped_cpu(cpu))
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr) || cpu_is_offline(cpu))
+	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
+	curr = rq->curr;
 	update_rq_clock(rq);
-	delta = rq_clock_task(rq) - curr->se.exec_start;
 
-	/*
-	 * Make sure the next tick runs within a reasonable
-	 * amount of time.
-	 */
-	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	if (!is_idle_task(curr)) {
+		/*
+		 * Make sure the next tick runs within a reasonable
+		 * amount of time.
+		 */
+		delta = rq_clock_task(rq) - curr->se.exec_start;
+		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	}
 	curr->sched_class->task_tick(rq, curr, 0);
 
+	calc_load_nohz_remote(rq);
 out_unlock:
 	rq_unlock_irq(rq, &rf);
-
 out_requeue:
+
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
@@ -7063,8 +7061,15 @@ void sched_move_task(struct task_struct *tsk)
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
-	if (running)
+	if (running) {
 		set_next_task(rq, tsk);
+		/*
+		 * After changing group, the running task may have joined a
+		 * throttled one but it's still the running task. Trigger a
+		 * resched to make sure that task can still run.
+		 */
+		resched_curr(rq);
+	}
 
 	task_rq_unlock(rq, tsk, &rf);
 }
@@ -7260,7 +7265,7 @@ capacity_from_percent(char *buf)
 					     &req.percent);
 		if (req.ret)
 			return req;
-		if (req.percent > UCLAMP_PERCENT_SCALE) {
+		if ((u64)req.percent > UCLAMP_PERCENT_SCALE) {
 			req.ret = -ERANGE;
 			return req;
 		}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d775375..3c8a379c357e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3516,7 +3516,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
- * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
@@ -5912,6 +5911,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
+	/*
+	 * Allow a per-cpu kthread to stack with the wakee if the
+	 * kworker thread and the tasks previous CPUs are the same.
+	 * The assumption is that the wakee queued work for the
+	 * per-cpu kthread that is now complete and the wakeup is
+	 * essentially a sync wakeup. An obvious example of this
+	 * pattern is IO completions.
+	 */
+	if (is_per_cpu_kthread(current) &&
+	    prev == smp_processor_id() &&
+	    this_rq()->nr_running <= 1) {
+		return prev;
+	}
+
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
@@ -8658,10 +8671,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	/*
 	 * Try to use spare capacity of local group without overloading it or
 	 * emptying busiest.
-	 * XXX Spreading tasks across NUMA nodes is not always the best policy
-	 * and special care should be taken for SD_NUMA domain level before
-	 * spreading the tasks. For now, load_balance() fully relies on
-	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
@@ -8701,16 +8710,37 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
-			return;
-		}
+		} else {
 
-		/*
-		 * If there is no overload, we just want to even the number of
-		 * idle cpus.
-		 */
-		env->migration_type = migrate_task;
-		env->imbalance = max_t(long, 0, (local->idle_cpus -
+			/*
+			 * If there is no overload, we just want to even the number of
+			 * idle cpus.
+			 */
+			env->migration_type = migrate_task;
+			env->imbalance = max_t(long, 0, (local->idle_cpus -
 						 busiest->idle_cpus) >> 1);
+		}
+
+		/* Consider allowing a small imbalance between NUMA groups */
+		if (env->sd->flags & SD_NUMA) {
+			unsigned int imbalance_min;
+
+			/*
+			 * Compute an allowed imbalance based on a simple
+			 * pair of communicating tasks that should remain
+			 * local and ignore them.
+			 *
+			 * NOTE: Generally this would have been based on
+			 * the domain size and this was evaluated. However,
+			 * the benefit is similar across a range of workloads
+			 * and machines but scaling by the domain size adds
+			 * the risk that lower domains have to be rebalanced.
+			 */
+			imbalance_min = 2;
+			if (busiest->sum_nr_running <= imbalance_min)
+				env->imbalance = 0;
+		}
+
 		return;
 	}
 
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a516575c18..de22da666ac7 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -231,16 +231,11 @@ static inline int calc_load_read_idx(void)
 	return calc_load_idx & 1;
 }
 
-void calc_load_nohz_start(void)
+static void calc_load_nohz_fold(struct rq *rq)
 {
-	struct rq *this_rq = this_rq();
 	long delta;
 
-	/*
-	 * We're going into NO_HZ mode, if there's any pending delta, fold it
-	 * into the pending NO_HZ delta.
-	 */
-	delta = calc_load_fold_active(this_rq, 0);
+	delta = calc_load_fold_active(rq, 0);
 	if (delta) {
 		int idx = calc_load_write_idx();
 
@@ -248,6 +243,24 @@ void calc_load_nohz_start(void)
 	}
 }
 
+void calc_load_nohz_start(void)
+{
+	/*
+	 * We're going into NO_HZ mode, if there's any pending delta, fold it
+	 * into the pending NO_HZ delta.
+	 */
+	calc_load_nohz_fold(this_rq());
+}
+
+/*
+ * Keep track of the load for NOHZ_FULL, must be called between
+ * calc_load_nohz_{start,stop}().
+ */
+void calc_load_nohz_remote(struct rq *rq)
+{
+	calc_load_nohz_fold(rq);
+}
+
 void calc_load_nohz_stop(void)
 {
 	struct rq *this_rq = this_rq();
@@ -268,7 +281,7 @@ void calc_load_nohz_stop(void)
 		this_rq->calc_load_update += LOAD_FREQ;
 }
 
-static long calc_load_nohz_fold(void)
+static long calc_load_nohz_read(void)
 {
 	int idx = calc_load_read_idx();
 	long delta = 0;
@@ -323,7 +336,7 @@ static void calc_global_nohz(void)
 }
 #else /* !CONFIG_NO_HZ_COMMON */
 
-static inline long calc_load_nohz_fold(void) { return 0; }
+static inline long calc_load_nohz_read(void) { return 0; }
 static inline void calc_global_nohz(void) { }
 
 #endif /* CONFIG_NO_HZ_COMMON */
@@ -346,7 +359,7 @@ void calc_global_load(unsigned long ticks)
 	/*
 	 * Fold the 'old' NO_HZ-delta to include all NO_HZ CPUs.
 	 */
-	delta = calc_load_nohz_fold();
+	delta = calc_load_nohz_read();
 	if (delta)
 		atomic_long_add(delta, &calc_load_tasks);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index db7b50bba3f1..38ccd49b9bf6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1199,6 +1199,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
+	if (!nbytes)
+		return -EINVAL;
+
 	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a88dc8ad11b..9ea647835fd6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -896,7 +896,7 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
 
-	struct task_struct	*curr;
+	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -2479,3 +2479,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+#ifdef CONFIG_SMP
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+#endif
