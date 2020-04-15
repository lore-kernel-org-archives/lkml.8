Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5589A2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895728AbgDOJju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:39:50 -0400
Received: from foss.arm.com ([217.140.110.172]:40752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895721AbgDOJjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:39:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F8E1063;
        Wed, 15 Apr 2020 02:39:39 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365CF3F68F;
        Wed, 15 Apr 2020 02:39:37 -0700 (PDT)
Subject: Re: [PATCH 3/4] sched/deadline: Make DL capacity-aware
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-4-dietmar.eggemann@arm.com>
 <20200410125253.GE14300@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f0e74500-77d7-a42c-410e-bc5d4d2ecdfb@arm.com>
Date:   Wed, 15 Apr 2020 11:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410125253.GE14300@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.20 14:52, Juri Lelli wrote:
> Hi,
> 
> On 08/04/20 11:50, Dietmar Eggemann wrote:
>> From: Luca Abeni <luca.abeni@santannapisa.it>

[...]

>> @@ -1623,10 +1624,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>>  	 * other hand, if it has a shorter deadline, we
>>  	 * try to make it stay here, it might be important.
>>  	 */
>> -	if (unlikely(dl_task(curr)) &&
>> -	    (curr->nr_cpus_allowed < 2 ||
>> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>> -	    (p->nr_cpus_allowed > 1)) {
>> +	select_rq = unlikely(dl_task(curr)) &&
>> +		    (curr->nr_cpus_allowed < 2 ||
>> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>> +		    p->nr_cpus_allowed > 1;
>> +
>> +	/*
>> +	 * We take into account the capacity of the CPU to
>> +	 * ensure it fits the requirement of the task.
>> +	 */
>> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
>> +		select_rq |= !dl_task_fits_capacity(p, cpu);
> 
> I'm thinking that, while dl_task_fits_capacity() works well when
> selecting idle cpus, in this case we should consider the fact that curr
> might be deadline as well and already consuming some of the rq capacity.
> 
> Do you think we should try to take that into account, maybe using
> dl_rq->this_bw ?

So you're saying that cpudl_find(..., later_mask) could return 1 (w/
best_cpu (cp->elements[0].cpu) in later_mask).

And that this best_cpu could be a non-fitting CPU for p.

This could happen if cp->free_cpus is empty (no idle CPUs) so we take
cpudl_find()'s else path and in case p's deadline < cp->elements[0]
deadline.

We could condition the 'return 1' on best_cpu fitting p.

But should we do this for cpudl_find(..., NULL) calls from
check_preempt_equal_dl() as well or will this break GEDF?
