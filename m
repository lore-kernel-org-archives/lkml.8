Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E311C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B9206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgEKKj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:39:56 -0400
Received: from foss.arm.com ([217.140.110.172]:55940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:39:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40951FB;
        Mon, 11 May 2020 03:39:54 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865453F305;
        Mon, 11 May 2020 03:39:53 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com>
Date:   Mon, 11 May 2020 12:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 11:36, Vincent Guittot wrote:
> On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/05/2020 19:02, Tao Zhou wrote:
>>> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
>>>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>>>>>
>>>>> Hi Phil,
>>>>>
>>>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
>>>>>> sched/fair: Fix enqueue_task_fair warning some more

[...]

>> I'm not 100% sure if this is exactly what Tao pointed out here but I
>> also had difficulties understanding understanding how this patch works:
>>
>>                        p.se
>>                         |
>>       __________________|
>>       |
>>       V
>>      cfs_c -> tg_c ->  se_c (se->on_rq = 1)
>>                         |
>>       __________________|
>>       |
>>       v
>>      cfs_b -> tg_b ->  se_b
>>                         |
>>       __________________|
>>       |
>>       V
>>      cfs_a -> tg_a ->  se_a
>>                         |
>>       __________________|
>>       |
>>       V
>>      cfs_r -> tg_r
>>       |
>>       V
>>       rq
>>
> 
> In your example, which cfs_ rq has been throttled ? cfs_a ?

Yes, cfs_a. 0xffffa085e48ce000 in Phil's trace.

> 
>> (1) The incomplete update happens with cfs_c at the end of
>>     enqueue_entity() in the first loop because of 'if ( .... ||
>>     cfs_bandwidth_used())' (cfs_b->on_list=0 since cfs_a is throttled)
> 
> so cfs_c is added with the 1st loop

Yes.

>> (2) se_c breaks out of the first loop (se_c->on_rq = 1)
>>
>> (3) With the patch cfs_b is added back to the list.
>>     But only because cfs_a->on_list=1.
> 
> hmm I don't understand the link between cfs_b been added and cfs_a->on_list=1

cfs_b, 0xffffa085e48ce000 is the one which is now added in the 2. loop.

Isn't the link between cfs_b and cfs_a the first if condition in
list_add_leaf_cfs_rq():

  if (cfs_rq->tg->parent &&
      cfs_rq->tg->parent->cfs_rq[cpu]->on_list)

to 'connect the branch' or not (default, returning false case)?

> cfs_b is added with 2nd loop because its throttle_count > 0 due to
> cfs_a been throttled (purpose of this patch)
> 
>>
>> But since cfs_a is throttled it should be cfs_a->on_list=0 as well.
> 
> So 2nd loop breaks because cfs_a is throttled

Yes.

> The 3rd loop will add cfs_a

Yes, but in the example, cfs_a->on_list=1, so we bail out of
list_add_leaf_cfs_rq() early.

I don't grasp how can cfs_a->on_list=1, when cfs_a is throttled and
cfs_b, cfs_c are in a throttled hierarchy?

>> throttle_cfs_rq()->walk_tg_tree_from(..., tg_throttle_down, ...) should
>> include cfs_a when calling list_del_leaf_cfs_rq().
>>
>> IMHO, throttle_cfs_rq() calls tg_throttle_down() for the throttled
>> cfs_rq too.
>>
>>
>> Another thing: Why don't we use throttled_hierarchy(cfs_rq) instead of
>> cfs_bandwidth_used() in enqueue_entity() as well?
> 
> Mainly to be conservative because as this patch demonstrates, there
> are a lot of possible use cases and combinations and I can't ensure
> that it is always safe to use the throttled_hierarchy.

Maybe this deserves a comment then.
