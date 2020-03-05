Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB384C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E42084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgCEBOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:14:52 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35406 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgCEBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:14:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TrgZIAX_1583370887;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TrgZIAX_1583370887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Mar 2020 09:14:48 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     bsegall@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
 <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <1180c6cd-ff61-2c9f-d689-ffe58f8c5a68@linux.alibaba.com>
Date:   Thu, 5 Mar 2020 09:14:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xm26o8tc3qkv.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/5 上午2:47, bsegall@google.com wrote:
[snip]
>> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
>> B->shares/nr_cpus.
>>
>>> While the se of D on root cfs_rq is far more bigger than 2, so it
>>> wins the battle.
>>>
>>> This patch add a check on the zero load and make it as MIN_SHARES
>>> to fix the nonsense shares, after applied the group C wins as
>>> expected.
>>>
>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>>> ---
>>>  kernel/sched/fair.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 84594f8aeaf8..53d705f75fa4 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>>  	tg_shares = READ_ONCE(tg->shares);
>>>
>>>  	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>> +	if (!load && cfs_rq->load.weight)
>>> +		load = MIN_SHARES;
>>>
>>>  	tg_weight = atomic_long_read(&tg->load_avg);
>>
>> Yeah, I suppose that'll do. Hurmph, wants a comment though.
>>
>> But that has me looking at other users of scale_load_down(), and doesn't
>> at least update_tg_cfs_load() suffer the same problem?
> 
> I think instead we should probably scale_load_down(tg_shares) and
> scale_load(load_avg). tg_shares is always a scaled integer, so just
> moving the source of the scaling in the multiply should do the job.
> 
> ie
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..6d7a9d72d742 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3179,9 +3179,9 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>         long tg_weight, tg_shares, load, shares;
>         struct task_group *tg = cfs_rq->tg;
>  
> -       tg_shares = READ_ONCE(tg->shares);
> +       tg_shares = scale_load_down(READ_ONCE(tg->shares));
>  
> -       load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
> +       load = max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_avg));
>  
>         tg_weight = atomic_long_read(&tg->load_avg);

Get the point, but IMHO fix scale_load_down() sounds better, to
cover all the similar cases, let's first try that way see if it's
working :-)

Regards,
Michael Wang

>  
> 
> 
