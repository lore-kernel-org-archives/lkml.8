Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C41C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BFA20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgDXMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:07:43 -0400
Received: from foss.arm.com ([217.140.110.172]:60924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgDXMHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:07:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F951FB;
        Fri, 24 Apr 2020 05:07:42 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F59C3F6CF;
        Fri, 24 Apr 2020 05:07:40 -0700 (PDT)
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when
 propagating
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
 <23c1cbb8-7335-80ca-cf40-8abc5c1463f4@arm.com>
 <CAKfTPtD_W8DRmFS6xJUo+Yt=XaJgZmKxUzcCSnoLWNJN5xPFCw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5a105c97-4762-aa80-a816-c11c1b1f23f3@arm.com>
Date:   Fri, 24 Apr 2020 14:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD_W8DRmFS6xJUo+Yt=XaJgZmKxUzcCSnoLWNJN5xPFCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2020 18:17, Vincent Guittot wrote:
> On Thu, 23 Apr 2020 at 16:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 22/04/2020 17:14, Vincent Guittot wrote:

[..]

>>     gcfs --> tg --> gse
>>      ________________|
>>      |
>>      V
>>
>>     cfs ---> tg (root)
>>
>>      |
>>      V
>>
>>     rq
>>
> 
> child cfs_rq aka gcfs_rq
>   |
> gse: group entity that represents child cfs_rq in parent cfs_rq
>   |
>   v
> parent cfs_rq aka cfs_rq

OK, I see. Maybe it's clearer to refer to child cfs_rq as gcfs_rq in
this context.

[...]

>>>       /* Set new sched_entity's utilization */
>>>       se->avg.util_avg = gcfs_rq->avg.util_avg;
>>> -     se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
>>> +     se->avg.util_sum = se->avg.util_avg * divider;
>>
>> divider uses cfs_rq but we sync se->avg.util_avg with gcfs_rq here.
> 
> we sync the util_avg of gse with the new util_avg of gcfs_rq but gse
> is attached to cfs_rq and as a result we have to use cfs_rq's
> period_contrib

I agree.

But the decay windows (avg.last_update_time, avg.period_contrib) of
cfs_rq and gcfs_rq are not always aligned, I guess?

I see they are not after the online_fair_sched_group() ->
attach_entity_cfs_rq() but later the are in sync as well.

I ran a couple of different rt-app taskgroup tests and try to

BUG_ON(se->avg.period_contrib != gcfs_rq->avg.period_contrib);
BUG_ON(se->avg.last_update_time != gcfs_rq->avg.last_update_time)

in update_tg_cfs_util() but they didn't trigger so far.

Both, cfs_rq and gcfs_rq are in sync in update_tg_cfs_util() before and
during a task runs in gcfs_rq.

Are there cases where this wouldn't necessary happen in
update_tg_cfs_util(), maybe a more complicated testcase?

>> But since avg.period_contrib of cfs_rq and gcfs_rq are the same this
>> should work.
>>
>>>       /* Update parent cfs_rq utilization */
>>>       add_positive(&cfs_rq->avg.util_avg, delta);
>>> -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
>>> +     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
>>
>> Looks like that avg.last_update_time of se (group entity), it's gcfs_rq
>> and cfs_rq is always the same in update_tg_cfs_[util\|runnable].
>>
>> So that means the PELT windows are aligned for cfs_rqs and group se's?
> 
> We want to align util_avg with util_sum and period_contrib otherwise
> we might have some unalignment. It's quite similarly to what is done
> in attach_entity_load_avg()

I agree.

>> And if we want to enforce this for cfs_rq and task, we have
>> sync_entity_load_avg().
> 
> It's not a matter of syncing the last_update_time

I agree, this is not what you want to achieve here.
But syncing 'last_update_time' and 'period_contrib' is what I understand
as aligning the decay window (like in attach_entity_load_avg()).
