Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B43EC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AB82086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGWIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:07:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:55631 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWIHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:07:08 -0400
IronPort-SDR: DsT83JoejBlpQiK+8MjN9SgJtKGZcvvSgBVeX1My05aOmu4lJfLuurlivxuq7T2XiFGN93UdtR
 VoqzpW+XjisA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="150466802"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="150466802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 01:07:05 -0700
IronPort-SDR: elm3Do/A4mv86haPOesTo5Hz4ftlnGBJlp7EsTqvsM3DRStSYeVrP88BFMJtC2Y97K8bu0+YFk
 YcMYSCaZ4MNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="362973187"
Received: from unknown (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2020 01:06:59 -0700
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
 <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
 <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com>
 <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
 <897E5117-8A78-4CE3-8514-3577C4474775@tencent.com>
 <6ab8a001-ae5e-e484-c571-90d6931004e7@linux.intel.com>
 <96A765D7-7FD3-40EB-873B-0F9365569490@tencent.com>
 <a4533d7f-41b0-3477-0316-0e2df55cbe9c@linux.intel.com>
 <325B98A4-9135-4138-AFED-ADFC3560D917@tencent.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <36cce58e-03b3-4d77-dfc5-e3c49f3ecdd8@linux.intel.com>
Date:   Thu, 23 Jul 2020 16:06:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <325B98A4-9135-4138-AFED-ADFC3560D917@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/23 15:47, benbjiang(蒋彪) wrote:
> Hi,
> 
>> On Jul 23, 2020, at 1:39 PM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/7/23 12:23, benbjiang(蒋彪) wrote:
>>> Hi,
>>>> On Jul 23, 2020, at 11:35 AM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>>>
>>>> On 2020/7/23 10:42, benbjiang(蒋彪) wrote:
>>>>> Hi,
>>>>>
>>>>>> On Jul 23, 2020, at 9:57 AM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>>>>>
>>>>>> On 2020/7/22 22:32, benbjiang(蒋彪) wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>>> On Jul 22, 2020, at 8:13 PM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>>>>>>>
>>>>>>>> On 2020/7/22 16:54, benbjiang(蒋彪) wrote:
>>>>>>>>> Hi, Aubrey,
>>>>>>>>>
>>>>>>>>>> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.com> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Aubrey Li <aubrey.li@intel.com>
>>>>>>>>>>
>>>>>>>>>> - Don't migrate if there is a cookie mismatch
>>>>>>>>>> Load balance tries to move task from busiest CPU to the
>>>>>>>>>> destination CPU. When core scheduling is enabled, if the
>>>>>>>>>> task's cookie does not match with the destination CPU's
>>>>>>>>>> core cookie, this task will be skipped by this CPU. This
>>>>>>>>>> mitigates the forced idle time on the destination CPU.
>>>>>>>>>>
>>>>>>>>>> - Select cookie matched idle CPU
>>>>>>>>>> In the fast path of task wakeup, select the first cookie matched
>>>>>>>>>> idle CPU instead of the first idle CPU.
>>>>>>>>>>
>>>>>>>>>> - Find cookie matched idlest CPU
>>>>>>>>>> In the slow path of task wakeup, find the idlest CPU whose core
>>>>>>>>>> cookie matches with task's cookie
>>>>>>>>>>
>>>>>>>>>> - Don't migrate task if cookie not match
>>>>>>>>>> For the NUMA load balance, don't migrate task to the CPU whose
>>>>>>>>>> core cookie does not match with task's cookie
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>>>>>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>>>>>>>> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
>>>>>>>>>> ---
>>>>>>>>>> kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
>>>>>>>>>> kernel/sched/sched.h | 29 ++++++++++++++++++++
>>>>>>>>>> 2 files changed, 88 insertions(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>>>>>> index d16939766361..33dc4bf01817 100644
>>>>>>>>>> --- a/kernel/sched/fair.c
>>>>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>>>>> @@ -2051,6 +2051,15 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>>>>>>>>>> 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>>>>>>>>> 			continue;
>>>>>>>>>>
>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
>>>>>>>>>> +		/*
>>>>>>>>>> +		 * Skip this cpu if source task's cookie does not match
>>>>>>>>>> +		 * with CPU's core cookie.
>>>>>>>>>> +		 */
>>>>>>>>>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>>>>>>>>>> +			continue;
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>> 		env->dst_cpu = cpu;
>>>>>>>>>> 		if (task_numa_compare(env, taskimp, groupimp, maymove))
>>>>>>>>>> 			break;
>>>>>>>>>> @@ -5963,11 +5972,17 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>>>>>>>>>>
>>>>>>>>>> 	/* Traverse only the allowed CPUs */
>>>>>>>>>> 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>>>>>>>>>> +		struct rq *rq = cpu_rq(i);
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
>>>>>>>>>> +		if (!sched_core_cookie_match(rq, p))
>>>>>>>>>> +			continue;
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>> 		if (sched_idle_cpu(i))
>>>>>>>>>> 			return i;
>>>>>>>>>>
>>>>>>>>>> 		if (available_idle_cpu(i)) {
>>>>>>>>>> -			struct rq *rq = cpu_rq(i);
>>>>>>>>>> 			struct cpuidle_state *idle = idle_get_state(rq);
>>>>>>>>>> 			if (idle && idle->exit_latency < min_exit_latency) {
>>>>>>>>>> 				/*
>>>>>>>>>> @@ -6224,8 +6239,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>>>>>>>>> 	for_each_cpu_wrap(cpu, cpus, target) {
>>>>>>>>>> 		if (!--nr)
>>>>>>>>>> 			return -1;
>>>>>>>>>> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>>>>>>>>>> -			break;
>>>>>>>>>> +
>>>>>>>>>> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
>>>>>>>>>> +			/*
>>>>>>>>>> +			 * If Core Scheduling is enabled, select this cpu
>>>>>>>>>> +			 * only if the process cookie matches core cookie.
>>>>>>>>>> +			 */
>>>>>>>>>> +			if (sched_core_enabled(cpu_rq(cpu)) &&
>>>>>>>>>> +			    p->core_cookie == cpu_rq(cpu)->core->core_cookie)
>>>>>>>>> Why not also add similar logic in select_idle_smt to reduce forced-idle? :)
>>>>>>>> We hit select_idle_smt after we scaned the entire LLC domain for idle cores
>>>>>>>> and idle cpus and failed,so IMHO, an idle smt is probably a good choice under
>>>>>>>> this scenario.
>>>>>>>
>>>>>>> AFAIC, selecting idle sibling with unmatched cookie will cause unnecessary fored-idle, unfairness and latency, compared to choosing *target* cpu.
>>>>>> Choosing target cpu could increase the runnable task number on the target runqueue, this
>>>>>> could trigger busiest->nr_running > 1 logic and makes the idle sibling trying to pull but
>>>>>> not success(due to cookie not match). Putting task to the idle sibling is relatively stable IMHO.
>>>>>
>>>>> I’m afraid that *unsuccessful* pullings between smts would not result in unstableness, because
>>>>> the load-balance always do periodicly , and unsuccess means nothing happen.
>>>> unsuccess pulling means more unnecessary overhead in load balance.
>>>>
>>>>> On the contrary, unmatched sibling tasks running concurrently could bring forced-idle to each other repeatedly,
>>>>> Which is more unstable, and more costly when pick_next_task for all siblings.
>>>> Not worse than two tasks ping-pong on the same target run queue I guess, and better if
>>>> - task1(cookie A) is running on the target, and task2(cookie B) in the runqueue,
>>>> - task3(cookie B) coming
>>>>
>>>> If task3 chooses target's sibling, it could have a chance to run concurrently with task2.
>>>> But if task3 chooses target, it will wait for next pulling luck of load balancer
>>> That’s more interesting. :)
>>> Distributing different cookie tasks onto different cpus(or cpusets) could be the *ideal stable status* we want, as I understood.
>>> Different cookie tasks running on sibling smts could hurt performance, and that should be avoided with best effort.
>> We already tried to avoid when we scan idle cores and idle cpus in llc domain.
> 
> I’m afraid that’s not enough either, :)
> 1. Scanning Idle cpus is not a full scan, there is limit according to scan cost.
> 2. That's only trying at the *core/cpu* level, *SMT* level should be considered too. 
> 
>>
>>> For above case, selecting idle sibling cpu can improve the concurrency indeed, but it decrease the imbalance for load-balancer.
>>> In that case, load-balancer could not notice the imbalance, and would do nothing to improve the unmatched situation.
>>> On the contrary, choosing the *target* cpu could enhance the imbalance, and load-balancer could try to pull unmatched task away,
>> Pulling away to where needs another bunch of elaboration.
> 
> Still with the SMT2+3tasks case, 
> if *idle sibling* chosen, 
> Smt1’s load = task1+task2, smt2’s load = task3. Task3 will run intermittently because of forced-idle, 
> so smt2’s real load could low enough, that it could not be pulled away forever. That’s indeed a stable state, 
> but with performance at a discount. 
> 
> If *target sibling* chose,
> Smt1’s load = task1+task2+task3, smt2’s load=0. It’s a obvious imbalance, and load-balancer will pick a task to pull,
> 1. If task1(cookie A) picked, that’s done for good.
> 2. If task2(cookie B) or task3(cookie B) picked, that’s ok too, the rest task(cookie B) could be pulled away at next balance(maybe need to improve the pulling to tend to pull matched task more aggressively).
> And then, we may reach a more stable state *globally* without performance discount.

I'm not sure what you mean pulled away,
- if you mean pulled away from this core, cookieA in idle sibling case can be
  pulled away too.
- and if you mean pulled away but within this core, I guess cookieB in target
  sibling case can't be pulled away either, as nr_running difference = 1

Thanks,
-Aubrey
