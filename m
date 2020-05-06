Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDCEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A4A20575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJr3sr6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEFMje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:39:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgEFMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:39:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Cboq7117730;
        Wed, 6 May 2020 12:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jkiqCFb8ZO557s3RPly9WeIuqgOYis3wsQUlecisOxk=;
 b=FJr3sr6b3hNO+Pa2lyjlrr/VbwfqGv10LSEe5L9w9WDxzMQHPtvXfoDXqOVfpfpSgEl1
 BXnoUCH7bUuDHx+y/qufvzMmq5g5rnLMKkreBsY934w27EzGlW3e1UMU8u2d2+/2w2YC
 aruhtnhMH4mcOiBNekHES5+sMGb1J4APngw2OXHCQaAoHERkkJY/pyWzyrs3T452nF3/
 erOmTGowY/LSB4cZu/sb90guBPsLpKggqFukDyIavwrJm9Q0wP8sFNv5E/2ixZJdE3du
 EGYsyMb6JDnXMelEnFMuq8fapZhJfMabp34Ku013lxFVMIgne+sunW0By2ApPV2U/a2Z 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09ra3sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:38:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CblAj139420;
        Wed, 6 May 2020 12:38:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r7r55t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:38:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046CcVLB001358;
        Wed, 6 May 2020 12:38:31 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 05:38:31 -0700
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
Date:   Wed, 6 May 2020 14:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.361859938@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=4
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=4
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> The scheduler IPI has grown weird and wonderful over the years, time
> for spring cleaning.
> 
> Move all the non-trivial stuff out of it and into a regular smp function
> call IPI. This then reduces the schedule_ipi() to most of it's former MOP
> glory and ensures to keep the interrupt vector lean and mean.
> 
> Aside of that avoiding the full irq_enter() in the x86 IPI implementation
> is incorrect as scheduler_ipi() can be instrumented. To work around that
> scheduler_ipi() had an irq_enter/exit() hack when heavy work was
> pending. This is gone now.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/sched/core.c  |   64 +++++++++++++++++++++++----------------------------
>   kernel/sched/fair.c  |    5 +--
>   kernel/sched/sched.h |    6 +++-
>   3 files changed, 36 insertions(+), 39 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -219,6 +219,13 @@ void update_rq_clock(struct rq *rq)
>   	update_rq_clock_task(rq, delta);
>   }
>   
> +static inline void
> +rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
> +{
> +	csd->flags = 0;
> +	csd->func = func;
> +	csd->info = rq;
> +}
>   
>   #ifdef CONFIG_SCHED_HRTICK
>   /*
> @@ -314,16 +321,14 @@ void hrtick_start(struct rq *rq, u64 del
>   	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
>   		      HRTIMER_MODE_REL_PINNED_HARD);
>   }
> +
>   #endif /* CONFIG_SMP */
>   
>   static void hrtick_rq_init(struct rq *rq)
>   {
>   #ifdef CONFIG_SMP
> -	rq->hrtick_csd.flags = 0;
> -	rq->hrtick_csd.func = __hrtick_start;
> -	rq->hrtick_csd.info = rq;
> +	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
>   #endif
> -
>   	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>   	rq->hrtick_timer.function = hrtick;
>   }
> @@ -650,6 +655,16 @@ static inline bool got_nohz_idle_kick(vo
>   	return false;
>   }
>   
> +static void nohz_csd_func(void *info)
> +{
> +	struct rq *rq = info;
> +
> +	if (got_nohz_idle_kick()) {
> +		rq->idle_balance = 1;
> +		raise_softirq_irqoff(SCHED_SOFTIRQ);
> +	}
> +}
> +
>   #else /* CONFIG_NO_HZ_COMMON */
>   
>   static inline bool got_nohz_idle_kick(void)
> @@ -2292,6 +2307,11 @@ void sched_ttwu_pending(void)
>   	rq_unlock_irqrestore(rq, &rf);
>   }
>   
> +static void wake_csd_func(void *info)
> +{
> +	sched_ttwu_pending();
> +}
> +
>   void scheduler_ipi(void)
>   {
>   	/*
> @@ -2300,34 +2320,6 @@ void scheduler_ipi(void)
>   	 * this IPI.
>   	 */
>   	preempt_fold_need_resched();
> -
> -	if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
> -		return;
> -
> -	/*
> -	 * Not all reschedule IPI handlers call irq_enter/irq_exit, since
> -	 * traditionally all their work was done from the interrupt return
> -	 * path. Now that we actually do some work, we need to make sure
> -	 * we do call them.
> -	 *
> -	 * Some archs already do call them, luckily irq_enter/exit nest
> -	 * properly.
> -	 *
> -	 * Arguably we should visit all archs and update all handlers,
> -	 * however a fair share of IPIs are still resched only so this would
> -	 * somewhat pessimize the simple resched case.
> -	 */
> -	irq_enter();
> -	sched_ttwu_pending();
> -
> -	/*
> -	 * Check if someone kicked us for doing the nohz idle load balance.
> -	 */
> -	if (unlikely(got_nohz_idle_kick())) {
> -		this_rq()->idle_balance = 1;
> -		raise_softirq_irqoff(SCHED_SOFTIRQ);
> -	}
> -	irq_exit();
>   }
>   
>   static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> @@ -2336,9 +2328,9 @@ static void ttwu_queue_remote(struct tas
>   
>   	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
>   
> -	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
> +	if (llist_add(&p->wake_entry, &rq->wake_list)) {
>   		if (!set_nr_if_polling(rq->idle))
> -			smp_send_reschedule(cpu);
> +			smp_call_function_single_async(cpu, &rq->wake_csd);
>   		else
>   			trace_sched_wake_idle_without_ipi(cpu);
>   	}
> @@ -6685,12 +6677,16 @@ void __init sched_init(void)
>   		rq->avg_idle = 2*sysctl_sched_migration_cost;
>   		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>   
> +		rq_csd_init(rq, &rq->wake_csd, wake_csd_func);
> +
>   		INIT_LIST_HEAD(&rq->cfs_tasks);
>   
>   		rq_attach_root(rq, &def_root_domain);
>   #ifdef CONFIG_NO_HZ_COMMON
>   		rq->last_blocked_load_update_tick = jiffies;
>   		atomic_set(&rq->nohz_flags, 0);
> +
> +		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
>   #endif
>   #endif /* CONFIG_SMP */
>   		hrtick_rq_init(rq);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10009,12 +10009,11 @@ static void kick_ilb(unsigned int flags)
>   		return;
>   
>   	/*
> -	 * Use smp_send_reschedule() instead of resched_cpu().
> -	 * This way we generate a sched IPI on the target CPU which
> +	 * This way we generate an IPI on the target CPU which
>   	 * is idle. And the softirq performing nohz idle load balance
>   	 * will be run before returning from the IPI.
>   	 */
> -	smp_send_reschedule(ilb_cpu);
> +	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->wake_csd);

This should be nohz_csd instead of wake_csd, no? I.e.:

        smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);


With that:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


>   }
>   
>   /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -890,9 +890,10 @@ struct rq {
>   #ifdef CONFIG_SMP
>   	unsigned long		last_blocked_load_update_tick;
>   	unsigned int		has_blocked_load;
> +	call_single_data_t	nohz_csd;
>   #endif /* CONFIG_SMP */
>   	unsigned int		nohz_tick_stopped;
> -	atomic_t nohz_flags;
> +	atomic_t		nohz_flags;
>   #endif /* CONFIG_NO_HZ_COMMON */
>   
>   	unsigned long		nr_load_updates;
> @@ -979,7 +980,7 @@ struct rq {
>   
>   	/* This is used to determine avg_idle's max value */
>   	u64			max_idle_balance_cost;
> -#endif
> +#endif /* CONFIG_SMP */
>   
>   #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>   	u64			prev_irq_time;
> @@ -1021,6 +1022,7 @@ struct rq {
>   #endif
>   
>   #ifdef CONFIG_SMP
> +	call_single_data_t	wake_csd;
>   	struct llist_head	wake_list;
>   #endif
>   
> 
