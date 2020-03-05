Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC1AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EACA20866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEBX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:23:59 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49534 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgCEBX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:23:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Trh0niI_1583371435;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Trh0niI_1583371435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Mar 2020 09:23:55 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
 <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
 <CAKfTPtB=+sMXYXEeb2WppUracxLNXQPJj0H7d-MqEmgrB3gTDw@mail.gmail.com>
 <CAKfTPtCnwUKCNbmGR-oErNrF+H+D0FPZPVS=d4m3mvr8Hc7ivQ@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <a22aa816-df93-3bf2-20be-c3eaae17628c@linux.alibaba.com>
Date:   Thu, 5 Mar 2020 09:23:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCnwUKCNbmGR-oErNrF+H+D0FPZPVS=d4m3mvr8Hc7ivQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/4 下午5:43, Vincent Guittot wrote:
> On Wed, 4 Mar 2020 at 09:47, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> On Wed, 4 Mar 2020 at 02:19, 王贇 <yun.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2020/3/4 上午3:52, Peter Zijlstra wrote:
>>> [snip]
>>>>> The reason is because we have group B with shares as 2, which make
>>>>> the group A 'cfs_rq->load.weight' very small.
>>>>>
>>>>> And in calc_group_shares() we calculate shares as:
>>>>>
>>>>>   load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>>>>   shares = (tg_shares * load) / tg_weight;
>>>>>
>>>>> Since the 'cfs_rq->load.weight' is too small, the load become 0
>>>>> in here, although 'tg_shares' is 102400, shares of the se which
>>>>> stand for group A on root cfs_rq become 2.
>>>>
>>>> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
>>>> B->shares/nr_cpus.
>>>
>>> Yeah, that's exactly why it happens, even the share 2 scale up to 2048,
>>> on 96 CPUs platform, each CPU get only 21 in equal case.
>>>
>>>>
>>>>> While the se of D on root cfs_rq is far more bigger than 2, so it
>>>>> wins the battle.
>>>>>
>>>>> This patch add a check on the zero load and make it as MIN_SHARES
>>>>> to fix the nonsense shares, after applied the group C wins as
>>>>> expected.
>>>>>
>>>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>>>>> ---
>>>>>  kernel/sched/fair.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 84594f8aeaf8..53d705f75fa4 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>>>>      tg_shares = READ_ONCE(tg->shares);
>>>>>
>>>>>      load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>>>> +    if (!load && cfs_rq->load.weight)
>>>>> +            load = MIN_SHARES;
>>>>>
>>>>>      tg_weight = atomic_long_read(&tg->load_avg);
>>>>
>>>> Yeah, I suppose that'll do. Hurmph, wants a comment though.
>>>>
>>>> But that has me looking at other users of scale_load_down(), and doesn't
>>>> at least update_tg_cfs_load() suffer the same problem?
>>>
>>> Good point :-) I'm not sure but is scale_load_down() supposed to scale small
>>> value into 0? If not, maybe we should fix the helper to make sure it at
>>> least return some real load? like:
>>>
>>> # define scale_load_down(w) ((w + (1 << SCHED_FIXEDPOINT_SHIFT)) >> SCHED_FIXEDPOINT_SHIFT)
>>
>> you will add +1 of nice prio for each device
> 
> Of course, it's not prio but only weight which is different

That's right, should only handle the issue cases.

Regards,
Michael Wang

> 
>>
>> should we use instead
>> # define scale_load_down(w) ((w >> SCHED_FIXEDPOINT_SHIFT) ? (w >>
>> SCHED_FIXEDPOINT_SHIFT) : MIN_SHARES)
>>
>> Regards,
>> Vincent
>>
>>>
>>> Regards,
>>> Michael Wang
>>>
>>>>
