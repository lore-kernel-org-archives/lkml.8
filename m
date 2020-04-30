Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75BC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D978520661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgD3PNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:13:31 -0400
Received: from foss.arm.com ([217.140.110.172]:57228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgD3PNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:13:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114D31FB;
        Thu, 30 Apr 2020 08:13:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E8B33F68F;
        Thu, 30 Apr 2020 08:13:28 -0700 (PDT)
References: <20200424041832.11364-1-hdanton@sina.com> <20200424043650.14940-1-hdanton@sina.com> <20200430121301.3460-1-hdanton@sina.com> <da5bf72d-1d50-5c5c-3bdb-113ed555dd10@arm.com> <jhjv9lhcb0e.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] sched: set new prio after checking schedule policy
In-reply-to: <jhjv9lhcb0e.mognet@arm.com>
Date:   Thu, 30 Apr 2020 16:13:26 +0100
Message-ID: <jhjsgglc8h5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/04/20 15:18, Valentin Schneider wrote:
> On 30/04/20 15:06, Dietmar Eggemann wrote:
>>>>> +		newprio = NICE_TO_PRIO(attr->sched_nice);
>>>>
>>>> This is new, however AFAICT it doesn't change anything for CFS (or about to
>>>> be) tasks since what matters is calling check_class_changed() further down.
>>>
>>> Yes it's only used by rt_effective_prio().
>>>
>>
>> Looks like changing a SCHED_NORMAL to a SCHED_BATCH task will create a different
>> queue_flags value.
>>
>> # chrt -p $$
>> pid 2803's current scheduling policy: SCHED_OTHER
>> pid 2803's current scheduling priority: 0
>>
>> # chrt -b -p 0 $$
>>
>> ...
>> [bash 2803] policy=3 oldprio=120 newprio=[99->120] new_effective_prio=[99->120] queue_flags=[0xe->0xa]
>> [bash 2803] queued=0 running=0
>> ...
>>
>> But since in this example 'queued=0' it has no further effect here.
>>
>> Why is SCHED_NORMAL/SCHED_BATCH (fair_policy()) now treated differently than SCHED_IDLE?
>>
>> # chrt -i -p 0 $$
>>
>> ...
>> [bash 2803] policy=5 newprio=99 oldprio=120 new_effective_prio=99 queue_flags=0xe
>> [bash 2803] queued=0 running=0
>> ...
>
>
> Good catch; I suppose we'll want to special case SCHED_IDLE (IIRC should
> map to nice 20).
>
> As you pointed out, right now the newprio computation for CFS tasks is
> kinda bonkers, so it seems we'll almost always clear DEQUEUE_MOVE from
> queue_flags for them.
>

Of course I misread that, it's the other way around: since newprio is
always 99 for SCHED_OTHER/BATCH/IDLE tasks, we'll never have
new_effective_prio == oldprio (unless pi involves a FIFO 99 task), thus
will never clear DEQUEUE_MOVE.

> For CFS, not having DEQUEUE_MOVE here would lead to not calling
> update_min_vruntime() on the dequeue. I'm not sure how much it matters in
> this one case - I don't expect sched_setscheduler() calls to be *too*
> frequent, and that oughta be fixed by the next entity_tick()) - but that is
> an actual change.
