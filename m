Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7961EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B26A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgEKRCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:02:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbgEKRCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:02:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E9D30E;
        Mon, 11 May 2020 10:02:43 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F34993F305;
        Mon, 11 May 2020 10:02:41 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tao Zhou <zohooouoto@zoho.com.cn>, Phil Auld <pauld@redhat.com>,
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
 <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
 <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com>
 <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com>
 <CAKfTPtB71Ov8HkBsVWKnn+_-SmXGHB167oKOmgpyEzycuZbhWg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2a45d9ac-1d8a-da8c-a743-7e1f87724635@arm.com>
Date:   Mon, 11 May 2020 19:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB71Ov8HkBsVWKnn+_-SmXGHB167oKOmgpyEzycuZbhWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 14:12, Vincent Guittot wrote:
> On Mon, 11 May 2020 at 12:39, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 11/05/2020 11:36, Vincent Guittot wrote:
>>> On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 08/05/2020 19:02, Tao Zhou wrote:
>>>>> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
>>>>>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>>>>>>>
>>>>>>> Hi Phil,
>>>>>>>
>>>>>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
>>>>>>>> sched/fair: Fix enqueue_task_fair warning some more
>>
>> [...]
>>
>>>> I'm not 100% sure if this is exactly what Tao pointed out here but I
>>>> also had difficulties understanding understanding how this patch works:
>>>>
>>>>                        p.se
>>>>                         |
>>>>       __________________|
>>>>       |
>>>>       V
>>>>      cfs_c -> tg_c ->  se_c (se->on_rq = 1)
>>>>                         |
>>>>       __________________|
>>>>       |
>>>>       v
>>>>      cfs_b -> tg_b ->  se_b
>>>>                         |
>>>>       __________________|
>>>>       |
>>>>       V
>>>>      cfs_a -> tg_a ->  se_a
>>>>                         |
>>>>       __________________|
>>>>       |
>>>>       V
>>>>      cfs_r -> tg_r
>>>>       |
>>>>       V
>>>>       rq
>>>>
>>>
>>> In your example, which cfs_ rq has been throttled ? cfs_a ?
>>
>> Yes, cfs_a. 0xffffa085e48ce000 in Phil's trace.
>>
>>>
>>>> (1) The incomplete update happens with cfs_c at the end of
>>>>     enqueue_entity() in the first loop because of 'if ( .... ||
>>>>     cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)
>>>
>>> so cfs_c is added with the 1st loop
>>
>> Yes.
>>
>>>> (2) se_c breaks out of the first loop (se_c->on_rq = 1)
>>>>
>>>> (3) With the patch cfs_b is added back to the list.
>>>>     But only because cfs_a->on_list=1.
>>>
>>> hmm I don't understand the link between cfs_b been added and cfs_a->on_list=1
>>
>> cfs_b, 0xffffa085e48ce000 is the one which is now added in the 2. loop.
>>
>> Isn't the link between cfs_b and cfs_a the first if condition in
> 
> on_list is only there to say if the cfs_rq is already in the list but
> there is not dependency with the child

Yes, I agree. But coming back to what the patch does in the example:

W/ the patch, list_add_leaf_cfs_rq() is now called for cfs_b and since
cfs_b->tg->parent->cfs_a and cfs_a->on_list=1 the 'branch is now
connected' which means 'rq->tmp_alone_branch = &rq->leaf_cfs_rq_list'.

I.e. assert_list_leaf_cfs_rq() at the end of enqueue_task_fair() is not
barfing anymore.

W/o the patch, list_add_leaf_cfs_rq() called w/ cfs_c left the 'branch
open', it's not called on cfs_b and since cfs_a->on_list=1, the 3rd
for_each_sched_entity() in enqueue_task_fair() doesn't 'connect the
branch' so the assert fires.

What I don't immediately see is how can cfs_a be throttled (which causes
cfs_b -> cfs_c being a throttled hierarchy) and be on the list
(cfs_a->on_list=1) at the same time.

So the only thing how this could happen is when there was a task enqueue
in a parallel cfs_b' (another child of cfs_a) sub hierarchy just before
the example.

>> list_add_leaf_cfs_rq():
>>
>>   if (cfs_rq->tg->parent &&
>>       cfs_rq->tg->parent->cfs_rq[cpu]->on_list)
>>
>> to 'connect the branch' or not (default, returning false case)?
>>
> 
> In your example above if the parent is already on the list then we
> know where to insert the child.

True, we go the 2nd if() condition in list_add_leaf_cfs_rq().

>>> cfs_b is added with 2nd loop because its throttle_count > 0 due to
>>> cfs_a been throttled (purpose of this patch)
>>>
>>>>
>>>> But since cfs_a is throttled it should be cfs_a->on_list=0 as well.
>>>
>>> So 2nd loop breaks because cfs_a is throttled
>>
>> Yes.
>>
>>> The 3rd loop will add cfs_a
>>
>> Yes, but in the example, cfs_a->on_list=1, so we bail out of
>> list_add_leaf_cfs_rq() early.
> 
> Because the cfs_rq is on the list already so we don't have to add it

Yes.

[...]
