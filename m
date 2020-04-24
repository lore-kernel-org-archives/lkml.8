Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9956AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD6120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgDXIlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:41:49 -0400
Received: from foss.arm.com ([217.140.110.172]:57428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgDXIlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:41:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F37A1FB;
        Fri, 24 Apr 2020 01:41:48 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8543F68F;
        Fri, 24 Apr 2020 01:41:46 -0700 (PDT)
Subject: Re: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when
 propagating
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200422151401.9147-1-vincent.guittot@linaro.org>
 <20200423192930.GY2483@worktop.programming.kicks-ass.net>
 <CAKfTPtBUtK1c2WvE82k1bpS6hWECBs25rRc6t_6gyeJWRaF8uA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <206b1f00-bb96-5e7f-f80a-b10cd88c8a71@arm.com>
Date:   Fri, 24 Apr 2020 10:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBUtK1c2WvE82k1bpS6hWECBs25rRc6t_6gyeJWRaF8uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2020 09:37, Vincent Guittot wrote:
> On Thu, 23 Apr 2020 at 21:29, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Apr 22, 2020 at 05:14:01PM +0200, Vincent Guittot wrote:
>>> update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
>>> an entity down into the cfs_rq hierarchy which must keep the sync with
>>> the current pelt window.
>>>
>>> Even if we can't sync child rq and its group se, we can sync the group se
>>> and parent cfs_rq with current PELT window. In fact, we must keep them sync
>>> in order to stay also synced with others se and group se that are already
>>> attached to the cfs_rq.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>  kernel/sched/fair.c | 26 ++++++--------------------
>>>  1 file changed, 6 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 02f323b85b6d..ca6aa89c88f2 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3441,52 +3441,38 @@ static inline void
>>>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>>>  {
>>>       long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
>>> +     u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>>>
>>>       /* Nothing to update */
>>>       if (!delta)
>>>               return;
>>>
>>> -     /*
>>> -      * The relation between sum and avg is:
>>> -      *
>>> -      *   LOAD_AVG_MAX - 1024 + sa->period_contrib
>>> -      *
>>> -      * however, the PELT windows are not aligned between grq and gse.
>>> -      */
>>
>> Instead of deleting this, could we perhaps extend it?
> 
> In fact, this is not the only place in fair.c that uses this rule to
> align _avg and _sum but others don't have any special comment.
> 
> I can add a more detailed description of this relation for
> ___update_load_avg() in pelt.c and make a ref to this in all places in
> fair.c that use this rule which are :
> - update_tg_cfs_util
> - update_tg_cfs_runnable
> - update_cfs_rq_load_avg
> - attach_entity_load_avg
> - reweight_entity

But IMHO the

"* however, the PELT windows are not aligned between grq and gse."

should only apply to update_tg_cfs_util() and update_tg_cfs_runnable().
And attach_entity_load_avg() (for cfs_rq and se).

They seem to be special since we derive divider from a cfs_rq PELT value
and use it for a se PELT value.

I assume this fact is specifically worth highlighting with a comment. I
mean the fact we can do this because the decay windows are actually aligned.
