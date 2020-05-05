Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C071C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75ABF206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgEESCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:02:19 -0400
Received: from foss.arm.com ([217.140.110.172]:46898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgEESCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:02:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871F71FB;
        Tue,  5 May 2020 11:02:12 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0DF3F305;
        Tue,  5 May 2020 11:02:09 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] sched/deadline: Make DL capacity-aware
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-6-dietmar.eggemann@arm.com>
 <20200430131036.GE19464@codeaurora.org>
 <aa00aee6-2adb-569b-825b-781da12ad8d3@arm.com>
 <20200504035842.GF19464@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <55fed70f-b64f-36a7-326d-70859bfdd315@arm.com>
Date:   Tue, 5 May 2020 20:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504035842.GF19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 05:58, Pavan Kondeti wrote:
> On Fri, May 01, 2020 at 06:12:07PM +0200, Dietmar Eggemann wrote:
>> On 30/04/2020 15:10, Pavan Kondeti wrote:
>>> On Mon, Apr 27, 2020 at 10:37:08AM +0200, Dietmar Eggemann wrote:
>>>> From: Luca Abeni <luca.abeni@santannapisa.it>
>>
>> [...]
>>
>>>> @@ -1653,10 +1654,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>>>>  	 * other hand, if it has a shorter deadline, we
>>>>  	 * try to make it stay here, it might be important.
>>>>  	 */
>>>> -	if (unlikely(dl_task(curr)) &&
>>>> -	    (curr->nr_cpus_allowed < 2 ||
>>>> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>>>> -	    (p->nr_cpus_allowed > 1)) {
>>>> +	select_rq = unlikely(dl_task(curr)) &&
>>>> +		    (curr->nr_cpus_allowed < 2 ||
>>>> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>>>> +		    p->nr_cpus_allowed > 1;
>>>> +
>>>> +	/*
>>>> +	 * Take the capacity of the CPU into account to
>>>> +	 * ensure it fits the requirement of the task.
>>>> +	 */
>>>> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
>>>> +		select_rq |= !dl_task_fits_capacity(p, cpu);
>>>> +
>>>> +	if (select_rq) {
>>>>  		int target = find_later_rq(p);
>>>
>>> I see that find_later_rq() checks if the previous CPU is part of
>>> later_mask and returns it immediately. So we don't migrate the
>>> task in the case where there previous CPU can't fit the task and
>>> there are no idle CPUs on which the task can fit. LGTM.
>>
>> Hope I understand you here. I don't think that [patch 6/6] provides this
>> already.
>>
>> In case 'later_mask' has no fitting CPUs, 'max_cpu' is set in the
>> otherwise empty 'later_mask'. But 'max_cpu' is not necessary task_cpu(p).
>>
>> Example on Juno [L b b L L L] with thread0-0 (big task)
>>
>>      cpudl_find [thread0-0 2117] orig later_mask=0,3-4 later_mask=0
>>   find_later_rq [thread0-0 2117] task_cpu=2 later_mask=0
>>
>> A tweak could be added favor task_cpu(p) in case it is amongst the CPUs
>> with the maximum capacity in cpudl_find() for the !fit case.
>>
> 
> You are right. max_cpu can be other than task_cpu(p) in which case we
> migrate the task though it won't fit on the new CPU. While introducing
> capacity awareness in RT, Quais made the below change to avoid the
> migration. We can do something similar here also.
> 
> commit b28bc1e002c2 (sched/rt: Re-instate old behavior in select_task_rq_rt())

I'm not sure something like this is necessary here.

With DL capacity awareness we reduce the later_mask returned by
cpudl_find() in find_later_rq() to those idle CPUs which can handle p
or in case there is none to (the/a) 'non-fitting CPU w/ max capacity'.

We just have to favor task_cpu(p) in [patch 6/6] in case it is part
of the initial later_mask and among these 'non-fitting CPUs w/ max
capacity'.

This will make sure that it gets chosen so find_later_rq() returns it
before the 'for_each_domain()' loop.

And I guess we still want to migrate if there is a non-fitting CPU w/ a
higher CPU capacity than task_cpu() (tri-gear).

@@ -137,7 +137,8 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
                                cap = capacity_orig_of(cpu);
 
-                               if (cap > max_cap) {
+                               if (cap > max_cap ||
+                                   (cpu == task_cpu(p) && cap == max_cap)) {
                                        max_cap = cap;
                                        max_cpu = cpu;

In case task_cpu() is not part of later_cpu, the 'max CPU capacity CPU' is
returned as 'best_cpu'. 

[...]
