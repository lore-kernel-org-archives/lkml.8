Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C86C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643532084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFJfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:35:47 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54521 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgCFJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:35:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Trp4UVu_1583487338;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Trp4UVu_1583487338)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Mar 2020 17:35:39 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
 <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
 <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
 <CAKfTPtCaPz2KBmagzpEurh5S9aNFzUomHGh1pDWBx6L_29w5hw@mail.gmail.com>
 <12f79b83-491c-4b4b-0581-d23bdcec7c0c@linux.alibaba.com>
 <CAKfTPtD+He8UULUavz0csUeUV3TBdjShV9kUPQY6rpLswUAm4g@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <746d2b82-fb39-1412-0dc3-c5ff10b578ec@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 17:34:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD+He8UULUavz0csUeUV3TBdjShV9kUPQY6rpLswUAm4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/6 下午4:04, Vincent Guittot wrote:
> On Fri, 6 Mar 2020 at 05:23, 王贇 <yun.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2020/3/5 下午3:53, Vincent Guittot wrote:
>>> On Thu, 5 Mar 2020 at 02:14, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> [snip]
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index fcc968669aea..6d7a9d72d742 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>>>>         long tg_weight, tg_shares, load, shares;
>>>>>         struct task_group *tg = cfs_rq->tg;
>>>>>
>>>>> -       tg_shares = READ_ONCE(tg->shares);
>>>>> +       tg_shares = scale_load_down(READ_ONCE(tg->shares));
>>>>>
>>>>> -       load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>>>> +       load = max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_avg));
>>>>>
>>>>>         tg_weight = atomic_long_read(&tg->load_avg);
>>>>
>>>> Get the point, but IMHO fix scale_load_down() sounds better, to
>>>> cover all the similar cases, let's first try that way see if it's
>>>> working :-)
>>>
>>> The problem with this solution is that the avg.load_avg of gse or
>>> cfs_rq might stay to 0 because it uses
>>> scale_load_down(se/cfs_rq->load.weight)
>>
>> Will cfs_rq->load.weight be zero too without scale down?
> 
> cfs_rq->load.weight will never be 0, it's min is 2
> 
>>
>> If cfs_rq->load.weight got at least something, the load will not be
>> zero after pick the max, correct?
> 
> But the cfs_rq->avg.load_avg will never be other than 0 what ever
> there are heavy or light tasks in the group

Aha, get the point now :-)

BTW, would you like to give a review on
  [PATCH] sched: avoid scale real weight down to zero
please?

Regards,
Michael Wang


> 
>>
>> Regards,
>> Michael Wang
>>
>>>
>>>>
>>>> Regards,
>>>> Michael Wang
>>>>
>>>>>
>>>>>
>>>>>
