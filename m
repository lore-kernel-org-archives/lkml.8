Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421BC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AABE24959
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEAQML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:12:11 -0400
Received: from foss.arm.com ([217.140.110.172]:43328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:12:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA2E30E;
        Fri,  1 May 2020 09:12:09 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608DF3F68F;
        Fri,  1 May 2020 09:12:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] sched/deadline: Optimize dl_bw_cpus()
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
 <20200427083709.30262-3-dietmar.eggemann@arm.com>
 <20200430105514.GC19464@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <98ba39a7-6b9a-fefe-ae2f-91fe3020b5c1@arm.com>
Date:   Fri, 1 May 2020 18:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430105514.GC19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 12:55, Pavan Kondeti wrote:
> On Mon, Apr 27, 2020 at 10:37:05AM +0200, Dietmar Eggemann wrote:

[..]

>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 504d2f51b0d6..4ae22bfc37ae 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -54,10 +54,16 @@ static inline struct dl_bw *dl_bw_of(int i)
>>  static inline int dl_bw_cpus(int i)
>>  {
>>  	struct root_domain *rd = cpu_rq(i)->rd;
>> -	int cpus = 0;
>> +	int cpus;
>>  
>>  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>>  			 "sched RCU must be held");
>> +
>> +	if (cpumask_subset(rd->span, cpu_active_mask))
>> +		return cpumask_weight(rd->span);
>> +
> 
> Looks good to me. This is a nice optimization.
> 
>> +	cpus = 0;
>> +
>>  	for_each_cpu_and(i, rd->span, cpu_active_mask)
>>  		cpus++;
>>  
> Do you know why this check is in place? Is it only to cover
> the case of cpuset_cpu_inactive()->dl_cpu_busy()?

It should cover:

(1) Preventing CPU hp when DL detects a possible overflow w/o the CPU:

    sched_cpu_deactivate() -> cpuset_cpu_inactive() -> dl_cpu_busy() ->
    dl_bw_cpus() [now replaced by dl_bw_capacity()].

(2) DL Admission Control in CPU HP:

    __sched_setscheduler() -> sched_dl_overflow() -> dl_bw_cpus()
                                           [now + -> dl_bw_capacity()]

(3) In create/destroy exclusive cpusets scenarios (comment in
    set_cpus_allowed_dl(), although I wasn't able to provoke this so
    far:

    do_set_cpus_allowed() -> p->sched_class->set_cpus_allowed() was
    never called when I ran a DL testcase and create/destroy exclusive
    cpusets at the same time?
