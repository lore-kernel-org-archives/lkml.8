Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B951206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgFHBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:41:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:27214 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgFHBlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:41:19 -0400
IronPort-SDR: 2pE3qk9eFHr0J/0gYZQjFLRYOVguZn0gJXOw3GepdGVPD6dz3tjQHfdZkVbqCk366WKvs2wmjo
 OvwXhHIesabQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 18:41:17 -0700
IronPort-SDR: TZG95OK6FwB+LKHeMujdT2WoyURi0oqBAUdj5EMDfbigk+hwFXSLPpu0gJLXVtQ4nOxR/sr+s1
 3iOQjgCmjutA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; 
   d="scan'208";a="259283887"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2020 18:41:17 -0700
Received: from [10.238.0.150] (hongyuni-mobl1.ccr.corp.intel.com [10.238.0.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3794C5805B5;
        Sun,  7 Jun 2020 18:41:12 -0700 (PDT)
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
To:     Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lwe@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <0da15134-6ef6-d88f-f020-15ad8e0a22e6@linux.intel.com>
Date:   Mon, 8 Jun 2020 09:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200514130248.GD2940@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/14 21:02, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 08:34:57PM +0800, Aaron Lu wrote:
>> With this said, I realized a workaround for the issue described above:
>> when the core went from 'compatible mode'(step 1-3) to 'incompatible
>> mode'(step 4), reset all root level sched entities' vruntime to be the
>> same as the core wide min_vruntime. After all, the core is transforming
>> from two runqueue mode to single runqueue mode... I think this can solve
>> the issue to some extent but I may miss other scenarios.
> 
> A little something like so, this syncs min_vruntime when we switch to
> single queue mode. This is very much SMT2 only, I got my head in twist
> when thikning about more siblings, I'll have to try again later.
> 
> This very much retains the horrible approximation of S we always do.
> 
> Also, it is _completely_ untested...
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -102,7 +102,6 @@ static inline int __task_prio(struct tas
>  /* real prio, less is less */
>  static inline bool prio_less(struct task_struct *a, struct task_struct *b)
>  {
> -
>  	int pa = __task_prio(a), pb = __task_prio(b);
>  
>  	if (-pa < -pb)
> @@ -114,19 +113,8 @@ static inline bool prio_less(struct task
>  	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
>  		return !dl_time_before(a->dl.deadline, b->dl.deadline);
>  
> -	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
> -		u64 vruntime = b->se.vruntime;
> -
> -		/*
> -		 * Normalize the vruntime if tasks are in different cpus.
> -		 */
> -		if (task_cpu(a) != task_cpu(b)) {
> -			vruntime -= task_cfs_rq(b)->min_vruntime;
> -			vruntime += task_cfs_rq(a)->min_vruntime;
> -		}
> -
> -		return !((s64)(a->se.vruntime - vruntime) <= 0);
> -	}
> +	if (pa == MAX_RT_PRIO + MAX_NICE)
> +		return cfs_prio_less(a, b);
>  
>  	return false;
>  }
> @@ -4293,10 +4281,11 @@ static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	struct task_struct *next, *max = NULL;
> +	int old_active = 0, new_active = 0;
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
> -	int i, j, cpu;
>  	bool need_sync = false;
> +	int i, j, cpu;
>  
>  	cpu = cpu_of(rq);
>  	if (cpu_is_offline(cpu))
> @@ -4349,10 +4338,14 @@ pick_next_task(struct rq *rq, struct tas
>  		rq_i->core_pick = NULL;
>  
>  		if (rq_i->core_forceidle) {
> +			// XXX is_idle_task(rq_i->curr) && rq_i->nr_running ??
>  			need_sync = true;
>  			rq_i->core_forceidle = false;
>  		}
>  
> +		if (!is_idle_task(rq_i->curr))
> +			old_active++;
> +
>  		if (i != cpu)
>  			update_rq_clock(rq_i);
>  	}
> @@ -4463,8 +4456,12 @@ next_class:;
>  
>  		WARN_ON_ONCE(!rq_i->core_pick);
>  
> -		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> -			rq_i->core_forceidle = true;
> +		if (is_idle_task(rq_i->core_pick)) {
> +			if (rq_i->nr_running)
> +				rq_i->core_forceidle = true;
> +		} else {
> +			new_active++;
> +		}
>  
>  		if (i == cpu)
>  			continue;
> @@ -4476,6 +4473,16 @@ next_class:;
>  		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
>  	}
>  
> +	/* XXX SMT2 only */
> +	if (new_active == 1 && old_active > 1) {
> +		/*
> +		 * We just dropped into single-rq mode, increment the sequence
> +		 * count to trigger the vruntime sync.
> +		 */
> +		rq->core->core_sync_seq++;
> +	}
> +	rq->core->core_active = new_active;
> +
>  done:
>  	set_next_task(rq, next);
>  	return next;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -386,6 +386,12 @@ is_same_group(struct sched_entity *se, s
>  	return NULL;
>  }
>  
> +static inline bool
> +is_same_tg(struct sched_entity *se, struct sched_entity *pse)
> +{
> +	return se->cfs_rq->tg == pse->cfs_rq->tg;
> +}
> +
>  static inline struct sched_entity *parent_entity(struct sched_entity *se)
>  {
>  	return se->parent;
> @@ -394,8 +400,6 @@ static inline struct sched_entity *paren
>  static void
>  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  {
> -	int se_depth, pse_depth;
> -
>  	/*
>  	 * preemption test can be made between sibling entities who are in the
>  	 * same cfs_rq i.e who have a common parent. Walk up the hierarchy of
> @@ -403,23 +407,16 @@ find_matching_se(struct sched_entity **s
>  	 * parent.
>  	 */
>  
> -	/* First walk up until both entities are at same depth */
> -	se_depth = (*se)->depth;
> -	pse_depth = (*pse)->depth;
> -
> -	while (se_depth > pse_depth) {
> -		se_depth--;
> -		*se = parent_entity(*se);
> -	}
> -
> -	while (pse_depth > se_depth) {
> -		pse_depth--;
> -		*pse = parent_entity(*pse);
> -	}
> +	/* XXX we now have 3 of these loops, C stinks */
>  
>  	while (!is_same_group(*se, *pse)) {
> -		*se = parent_entity(*se);
> -		*pse = parent_entity(*pse);
> +		int se_depth = (*se)->depth;
> +		int pse_depth = (*pse)->depth;
> +
> +		if (se_depth <= pse_depth)
> +			*pse = parent_entity(*pse);
> +		if (se_depth >= pse_depth)
> +			*se = parent_entity(*se);
>  	}
>  }
>  
> @@ -455,6 +452,12 @@ static inline struct sched_entity *paren
>  	return NULL;
>  }
>  
> +static inline bool
> +is_same_tg(struct sched_entity *se, struct sched_entity *pse)
> +{
> +	return true;
> +}
> +
>  static inline void
>  find_matching_se(struct sched_entity **se, struct sched_entity **pse)
>  {
> @@ -462,6 +465,31 @@ find_matching_se(struct sched_entity **s
>  
>  #endif	/* CONFIG_FAIR_GROUP_SCHED */
>  
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	struct sched_entity *se_a = &a->se, *se_b = &b->se;
> +	struct cfs_rq *cfs_rq_a, *cfa_rq_b;
> +	u64 vruntime_a, vruntime_b;
> +
> +	while (!is_same_tg(se_a, se_b)) {
> +		int se_a_depth = se_a->depth;
> +		int se_b_depth = se_b->depth;
> +
> +		if (se_a_depth <= se_b_depth)
> +			se_b = parent_entity(se_b);
> +		if (se_a_depth >= se_b_depth)
> +			se_a = parent_entity(se_a);
> +	}
> +
> +	cfs_rq_a = cfs_rq_of(se_a);
> +	cfs_rq_b = cfs_rq_of(se_b);
> +
> +	vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
> +	vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
> +
> +	return !((s64)(vruntime_a - vruntime_b) <= 0);
> +}
> +
>  static __always_inline
>  void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
>  
> @@ -6891,6 +6919,18 @@ static void check_preempt_wakeup(struct
>  		set_last_buddy(se);
>  }
>  
> +static void core_sync_entity(struct rq *rq, struct cfs_rq *cfs_rq)
> +{
> +	if (!sched_core_enabled())
> +		return;
> +
> +	if (rq->core->core_sync_seq == cfs_rq->core_sync_seq)
> +		return;
> +
> +	cfs_rq->core_sync_seq = rq->core->core_sync_seq;
> +	cfs_rq->core_vruntime = cfs_rq->min_vruntime;
> +}
> +
>  static struct task_struct *pick_task_fair(struct rq *rq)
>  {
>  	struct cfs_rq *cfs_rq = &rq->cfs;
> @@ -6902,6 +6942,14 @@ static struct task_struct *pick_task_fai
>  	do {
>  		struct sched_entity *curr = cfs_rq->curr;
>  
> +		/*
> +		 * Propagate the sync state down to whatever cfs_rq we need,
> +		 * the active cfs_rq's will have been done by
> +		 * set_next_task_fair(), the rest is inactive and will not have
> +		 * changed due to the current running task.
> +		 */
> +		core_sync_entity(rq, cfs_rq);
> +
>  		se = pick_next_entity(cfs_rq, NULL);
>  
>  		if (curr) {
> @@ -10825,7 +10873,8 @@ static void switched_to_fair(struct rq *
>  	}
>  }
>  
> -/* Account for a task changing its policy or group.
> +/*
> + * Account for a task changing its policy or group.
>   *
>   * This routine is mostly called to set cfs_rq->curr field when a task
>   * migrates between groups/classes.
> @@ -10847,6 +10896,9 @@ static void set_next_task_fair(struct rq
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> +		/* snapshot vruntime before using it */
> +		core_sync_entity(rq, cfs_rq);
> +
>  		set_next_entity(cfs_rq, se);
>  		/* ensure bandwidth has been allocated on our new cfs_rq */
>  		account_cfs_rq_runtime(cfs_rq, 0);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -503,6 +503,10 @@ struct cfs_rq {
>  	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
>  	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
>  
> +#ifdef CONFIG_SCHED_CORE
> +	unsigned int		core_sync_seq;
> +	u64			core_vruntime;
> +#endif
>  	u64			exec_clock;
>  	u64			min_vruntime;
>  #ifndef CONFIG_64BIT
> @@ -1035,12 +1039,15 @@ struct rq {
>  	unsigned int		core_enabled;
>  	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;
> -	bool			core_forceidle;
> +	unsigned int		core_forceidle;
>  
>  	/* shared state */
>  	unsigned int		core_task_seq;
>  	unsigned int		core_pick_seq;
>  	unsigned long		core_cookie;
> +	unsigned int		core_sync_seq;
> +	unsigned int		core_active;
> +
>  #endif
>  };
>  
> @@ -2592,6 +2599,8 @@ static inline bool sched_energy_enabled(
>  
>  #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
>  
> +extern bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
> +
>  #ifdef CONFIG_MEMBARRIER
>  /*
>   * The scheduler provides memory barriers required by membarrier between:
> 

here is a quick test update based on Peter's fairness patch above:

- Kernel under test: 
A: Core scheduling v5 community base + Peter's fairness patch (by reverting Aaron's fairness patch)
https://github.com/digitalocean/linux-coresched/tree/coresched/v5-v5.5.y + Peter's patch above
B: Core scheduling v5 community base (with Aaron's fairness patchset)
https://github.com/digitalocean/linux-coresched/tree/coresched/v5-v5.5.y (with Aaron's fairness patch）

- Test results briefing:
OVERALL PERFORMANCE ARE THE SAME FOR FOLLOWING 3 TEST SETS, BETWEEN 2 KERNEL TEST BUILDS

- Test set based on sysbench 1.1.0-bd4b418:
1: sysbench cpu in cgroup cpu 0 + sysbench cpu in cgroup cpu 1 (192 workload tasks for each cgroup)
2: sysbench mysql in cgroup mysql 0 + sysbench mysql in cgroup mysql 1 (192 workload tasks for each cgroup)
3: sysbench cpu in cgroup cpu 0 + sysbench mysql in cgroup mysql 0 (192 workload tasks for each cgroup)

- Test environment:
Intel Xeon Server platform
CPU(s):              192
On-line CPU(s) list: 0-191
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        4

- Test results:

Note: 
1: test results in following tables are Tput normalized to default baseline
2: test setting in following tables:
2.1: default -> core scheduling disabled
2.2: coresched -> core scheduling enabled
3. default test results are reused between 2 kernel test builds


Test set 1:
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| setting                          | ***   | default   | default     | coresched   | coresched     | **   | default     | default     | coresched     | coresched     |
+==================================+=======+===========+=============+=============+===============+======+=============+=============+===============+===============+
| cgroups                          | ***   | cg cpu 0  | cg cpu 0    | cg cpu 0    | cg cpu 0      | **   | cg cpu 1    | cg cpu 1    | cg cpu 1      | cg cpu 1      |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| sysbench workload                | ***   | cpu       | cpu         | cpu         | cpu           | **   | cpu         | cpu         | cpu           | cpu           |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| record item                      | ***   | Tput_avg  | Tput_stdev% | Tput_avg    | Tput_stdev%   | **   | Tput_avg    | Tput_stdev% | Tput_avg      | Tput_stdev%   |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| Kernel_A(Peter's fairness patch) | ***   |           |             | 0.96        | 3.45%         | **   |             |             | 1.03          | 3.60%         |
+----------------------------------+-------+ 1         + 1.14%       +-------------+---------------+------+ 1           + 1.20%       +---------------+---------------+
| Kernel_B(Aaron's fairness patch) | ***   |           |             | 0.98        | 1.75%         | **   |             |             | 1.01          | 1.83%         |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+

Test set 2:
+----------------------------------+-------+------------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| setting                          | ***   | default    | default     | coresched   | coresched     | **   | default     | default     | coresched     | coresched     |
+==================================+=======+============+=============+=============+===============+======+=============+=============+===============+===============+
| cgroups                          | ***   | cg mysql 0 | cg mysql 0  | cg mysql 0  | cg mysql 0    | **   | cg mysql 1  | cg mysql 1  | cg mysql 1    | cg mysql 1    |
+----------------------------------+-------+------------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| sysbench workload                | ***   | mysql      | mysql       | mysql       | mysql         | **   | mysql       | mysql       | mysql         | mysql         |
+----------------------------------+-------+------------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| record item                      | ***   | Tput_avg   | Tput_stdev% | Tput_avg    | Tput_stdev%   | **   | Tput_avg    | Tput_stdev% | Tput_avg      | Tput_stdev%   |
+----------------------------------+-------+------------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| Kernel_A(Peter's fairness patch) | ***   |            |             | 0.98        | 2.00%         | **   |             |             | 0.98          | 1.98%         |
+----------------------------------+-------+ 1          + 1.85%       +-------------+---------------+------+ 1           + 1.84%       +---------------+---------------+
| Kernel_B(Aaron's fairness patch) | ***   |            |             | 1.01        | 1.61%         | **   |             |             | 1.01          | 1.59%         |
+----------------------------------+-------+------------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+

Test set 3:
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| setting                          | ***   | default   | default     | coresched   | coresched     | **   | default     | default     | coresched     | coresched     |
+==================================+=======+===========+=============+=============+===============+======+=============+=============+===============+===============+
| cgroups                          | ***   | cg cpu    | cg cpu      | cg cpu      | cg cpu        | **   | cg mysql    | cg mysql    | cg mysql      | cg mysql      |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| sysbench workload                | ***   | cpu       | cpu         | cpu         | cpu           | **   | mysql       | mysql       | mysql         | mysql         |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| record item                      | ***   | Tput_avg  | Tput_stdev% | Tput_avg    | Tput_stdev%   | **   | Tput_avg    | Tput_stdev% | Tput_avg      | Tput_stdev%   |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
| Kernel_A(Peter's fairness patch) | ***   |           |             | 1.01        | 4.67%         | **   |             |             | 0.84          | 25.89%        |
+----------------------------------+-------+ 1         + 1.56%       +-------------+---------------+------+ 1           + 3.17%       +---------------+---------------+
| Kernel_B(Aaron's fairness patch) | ***   |           |             | 0.99        | 4.17%         | **   |             |             | 0.89          | 16.44%        |
+----------------------------------+-------+-----------+-------------+-------------+---------------+------+-------------+-------------+---------------+---------------+
