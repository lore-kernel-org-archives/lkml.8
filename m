Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACFC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A6C2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCJDmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:42:31 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58538 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726195AbgCJDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:42:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TsBJEkt_1583811746;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TsBJEkt_1583811746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Mar 2020 11:42:26 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <xm267dzx47k9.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtDKTp_G1VNgAXnh=_yLS_T6YkipOsQQ52tBRp-m612JEw@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <49a4dd4a-e7b6-5182-150d-16fff2d101cf@linux.alibaba.com>
Date:   Tue, 10 Mar 2020 11:42:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDKTp_G1VNgAXnh=_yLS_T6YkipOsQQ52tBRp-m612JEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/9 下午7:15, Vincent Guittot wrote:
[snip]
>>>> -       load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>>> +       load = max(cfs_rq->load.weight, scale_load(cfs_rq->avg.load_avg));
>>>>
>>>>         tg_weight = atomic_long_read(&tg->load_avg);
>>>
>>> Get the point, but IMHO fix scale_load_down() sounds better, to
>>> cover all the similar cases, let's first try that way see if it's
>>> working :-)
>>
>> Yeah, that might not be a bad idea as well; it's just that doing this
>> fix would keep you from losing all your precision (and I'd have to think
>> if that would result in fairness issues like having all the group ses
>> having the full tg shares, or something like that).
> 
> AFAICT, we already have a fairness problem case because
> scale_load_down is used in calc_delta_fair() so all sched groups that
> have a weight lower than 1024 will end up with the same increase of
> their vruntime when running.
> Then the load_avg is used to balance between rq so load_balance will
> ensure at least 1 task per CPU but not more because the load_avg which
> is then used will stay null.
> 
> That being said, having a min of 2 for scale_load_down will enable us
> to have the tg->load_avg != 0 so a tg_weight != 0 and each sched group
> will not have the full shares. But it will make those group completely
> fair anyway.
> The best solution would be not to scale down the weight but that's a
> bigger change

Does that means a changing for all those 'load.weight' related
calculation, to reserve the scaled weight?

I suppose u64 is capable for 'cfs_rq.load' to reserve the scaled up load,
changing all those places could be annoying but still fine.

However, I'm not quite sure about the benefit, how much more precision
we'll gain and does that really matters? better to have some testing to
demonstrate it.

Regards,
Michael Wang


> 
