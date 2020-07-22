Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E810C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E738520771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgGVMNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:13:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:47085 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:13:11 -0400
IronPort-SDR: pXzA08Tv6LlP3Syg2vqSYObBifweG/SN1Bqzb/8nnu50naU9VQ/UoUi3hkV6Xe1qmtA6prfU7j
 yiaTYx+hbl3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="214951282"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="214951282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 05:13:10 -0700
IronPort-SDR: O3ESnKIALFRX8eTUBTbm5ernXW7utlPOdg9bKoHnjOC+DwcgXrvRw6Zj39H6RPscPgL/4tCqz9
 bORfBVRJuGrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="328194123"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2020 05:13:03 -0700
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
Date:   Wed, 22 Jul 2020 20:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/22 16:54, benbjiang(蒋彪) wrote:
> Hi, Aubrey,
> 
>> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.com> wrote:
>>
>> From: Aubrey Li <aubrey.li@intel.com>
>>
>> - Don't migrate if there is a cookie mismatch
>>     Load balance tries to move task from busiest CPU to the
>>     destination CPU. When core scheduling is enabled, if the
>>     task's cookie does not match with the destination CPU's
>>     core cookie, this task will be skipped by this CPU. This
>>     mitigates the forced idle time on the destination CPU.
>>
>> - Select cookie matched idle CPU
>>     In the fast path of task wakeup, select the first cookie matched
>>     idle CPU instead of the first idle CPU.
>>
>> - Find cookie matched idlest CPU
>>     In the slow path of task wakeup, find the idlest CPU whose core
>>     cookie matches with task's cookie
>>
>> - Don't migrate task if cookie not match
>>     For the NUMA load balance, don't migrate task to the CPU whose
>>     core cookie does not match with task's cookie
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
>> ---
>> kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
>> kernel/sched/sched.h | 29 ++++++++++++++++++++
>> 2 files changed, 88 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d16939766361..33dc4bf01817 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2051,6 +2051,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>> 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>> 			continue;
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +		/*
>> +		 * Skip this cpu if source task's cookie does not match
>> +		 * with CPU's core cookie.
>> +		 */
>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>> +			continue;
>> +#endif
>> +
>> 		env->dst_cpu = cpu;
>> 		if (task_numa_compare(env, taskimp, groupimp, maymove))
>> 			break;
>> @@ -5963,11 +5972,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>
>> 	/* Traverse only the allowed CPUs */
>> 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>> +		struct rq *rq = cpu_rq(i);
>> +
>> +#ifdef CONFIG_SCHED_CORE
>> +		if (!sched_core_cookie_match(rq, p))
>> +			continue;
>> +#endif
>> +
>> 		if (sched_idle_cpu(i))
>> 			return i;
>>
>> 		if (available_idle_cpu(i)) {
>> -			struct rq *rq = cpu_rq(i);
>> 			struct cpuidle_state *idle = idle_get_state(rq);
>> 			if (idle && idle->exit_latency < min_exit_latency) {
>> 				/*
>> @@ -6224,8 +6239,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>> 	for_each_cpu_wrap(cpu, cpus, target) {
>> 		if (!--nr)
>> 			return -1;
>> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>> -			break;
>> +
>> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
>> +#ifdef CONFIG_SCHED_CORE
>> +			/*
>> +			 * If Core Scheduling is enabled, select this cpu
>> +			 * only if the process cookie matches core cookie.
>> +			 */
>> +			if (sched_core_enabled(cpu_rq(cpu)) &&
>> +			    p->core_cookie == cpu_rq(cpu)->core->core_cookie)
> Why not also add similar logic in select_idle_smt to reduce forced-idle? :)
We hit select_idle_smt after we scaned the entire LLC domain for idle cores
and idle cpus and failed,so IMHO, an idle smt is probably a good choice under
this scenario.

> 
>> +#endif
>> +				break;
>> +		}
>> 	}
>>
>> 	time = cpu_clock(this) - time;
>> @@ -7609,8 +7634,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>> 	 * We do not migrate tasks that are:
>> 	 * 1) throttled_lb_pair, or
>> 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>> -	 * 3) running (obviously), or
>> -	 * 4) are cache-hot on their current CPU.
>> +	 * 3) task's cookie does not match with this CPU's core cookie
>> +	 * 4) running (obviously), or
>> +	 * 5) are cache-hot on their current CPU.
>> 	 */
>> 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>> 		return 0;
>> @@ -7645,6 +7671,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>> 		return 0;
>> 	}
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +	/*
>> +	 * Don't migrate task if the task's cookie does not match
>> +	 * with the destination CPU's core cookie.
>> +	 */
>> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>> +		return 0;
>> +#endif
>> +
>> 	/* Record that we found atleast one task that could run on dst_cpu */
>> 	env->flags &= ~LBF_ALL_PINNED;
>>
>> @@ -8857,6 +8892,25 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>> 					p->cpus_ptr))
>> 			continue;
>>
>> +#ifdef CONFIG_SCHED_CORE
>> +		if (sched_core_enabled(cpu_rq(this_cpu))) {
>> +			int i = 0;
>> +			bool cookie_match = false;
>> +
>> +			for_each_cpu(i, sched_group_span(group)) {
> Should we consider the p->cpus_ptr here? like,
> 			for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr ) {

This is already considered just above #ifdef CONFIG_SCHED_CORE, but not included
in the patch file.

Thanks,
-Aubrey

> 				...
> 			}
> Thx.
> Regards,
> Jiang
> 
>> +				struct rq *rq = cpu_rq(i);
>> +
>> +				if (sched_core_cookie_match(rq, p)) {
>> +					cookie_match = true;
>> +					break;
>> +				}
>> +			}
>> +			/* Skip over this group if no cookie matched */
>> +			if (!cookie_match)
>> +				continue;
>> +		}
>> +#endif
>> +
>> 		local_group = cpumask_test_cpu(this_cpu,
>> 					       sched_group_span(group));
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 464559676fd2..875796d43fca 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1089,6 +1089,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
>> bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
>> void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
>>
>> +/*
>> + * Helper to check if the CPU's core cookie matches with the task's cookie
>> + * when core scheduling is enabled.
>> + * A special case is that the task's cookie always matches with CPU's core
>> + * cookie if the CPU is in an idle core.
>> + */
>> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>> +{
>> +	bool idle_core = true;
>> +	int cpu;
>> +
>> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
>> +	if (!sched_core_enabled(rq))
>> +		return true;
>> +
>> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
>> +		if (!available_idle_cpu(cpu)) {
>> +			idle_core = false;
>> +			break;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * A CPU in an idle core is always the best choice for tasks with
>> +	 * cookies.
>> +	 */
>> +	return idle_core || rq->core->core_cookie == p->core_cookie;
>> +}
>> +
>> extern void queue_core_balance(struct rq *rq);
>>
>> #else /* !CONFIG_SCHED_CORE */
>> -- 
>> 2.17.1
>>
>>
> 

