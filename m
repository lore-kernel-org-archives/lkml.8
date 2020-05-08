Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B712EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9856D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEHLPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgEHLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:15:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048B2oqH021335;
        Fri, 8 May 2020 07:15:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsxhc7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:15:26 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048B3riR028767;
        Fri, 8 May 2020 07:15:26 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsxhc6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 07:15:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048B9nEr005142;
        Fri, 8 May 2020 11:15:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5w9uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 11:15:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048BFLWs61145110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 11:15:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2DBE42054;
        Fri,  8 May 2020 11:15:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DB6D42056;
        Fri,  8 May 2020 11:15:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.16.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 11:15:17 +0000 (GMT)
Subject: Re: [RFC 2/4] sched/core: Set nr_lat_sensitive counter at various
 scheduler entry/exit points
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-3-parth@linux.ibm.com>
 <20200508083308.GI19464@codeaurora.org>
From:   Parth Shah <parth@linux.ibm.com>
Message-ID: <73506bba-7bcb-fd40-6866-d5d88d436fbf@linux.ibm.com>
Date:   Fri, 8 May 2020 16:45:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200508083308.GI19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

Thanks for going through this patch-set.

On 5/8/20 2:03 PM, Pavan Kondeti wrote:
> Hi Parth,
> 
> On Thu, May 07, 2020 at 07:07:21PM +0530, Parth Shah wrote:
>> Monitor tasks at:
>> 1. wake_up_new_task() - forked tasks
>>
>> 2. set_task_cpu() - task migrations, Load balancer
>>
>> 3. __sched_setscheduler() - set/unset latency_nice value
>> Increment the nr_lat_sensitive count on the CPU with task marked with
>> latency_nice == -20.
>> Similarly, decrement the nr_lat_sensitive counter upon re-marking the task
>> with >-20 latency_nice task.
>>
>> 4. finish_task_switch() - dying task
>>
> 
> 
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  kernel/sched/core.c  | 30 ++++++++++++++++++++++++++++--
>>  kernel/sched/sched.h |  5 +++++
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2d8b76f41d61..ad396c36eba6 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1744,6 +1744,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>  	trace_sched_migrate_task(p, new_cpu);
>>  
>>  	if (task_cpu(p) != new_cpu) {
>> +		if (task_is_lat_sensitive(p)) {
>> +			per_cpu(nr_lat_sensitive, task_cpu(p))--;
>> +			per_cpu(nr_lat_sensitive, new_cpu)++;
>> +		}
>> +
> 
> Since we can come here without rq locks, there is a possibility
> of a race and incorrect updates can happen. Since the counters
> are used to prevent C-states, we don't want that to happen.

I did tried using task_lock(p) wherever we do change refcount and when
latency_nice value is set. There I was using nr_lat_sensitive with atomic_t
type.

After lots of thinking to optimize it and thinking that we anyways hold rq
lock, I thought of not using any lock here and see if scheduler community
has well known solution for this :-)

But in brief, using atomic_t nr_lat_sensitive and task_lock(p) when changin
refcount should solve problem, right?

If you or anyone have solution for this kind of pattern, then that surely
will be helpful.

> 
>>  		if (p->sched_class->migrate_task_rq)
>>  			p->sched_class->migrate_task_rq(p, new_cpu);
>>  		p->se.nr_migrations++;
>> @@ -2947,6 +2952,7 @@ void wake_up_new_task(struct task_struct *p)
>>  {
>>  	struct rq_flags rf;
>>  	struct rq *rq;
>> +	int target_cpu = 0;
>>  
>>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>>  	p->state = TASK_RUNNING;
>> @@ -2960,9 +2966,17 @@ void wake_up_new_task(struct task_struct *p)
>>  	 * as we're not fully set-up yet.
>>  	 */
>>  	p->recent_used_cpu = task_cpu(p);
>> -	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
>> +	target_cpu = select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0);
>> +	__set_task_cpu(p, target_cpu);
>> +
> 
> The target_cpu variable can be eliminated by using task_cpu(p) directly
> in the below update.

Right. Will change it thus saving one diff line.

> 
>>  #endif
>>  	rq = __task_rq_lock(p, &rf);
>> +
>> +#ifdef CONFIG_SMP
>> +	if (task_is_lat_sensitive(p))
>> +		per_cpu(nr_lat_sensitive, target_cpu)++;
>> +#endif
>> +
> 
> Is the SMP check intentional? In some parts of this patch, updates to
> nr_lat_sensitive are done without SMP checks. For example,
> finish_task_switch() below.

No. just forget to remove. I will remove SMP checks in next revision.

> 
>>  	update_rq_clock(rq);
>>  	post_init_entity_util_avg(p);
>>  
>> @@ -3248,6 +3262,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>>  		if (prev->sched_class->task_dead)
>>  			prev->sched_class->task_dead(prev);
>>  
>> +		if (task_is_lat_sensitive(prev))
>> +			per_cpu(nr_lat_sensitive, prev->cpu)--;
>> +
>>  		/*
>>  		 * Remove function-return probe instances associated with this
>>  		 * task and put them back on the free list.
>> @@ -4732,8 +4749,17 @@ static void __setscheduler_params(struct task_struct *p,
>>  	p->normal_prio = normal_prio(p);
>>  	set_load_weight(p, true);
>>  
>> -	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
>> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
>> +		if (p->state != TASK_DEAD &&
>> +		    attr->sched_latency_nice != p->latency_nice) {
>> +			if (attr->sched_latency_nice == MIN_LATENCY_NICE)
>> +				per_cpu(nr_lat_sensitive, task_cpu(p))++;
>> +			else if (task_is_lat_sensitive(p))
>> +				per_cpu(nr_lat_sensitive, task_cpu(p))--;
>> +		}
>> +
>>  		p->latency_nice = attr->sched_latency_nice;
>> +	}
>>  }
> 
> There is a potential race here due to which we can mess up the refcount.
> 
> - A latency sensitive task is marked TASK_DEAD
> <snip>
> - sched_setattr() called on the task to clear the latency nice. Since
> we check the task state here, we skip the decrement.
> - The task is finally context switched out and we skip the decrement again
> since it is not a latency senstivie task.

if task is already marked TASK_DEAD then we should have already decremented
its refcount in finish_task_switch().
am I missing something?

> 
>>  
>>  /* Actually do priority change: must hold pi & rq lock. */
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 5c41020c530e..56f885e37451 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -211,6 +211,11 @@ static inline int task_has_dl_policy(struct task_struct *p)
>>  	return dl_policy(p->policy);
>>  }
>>  
>> +static inline int task_is_lat_sensitive(struct task_struct *p)
>> +{
>> +	return p->latency_nice == MIN_LATENCY_NICE;
>> +}
>> +
>>  #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
>>  
>>  /*
>> -- 
>> 2.17.2
>>
> 
> Thanks,
> Pavan
> 

Thanks,
Parth
