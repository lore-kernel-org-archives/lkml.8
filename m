Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F6C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8528A2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgCDBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:19:41 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:64767 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbgCDBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:19:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Trab3LS_1583284752;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Trab3LS_1583284752)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 09:19:27 +0800
Subject: Re: [RFC PATCH] sched: fix the nonsense shares when load of cfs_rq is
 too, small
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <44fa1cee-08db-e4ab-e5ab-08d6fbd421d7@linux.alibaba.com>
 <20200303195245.GF2596@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <241603dd-1149-58aa-85cf-43f3da2de43f@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 09:19:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303195245.GF2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/4 上午3:52, Peter Zijlstra wrote:
[snip]
>> The reason is because we have group B with shares as 2, which make
>> the group A 'cfs_rq->load.weight' very small.
>>
>> And in calc_group_shares() we calculate shares as:
>>
>>   load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>>   shares = (tg_shares * load) / tg_weight;
>>
>> Since the 'cfs_rq->load.weight' is too small, the load become 0
>> in here, although 'tg_shares' is 102400, shares of the se which
>> stand for group A on root cfs_rq become 2.
> 
> Argh, because A->cfs_rq.load.weight is B->se.load.weight which is
> B->shares/nr_cpus.

Yeah, that's exactly why it happens, even the share 2 scale up to 2048,
on 96 CPUs platform, each CPU get only 21 in equal case.

> 
>> While the se of D on root cfs_rq is far more bigger than 2, so it
>> wins the battle.
>>
>> This patch add a check on the zero load and make it as MIN_SHARES
>> to fix the nonsense shares, after applied the group C wins as
>> expected.
>>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 84594f8aeaf8..53d705f75fa4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3182,6 +3182,8 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>>  	tg_shares = READ_ONCE(tg->shares);
>>
>>  	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>> +	if (!load && cfs_rq->load.weight)
>> +		load = MIN_SHARES;
>>
>>  	tg_weight = atomic_long_read(&tg->load_avg);
> 
> Yeah, I suppose that'll do. Hurmph, wants a comment though.
> 
> But that has me looking at other users of scale_load_down(), and doesn't
> at least update_tg_cfs_load() suffer the same problem?

Good point :-) I'm not sure but is scale_load_down() supposed to scale small
value into 0? If not, maybe we should fix the helper to make sure it at
least return some real load? like:

# define scale_load_down(w) ((w + (1 << SCHED_FIXEDPOINT_SHIFT)) >> SCHED_FIXEDPOINT_SHIFT)

Regards,
Michael Wang

> 
