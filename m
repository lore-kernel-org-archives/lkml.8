Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D60C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2252468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgB0LUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:20:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgB0LUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:20:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B9B1FB;
        Thu, 27 Feb 2020 03:20:17 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018F93F73B;
        Thu, 27 Feb 2020 03:20:15 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
Date:   Thu, 27 Feb 2020 11:20:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.20 21:01, Vincent Guittot wrote:
> On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
>>
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>
>>> When a cfs_rq is throttled, its group entity is dequeued and its running
>>> tasks are removed. We must update runnable_avg with current h_nr_running
>>> and update group_se->runnable_weight with new h_nr_running at each level

                                              ^^^

Shouldn't this be 'current' rather 'new' h_nr_running for
group_se->runnable_weight? IMHO, you want to cache the current value
before you add/subtract task_delta.

>>> of the hierarchy.
>>
>> You'll also need to do this for task enqueue/dequeue inside of a
>> throttled hierarchy, I'm pretty sure.
> 
> AFAICT, this is already done with patch "sched/pelt: Add a new
> runnable average signal" when task is enqueued/dequeued inside a
> throttled hierarchy
> 
>>
>>>
>>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>> This patch applies on top of tip/sched/core
>>>
>>>  kernel/sched/fair.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index fcc968669aea..6d46974e9be7 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>>
>>>               if (dequeue)
>>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>>> +             else {
>>> +                     update_load_avg(qcfs_rq, se, 0);
>>> +                     se_update_runnable(se);
>>> +             }
>>> +
>>>               qcfs_rq->h_nr_running -= task_delta;
>>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
>>>
>>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>>               cfs_rq = cfs_rq_of(se);
>>>               if (enqueue)
>>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>>> +             else {
>>> +                     update_load_avg(cfs_rq, se, 0);
>>
>>
>>> +                     se_update_runnable(se);
>>> +             }
>>> +
>>>               cfs_rq->h_nr_running += task_delta;
>>>               cfs_rq->idle_h_nr_running += idle_task_delta;
