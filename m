Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4195EC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2020A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBSLHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:07:51 -0500
Received: from foss.arm.com ([217.140.110.172]:46536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgBSLHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:07:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D593831B;
        Wed, 19 Feb 2020 03:07:50 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F163F6CF;
        Wed, 19 Feb 2020 03:07:48 -0800 (PST)
Subject: Re: [PATCH v2 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-2-vincent.guittot@linaro.org>
 <ee38d205-b356-9474-785e-e514d81b7d7f@arm.com>
 <20200218132203.GB14914@hirez.programming.kicks-ass.net>
 <CAKfTPtB3qudK8aMq2cx==4RW8t1pz6ymz1Ti0r8oO4TefWzMRw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c18ab89e-d635-e370-6cbb-6015b404d906@arm.com>
Date:   Wed, 19 Feb 2020 12:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB3qudK8aMq2cx==4RW8t1pz6ymz1Ti0r8oO4TefWzMRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 15:15, Vincent Guittot wrote:
> On Tue, 18 Feb 2020 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Tue, Feb 18, 2020 at 01:37:37PM +0100, Dietmar Eggemann wrote:
>>> On 14/02/2020 16:27, Vincent Guittot wrote:
>>>> The walk through the cgroup hierarchy during the enqueue/dequeue of a task
>>>> is split in 2 distinct parts for throttled cfs_rq without any added value
>>>> but making code less readable.
>>>>
>>>> Change the code ordering such that everything related to a cfs_rq
>>>> (throttled or not) will be done in the same loop.
>>>>
>>>> In addition, the same steps ordering is used when updating a cfs_rq:
>>>> - update_load_avg
>>>> - update_cfs_group
>>>> - update *h_nr_running
>>>
>>> Is this code change really necessary? You pay with two extra goto's. We
>>> still have the two for_each_sched_entity(se)'s because of 'if
>>> (se->on_rq); break;'.
>>
>> IIRC he relies on the presented ordering in patch #5 -- adding the
>> running_avg metric.
> 
> Yes, that's the main reason, updating load_avg before h_nr_running

My hunch is you refer to the new function:

static inline void se_update_runnable(struct sched_entity *se)
{
        if (!entity_is_task(se))
                se->runnable_weight = se->my_q->h_nr_running;
}

I don't see the dependency to the 'update_load_avg -> h_nr_running'
order since it operates on se->my_q, not cfs_rq = cfs_rq_of(se), i.e.
se->cfs_rq.

What do I miss here?
