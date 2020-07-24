Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6F2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1C20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:18:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:18:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091DDD6E;
        Fri, 24 Jul 2020 09:18:08 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831833F66F;
        Fri, 24 Jul 2020 09:18:06 -0700 (PDT)
Subject: Re: [PATCH] sched/deadline: dome some cleanup for push_dl_task()
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
References: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
 <20200724071426.GD14912@localhost.localdomain>
 <16385ed9-eb44-3ea4-b10a-1e5ef993b33e@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6f4c7154-f850-c8ee-6def-83dfa6bc4341@arm.com>
Date:   Fri, 24 Jul 2020 18:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16385ed9-eb44-3ea4-b10a-1e5ef993b33e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2020 17:31, Daniel Bristot de Oliveira wrote:
> On 7/24/20 9:14 AM, Juri Lelli wrote:
>> Hi,
>>
>> On 07/07/20 00:04, Peng Liu wrote:
>>> 'commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq when pushing a task")'
>>> introduced the update_rq_clock() to fix the "used-before-update" bug.
>>>
>>> 'commit f4904815f97a ("sched/deadline: Fix double accounting of rq/running bw in push & pull")'
>>> took away the bug source(add_running_bw()).
>>>
>>> We no longer need to update rq_clock in advance, let activate_task()
>>> worry about that.
>>>
>>> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
>>> ---
>>>  kernel/sched/deadline.c | 8 +-------
>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index 504d2f51b0d6..c3fa11f84d93 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -2104,13 +2104,7 @@ static int push_dl_task(struct rq *rq)
>>>  
>>>  	deactivate_task(rq, next_task, 0);
>>>  	set_task_cpu(next_task, later_rq->cpu);
>>> -
>>> -	/*
>>> -	 * Update the later_rq clock here, because the clock is used
>>> -	 * by the cpufreq_update_util() inside __add_running_bw().
>>> -	 */
>>> -	update_rq_clock(later_rq);
>>> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>>> +	activate_task(later_rq, next_task, 0);
>>>  	ret = 1;
>> The change looks good to me, since now add_running_bw() is called later
>> by enqueue_task_dl(), but rq_clock has already been updated by core's
>> enqueue_task().
>>
>> Daniel, Dietmar, a second pair of eyes (since you authored the commits
>> above)?
>>
>> I'd chage subject to something like "sched/deadline: Stop updating
>> rq_clock before pushing a task".
> 
> Looks good to me!
> 
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Yes, makes sense to me!

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
