Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85530C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B18206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEKIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:40:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgEKIkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:40:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 889E0D6E;
        Mon, 11 May 2020 01:40:46 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37E343F305;
        Mon, 11 May 2020 01:40:45 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Tao Zhou <zohooouoto@zoho.com.cn>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tao Zhou <ouwen210@hotmail.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
Date:   Mon, 11 May 2020 10:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508170213.GA27353@geo.homenetwork>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2020 19:02, Tao Zhou wrote:
> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>>>
>>> Hi Phil,
>>>
>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
>>>> sched/fair: Fix enqueue_task_fair warning some more

[...]

>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 02f323b85b6d..c6d57c334d51 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>               /* end evaluation on encountering a throttled cfs_rq */
>>>>               if (cfs_rq_throttled(cfs_rq))
>>>>                       goto enqueue_throttle;
>>>> +
>>>> +               /*
>>>> +                * One parent has been throttled and cfs_rq removed from the
>>>> +                * list. Add it back to not break the leaf list.
>>>> +                */
>>>> +               if (throttled_hierarchy(cfs_rq))
>>>> +                       list_add_leaf_cfs_rq(cfs_rq);
>>>>       }
>>>
>>> I was confused by why the throttled cfs rq can be on list.
>>> It is possible when enqueue a task and thanks to the 'threads'.
>>> But I think the above comment does not truely put the right
>>> intention, right ?
>>> If throttled parent is onlist, the child cfs_rq is ignored
>>> to be added to the leaf cfs_rq list me think.
>>>
>>> unthrottle_cfs_rq() follows the same logic if i am not wrong.
>>> Is it necessary to add the above to it ?
>>
>> When a cfs_rq is throttled, its sched group is dequeued and all child
>> cfs_rq are removed from  leaf_cfs_rq list. But the sched group of the
>> child cfs_rq stay enqueued in the throttled cfs_rq so child sched
>> group->on_rq might be still set.
> 
> If there is a throttle of throttle, and unthrottle the child throttled
> cfs_rq(ugly):
>                                ...
>                                 |
>                       cfs_rq throttled (parent A)
>                                 |
>                                 |
>                       cfs_rq in hierarchy (B)
>                                 |
>                                 |
>                       cfs_rq throttled (C)
>                                 |
>                                ...
> 
> Then unthrottle the child throttled cfs_rq C, now the A is on the 
> leaf_cfs_rq list. sched_group entity of C is enqueued to B, and 
> sched_group entity of B is on_rq and is ignored by enqueue but in
> the throttled hierarchy and not add to leaf_cfs_rq list.
> The above may be absolutely wrong that I miss something.
> 
> Another thing :
> In enqueue_task_fair():
> 
> 	for_each_sched_entity(se) {
> 		cfs_rq = cfs_rq_of(se);
> 
> 		if (list_add_leaf_cfs_rq(cfs_rq))
> 			break;
> 	}
> 
> In unthrottle_cfs_rq():
> 
> 	for_each_sched_entity(se) {
> 		cfs_rq = cfs_rq_of(se);
> 
> 		list_add_leaf_cfs_rq(cfs_rq);
> 	}
> 
> The difference between them is that if condition, add if
> condition to unthrottle_cfs_rq() may be an optimization and
> keep the same.
> 

I'm not 100% sure if this is exactly what Tao pointed out here but I
also had difficulties understanding understanding how this patch works:

                       p.se
                        |
      __________________|
      |
      V
     cfs_c -> tg_c ->  se_c (se->on_rq = 1)
                        |
      __________________|
      |
      v
     cfs_b -> tg_b ->  se_b
                        |
      __________________|
      |
      V
     cfs_a -> tg_a ->  se_a
                        |
      __________________|
      |
      V
     cfs_r -> tg_r
      |
      V
      rq

(1) The incomplete update happens with cfs_c at the end of
    enqueue_entity() in the first loop because of 'if ( .... ||
    cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)

(2) se_c breaks out of the first loop (se_c->on_rq = 1)

(3) With the patch cfs_b is added back to the list.
    But only because cfs_a->on_list=1.

But since cfs_a is throttled it should be cfs_a->on_list=0 as well.
throttle_cfs_rq()->walk_tg_tree_from(..., tg_throttle_down, ...) should
include cfs_a when calling list_del_leaf_cfs_rq().

IMHO, throttle_cfs_rq() calls tg_throttle_down() for the throttled
cfs_rq too.


Another thing: Why don't we use throttled_hierarchy(cfs_rq) instead of
cfs_bandwidth_used() in enqueue_entity() as well?
